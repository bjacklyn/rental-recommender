from models import PropertyResponse
from motor.motor_asyncio import AsyncIOMotorClient

# Hardcoded MongoDB credentials
MONGO_URL = "mongodb://dev:MongoDBDev@localhost:27017/dev?directConnection=true&authSource=dev"
DB_NAME = "dev"
COLLECTION_NAME = "sample"

# Log the credentials (optional, useful for debugging, remove in production)
print(f"MONGO_URL: {MONGO_URL}")
print(f"DB_NAME: {DB_NAME}")
print(f"COLLECTION_NAME: {COLLECTION_NAME}")

# Initialize MongoDB client and database connection
client = AsyncIOMotorClient(MONGO_URL)
db = client[DB_NAME]
collection = db[COLLECTION_NAME]
