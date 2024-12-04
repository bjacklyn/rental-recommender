import app
import pytest

from fastapi.testclient import TestClient

@pytest.fixture
def client():
    with TestClient(app.app) as client:
        yield client

def test_invalid_NaN_property_id(client):
    response = client.get("/rental-recommender/api/get-rental-recommendations/NaN")
    assert response.status_code == 422


def test_invalid_negative_property_id(client):
    response = client.get("/rental-recommender/api/get-rental-recommendations/-1")
    assert response.status_code == 422


def test_invalid_large_property_id(client):
    response = client.get("/rental-recommender/api/get-rental-recommendations/1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")
    assert response.status_code == 422


def test_valid_property_id(client):
    response = client.get("/rental-recommender/api/get-rental-recommendations/2682968763")
    assert response.status_code == 200
    assert len(response.json()) == 3

def test_download_latest_model():
    latest_file = app.get_latest_file()
    assert "ETag" in latest_file
    assert latest_file["ETag"] != None
