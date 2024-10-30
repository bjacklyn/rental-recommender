from datetime import datetime
from sqlalchemy import create_engine, Column, DateTime, ForeignKey, Integer, String, and_
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, Session, sessionmaker

Base = declarative_base()


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    username = Column(String, unique=True, index=True)


class Chat(Base):
    __tablename__ = "chats"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))  # Foreign key to User table
    created_at = Column(DateTime, default=datetime.utcnow) # Automatically set to the current UTC time
    chat_messages = relationship("ChatMessage", back_populates="chats")  # One-to-many relationship


class ChatMessage(Base):
    __tablename__ = "chat_messages"

    id = Column(Integer, primary_key=True, index=True)
    chat_id = Column(Integer, ForeignKey("chats.id"))  # Foreign key to Chat table
    prompt = Column(String, index=True)  # User prompt
    response = Column(String, index=True)  # Bot response
    created_at = Column(DateTime, default=datetime.utcnow)  # Automatically set to the current UTC time
    chats = relationship("Chat", back_populates="chat_messages")  # Many-to-one relationship


# TODO: Eventually use another database like postgres, but sqlite is good for development
DATABASE_URL = "sqlite:///./chatbot.db"  # Adjust path as needed
engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
session = sessionmaker(autocommit=False, autoflush=False, bind=engine)


class ChatDB:
    def __init__(self):
        self.db = session()
        print("Created session")


    def __del__(self):
        self.db.close()
        print("Deleted session")


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


    def get_chat(self, user_id: int, chat_id: int):
        chat = self.db.query(Chat).filter(and_(Chat.user_id == user_id, Chat.id == chat_id)).first()
        return chat


    def get_chats(self, user_id: int):
        # Query the Chat table for chats associated with the given user_id
        chats = self.db.query(Chat).filter(Chat.user_id == user_id).all()
        return chats


    def get_chat_message(self, chat_message_id: int):
        chat_message = self.db.query(ChatMessage).filter(ChatMessage.id == chat_message_id).first()
        return chat_message


    def get_chat_messages(self, user_id: int, chat_id: int):
        messages = []
        # Ensure the current user is the owner of this Chat before leaking all the messages
        chat = self.get_chat(user_id, chat_id)
        if chat:
            # Get the ChatMessages for the associated Chat
            messages = self.db.query(ChatMessage).filter(ChatMessage.chat_id == chat_id).order_by(ChatMessage.created_at).all()
        return messages


    def create_chat(self, user_id: int):
        chat = Chat(user_id=user_id)
        self.db.add(chat)
        self.db.commit()
        self.db.refresh(chat)
        return chat


    def delete_chat(self, chat: Chat):
        self.db.delete(chat)
        self.db.commit()


    def create_chat_message(self, chat_id: int, prompt: str, response: str):
        chat_message = ChatMessage(chat_id=chat_id, prompt=prompt, response=response)
        self.db.add(chat_message)
        self.db.commit()
        self.db.refresh(chat_message)
        return chat_message


    def update_chat_message(self, chat_message: ChatMessage):
        self.db.commit()
        self.db.refresh(chat_message)
