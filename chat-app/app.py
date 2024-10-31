import asyncio
import json
import multiprocessing
import os

from db import ChatDB, Chat, ChatMessage, User
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


def chat_to_dict(chat: Chat):
    return {
        "id": chat.id,
        "created_at": chat.created_at.isoformat(),
    }

def chat_message_to_dict(chat_message: ChatMessage):
    return {
        "id": chat_message.id,
        "chat_id": chat_message.chat_id,
        "prompt": chat_message.prompt,
        "response": chat_message.response,
        "created_at": chat_message.created_at.isoformat(),
    }


@router.get("/get-chats")
async def get_chats(request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chats = db.get_chats(user.id)

    return {
        "user_id": user.id,
        "chats": [chat_to_dict(chat) for chat in chats],
    }


@router.get("/get-chat-messages/{chat_id}")
async def get_chat_messages(chat_id: int, request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat_messages = db.get_chat_messages(user.id, chat_id)

    return [chat_message_to_dict(chat_message) for chat_message in chat_messages]


@router.post("/new-chat")
async def new_chat(request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat = db.create_chat(user.id)

    return chat_to_dict(chat)


@router.delete("/delete-chat/{chat_id}")
async def delete_chat(chat_id: int, request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat = db.get_chat(user.id, chat_id)
    if chat:
        db.delete_chat(chat)
        return {"message": "Chat deleted successfully"}
    else:
        raise HTTPException(status_code=404, detail="Chat not found")


class TokenQueueStreamer(TextStreamer):
    def __init__(self, token_queue, chat_message_id, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.token_queue = token_queue
        self.chat_message_id = chat_message_id

    def on_finalized_text(self, printable_text, stream_end: bool = False):
        if printable_text or stream_end:
            self.token_queue.put((self.chat_message_id, printable_text, stream_end))


# Shared manager for handling user queues
manager = None

# Dictionary to hold chat messages
chats_dict = None

# Queues for managing user prompts
work_queue = None


async def handle_chat_tokens(websocket: WebSocket, chat_id, user_id, db):
    try:
        token_queue = chats_dict[chat_id]["token_queue"]
        token_count = None
        chat_message = None

        while True:
            try:
                token_chat_message_id, token, is_last_token = token_queue.get_nowait()

                if token_chat_message_id is None:  # Exit signal
                    break

            except Empty:
                await asyncio.sleep(.1)  # Yield control back to the event loop
                continue

            if not chat_message or token_chat_message_id != chat_message.id:
                token_count = 1
                chat_message = db.get_chat_message(token_chat_message_id)

            await websocket.send_text(f"{chat_message.id}:{token_count}:{token}")

            token_count += 1
            chat_message.response += token
            print(f"{chat_message.id}:{token_count}:{token}")

            if is_last_token:
                # Save response in database
                db.update_chat_message(chat_message)

    except Exception as e:
        print(e)
        print(f"Error sending token: {e}")


@router.websocket("/ws/chat/{chat_id}")
async def chat(chat_id: int, websocket: WebSocket, db: ChatDB = Depends(ChatDB)):
    await websocket.accept()

    try:
        user = await get_user(websocket, db)

        chat = None
        if chat_id:
            chat = db.get_chat(user.id, chat_id)
            if not chat:
                raise HTTPException(status_code=400, detail=f"{chat_id} does not exist or is not owned by you")

        if chat_id not in chats_dict:
            chats_dict[chat_id] = manager.dict()

        chats_dict[chat_id]["token_queue"] = manager.Queue()
        asyncio.create_task(handle_chat_tokens(websocket, chat_id, user.id, db))

        while True:
            # Receive a message from the client
            prompt = await websocket.receive_text()

            # Save ChatMessage with empty response in database to get a chat_message.id
            chat_message = db.create_chat_message(chat.id, prompt, "")

            # Send chat_message json back to user
            await websocket.send_text(f"{chat_message.id}:0:{json.dumps(chat_message_to_dict(chat_message))}")

            print("ok")

            # Send work to LLM process
            work_queue.put((prompt, chat_id, chat_message.id))

    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(e)
        await websocket.send_json({
             "error": str(e),
        })
        await websocket.close()  # Close on unexpected error
    finally:
        if chat_id in chats_dict:
            if "token_queue" in chats_dict[chat_id]:
                chats_dict[chat_id]["token_queue"].put((None, None, None))
                del chats_dict[chat_id]["token_queue"]


app.include_router(router)

chatbot_process = None


def chat_bot_pipeline(work_queue, chats_dict):
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
        user_message, chat_id, chat_message_id = work_queue.get()
        if chat_message_id is None:  # Exit signal
            break

        print("Working on: " + str(chat_id) + ". " + user_message)

        token_queue = chats_dict[chat_id]["token_queue"]

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
    global manager, chats_dict, work_queue, chatbot_process
    manager = multiprocessing.Manager()
    chats_dict = manager.dict()
    work_queue = manager.Queue()

    chatbot_process = multiprocessing.Process(target=chat_bot_pipeline, args=(work_queue,chats_dict,))
    chatbot_process.start()
    print("Chatbot process started.")


@app.on_event("shutdown")
async def shutdown_event():
    global chatbot_process
    if chatbot_process:
        print("Shutting down chatbot process.")
        chatbot_process.terminate()  # Gracefully terminate the worker process
        chatbot_process.join()  # Wait for it to finish
        print("Chatbot process terminated.")
