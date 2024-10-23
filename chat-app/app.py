from db import create_tables, get_db_session, get_or_create_user, User
from fastapi import APIRouter, Depends, HTTPException, FastAPI, Request
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from sqlalchemy.orm import Session

router = APIRouter(prefix="/chat-app")

app = FastAPI()

# Mount static files for CSS and JS (same as before)
app.mount("/chat-app/static", StaticFiles(directory="static"), name="static")

# Create the database table
create_tables()

class ChatMessage(BaseModel):
    chat_id: str
    user_message: str
    bot_response: str

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

async def get_user(request: Request) -> User:
    x_auth_request_user_header = "x-auth-request-user"

    auth_request_user = request.headers.get(x_auth_request_user_header)
    if not auth_request_user:
        raise HTTPException(status_code=400, detail=f"{x_auth_request_user_header} header is missing")

    user = await get_or_create_user(username=auth_request_user, db_session=db_session)
    return user


@router.get("/get-chats")
async def get_chats(request: Request, db_session: Session = Depends(get_db_session)):
    user = get_user(request)
    return {"message": f"Welcome, {user.username}!", "user_id": user.id}

#@router.post("/chat/")
#async def post_chat(chat_message: ChatMessage):
#    print(chat_message.chat_id)
#    store_chat(chat_message.chat_id, chat_message.user_message, chat_message.bot_response)
#    return {"status": "success"}

#@router.get("/load-chat/{chat_id}")
#async def get_chat(request: Request, chat_id: str):
#    print(dict(request.headers))
#    print(chat_id)
#    chats = load_chats(chat_id)
#    return {"chats": chats}

app.include_router(router)
