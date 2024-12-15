import asyncio
import boto3
import gdown
import os
import pandas as pd
import pickle
import random
import requests

from botocore.exceptions import NoCredentialsError, PartialCredentialsError
from collections import defaultdict
from fastapi.middleware.cors import CORSMiddleware
from fastapi import APIRouter, FastAPI, Query, Request, HTTPException
from pathlib import Path
from sklearn.cluster import KMeans
from typing import List

ENV_TEST_FLAG = True

ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS", "*") 
origins = ALLOWED_ORIGINS.split(",") if ALLOWED_ORIGINS != "*" else ["*"]

app = FastAPI(root_path="/rental-recommender")
app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,  
    allow_credentials=True,
    allow_methods=["*"],  
    allow_headers=["*"],  
)
router = APIRouter()
s3_client = boto3.client('s3')

# Configuration
BUCKET_NAME = "rentalrecommender"
CURRENT_FILE_PATH = Path("latest_model")
TEMP_FILE_PATH = Path("temp_latest_model")
CHECK_INTERVAL_SECONDS = 300
HOUSE_DATA_CSV_FILENAME = "HouseData_CA_Complete.csv"
NUM_RECOMMENDATIONS = 3

current_model = None
current_model_version = None
df = None

def get_latest_file():
    response = s3_client.list_objects_v2(Bucket='rentalrecommender')
    contents = response["Contents"]
    latest_file = max(contents, key=lambda x: x['LastModified'])
    return latest_file


def load_model(file_path):
    with open(file_path, 'rb') as f:
        model_loaded = pickle.load(f)
        return model_loaded


async def download_latest_model():
    global current_model, current_model_version

    try:
        # Get the latest file in S3 bucket
        latest_file = get_latest_file()
        if latest_file:
            print(latest_file)
            latest_file_version = latest_file["ETag"]
            if latest_file_version != current_model_version:
                s3_client.download_file(BUCKET_NAME, latest_file["Key"], str(TEMP_FILE_PATH))

                # Load file from disk at TEMP_FILE_PATH and check if it loads successfully..
                temp_model = load_model(TEMP_FILE_PATH)

                os.replace(TEMP_FILE_PATH, CURRENT_FILE_PATH)
                current_model_version = latest_file_version
                current_model = temp_model

                print("New model downloaded, and loaded.")
            else:
                print("Current model is up-to-date. No download needed.")

    except (NoCredentialsError, PartialCredentialsError) as e:
        print("Credentials error: ", e)
    except Exception as e:
        print("Error downloading or replacing file:", e)


async def download_latest_model_loop():
    while True:
        # Download latest model if available
        await download_latest_model()

        # Wait for the specified interval before checking again
        await asyncio.sleep(CHECK_INTERVAL_SECONDS)


@app.on_event("startup")
async def start_background_task():
    if ENV_TEST_FLAG:
        print("Skipping model download while testing..")
        return
    await download_latest_model()
    asyncio.create_task(download_latest_model_loop())


def fetch_listings(requests_func, search_criteria):
    """Fetches property details from external API."""
    property_details = {}

    api_url = "http://18.119.153.150:8010/api/v1/housing-properties"
    try:
        response = requests_func(api_url, json=search_criteria, headers={"Content-Type": "application/json"})
        if response.status_code == 200:
            api_response = response.json()
            print(f"API response: {api_response}")
            if isinstance(api_response, list):
                property_details = api_response
            elif isinstance(api_response, dict):
                property_details = api_response.get("properties", [])
        else:
            print(f"Failed to fetch property details from API. Status: {response.status_code}, Response: {response.text}")
    except requests.RequestException as e:
        print(f"Error during API call: {e}")

    return property_details


#def fetch_listings_by_zip_code(zip_code):
#    search_criteria = {"zip_code": zip_code}
#    return fetch_listings(requests.get, search_criteria)


def fetch_listings_by_zip_code(zip_code, property_id):
    return df[(df['zip_code'] == zip_code) & (df['property_id'] != property_id)].to_dict(orient='records')


def fetch_listings_by_property_ids_api(property_ids):
    search_criteria = {"property_ids": property_ids}
    return fetch_listings(requests.post, search_criteria)


def fetch_listings_by_property_ids(property_ids):
    return df[df['property_id'].isin(property_ids)].to_dict(orient='records')


cache = {}
def predict(data):
    if not current_model or not current_model_version:
        print("Model missing, cannot perform predictions")
        return None

    if current_model_version not in cache:
        cache[current_model_version] = {}

    predicted_labels = {}
    missing_property_id_labels = []

    df = pd.DataFrame(data)

    for index, property_id in df['property_id'].items():
        if property_id in cache[current_model_version]:
            predicted_labels[property_id] = cache[current_model_version][property_id]
        else:
            missing_property_id_labels.append(property_id)

    if missing_property_id_labels:
        df = df[df["property_id"].isin(missing_property_id_labels)]

        df_for_inference = df.drop(['property_id', 'zip_code'], axis=1)
        predictions = current_model.predict(df_for_inference)

        for index, property_id in df['property_id'].items():
            predicted_labels[property_id] = cache[current_model_version][property_id] = predictions[index]

    return predicted_labels


@router.get("/api/get-rental-recommendations/{property_id}")
async def get_rental_recommendations(property_id: int):
    if property_id < 0:
        raise HTTPException(status_code=422, detail='property_id must be positive integer')

    if property_id.bit_length() > 63:
        raise HTTPException(status_code=422, detail='property_id value must fit in 64 bits')

    # 1) Query listing-service for listing details with property_id
    property_id_details = fetch_listings_by_property_ids([property_id])

    # 2) Query listing-service for all properties in same zip code
    zip_code = property_id_details[0]["zip_code"]
    same_zip_code_property_details = fetch_listings_by_zip_code(zip_code, property_id)

    property_ids = []
    if ENV_TEST_FLAG:
        property_ids = [property['property_id'] for property in same_zip_code_property_details]
        print("property_ids", property_ids)
    else:
        # 3) Run properties through the clustering model inference
        property_id_predicted_label  = predict(property_id_details)[property_id]
        print(f"Predicted label {property_id_predicted_label} for property id {property_id}")

        same_zip_code_predicted_labels = predict(same_zip_code_property_details)
        print(same_zip_code_predicted_labels)

        # 4) Filter other properties by those in same cluster as original property_id
        clustered_property_ids = [property_id for property_id, predicted_label in same_zip_code_predicted_labels.items() if predicted_label == property_id_predicted_label]
        print(clustered_property_ids)

        print(len(same_zip_code_predicted_labels.keys()))
        print(len(clustered_property_ids))
        property_ids = random.sample(clustered_property_ids, NUM_RECOMMENDATIONS)

    properties = fetch_listings_by_property_ids_api(property_ids)
    return {"properties":properties}


def preprocess_data(df):
    ### Fix Type Conversions

    # Date
    date_columns = ['list_date', 'last_sold_date']
    for col in date_columns:
        if col in df.columns:
            df[col] = pd.to_datetime(df[col], errors='coerce')
    # Numeric
    numeric_columns = ['beds', 'full_baths', 'half_baths', 'lot_sqft',
                       'list_price', 'sold_price', 'year_built', 'latitude', 'longitude', 'parking_garage', 'zip_code']
    df[numeric_columns] = df[numeric_columns].apply(pd.to_numeric, errors='coerce')

    # Categorical
    categorical_columns = ['property_type', 'status', 'style', 'neighborhoods']
    for col in categorical_columns:
        if col in df.columns:
            df[col] = df[col].astype('category')


    # String Standardization
    string_columns = ['city', 'state', 'street', 'unit']
    for col in string_columns:
        if col in df.columns:
            df[col] = df[col].str.strip().str.lower()

    ### Imputation for Missing Values

    # Impute `half_baths` with 0 for missing values.
    df['half_baths'] = df['half_baths'].fillna(0)

    # Impute `year_built` with placeholder 9999
    df['year_built'] = df['year_built'].fillna(9999)

    # Impute `parking_garage` with 0
    df['parking_garage'] = df['parking_garage'].fillna(0)
    df['parking_garage'] = df['parking_garage'].apply(lambda x: x if x <= 10 else None)

    ### Group-based imputation for location
    df['latitude'] = df['latitude'].fillna(
        df.groupby('city')['latitude'].transform('mean')
    )
    df['longitude'] = df['longitude'].fillna(
        df.groupby('city')['longitude'].transform('mean')
    )

    # Fallback if city is not available
    df['latitude'] = df['latitude'].fillna(
        df.groupby('state')['latitude'].transform('mean')
    )
    df['longitude'] = df['longitude'].fillna(
        df.groupby('state')['longitude'].transform('mean')
    )

    ### Mean/Median/Mode based imputation

    df['sold_price'] = df['sold_price'].fillna(df['sold_price'].mean())

    df['lot_sqft'] = df['lot_sqft'].fillna(df['lot_sqft'].median())
    df['list_price'] = df['list_price'].fillna(df['list_price'].median())


    if 'neighborhoods' in df.columns and df['neighborhoods'].dtype.name == 'category' and 'Unknown' not in df['neighborhoods'].cat.categories:
        df['neighborhoods'] = df['neighborhoods'].cat.add_categories(['Unknown'])

    df['neighborhoods'] = df['neighborhoods'].fillna(
        df.groupby(['city', 'style'])['neighborhoods'].transform(lambda x: x.mode()[0] if not x.mode().empty else 'Unknown')
    )

    unknown_impute_col = ['neighborhoods']
    for col in unknown_impute_col:
        df[col] = df[col].fillna('Unknown')

    ### Drop irrelevant columns

    invalid_flags = [
        # 'is_invalid_beds', 'is_invalid_full_baths', 'is_invalid_half_baths',
        'is_invalid_beds',
        'is_invalid_year_built', 'is_invalid_latitude', 'is_invalid_longitude',
        'is_invalid_lot_sqft', 'is_invalid_list_date'
    ]
    columns_to_remove = ['listing_id','unit','agent_email','agent_phones','alt_photos','mls_id','fips_code','is_invalid_row','property_url','mls','list_price_min','list_price_max','office_id','agent_id','builder_name', 'builder_id','agent_nrds_id','broker_id','broker_name','hoa_fee','office_email','office_phones','agent_mls_set','agent_name','office_mls_set','office_name']
    # columns_to_remove = ['property_id','listing_id','unit','agent_email','agent_phones','alt_photos','mls_id','fips_code','is_invalid_row','property_url','mls','list_price_min','list_price_max','office_id','agent_id','builder_name', 'builder_id','agent_nrds_id','broker_id','broker_name','hoa_fee','office_email','office_phones','agent_mls_set','agent_name','office_mls_set','office_name']
    columns_to_remove.extend(invalid_flags)
    df = df.drop(columns=columns_to_remove, errors='ignore')

    ### Fixup property_id column
    df["property_id"] = pd.to_numeric(df['property_id'], downcast='integer', errors='coerce')
    df = df.dropna(subset=['property_id'])
    df['property_id'] = df['property_id'].astype(int)

    numerics = ['int16', 'int32', 'int64', 'float16', 'float32', 'float64']
    df = df.select_dtypes(include=numerics)
    df.fillna(0, inplace=True)

    return df


@app.on_event("startup")
def startup_event() -> None:
    if not os.path.exists(HOUSE_DATA_CSV_FILENAME):
        try:
            gdown.download(id="1Ey4OGTEK8t8irdWHF1bpIO4KQnu0kjeV", output=HOUSE_DATA_CSV_FILENAME)
            print(f"Successfully downloaded {HOUSE_DATA_CSV_FILENAME}")
        except Exception as e:
            print(f"Failed to download {HOUSE_DATA_CSV_FILENAME}")
    else:
        print(f"{HOUSE_DATA_CSV_FILENAME} already downloaded")

    global df
    df = pd.read_csv(HOUSE_DATA_CSV_FILENAME)
    df = preprocess_data(df)


app.include_router(router)
