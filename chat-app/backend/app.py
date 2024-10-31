import asyncio
import json
import multiprocessing
import os

from chatbot import ChatBot, ChatBotPrompt
from db import ChatDB, Chat, ChatMessage, User
from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from queue import Empty

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


# Create the database table
ChatDB.create_tables()

# Create the FastAPI Router
router = APIRouter(prefix="/chat-app")


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


@router.get("/api/get-chats")
async def get_chats(request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chats = db.get_chats(user.id)

    return {
        "user_id": user.id,
        "chats": [chat_to_dict(chat) for chat in chats],
    }


@router.get("/api/get-chat-messages/{chat_id}")
async def get_chat_messages(chat_id: int, request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat_messages = db.get_chat_messages(user.id, chat_id)

    return [chat_message_to_dict(chat_message) for chat_message in chat_messages]


@router.post("/api/new-chat")
async def new_chat(request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat = db.create_chat(user.id)

    return chat_to_dict(chat)


@router.delete("/api/delete-chat/{chat_id}")
async def delete_chat(chat_id: int, request: Request, db: ChatDB = Depends(ChatDB)):
    user = await get_user(request, db)

    chat = db.get_chat(user.id, chat_id)
    if chat:
        db.delete_chat(chat)
        return {"message": "Chat deleted successfully"}
    else:
        raise HTTPException(status_code=404, detail="Chat not found")


# Shared manager for handling user queues
manager = None

# Dictionary to hold chat id to corresponding token_queue
chat_token_queues_dict = None

# Queues for handling chat bot prompts
chat_bot_prompts_queue = None


# XXX: Could use a selector with multiprocessing.Pipe's to avoid the
# asyncio.sleep(.1)'s, but this would be a lot more work for perf gain we don't
# currently need. But we should mention this under load testing/expansion to more users
# sections of reports.
async def handle_chat_tokens(websocket: WebSocket, chat_id, user_id, db):
    try:
        token_queue = chat_token_queues_dict[chat_id]
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

        chat_token_queues_dict[chat_id] = manager.Queue()
        asyncio.create_task(handle_chat_tokens(websocket, chat_id, user.id, db))

        while True:
            # Receive a message from the client
            prompt = await websocket.receive_text()

            # Save ChatMessage with empty response in database to get a chat_message.id
            chat_message = db.create_chat_message(chat.id, prompt, "")

            # Send chat_message json back to user
            await websocket.send_text(f"{chat_message.id}:0:{json.dumps(chat_message_to_dict(chat_message))}")

            # Put chat bot prompt in queue for LLM to process
            chat_bot_prompts_queue.put(ChatBotPrompt(prompt, chat_id, chat_message.id))

    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(e)
        await websocket.send_json({
             "error": str(e),
        })
        await websocket.close()  # Close on unexpected error
    finally:
        if chat_id in chat_token_queues_dict:
            chat_token_queues_dict[chat_id].put(None)
            del chat_token_queues_dict[chat_id]


chat_bot = None

@app.on_event("startup")
def startup_event() -> None:
    global manager, chat_token_queues_dict, chat_bot_prompts_queue, chat_bot
    manager = multiprocessing.Manager()
    chat_token_queues_dict = manager.dict()
    chat_bot_prompts_queue = manager.Queue()

    chat_bot = ChatBot(chat_token_queues_dict, chat_bot_prompts_queue)
    chat_bot.start()


@app.on_event("shutdown")
async def shutdown_event():
    global chatbot_process
    if chat_bot:
        chat_bot.stop()


app.include_router(router)

# Mount static files for CSS and JS (same as before)
# Must be mounted _after_ the router or static routes will override api routes
app.mount("/chat-app", StaticFiles(directory="static", html=True), name="static")
