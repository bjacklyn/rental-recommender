# config.py
from pydantic_settings import BaseSettings
from functools import lru_cache
from dotenv import load_dotenv
import os

# Load environment variables from .env file
load_dotenv("./.env")

class Settings(BaseSettings):
    mongodb_url: str = os.getenv("MONGODB_URL")
    database_name: str = os.getenv("DATABASE_NAME")
    collection_name: str = os.getenv("COLLECTION_NAME")

    class Config:
        env_file = "./.env"  # Optional, additional loading

@lru_cache()
def get_settings():
    settings = Settings()
    print("MONGODB_URL:", settings.mongodb_url)  # Debug print
    print("DATABASE_NAME:", settings.database_name)  # Debug print
    print("COLLECTION_NAME:", settings.collection_name)  # Debug print
    return settings

settings = get_settings()