import asyncio
import os

from db import (add_chat_message, create_chat_log, create_tables, delete_chat_log, get_chat_log_for_user, get_chat_logs_for_user,
                get_chat_messages_for_log, get_db_session, get_or_create_user, update_chat_message, ChatLog, ChatMessage, User)
from fastapi import APIRouter, Depends, HTTPException, FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel
from sqlalchemy.orm import Session
from transformers import AutoModelForCausalLM, AutoTokenizer
import torch

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
async def get_chat_logs(request: Request, db: Session = Depends(get_db_session)):
    user = await get_user(request, db)

    chat_logs = get_chat_logs_for_user(user.id, db)

    return {
        "user_id": user.id,
        "chat_logs": [chat_log_to_dict(chat_log) for chat_log in chat_logs],
    }


@router.get("/get-chat-messages/{chat_log_id}")
async def get_chat_log_messages(chat_log_id: int, request: Request, db: Session = Depends(get_db_session)):
    user = await get_user(request, db)

    chat_messages = get_chat_messages_for_log(user.id, chat_log_id, db)

    return [chat_message_to_dict(chat_message) for chat_message in chat_messages]


@router.post("/new-chat")
async def new_chat(request: Request, db: Session = Depends(get_db_session)):
    user = await get_user(request, db)

    chat_log = create_chat_log(user.id, db)

    return chat_log_to_dict(chat_log)


@router.delete("/delete-chat/{chat_log_id}")
async def delete_chat(chat_log_id: int, request: Request, db: Session = Depends(get_db_session)):
    user = await get_user(request, db)

    chat_log = get_chat_log_for_user(user.id, chat_log_id, db)
    if chat_log:
        delete_chat_log(chat_log, db)
        return {"message": "Chat log deleted successfully"}
    else:
        raise HTTPException(status_code=404, detail="Chat log not found")


@router.websocket("/ws/chat/{chat_log_id}")
async def chat_websocket(chat_log_id: int, websocket: WebSocket, db: Session = Depends(get_db_session)):
    await websocket.accept()
    await chat(websocket, db, chat_log_id)


#model_name = "gpt2"
model_name = "EleutherAI/gpt-neo-2.7B"
tokenizer = AutoTokenizer.from_pretrained(model_name)
#tokenizer.pad_token = tokenizer.eos_token
model = AutoModelForCausalLM.from_pretrained(model_name)

# Move the model to GPU if available
device = 'cuda' if torch.cuda.is_available() else 'cpu'
model.to(device)

model.eval()

def token_generator(prompt: str, max_output_tokens=50):
    input_ids = tokenizer.encode(prompt, return_tensors="pt")
    eos_token_id = tokenizer.eos_token_id

    for _ in range(max_output_tokens):
        with torch.no_grad():
            outputs = model(input_ids)
            next_token_logits = outputs.logits[:, -1, :]
            next_token = torch.argmax(next_token_logits, dim=-1)

            # Check for EOS token
            if next_token.item() == eos_token_id:
                break

            input_ids = torch.cat([input_ids, next_token.unsqueeze(0)], dim=1)
            yield tokenizer.decode(next_token)


def full_text_generator_gpt2(prompt: str):
    # Encode the input text with padding and attention mask
    inputs = tokenizer.encode_plus(
        prompt,
        return_tensors="pt",
        padding="max_length",  # Or use "longest" if you have multiple inputs
        max_length=50,         # Set max length for padding
        truncation=True         # Ensure truncation if input exceeds max_length
    )

    input_ids = inputs['input_ids']
    attention_mask = inputs['attention_mask']

    # Generate text
    output = model.generate(
        input_ids,
        attention_mask=attention_mask,  # Include the attention mask
        max_length=100,            # Maximum length of generated text
        num_return_sequences=1,    # Number of sequences to generate
        do_sample=True,            # Use sampling for more diverse outputs
        top_k=50,                  # Limit to top-k tokens for sampling
        top_p=0.95,                # Nucleus sampling
        temperature=0.7,           # Control randomness (lower is less random)
        eos_token_id=tokenizer.eos_token_id,  # Specify the end-of-sequence token
    )

    # Decode the generated text
    generated_text = tokenizer.decode(output[0], skip_special_tokens=True)

    print(generated_text)

    for word in generated_text.split(" "):
        yield word


def full_text_generator_gpt_neo_27b(prompt: str):
    # Encode the input text with padding and attention mask
    input_ids = tokenizer.encode(prompt, return_tensors="pt").to(device)  # Move input_ids to GPU

    # Generate text
    output = model.generate(
        input_ids,
        max_length=100,            # Maximum length of generated text
        num_return_sequences=1,    # Number of sequences to generate
        do_sample=True,            # Use sampling for more diverse outputs
        top_k=50,                  # Limit to top-k tokens for sampling
        top_p=0.95,                # Nucleus sampling
        temperature=0.7,           # Control randomness (lower is less random)
        eos_token_id=tokenizer.eos_token_id,  # Specify the end-of-sequence token
    )

    # Decode the generated text
    generated_text = tokenizer.decode(output[0], skip_special_tokens=True)

    print(generated_text)

    for word in generated_text.split(" "):
        yield word


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

            # Response will be incrementally generated
            response = ""

            # Save ChatMessage with empty response in database
            chat_message = add_chat_message(chat_log.id, prompt, response, db)

            # Send an initial response back to the client with the chat_message's id
            message_count = 0
            initial_chat_message_json = chat_message_to_dict(chat_message)
            initial_chat_message_json["type"] = "initial"
            initial_chat_message_json["count"] = message_count
            await websocket.send_json(initial_chat_message_json)


            print(prompt)


            generator = full_text_generator_gpt_neo_27b(prompt)
            #generator = token_generator(prompt)
            for token in generator:
                response += token
                message_count = message_count + 1
                await websocket.send_json({
                    "id": chat_message.id,
                    "response": token + " ",
                    "type": "partial",
                    "count": message_count,
                })

            print("Done with model")


            # Process the message (TODO: generate a bot response)
#            response_parts = [
#                "Hello, this is a response from the LLM.\n ",
#                " I'm generating the response in parts.\n ",
#                f"You said '{prompt}'.\n ",
#                " This is the last part of the response.",
#            ]

#            for part in response_parts:
#                response = response + part
#                message_count = message_count + 1
#                await websocket.send_json({
#                    "id": chat_message.id,
#                    "response": part,
#                    "type": "partial",
#                    "count": message_count,
#                })
#                await asyncio.sleep(.5)



            message_count = message_count + 1
            await websocket.send_json({
                "id": chat_message.id,
                "type": "complete",
                "count": message_count,
            })

            chat_message.response = response
            update_chat_message(chat_message, db)

    except WebSocketDisconnect:
        print("Client disconnected")
    except Exception as e:
        print(e)
        await websocket.send_json({
             "error": str(e),
        })
        await websocket.close()  # Close on unexpected error


app.include_router(router)
