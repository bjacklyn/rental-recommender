import multiprocessing
import torch

from transformers import AutoModelForCausalLM, AutoTokenizer
from transformers import LlamaForCausalLM, LlamaTokenizer
from transformers import pipeline, TextStreamer, TextIteratorStreamer


class TokenQueueStreamer(TextStreamer):
    def __init__(self, token_queue, chat_message_id, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.token_queue = token_queue
        self.chat_message_id = chat_message_id

    def on_finalized_text(self, printable_text, stream_end: bool = False):
        if printable_text or stream_end:
            self.token_queue.put((self.chat_message_id, printable_text, stream_end))


class ChatBot:
    def __init__(self, chats_dict, work_queue):
        self.chats_dict = chats_dict
        self.work_queue = work_queue
        self.chatbot_process = multiprocessing.Process(target=self.chat_bot_pipeline, args=(work_queue, chats_dict))


    def start(self):
        self.chatbot_process.start()
        print("Chatbot process started.")


    def stop(self):
        print("Shutting down chatbot process.")
        self.chatbot_process.terminate()  # Gracefully terminate the worker process
        self.chatbot_process.join()  # Wait for it to finish
        print("Chatbot process terminated.")


    def chat_bot_pipeline(self, chats_dict, work_queue):
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
            user_message, chat_id, chat_message_id = work_queue.get()
            if chat_message_id is None:  # Exit signal
                break

            print("Working on: " + str(chat_id) + ". " + user_message)

            token_queue = chats_dict[chat_id]["token_queue"]

            token_queue_streamer = TokenQueueStreamer(token_queue, chat_message_id, pipe.tokenizer, timeout=10.0, skip_prompt=True, skip_special_tokens=True)

            messages = [
                {"role": "system", "content": "You are a pirate chatbot who always responds in pirate speak!"},
                {"role": "user", "content": user_message},
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
