import asyncio
import multiprocessing
import os

from db import ChatDB, ChatLog, ChatMessage, User
from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from queue import Empty
from sqlalchemy.orm import Session
from transformers import AutoModelForCausalLM, AutoTokenizer
from transformers import LlamaForCausalLM, LlamaTokenizer
from transformers import pipeline, TextStreamer, TextIteratorStreamer
import time
import torch

app = FastAPI()

# Check if the app is in development mode
is_dev = os.getenv("DEV_MODE", "false").lower() == "true"

# Dealing with CORS (Cross-Origin-Resource-Sharing) is a pain in development
# so allow requests from all origins in dev mode
if is_dev:
    # Add CORS middleware
    origins = [
        "*",  # Allows all origins
    ]

    app.add_middleware(
        CORSMiddleware,
        allow_origins=origins,
        allow_credentials=True,
        allow_methods=["*"],  # Allows all HTTP methods
        allow_headers=["*"],  # Allows all headers
    )


# Mount static files for CSS and JS (same as before)
app.mount("/chat-app/static", StaticFiles(directory="static"), name="static")

# Create the database table
ChatDB.create_tables()

# Create the FastAPI Router
router = APIRouter(prefix="/chat-app")


@router.get("/", response_class=HTMLResponse)
async def get_chat_interface():
    return """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/chat-app/static/style.css">
        <title>Chatbot</title>
    </head>
    <body>
        <div id="chat-interface">
            <h1>Chatbot</h1>
            <div id="old-chats">
                <h2>Old Chats</h2>
                <ul id="chat-list">
                    <li onclick="loadChat('chat_1')">Chat 1</li>
                    <li onclick="loadChat('chat_2')">Chat 2</li>
                </ul>
            </div>
            <div id="new-chat">
                <h2>New Chat</h2>
                <button onclick="startNewChat()">Start New Chat</button>
                <div id="chat-output"></div>
                <textarea id="user-input" placeholder="Type your message..."></textarea>
                <button onclick="sendMessage()">Send</button>
            </div>
        </div>
        <script src="/chat-app/static/script.js"></script>
    </body>
    </html>
    """

async def get_user(request: Request, db: ChatDB) -> User:
    x_auth_request_user_header = "x-auth-request-user"

    # Passing the Keycloak Authentication headers is a pain in development..
    if is_dev:
        auth_request_user = "foobar"
    else:
        auth_request_user = request.headers.get(x_auth_request_user_header)

    if not auth_request_user:
        raise HTTPException(status_code=400, detail=f"{x_auth_request_user_header} header is missing")

    user = await db.get_or_create_user(username=auth_request_user)
    return user


def chat_log_to_dict(chat_log: ChatLog):
    return {
        "id": chat_log.id,
        "created_at": chat_log.created_at.isoformat(),
    }

def chat_message_to_dict(chat_message: ChatMessage):
    return {
        "id": chat_message.id,
        "chat_log_id": chat_message.chat_log_id,
        "prompt": chat_message.prompt,
        "response": chat_message.response,
        "created_at": chat_message.created_at.isoformat(),
    }


@router.get("/get-chat-logs")
async def get_chat_logs(request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat_logs = db.get_chat_logs_for_user(user.id)

    return {
        "user_id": user.id,
        "chat_logs": [chat_log_to_dict(chat_log) for chat_log in chat_logs],
    }


@router.get("/get-chat-messages/{chat_log_id}")
async def get_chat_log_messages(chat_log_id: int, request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat_messages = db.get_chat_messages_for_log(user.id, chat_log_id)

    return [chat_message_to_dict(chat_message) for chat_message in chat_messages]


@router.post("/new-chat")
async def new_chat(request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat_log = db.create_chat_log(user.id)

    return chat_log_to_dict(chat_log)


@router.delete("/delete-chat/{chat_log_id}")
async def delete_chat(chat_log_id: int, request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat_log = db.get_chat_log_for_user(user.id, chat_log_id)
    if chat_log:
        db.delete_chat_log(chat_log)
        return {"message": "Chat log deleted successfully"}
    else:
        raise HTTPException(status_code=404, detail="Chat log not found")


class TokenQueueStreamer(TextStreamer):
    def __init__(self, token_queue, chat_message_id, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.token_queue = token_queue
        self.chat_message_id = chat_message_id

    def on_finalized_text(self, printable_text, stream_end: bool = False):
        self.token_queue.put((self.chat_message_id, printable_text, stream_end))


# Shared manager for handling user queues
manager = None
#manager = multiprocessing.Manager()

# Dictionary to hold chat messages
chat_logs_dict = None
#chat_logs_dict = manager.dict()

# Queues for managing user prompts
work_queue = None
#work_queue = manager.Queue()


async def handle_chat_messages(websocket: WebSocket, chat_log_id, db):
    try:
        print(chat_log_id)
        print(chat_log_id in chat_logs_dict)
        print(chat_logs_dict[chat_log_id])
        print("token_queue" in chat_logs_dict[chat_log_id])

        token_queue = chat_logs_dict[chat_log_id]["token_queue"]
        chat_message = None
        message_count = None

        while True:
            try:
                token_chat_message_id, token, is_last_token = token_queue.get_nowait()

                if token_chat_message_id is None:  # Exit signal
                    break

            except Empty:
                await asyncio.sleep(.1)  # Yield control back to the event loop
                continue

            # Now processing new chat_message!
            if not chat_message or token_chat_message_id != chat_message.id:
                chat_message = chat_logs_dict[chat_log_id][token_chat_message_id]
                message_count = 0

                initial_chat_message_json = chat_message_to_dict(chat_message)
                initial_chat_message_json["type"] = "initial"
                initial_chat_message_json["count"] = message_count
                await websocket.send_json(initial_chat_message_json)

            chat_message.response += token
            message_count += 1
            await websocket.send_json({
                "id": chat_message.id,
                "response": token,
                "type": "partial",
                "count": message_count,
            })

            if is_last_token:
                message_count += 1
                await websocket.send_json({
                    "id": chat_message.id,
                    "type": "complete",
                    "count": message_count,
                })

                # Save response in database
                db.update_chat_message(chat_message)

    except Exception as e:
        print(e)
        print(f"Error sending token: {e}")


@router.websocket("/ws/chat/{chat_log_id}")
async def chat(chat_log_id: int, websocket: WebSocket, db: ChatDB = Depends(ChatDB)):
    await websocket.accept()

    try:
        user = await get_user(websocket, db)

        chat_log = None
        if chat_log_id:
            chat_log = db.get_chat_log_for_user(user.id, chat_log_id)
            if not chat_log:
                raise HTTPException(status_code=400, detail=f"{chat_log_id} does not exist or is not owned by you")

        if chat_log_id not in chat_logs_dict:
            chat_logs_dict[chat_log_id] = manager.dict()

        chat_logs_dict[chat_log_id]["token_queue"] = manager.Queue()
        print("wtf")
        print(chat_logs_dict[chat_log_id])
        asyncio.create_task(handle_chat_messages(websocket, chat_log_id, db))

        while True:
            # Receive a message from the client
            prompt = await websocket.receive_text()

            # Save ChatMessage with empty response in database
            chat_message = db.add_chat_message(chat_log.id, prompt, "")
            chat_logs_dict[chat_log_id][chat_message.id] = chat_message

            # Send work to LLM process
            work_queue.put((prompt, chat_log_id, chat_message.id))

    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(e)
        await websocket.send_json({
             "error": str(e),
        })
        await websocket.close()  # Close on unexpected error
    finally:
        if chat_log_id in chat_logs_dict:
            if "token_queue" in chat_logs_dict[chat_log_id]:
                chat_logs_dict[chat_log_id]["token_queue"].put((None, None, None))
                del chat_logs_dict[chat_log_id]["token_queue"]


app.include_router(router)

chatbot_process = None


def chat_bot_pipeline(work_queue, chat_logs_dict):
    model_id = "meta-llama/Llama-3.2-1B-Instruct"

    print(model_id)

    pipe = pipeline(
        "text-generation",
        model=model_id,
        torch_dtype=torch.bfloat16,
        device=torch.device('cuda', index=0),
#        device_map="auto",
    )

    while True:
        user_message, chat_log_id, chat_message_id = work_queue.get()
        if chat_message_id is None:  # Exit signal
            break

        print("Working on: " + str(chat_log_id) + ". " + user_message)

        token_queue = chat_logs_dict[chat_log_id]["token_queue"]

        token_queue_streamer = TokenQueueStreamer(token_queue, chat_message_id, pipe.tokenizer, timeout=10.0, skip_prompt=True, skip_special_tokens=True)

        messages = [
            {"role": "system", "content": "You are a pirate chatbot who always responds in pirate speak!"},
            #{"role": "user", "content": "Who are you?"},
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


@app.on_event("startup")
def startup_event() -> None:
    global manager, chat_logs_dict, work_queue
    manager = multiprocessing.Manager()
    chat_logs_dict = manager.dict()
    work_queue = manager.Queue()

    chatbot_process = multiprocessing.Process(target=chat_bot_pipeline, args=(work_queue,chat_logs_dict,))
    chatbot_process.start()
    print("Chatbot process started.")

#    multiprocessing.set_start_method("spawn", force=True)



@app.on_event("shutdown")
async def shutdown_event():
    global chatbot_process
    if chatbot_process:
        print("Shutting down chatbot process.")
        chatbot_process.terminate()  # Gracefully terminate the worker process
        chatbot_process.join()  # Wait for it to finish
        print("Chatbot process terminated.")


#import signal
#import time
#import os

#def handle_sigterm(signum, frame):
#    print("SIGTERM received, shutting down child processes...")
#    if process:
#        process.terminate()

#signal.signal(signal.SIGTERM, handle_sigterm)


#if __name__ == '__main__':
    # Start the chat bot process

