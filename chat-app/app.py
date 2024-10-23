import os

from db import (add_chat_message, create_chat_log, create_tables, get_chat_log_for_user, get_chat_logs_for_user,
                get_chat_messages_for_log, get_db_session, get_or_create_user, ChatLog, User)
from fastapi import APIRouter, Depends, HTTPException, FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from sqlalchemy.orm import Session

# Check if the app is in development mode
is_dev = os.getenv("DEV_MODE", "false").lower() == "true"

app = FastAPI()

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
create_tables()

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

async def get_user(request: Request, db: Session) -> User:
    x_auth_request_user_header = "x-auth-request-user"

    # Passing the Keycloak Authentication headers is a pain in development..
    if is_dev:
        auth_request_user = "foobar"
    else:
        auth_request_user = request.headers.get(x_auth_request_user_header)

    if not auth_request_user:
        raise HTTPException(status_code=400, detail=f"{x_auth_request_user_header} header is missing")

    user = await get_or_create_user(username=auth_request_user, db=db)
    return user


def chat_log_to_dict(chat_log: ChatLog):
    return {
        "chat_log_id": chat_log.id,
        "chat_log_title": chat_log.created_at,
    }


@router.get("/get-chat-logs")
async def get_chat_logs(request: Request, db: Session = Depends(get_db_session)):
    user = await get_user(request, db)

    chat_logs = get_chat_logs_for_user(user.id, db)

    return {
        "message": f"Welcome, {user.username}!",
        "user_id": user.id,
        "chat_logs": [chat_log_to_dict(chat_log) for chat_log in chat_logs],
    }


@router.get("/get-chat-messages/{chat_log_id}")
async def get_chat_log_messages(chat_log_id: int, request: Request, db: Session = Depends(get_db_session)):
    user = await get_user(request, db)

    chat_messages = get_chat_messages_for_log(user.id, chat_log_id, db)

    return [{
        "prompt": chat_message.prompt,
        "response": chat_message.response,
        "created_at": chat_message.created_at,
    } for chat_message in chat_messages]


@router.post("/new-chat")
async def new_chat(request: Request, db: Session = Depends(get_db_session)):
    user = await get_user(request, db)

    chat_log = create_chat_log(user.id, db)

    return chat_log_to_dict(chat_log)


@router.websocket("/ws/chat/")
async def chat_websocket(websocket: WebSocket, db: Session = Depends(get_db_session)):
    await websocket.accept()
    await chat(websocket, db)


@router.websocket("/ws/chat/{chat_log_id}")
async def chat_websocket(chat_log_id: int, websocket: WebSocket, db: Session = Depends(get_db_session)):
    await websocket.accept()
    await chat(websocket, db, chat_log_id)


async def chat(websocket: WebSocket, db: Session = Depends(get_db_session), chat_log_id: int = None):
    try:
        user = await get_user(websocket, db)

        chat_log = None
        if chat_log_id:
            chat_log = get_chat_log_for_user(user.id, chat_log_id, db)
            if not chat_log:
                raise HTTPException(status_code=400, detail=f"{chat_log_id} does not exist or is not owned by you")

        while True:
            # Receive a message from the client
            prompt = await websocket.receive_text()

            # If this is the first message in a new chat, create new ChatLog
            if not chat_log:
                chat_log = create_chat_log(user.id, db)

            # Process the message (TODO: generate a bot response)
            response = f"Bot: You said '{prompt}'"

            # Send a response back to the client
            await websocket.send_text(response)

            # Save ChatMessage in database
            add_chat_message(chat_log.id, prompt, response, db)
    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(e)
        await websocket.send_text(f"Unexpected error: {str(e)}")
        await websocket.close()  # Close on unexpected error


app.include_router(router)
