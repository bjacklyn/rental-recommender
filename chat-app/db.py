from datetime import datetime
from sqlalchemy import create_engine, Column, DateTime, ForeignKey, Integer, String, and_
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, Session, sessionmaker

# TODO: Eventually use another database like postgres, but sqlite is good for development
DATABASE_URL = "sqlite:///./chatbot.db"  # Adjust path as needed

engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})
session = sessionmaker(autocommit=False, autoflush=False, bind=engine)

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


def create_tables():
    # Create the database tables
    Base.metadata.create_all(bind=engine)


def get_db_session():
    db = session()
    try:
        yield db
    finally:
        db.close()


async def get_or_create_user(username: str, db: Session):
    user = db.query(User).filter(User.username == username).first()
    if not user:
        user = User(username=username)
        db.add(user)
        db.commit()
        db.refresh(user)
    return user


def get_chat_log_for_user(user_id: int, chat_log_id: int, db: Session):
    chat_log = db.query(ChatLog).filter(and_(ChatLog.user_id == user_id, ChatLog.id == chat_log_id)).first()
    return chat_log


def get_chat_logs_for_user(user_id: int, db: Session):
    # Query the ChatLog table for logs associated with the given user_id
    chat_logs = db.query(ChatLog).filter(ChatLog.user_id == user_id).all()
    return chat_logs


def get_chat_messages_for_log(user_id: int, chat_log_id: int, db: Session):
    messages = []
    # Ensure the current user is the owner of this ChatLog before leaking all the messages
    chat_log = get_chat_log_for_user(user_id, chat_log_id, db)
    if chat_log:
        # Get the ChatMessages for the associated ChatLog
        messages = db.query(ChatMessage).filter(ChatMessage.chat_log_id == chat_log_id).order_by(ChatMessage.created_at).all()
    return messages


def create_chat_log(user_id: int, db: Session):
    chat_log = ChatLog(user_id=user_id)
    db.add(chat_log)
    db.commit()
    db.refresh(chat_log)
    return chat_log


def add_chat_message(chat_log_id: int, prompt: str, response: str, db: Session):
    chat_message = ChatMessage(chat_log_id=chat_log_id, prompt=prompt, response=response)
    db.add(chat_message)
    db.commit()
    db.refresh(chat_message)
    return chat_message


def delete_chat_log(chat_log: ChatLog, db: Session):
    db.delete(chat_log)
    db.commit()
