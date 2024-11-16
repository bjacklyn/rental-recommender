import asyncio
import websockets
import json

async def send_message():
    uri = "ws://localhost:8000/ws"
    async with websockets.connect(uri) as websocket:
        message = { "user_id": "user123", "text": "Hello, AI!" }
        await websocket.send(json.dumps(message))
        response = await websocket.recv()
        print(f"Response: {response}")

asyncio.run(send_message())
