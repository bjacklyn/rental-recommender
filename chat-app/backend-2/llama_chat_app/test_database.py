from database_manager import DatabaseManager

db_manager = DatabaseManager()

# Test MongoDB: Save and retrieve context
db_manager.save_context("user123", "This is the user context.")
retrieved_context = db_manager.get_context("user123")
print("MongoDB - Retrieved Context:", retrieved_context)

# Test Redis: Save and retrieve chat history
db_manager.save_chat_history("user123", "Hello, this is a test message!")
history = db_manager.get_chat_history("user123", limit=5)
print("Redis - Retrieved Chat History:", history)
