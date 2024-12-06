import multiprocessing
import multiprocessing.managers
import torch
import redis
import requests
import json


from transformers import pipeline, TextStreamer


class TokenQueueStreamer(TextStreamer):
    def __init__(self, token_queue: multiprocessing.Queue, chat_message_id: int, *args, **kwargs):
        """Initializes the TokenQueueStreamer."""
        super().__init__(*args, **kwargs)
        self.token_queue = token_queue
        self.chat_message_id = chat_message_id

    def on_finalized_text(self, printable_text: str, stream_end: bool = False):
        """Pushes the token to a queue rather than printing it."""
        if printable_text or stream_end:
            self.token_queue.put((self.chat_message_id, printable_text, stream_end))


class ChatBotPrompt:
    def __init__(self, user_prompt, chat_id, chat_message_id, property_ids):
        self.user_prompt = user_prompt
        self.chat_id = chat_id
        self.chat_message_id = chat_message_id
        self.property_ids = property_ids


class ChatBot:
    def __init__(self, chat_token_queues_dict: multiprocessing.managers.DictProxy, chat_bot_prompts_queue: multiprocessing.Queue, redis_host='host.docker.internal', redis_port=6379):
        """Initializes the ChatBot."""
        self.chat_bot_prompts_queue = chat_bot_prompts_queue
        self.chatbot_process = multiprocessing.Process(target=self.chat_bot_pipeline, args=(chat_token_queues_dict, chat_bot_prompts_queue, redis_host, redis_port))

    def start(self):
        self.chatbot_process.start()
        print("Chatbot process started.")

    def stop(self):
        print("Shutting down chatbot process")
        self.chat_bot_prompts_queue.put(None)  # Signal worker it should exit
        self.chatbot_process.terminate()  # Gracefully terminate the worker process
        self.chatbot_process.join()  # Wait for it to finish
        print("Chatbot process terminated.")

    def fetch_property_details(self, redis_client, property_ids):
        """Fetches property details from Redis or an external API."""
        property_details = {}
        missing_property_ids = []

        # Check Redis for property details
        for property_id in property_ids:
            details = redis_client.get(str(property_id))
            if details:
                print(f"Property {property_id} found in Redis.")
                property_details[property_id] = json.loads(details)
            else:
                print(f"Property {property_id} not found in Redis.")
                missing_property_ids.append(property_id)

        # Fetch missing property details from API
        if missing_property_ids:
            print(f"Fetching missing property details for IDs: {missing_property_ids}")
            api_url = "http://18.119.153.150:8010/api/v1/housing-properties"
            try:
                response = requests.post(api_url, json={"property_ids": missing_property_ids}, headers={"Content-Type": "application/json"})
                response.status_code = 200
                if response.status_code == 200:
                    api_response = response.json()
                    print(f"API response: {api_response}")
                    properties = []
                    if isinstance(api_response, list):
                        properties = api_response
                    elif isinstance(api_response, dict):
                        properties = api_response.get("properties", [])
                    for property_data in properties:
                        property_id = property_data.get("property_id")
                        if property_id:
                            # Save each property to Redis
                            print("Saving property to Redis for 1 hour.")
                            redis_client.set(str(property_id), json.dumps(property_data), ex=3600)  # Cache for 1 hour
                            property_details[property_id] = property_data
                else:
                    print(f"Failed to fetch property details from API. Status: {response.status_code}, Response: {response.text}")
            except requests.RequestException as e:
                print(f"Error during API call: {e}")

        return property_details

    def chat_bot_pipeline(self, chat_token_queues_dict, chat_bot_prompts_queue, redis_host, redis_port):
        redis_client = redis.StrictRedis(host=redis_host, port=redis_port, decode_responses=True)

        model_id = "meta-llama/Llama-3.2-1B-Instruct"
        print(f"Using model_id: {model_id}")

        pipe = pipeline(
            "text-generation",
            model=model_id,
            torch_dtype=torch.bfloat16,
            device_map="auto",
        )

        while True:
            chat_bot_prompt = chat_bot_prompts_queue.get()
            if chat_bot_prompt is None:  # Exit signal
                break

            print("Working on: " + str(chat_bot_prompt.chat_id) + ". " + chat_bot_prompt.user_prompt)

            token_queue = chat_token_queues_dict[chat_bot_prompt.chat_id]

            # Fetch property details
            property_details = self.fetch_property_details(redis_client, chat_bot_prompt.property_ids)
            property_contexts = [json.dumps(details) for details in property_details.values()]

            # Combine context and user prompt
            context = "\n".join(property_contexts)
            full_prompt = f"{context}\nUser Prompt: {chat_bot_prompt.user_prompt}"

            token_queue_streamer = TokenQueueStreamer(
                token_queue,
                chat_bot_prompt.chat_message_id,
                pipe.tokenizer,
                timeout=10.0,
                skip_prompt=True,
                skip_special_tokens=True,
            )

            messages = [
                {"role": "system", "content": "You are an AI assistant for our property recommender application."
                                              " You are responsible for answering user queries and providing recommendations "
                                              "based on the user's preferences provided in the prompt itself."
                                              " Do not recommend properties outside of the user's preferences. "
                                              "Output must always be just a numerical list of recommended property_id"
                                              " and corresponding property_url, each on a new line. Do not include any other information."
                                              "Avoid duplicating properties.Duplicate properties will have same property_id"},
                {"role": "user", "content": full_prompt},
            ]

            prompt = pipe.tokenizer.apply_chat_template(
                messages,
                tokenize=False,
                add_generation_prompt=True
            )

            terminators = [
                pipe.tokenizer.eos_token_id,
                pipe.tokenizer.convert_tokens_to_ids("<|eot_id|>")
            ]

            outputs = pipe(
                prompt,
                max_new_tokens=256,
                eos_token_id=terminators,
                do_sample=True,
                temperature=0.6,
                top_p=0.9,
                pad_token_id=pipe.tokenizer.eos_token_id,
                streamer=token_queue_streamer,
            )
