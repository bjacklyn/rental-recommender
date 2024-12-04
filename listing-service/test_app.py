import pytest
from httpx import AsyncClient
from main import app  # Replace `main` with your FastAPI application file name

@pytest.mark.asyncio
async def test_get_filtered_properties_empty():
    """
    Test the GET endpoint for filtered properties with no query parameters.
    Should return 200 OK with an empty list if no data exists.
    """
    async with AsyncClient(app=app, base_url="http://testserver") as client:
        response = await client.get("/api/v1/housing-properties")
    assert response.status_code == 200
    assert response.json() == {"properties": []}

@pytest.mark.asyncio
async def test_post_properties_by_ids_empty():
    """
    Test the POST endpoint for properties by IDs with an empty list.
    Should return 200 OK with an empty list.
    """
    async with AsyncClient(app=app, base_url="http://testserver") as client:
        payload = {"property_ids": []}
        response = await client.post("/api/v1/housing-properties", json=payload)
    assert response.status_code == 200
    assert response.json() == {"properties": []}

@pytest.mark.asyncio
async def test_post_properties_by_ids_invalid_format():
    """
    Test the POST endpoint for properties by IDs with invalid data format.
    Should return 422 Unprocessable Entity.
    """
    async with AsyncClient(app=app, base_url="http://testserver") as client:
        payload = {"property_ids": "not_a_list"}  # Invalid format
        response = await client.post("/api/v1/housing-properties", json=payload)
    assert response.status_code == 422

@pytest.mark.asyncio
async def test_get_filtered_properties_with_params():
    """
    Test the GET endpoint for filtered properties with valid query parameters.
    Should return 200 OK and filter properties.
    """
    async with AsyncClient(app=app, base_url="http://testserver") as client:
        params = {"city": "San Francisco", "state": "CA"}
        response = await client.get("/api/v1/housing-properties", params=params)
    assert response.status_code == 200
    # Assuming no properties exist, it should return an empty list
    assert "properties" in response.json()

@pytest.mark.asyncio
async def test_post_properties_by_ids_valid():
    """
    Test the POST endpoint for properties by IDs with valid data.
    Should return 200 OK.
    """
    async with AsyncClient(app=app, base_url="http://testserver") as client:
        payload = {"property_ids": ["1", "2"]}
        response = await client.post("/api/v1/housing-properties", json=payload)
    assert response.status_code == 200
    assert "properties" in response.json()

