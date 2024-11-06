# app.py
from fastapi import FastAPI, Depends, HTTPException
from typing import List
from .db import collection
from .model import PropertyResponse, PropertyQueryParams
from .config import settings
from pymongo import ASCENDING

app = FastAPI(
    title="Property Listings API",
    description="An API to query real estate property listings with flexible filtering options.",
    version="1.0.0",
)

def build_query(params: PropertyQueryParams):
    """Dynamically build MongoDB query from request parameters."""
    query = {}

    if params.city:
        query["city"] = params.city
    if params.state:
        query["state"] = params.state
    if params.neighborhood:
        query["neighborhood"] = params.neighborhood
    if params.county:
        query["county"] = params.county
    if params.style:
        query["style"] = params.style
    if params.status:
        query["status"] = params.status
    if params.zip_code:
        query["zip_code"] = params.zip_code

    # Range-based filters
    if params.min_beds is not None or params.max_beds is not None:
        query["beds"] = {}
        if params.min_beds is not None:
            query["beds"]["$gte"] = params.min_beds
        if params.max_beds is not None:
            query["beds"]["$lte"] = params.max_beds

    if params.min_full_baths is not None or params.max_full_baths is not None:
        query["full_baths"] = {}
        if params.min_full_baths is not None:
            query["full_baths"]["$gte"] = params.min_full_baths
        if params.max_full_baths is not None:
            query["full_baths"]["$lte"] = params.max_full_baths

    if params.min_half_baths is not None or params.max_half_baths is not None:
        query["half_baths"] = {}
        if params.min_half_baths is not None:
            query["half_baths"]["$gte"] = params.min_half_baths
        if params.max_half_baths is not None:
            query["half_baths"]["$lte"] = params.max_half_baths

    if params.min_sqft is not None or params.max_sqft is not None:
        query["sqft"] = {}
        if params.min_sqft is not None:
            query["sqft"]["$gte"] = params.min_sqft
        if params.max_sqft is not None:
            query["sqft"]["$lte"] = params.max_sqft

    # Date range filter
    if params.min_listing_date or params.max_listing_date:
        query["list_date"] = {}
        if params.min_listing_date:
            query["list_date"]["$gte"] = params.min_listing_date
        if params.max_listing_date:
            query["list_date"]["$lte"] = params.max_listing_date

    return query

@app.get(
    "/property",
    response_model=List[PropertyResponse],
    summary="Retrieve property listings",
    description="Fetches a list of properties with flexible filtering options.",
)
async def get_properties(params: PropertyQueryParams = Depends()):
    query = build_query(params)
    properties = []
    async for doc in collection.find(query).sort("list_price", ASCENDING).limit(10):
        properties.append(PropertyResponse(**doc))
    if not properties:
        raise HTTPException(status_code=404, detail="No properties found.")
    return properties
