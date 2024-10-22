from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
import uuid  # To generate unique chat IDs
from db import create_table, store_chat, load_chats

app = FastAPI()

# Create the database table
create_table()

# Mount static files for CSS and JS
app.mount("/static", StaticFiles(directory="static"), name="static")

class ChatMessage(BaseModel):
    chat_id: str
    user_message: str
    bot_response: str

@app.get("/", response_class=HTMLResponse)
async def get_chat_interface():
    return """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="/static/style.css">
        <title>Chatbot</title>
    </head>
    <body>
        <div id="chat-interface">
            <div id="header">
                <button onclick="startNewChat()">Start New Chat</button>
            </div>
            <div id="chat-container">
                <div id="old-chats">
                    <h2>Previous Chats</h2>
                    <ul id="chat-list"></ul>
                </div>
                <div id="new-chat">
                    <h2 id="active-chat-title">Chat</h2>
                    <div id="chat-output"></div>
                    <textarea id="user-input" placeholder="Type your message..."></textarea>
                    <button onclick="sendMessage()">Send</button>
                </div>
            </div>
        </div>
        <script src="/static/script.js"></script>
    </body>
    </html>
    """

@app.post("/chat/")
async def post_chat(chat_message: ChatMessage):
    store_chat(chat_message.chat_id, chat_message.user_message, chat_message.bot_response)
    return {"status": "success"}

@app.get("/load-chat/{chat_id}")
async def get_chat(chat_id: str):
    chats = load_chats(chat_id)
    return {"chats": chats}
