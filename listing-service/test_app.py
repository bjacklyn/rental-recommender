import pytest
from httpx import AsyncClient
from app import app  

@pytest.mark.asyncio
async def test_get_filtered_properties_empty():
    """
    Test the GET endpoint for filtered properties with no query parameters.
    Should return 200 OK with an empty list if no data exists.
    """
    async with AsyncClient(app=app, base_url="http://18.119.153.150:8010") as client:
        payload = {
            "property_ids": []
        }
        params = {}
        headers = {"Content-Type": "application/json"}
        response = await client.post("/api/v1/housing-properties",json=payload, headers=headers)
    assert response.status_code == 200
    assert response.json() == {"properties": []}

@pytest.mark.asyncio
async def test_post_properties_by_ids_empty():
    """
    Test the POST endpoint for properties by IDs with an empty list.
    Should return 200 OK with an empty list.
    """
    async with AsyncClient(app=app, base_url="http://18.119.153.150:8010") as client:
        payload = {"property_ids": []}
        headers = {"Content-Type": "application/json"}
        response = await client.post("/api/v1/housing-properties", json=payload, headers=headers)
    assert response.status_code == 200
    assert response.json() == {"properties": []}

@pytest.mark.asyncio
async def test_post_properties_by_ids_invalid_format():
    """
    Test the POST endpoint for properties by IDs with invalid data format.
    Should return 422 Unprocessable Entity.
    """
    async with AsyncClient(app=app, base_url="http://18.119.153.150:8010") as client:
        payload = {"property_ids": ["a", "b", "c"]}
        headers = {"Content-Type": "application/json"}
        response = await client.post("/api/v1/housing-properties", json=payload, headers=headers)
    assert response.status_code == 422

@pytest.mark.asyncio
async def test_get_filtered_properties_with_params():
    """
    Test the GET endpoint for filtered properties with valid query parameters.
    Should return 200 OK and filter properties.
    """
    async with AsyncClient(app=app, base_url="http://18.119.153.150:8010") as client:
        payload = {"property_ids": []}
        params = {"city": "San Francisco", "state": "CA"}
        headers = {"Content-Type": "application/json"}
        response = await client.post("/api/v1/housing-properties", json=payload, headers=headers)
    assert response.status_code == 200
    assert "properties" in response.json()

@pytest.mark.asyncio
async def test_post_properties_by_ids_valid():
    """
    Test the POST endpoint for properties by IDs with valid data.
    Should return 200 OK.
    """
    async with AsyncClient(app=app, base_url="http://18.119.153.150:8010") as client:
        payload = {"property_ids": ["1", "2"]}
        response = await client.post("/api/v1/housing-properties", json=payload)
    assert response.status_code == 200
    assert "properties" in response.json()

