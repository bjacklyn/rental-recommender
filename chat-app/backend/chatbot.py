import multiprocessing
import multiprocessing.managers
import torch

from transformers import AutoModelForCausalLM, AutoTokenizer
from transformers import LlamaForCausalLM, LlamaTokenizer
from transformers import pipeline, TextStreamer, TextIteratorStreamer


class TokenQueueStreamer(TextStreamer):
    def __init__(self, token_queue: multiprocessing.Queue, chat_message_id: int, *args, **kwargs):
        """Initializes the TokenQueueStreamer.

        Args:
            token_queue: queue to push tokens that the main application process will consume
            chat_message_id: the id of the chat_message we are streaming the token response for
        """
        super().__init__(*args, **kwargs)
        self.token_queue = token_queue
        self.chat_message_id = chat_message_id


    def on_finalized_text(self, printable_text: str, stream_end: bool = False):
        """Overrides the method of the TextStreamer parent class.

        Rather than the default behavior (printing the token to stdout) to instead push the
        token to a queue.
        """
        if printable_text or stream_end:
            self.token_queue.put((self.chat_message_id, printable_text, stream_end))


class ChatBotPrompt:
    def __init__(self, user_prompt, chat_id, chat_message_id):
        self.user_prompt = user_prompt
        self.chat_id = chat_id
        self.chat_message_id = chat_message_id


class ChatBot:
    def __init__(self, chat_token_queues_dict: multiprocessing.managers.DictProxy, chat_bot_prompts_queue: multiprocessing.Queue):
        """Initializes the ChatBot.

        Args:
            chat_token_queues_dict: dict of chat_id to corresponding token_queue to push tokens to
            chat_bot_prompts_queue: queue of ChatBotPrompts for the LLM to respond to
        """
        self.chat_bot_prompts_queue = chat_bot_prompts_queue
        self.chatbot_process = multiprocessing.Process(target=self.chat_bot_pipeline, args=(chat_token_queues_dict, chat_bot_prompts_queue))


    def start(self):
        self.chatbot_process.start()
        print("Chatbot process started.")


    def stop(self):
        print("Shutting down chatbot process.")
        self.chat_bot_prompts_queue.put(None) # Signal worker it should exit
        self.chatbot_process.terminate()  # Gracefully terminate the worker process
        self.chatbot_process.join()  # Wait for it to finish
        print("Chatbot process terminated.")


    def chat_bot_pipeline(self, chat_token_queues_dict, chat_bot_prompts_queue):
        model_id = "meta-llama/Llama-3.2-1B-Instruct"

        print(f"Using model_id: {model_id}")

        pipe = pipeline(
            "text-generation",
            model=model_id,
            torch_dtype=torch.bfloat16,
            device=torch.device('cuda', index=0),
# Uncomment this to run llm on cpu instead of gpu if gpu is too small
#            device_map="auto",
        )

        while True:
            chat_bot_prompt = chat_bot_prompts_queue.get()
            if chat_bot_prompt is None:  # Exit signal
                break

            print("Working on: " + str(chat_bot_prompt.chat_id) + ". " + chat_bot_prompt.user_prompt)

            token_queue = chat_token_queues_dict[chat_bot_prompt.chat_id]

            token_queue_streamer = TokenQueueStreamer(token_queue, chat_bot_prompt.chat_message_id, pipe.tokenizer, timeout=10.0, skip_prompt=True, skip_special_tokens=True)

            messages = [
                {"role": "system", "content": "You are a pirate chatbot who always responds in pirate speak!"},
                {"role": "user", "content": chat_bot_prompt.user_prompt},
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
                pad_token_id = pipe.tokenizer.eos_token_id,
                streamer=token_queue_streamer,
            )
