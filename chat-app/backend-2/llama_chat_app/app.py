from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from websocket_manager import WebSocketManager

app = FastAPI()
websocket_manager = WebSocketManager()

@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    """
    WebSocket endpoint for real-time communication.
    """
    await websocket_manager.connect(websocket)
    try:
        while True:
            # Receive message from WebSocket
            message = await websocket.receive_json()
            await websocket_manager.handle_message(websocket, message)
    except WebSocketDisconnect:
        websocket_manager.disconnect(websocket)
