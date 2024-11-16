from fastapi import WebSocket
from llama_model import LLaMAChat
from database_manager import DatabaseManager

llama = LLaMAChat()
db_manager = DatabaseManager()

class WebSocketManager:
    def __init__(self):
        self.active_connections = []

    async def connect(self, websocket: WebSocket):
        """
        Accept a new WebSocket connection.
        """
        await websocket.accept()
        self.active_connections.append(websocket)

    def disconnect(self, websocket: WebSocket):
        """
        Remove a WebSocket connection.
        """
        self.active_connections.remove(websocket)

    async def handle_message(self, websocket: WebSocket, message: dict):
        """
        Handle incoming messages and generate responses.
        """
        user_id = message.get("user_id")
        user_input = message.get("text")

        # Retrieve context from MongoDB
        context = db_manager.get_context(user_id)

        # Generate response using LLaMA
        prompt = f"Context: {context}\nUser: {user_input}\nAI:"
        response = llama.generate_response(prompt)

        # Save context and chat history
        db_manager.save_context(user_id, context + f"\nUser: {user_input}\nAI: {response}")
        db_manager.save_chat_history(user_id, f"User: {user_input}\nAI: {response}")

        # Send the AI's response back to the client
        await websocket.send_json({"response": response})
