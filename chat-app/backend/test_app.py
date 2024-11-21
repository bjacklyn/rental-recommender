from fastapi.testclient import TestClient
from app import app

client = TestClient(app)

def test_read_root():
    response = client.get("/chat-app")
    assert response.status_code == 200
    assert "text/html" in response.headers['content-type']


def test_create_new_chat():
    response = client.post("/chat-app/api/new-chat")
    assert response.status_code == 200
    json = response.json()
    assert "id" in json
    assert "created_at" in json


def test_delete_chat():
    new_chat_response = client.post("/chat-app/api/new-chat")
    assert new_chat_response.status_code == 200
    chat_id = new_chat_response.json()["id"]
    delete_chat_response = client.delete(f"/chat-app/api/delete-chat/{chat_id}")
    assert delete_chat_response.status_code == 200


def test_get_chats():
    new_chat_response = client.post("/chat-app/api/new-chat")
    assert new_chat_response.status_code == 200
    get_chats_response = client.get("/chat-app/api/get-chats")
    json = get_chats_response.json()
    assert "user_id" in json
    assert "chats" in json
    assert len(json["chats"]) > 0
