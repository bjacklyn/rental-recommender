from fastapi import FastAPI, HTTPException, Header, Depends
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
from models import PropertyResponse, PropertyQueryParams, PropertyIDs, PropertiesResponse
from db import collection
from pymongo import ASCENDING
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
import os
from dotenv import load_dotenv
from tracing import configure_tracer

load_dotenv()

app = FastAPI()

configure_tracer(app)


ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "*") 
origins = ALLOWED_ORIGINS.split(",") if ALLOWED_ORIGINS != "*" else ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  
    allow_credentials=True,
    allow_methods=["*"],  
    allow_headers=["*"],  
)

def build_query(params: PropertyQueryParams):
    query = {}
    return query

@app.post("/api/v1/housing-properties", response_model=PropertiesResponse)
async def get_properties_by_ids(property_ids: PropertyIDs):
    return await fetch_properties(property_ids)
        


async def fetch_properties(property_ids: PropertyIDs):
    """
    Common function to fetch properties by IDs.
    """
    string_property_ids = [str(pid) for pid in property_ids.property_ids]
    query = {"property_id": {"$in": string_property_ids}}

    properties = []
    async for doc in collection.find(query):
        properties.append(PropertyResponse(**doc))

    if not properties:
        return PropertiesResponse(properties=[])

    return PropertiesResponse(properties=properties)

@app.get("/api/v1/housing-properties", response_model=PropertiesResponse)
async def get_filtered_properties(
    params: PropertyQueryParams = Depends(), authorization: Optional[str] = Header(None)
):
    return await fetch_filtered(params)
        


async def fetch_filtered(params: PropertyQueryParams):
    """
    Common function to fetch filtered properties.
    """
    query = build_query(params)
    properties = []

    try:
        pipeline = [
            {"$match": query},
            {"$addFields": {
                "sqft_exists": {"$cond": [{"$ifNull": ["$sqft", False]}, 1, 0]},
                "beds_exists": {"$cond": [{"$ifNull": ["$beds", False]}, 1, 0]},
            }},
            {"$sort": {
                "beds_exists": -1,
                "sqft_exists": -1,
                "list_price": 1
            }},
            {"$unset": ["sqft_exists", "beds_exists"]},
            {"$limit": 50}
        ]

        async for doc in collection.aggregate(pipeline):
            properties.append(PropertyResponse(**doc))

        if not properties:
            return PropertiesResponse(properties=[])

    except Exception as e:
        print(f"Error occurred: {e}")
        raise HTTPException(status_code=500, detail="Internal server error occurred.")

    return PropertiesResponse(properties=properties)
