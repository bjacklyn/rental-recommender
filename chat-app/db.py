from sqlalchemy import create_engine, Column, ForeignKey, Integer, String
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, Session, sessionmaker

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
    messages = relationship("ChatMessage", back_populates="chat_log")  # One-to-many relationship


class ChatMessage(Base):
    __tablename__ = "chat_messages"

    id = Column(Integer, primary_key=True, index=True)
    chat_log_id = Column(Integer, ForeignKey("chat_logs.id"))  # Foreign key to ChatLog table
    prompt = Column(String, index=True)  # User prompt
    response = Column(String, index=True)  # Bot response
    chat_log = relationship("ChatLog", back_populates="messages")  # Many-to-one relationship


def create_tables():
    # Create the database tables
    Base.metadata.create_all(bind=engine)


def get_db_session():
    db = SessionLocal()
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
