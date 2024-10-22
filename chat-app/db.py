import sqlite3

DATABASE = "chatbot.db"

def create_table():
    with sqlite3.connect(DATABASE) as conn:
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS chat_interactions (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                chat_id TEXT NOT NULL,
                user_message TEXT NOT NULL,
                bot_response TEXT,
                timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
            )
        """)
        conn.commit()

def store_chat(chat_id, user_message, bot_response):
    with sqlite3.connect(DATABASE) as conn:
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO chat_interactions (chat_id, user_message, bot_response)
            VALUES (?, ?, ?)
        """, (chat_id, user_message, bot_response))
        conn.commit()

def load_chats(chat_id):
    with sqlite3.connect(DATABASE) as conn:
        cursor = conn.cursor()
        cursor.execute("""
            SELECT user_message, bot_response, timestamp
            FROM chat_interactions
            WHERE chat_id = ?
            ORDER BY timestamp
        """, (chat_id,))
        return cursor.fetchall()
