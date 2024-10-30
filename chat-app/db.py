from datetime import datetime
from sqlalchemy import create_engine, Column, DateTime, ForeignKey, Integer, String, and_
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, Session, sessionmaker

Base = declarative_base()


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)


class ChatLog(Base):
    __tablename__ = "chat_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))  # Foreign key to User table
    created_at = Column(DateTime, default=datetime.utcnow) # Automatically set to the current UTC time
    messages = relationship("ChatMessage", back_populates="chat_log")  # One-to-many relationship


class ChatMessage(Base):
    __tablename__ = "chat_messages"

    id = Column(Integer, primary_key=True, index=True)
    chat_log_id = Column(Integer, ForeignKey("chat_logs.id"))  # Foreign key to ChatLog table
    prompt = Column(String, index=True)  # User prompt
    response = Column(String, index=True)  # Bot response
    created_at = Column(DateTime, default=datetime.utcnow)  # Automatically set to the current UTC time
    chat_log = relationship("ChatLog", back_populates="messages")  # Many-to-one relationship


# TODO: Eventually use another database like postgres, but sqlite is good for development
DATABASE_URL = "sqlite:///./chatbot.db"  # Adjust path as needed
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
session = sessionmaker(autocommit=False, autoflush=False, bind=engine)


class ChatDB:
    def __init__(self):
        self.db = session()


    def __del__(self):
        self.db.close()


    @staticmethod
    def create_tables():
        # Create the database tables
        Base.metadata.create_all(bind=engine)


    async def get_or_create_user(self, username: str):
        user = self.db.query(User).filter(User.username == username).first()
        if not user:
            user = User(username=username)
            self.db.add(user)
            self.db.commit()
            self.db.refresh(user)
        return user


    def get_chat_log_for_user(self, user_id: int, chat_log_id: int):
        chat_log = self.db.query(ChatLog).filter(and_(ChatLog.user_id == user_id, ChatLog.id == chat_log_id)).first()
        return chat_log


    def get_chat_logs_for_user(self, user_id: int):
        # Query the ChatLog table for logs associated with the given user_id
        chat_logs = self.db.query(ChatLog).filter(ChatLog.user_id == user_id).all()
        return chat_logs


    def get_chat_messages_for_log(self, user_id: int, chat_log_id: int):
        messages = []
        # Ensure the current user is the owner of this ChatLog before leaking all the messages
        chat_log = self.get_chat_log_for_user(user_id, chat_log_id)
        if chat_log:
            # Get the ChatMessages for the associated ChatLog
            messages = self.db.query(ChatMessage).filter(ChatMessage.chat_log_id == chat_log_id).order_by(ChatMessage.created_at).all()
        return messages


    def create_chat_log(self, user_id: int):
        chat_log = ChatLog(user_id=user_id)
        self.db.add(chat_log)
        self.db.commit()
        self.db.refresh(chat_log)
        return chat_log


    def delete_chat_log(self, chat_log: ChatLog):
        self.db.delete(chat_log)
        self.db.commit()


    def add_chat_message(self, chat_log_id: int, prompt: str, response: str):
        chat_message = ChatMessage(chat_log_id=chat_log_id, prompt=prompt, response=response)
        self.db.add(chat_message)
        self.db.commit()
        self.db.refresh(chat_message)
        return chat_message


    def update_chat_message(self, chat_message: ChatMessage):
        self.db.commit()
