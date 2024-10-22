from fastapi import FastAPI
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from db import create_table, store_chat, load_chats

app = FastAPI()

# Create the database table
create_table()

# Mount static files for CSS and JS (same as before)
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
        <script src="/static/script.js"></script>
    </body>
    </html>
    """

@app.post("/chat/")
async def post_chat(chat_message: ChatMessage):
    print(chat_message.chat_id)
    store_chat(chat_message.chat_id, chat_message.user_message, chat_message.bot_response)
    return {"status": "success"}

@app.get("/load-chat/{chat_id}")
async def get_chat(chat_id: str):
    print(chat_id)
    chats = load_chats(chat_id)
    return {"chats": chats}
