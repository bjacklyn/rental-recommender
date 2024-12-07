from fastapi import FastAPI, HTTPException, Header, Depends
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
from models import PropertyResponse, PropertyQueryParams, PropertyIDs, PropertiesResponse
from db import collection
from pymongo import ASCENDING
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Initialize FastAPI app
app = FastAPI()

# CORS Configuration
ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "*")  # Default to all origins if not set
origins = ALLOWED_ORIGINS.split(",") if ALLOWED_ORIGINS != "*" else ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  # Origins from .env or allow all
    allow_credentials=True,
    allow_methods=["*"],  # Allow all HTTP methods
    allow_headers=["*"],  # Allow all headers
)

# Function to build MongoDB query
def build_query(params: PropertyQueryParams):
    """Constructs MongoDB query for fields stored as strings."""
    query = {}

    if params.city:
        query["city"] = params.city  # No null inclusion for city
    if params.state:
        query["state"] = params.state  # No null inclusion for state

    if params.zip_code:
        query["$or"] = [
            {"zip_code": str(params.zip_code)},
            {"zip_code": None}
        ]

    # Beds and sqft inclusion
    query["$and"] = []

    # Handle beds (convert to string range)
    if params.min_beds or params.max_beds:
        beds_query = {}
        if params.min_beds:
            beds_query["$gte"] = str(params.min_beds)  # Convert to string
        if params.max_beds:
            beds_query["$lte"] = str(params.max_beds)  # Convert to string
        query["$and"].append({"$or": [{"beds": beds_query}, {"beds": None}]})

    # Handle sqft (convert to string range)
    if params.min_sqft or params.max_sqft:
        sqft_query = {}
        if params.min_sqft:
            sqft_query["$gte"] = str(params.min_sqft)  # Convert to string
        if params.max_sqft:
            sqft_query["$lte"] = str(params.max_sqft)  # Convert to string
        query["$and"].append({"$or": [{"sqft": sqft_query}, {"sqft": None}]})

    # Clean up if no $and conditions were added
    if not query["$and"]:
        del query["$and"]

    return query

# POST Endpoint to Fetch Properties by IDs
@app.post("/api/v1/housing-properties", response_model=PropertiesResponse)
async def get_properties_by_ids(property_ids: PropertyIDs):
    """
    Fetch properties by their IDs.
    """
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
    """
    Fetch filtered housing properties using aggregation for sorting by field existence.
    Handles cases where sqft and beds are null.
    """
    print(f"Received Query Parameters: {params}")
    query = build_query(params)
    print(f"Constructed MongoDB Query: {query}")

    properties = []

    try:
        # Aggregation pipeline
        pipeline = [
            {"$match": query},  # Filter by query parameters
            {"$addFields": {  # Add computed fields to indicate field existence
                "sqft_exists": {"$cond": [{"$ifNull": ["$sqft", False]}, 1, 0]},
                "beds_exists": {"$cond": [{"$ifNull": ["$beds", False]}, 1, 0]},
            }},
            {"$sort": {  # Sort by existence of fields, then by price
                "beds_exists": -1,       # Prioritize non-null beds
                "sqft_exists": -1,       # Prioritize non-null sqft
                "list_price": 1          # Finally sort by list_price (ascending)
            }},
            {"$unset": [  # Remove computed fields from results
                "sqft_exists",
                "beds_exists",
            ]}
        ]

        # Execute the aggregation pipeline
        async for doc in collection.aggregate(pipeline):
            properties.append(PropertyResponse(**doc))

        # If no properties are found, return an empty list
        if not properties:
            return PropertiesResponse(properties=[])

    except Exception as e:
        # Log the error and return a 500 Internal Server Error
        print(f"Error occurred: {e}")
        raise HTTPException(status_code=500, detail="Internal server error occurred.")

    return PropertiesResponse(properties=properties)
