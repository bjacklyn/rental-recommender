from pydantic import BaseModel, Field, validator
from typing import Optional, List, Union
from datetime import date, datetime

# Model for Query Parameters with Data Cleaning
class PropertyQueryParams(BaseModel):
    city: Optional[str] = None
    state: Optional[str] = None
    neighborhood: Optional[str] = None
    county: Optional[str] = None
    style: Optional[str] = Field(None, description="Property style, e.g., CONDO")
    status: Optional[str] = Field(None, description="Status, e.g., FOR_RENT, RENTED")
    zip_code: Optional[Union[int, str]] = None
    min_beds: Optional[Union[int, str]] = None
    max_beds: Optional[Union[int, str]] = None
    min_full_baths: Optional[Union[int, str]] = None
    max_full_baths: Optional[Union[int, str]] = None
    min_half_baths: Optional[Union[int, str]] = None
    max_half_baths: Optional[Union[int, str]] = None
    min_sqft: Optional[Union[int, str]] = None
    max_sqft: Optional[Union[int, str]] = None
    min_listing_date: Optional[Union[date, str]] = None
    max_listing_date: Optional[Union[date, str]] = None

    # Validators for cleaning and converting query parameters
    @validator('*', pre=True)
    def clean_empty_strings(cls, v):
        """Convert empty strings to None for all fields."""
        return None if v == "" else v

    @validator('zip_code', 'min_beds', 'max_beds', 'min_full_baths', 'max_full_baths', 'min_half_baths', 'max_half_baths', 'min_sqft', 'max_sqft', pre=True)
    def parse_int_query_fields(cls, v):
        """Convert values to integers, set to None if conversion fails."""
        try:
            return int(v)
        except (TypeError, ValueError):
            return None

    @validator('min_listing_date', 'max_listing_date', pre=True)
    def parse_date_query_fields(cls, v):
        """Parse dates, set None if conversion fails."""
        if isinstance(v, date):
            return v
        try:
            return datetime.strptime(v, "%Y-%m-%d").date()
        except (TypeError, ValueError):
            return None

# Model for Property Response with Data Cleaning
class PropertyResponse(BaseModel):
    property_url: Optional[str] = None
    property_id: Optional[int] = None
    listing_id: Optional[int] = None
    mls: Optional[str] = None
    mls_id: Optional[str] = None
    status: Optional[str] = None
    text: Optional[str] = None
    style: Optional[str] = None
    full_street_line: Optional[str] = None
    street: Optional[str] = None
    unit: Optional[str] = None
    city: Optional[str] = None
    state: Optional[str] = None
    zip_code: Optional[Union[int, str]] = None
    beds: Optional[Union[int, str]] = None
    full_baths: Optional[Union[int, str]] = None
    half_baths: Optional[Union[int, str]] = None
    sqft: Optional[Union[int, str]] = None
    year_built: Optional[Union[int, str]] = None
    days_on_mls: Optional[Union[int, str]] = None
    list_price: Optional[Union[float, str]] = None
    list_price_min: Optional[float] = None
    list_price_max: Optional[float] = None
    list_date: Optional[Union[date, str]] = None
    sold_price: Optional[Union[float, str]] = None
    last_sold_date: Optional[Union[date, str]] = None
    assessed_value: Optional[float] = None
    estimated_value: Optional[Union[float, str]] = None
    new_construction: Optional[bool] = None
    lot_sqft: Optional[Union[int, str]] = None
    price_per_sqft: Optional[Union[float, str]] = None
    latitude: Optional[float] = None
    longitude: Optional[float] = None
    neighborhood: Optional[str] = None
    county: Optional[str] = None
    fips_code: Optional[str] = None
    stories: Optional[Union[int, str]] = None
    hoa_fee: Optional[Union[int, str]] = None
    parking_garage: Optional[Union[int, str]] = None
    agent_id: Optional[Union[int, str]] = None
    agent_name: Optional[str] = None
    agent_email: Optional[str] = None
    agent_phones: Optional[str] = None
    agent_mls_set: Optional[str] = None
    agent_nrds_id: Optional[str] = None
    broker_id: Optional[str] = None
    broker_name: Optional[str] = None
    builder_id: Optional[str] = None
    builder_name: Optional[str] = None
    office_id: Optional[str] = None
    office_mls_set: Optional[str] = None
    office_name: Optional[str] = None
    office_email: Optional[str] = None
    office_phones: Optional[str] = None
    nearby_schools: Optional[str] = None
    primary_photo: Optional[str] = None
    alt_photos: Optional[Union[List[str], str]] = None  # Allow None or a list of strings

    # Validators for cleaning and converting response data fields
    @validator('*', pre=True)
    def clean_empty_strings(cls, v):
        """Convert empty strings to None for all fields."""
        return None if v == "" else v

    @validator('zip_code', 'beds', 'full_baths', 'half_baths', 'sqft', 'year_built', 'days_on_mls', 'lot_sqft', 'stories', 'hoa_fee', 'parking_garage', 'agent_id', pre=True)
    def parse_int_fields(cls, v):
        """Convert values to integers, set to None if conversion fails."""
        try:
            return int(v)
        except (TypeError, ValueError):
            return None

    @validator('list_price', 'sold_price', 'estimated_value', 'price_per_sqft', pre=True)
    def parse_float_fields(cls, v):
        """Convert values to floats, set None if conversion fails."""
        try:
            return float(v)
        except (TypeError, ValueError):
            return None

    @validator('list_date', 'last_sold_date', pre=True)
    def parse_date_fields(cls, v):
        """Parse dates, set None if conversion fails."""
        if isinstance(v, date):
            return v
        try:
            return datetime.strptime(v, "%Y-%m-%d").date()
        except (TypeError, ValueError):
            return None
