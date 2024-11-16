from pymongo import MongoClient
import redis

class DatabaseManager:
    def __init__(self):
        # MongoDB setup
        self.mongo_client = MongoClient("mongodb://localhost:27017/")
        self.mongo_db = self.mongo_client["chat_app"]
        self.mongo_collection = self.mongo_db["chat_context"]

        # Redis setup
        self.redis_client = redis.Redis(host='localhost', port=6379, decode_responses=True)

    def save_context(self, user_id, context):
        """
        Save or update user context in MongoDB.
        """
        self.mongo_collection.update_one(
            {"user_id": user_id},
            {"$set": {"context": context}},
            upsert=True
        )

    def get_context(self, user_id):
        """
        Retrieve user context from MongoDB.
        """
        doc = self.mongo_collection.find_one({"user_id": user_id})
        return doc.get("context", "") if doc else ""

    def save_chat_history(self, user_id, message):
        """
        Save chat history in Redis (cache).
        """
        self.redis_client.lpush(f"chat_history:{user_id}", message)

    def get_chat_history(self, user_id, limit=10):
        """
        Retrieve the latest chat history from Redis.
        """
        return self.redis_client.lrange(f"chat_history:{user_id}", 0, limit - 1)
