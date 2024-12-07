from pydantic import BaseModel, Field, validator
from typing import Optional, List

class PropertyResponse(BaseModel):
    property_id: Optional[int] = Field(None, description="Unique identifier for the property")
    property_url: Optional[str] = Field(None, description="URL to the property listing")
    status: Optional[str] = Field(None, description="Current status of the property")
    nearby_schools: Optional[str] = Field(None, description="Nearby schools information")
    office_name: Optional[str] = Field(None, description="Name of the real estate office")
    builder_name: Optional[str] = Field(None, description="Builder name")
    parking_garage: Optional[int] = Field(None, description="Number of parking garages")
    bathrooms: Optional[int] = Field(None, description="Total number of bathrooms")
    stories: Optional[int] = Field(None, description="Number of stories")
    county: Optional[str] = Field(None, description="County name")
    neighborhoods: Optional[str] = Field(None, description="Neighborhood name")
    latitude: Optional[float] = Field(None, description="Latitude coordinate")
    longitude: Optional[float] = Field(None, description="Longitude coordinate")
    text: Optional[str] = Field(None, description="Description of the property")
    style: Optional[str] = Field(None, description="Property style")
    full_street_line: Optional[str] = Field(None, description="Full street address")
    street: Optional[str] = Field(None, description="Street name")
    unit: Optional[str] = Field(None, description="Unit number, if applicable")
    city: Optional[str] = Field(None, description="City name")
    state: Optional[str] = Field(None, description="State abbreviation")
    zip_code: Optional[int] = Field(None, description="ZIP code")
    beds: Optional[int] = Field(None, description="Number of bedrooms")
    full_baths: Optional[int] = Field(None, description="Number of full bathrooms")
    half_baths: Optional[int] = Field(None, description="Number of half bathrooms")
    sqft: Optional[int] = Field(None, description="Square footage")
    year_built: Optional[int] = Field(None, description="Year the property was built")
    list_price: Optional[float] = Field(None, description="Listing price")
    list_price_min: Optional[float] = Field(None, description="Minimum list price")
    list_price_max: Optional[float] = Field(None, description="Maximum list price")
    list_date: Optional[str] = Field(None, description="Date when the property was listed")
    sold_price: Optional[float] = Field(None, description="Sold price")
    last_sold_date: Optional[str] = Field(None, description="Date of the last sale")
    assessed_value: Optional[float] = Field(None, description="Assessed value of the property")
    estimated_value: Optional[float] = Field(None, description="Estimated value of the property")
    new_construction: Optional[bool] = Field(None, description="Indicates if it is a new construction")
    lot_sqft: Optional[int] = Field(None, description="Lot size in square feet")
    price_per_sqft: Optional[float] = Field(None, description="Price per square foot")
    primary_photo: Optional[str] = Field(None, description="URL of the primary photo of the property") 

    @validator(
        "zip_code",
        "beds",
        "full_baths",
        "half_baths",
        "sqft",
        "year_built",
        "parking_garage",
        "stories",
        "lot_sqft",
        pre=True
    )
    def parse_int_fields(cls, value):
        """Convert empty strings or invalid integers to None."""
        if isinstance(value, str) and value.strip() == "":
            return None
        try:
            return int(value)
        except (ValueError, TypeError):
            return None

    @validator(
        "list_price",
        "list_price_min",
        "list_price_max",
        "sold_price",
        "assessed_value",
        "estimated_value",
        "price_per_sqft",
        "latitude",
        "longitude",
        pre=True
    )
    def parse_float_fields(cls, value):
        """Convert empty strings or invalid floats to None."""
        if isinstance(value, str) and value.strip() == "":
            return None
        try:
            return float(value)
        except (ValueError, TypeError):
            return None

    @validator("new_construction", pre=True)
    def parse_bool_fields(cls, value):
        """Convert 'False' or 'True' strings to boolean."""
        if isinstance(value, str):
            return value.strip().lower() == "true"
        return value

class PropertiesResponse(BaseModel):
        properties: List[PropertyResponse] = Field(
                        ..., description="List of property responses"
                            )


class PropertyQueryParams(BaseModel):
    city: Optional[str] = Field(None, example="San Jose")
    state: Optional[str] = Field(None, example="CA")
    zip_code: Optional[int] = Field(None, example=95125)
    min_beds: Optional[int] = Field(None, example=3)
    max_beds: Optional[int] = Field(None, example=5)
    min_sqft: Optional[int] = Field(None, example=1500)
    max_sqft: Optional[int] = Field(None, example=3000)

class PropertyIDs(BaseModel):
    property_ids: List[int] = Field(
        ..., description="List of property IDs to fetch details for."
    )
