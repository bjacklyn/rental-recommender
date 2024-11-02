import asyncio
import boto3
import os

from botocore.exceptions import NoCredentialsError, PartialCredentialsError
from fastapi import APIRouter, FastAPI, Query, Request
from pathlib import Path
from typing import List


app = FastAPI(root_path="/rental-recommender")
router = APIRouter()
s3_client = boto3.client('s3')

# Configuration
BUCKET_NAME = "rentalrecommender"
CURRENT_FILE_PATH = Path("latest_model")
TEMP_FILE_PATH = Path("temp_latest_model")
CHECK_INTERVAL_SECONDS = 300

current_model = None
current_model_version = None


def get_latest_file():
    response = s3_client.list_objects_v2(Bucket='rentalrecommender')
    contents = response["Contents"]
    latest_file = max(contents, key=lambda x: x['LastModified'])
    return latest_file


async def download_latest_model():
    global current_model, current_model_version

    while True:
        try:
            # Get the latest file in S3 bucket
            latest_file = get_latest_file()
            if latest_file:
                print(latest_file)
                latest_file_version = latest_file["ETag"]
                if latest_file_version != current_model_version:
                    s3_client.download_file(BUCKET_NAME, latest_file["Key"], str(TEMP_FILE_PATH))

                    # TODO: Load file from disk at TEMP_FILE_PATH and if it loads successfully then..
                    # temp_model = load(TEMP_FILE_PATH)

                    os.replace(TEMP_FILE_PATH, CURRENT_FILE_PATH)
                    current_model_version = latest_file_version
                    # current_model = temp_model

                    print("New model downloaded, and loaded.")
                else:
                    print("Current model is up-to-date. No download needed.")

        except (NoCredentialsError, PartialCredentialsError) as e:
            print("Credentials error: ", e)
        except Exception as e:
            print("Error downloading or replacing file:", e)

        # Wait for the specified interval before checking again
        await asyncio.sleep(CHECK_INTERVAL_SECONDS)


@app.on_event("startup")
async def start_background_task():
    asyncio.create_task(download_latest_model())


@router.get("/api/get-rental-recommendations/{listing_id}")
async def get_chat_messages(listing_id: int, other_listing_ids: List[int] = Query(None)):
    # TODO: 1) Query listing-service for listing details with listing_id and other_listing_ids
    # TODO: 2) Run each listing through the clustering model inference
    # TODO: 3) Rank the clustered results and return them
    pass
