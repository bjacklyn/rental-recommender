FROM python:3-alpine

RUN python3 -m pip install \
  fastapi \
  sqlalchemy \
  uvicorn

RUN mkdir /opt/chat-app
COPY app.py /opt/chat-app/app.py
COPY db.py /opt/chat-app/db.py

RUN mkdir /opt/chat-app/static
COPY static/script.js /opt/chat-app/static/script.js
COPY static/style.css /opt/chat-app/static/style.css

WORKDIR /opt/chat-app
