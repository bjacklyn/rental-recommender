from fastapi import FastAPI, HTTPException, Header, Depends
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
from dotenv import load_dotenv
from models import PropertyResponse, PropertyQueryParams, PropertyIDs, PropertiesResponse
from db import collection
import logging
import os

# Load environment variables
load_dotenv()

# Initialize FastAPI app
app = FastAPI()

# CORS Configuration
ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "*")
origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Function to build MongoDB query
def build_query(params: PropertyQueryParams):
    query = {}
    if params.city:
        query["city"] = params.city
    if params.state:
        query["state"] = params.state
    if params.zip_code:
        query["$or"] = [{"zip_code": str(params.zip_code)}, {"zip_code": None}]
    query["$and"] = []
    if params.min_beds or params.max_beds:
        beds_query = {}
        if params.min_beds:
            beds_query["$gte"] = str(params.min_beds)
        if params.max_beds:
            beds_query["$lte"] = str(params.max_beds)
        query["$and"].append({"$or": [{"beds": beds_query}, {"beds": None}]})
    if params.min_sqft or params.max_sqft:
        sqft_query = {}
        if params.min_sqft:
            sqft_query["$gte"] = str(params.min_sqft)
        if params.max_sqft:
            sqft_query["$lte"] = str(params.max_sqft)
        query["$and"].append({"$or": [{"sqft": sqft_query}, {"sqft": None}]})
    if not query["$and"]:
        del query["$and"]
    return query

# POST Endpoint to Fetch Properties by IDs
@app.post("/api/v1/housing-properties", response_model=PropertiesResponse)
async def get_properties_by_ids(property_ids: PropertyIDs):
    string_property_ids = [str(pid) for pid in property_ids.property_ids]
    query = {"property_id": {"$in": string_property_ids}}
    properties = []
    async for doc in collection.find(query):
        properties.append(PropertyResponse(**doc))
    if not properties:
        return PropertiesResponse(properties=[])
    return PropertiesResponse(properties=properties)

# GET Endpoint to Fetch Filtered Properties
@app.get("/api/v1/housing-properties", response_model=PropertiesResponse)
async def get_filtered_properties(
    params: PropertyQueryParams = Depends(), authorization: Optional[str] = Header(None)
):

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
            {"$unset": ["sqft_exists", "beds_exists"]}
        ]
        async for doc in collection.aggregate(pipeline):
            properties.append(PropertyResponse(**doc))
        if not properties:
            return PropertiesResponse(properties=[])
    except Exception as e:
        raise HTTPException(status_code=500, detail="Internal server error occurred.")
    return PropertiesResponse(properties=properties)
