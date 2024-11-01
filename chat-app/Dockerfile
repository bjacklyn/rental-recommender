# Stage 1: Build the React frontend app
FROM node:14 AS frontend_build
WORKDIR /chat-app
COPY ./frontend/package.json ./frontend/package-lock.json ./
RUN npm install
COPY ./frontend ./
RUN npm run build

# Stage 2: Serve the app with the FastAPI backend

FROM python:3.12

# Install LLM dependencies
RUN python3 -m pip install \
  torch \
  transformers

# Install backend web application dependencies
RUN python3 -m pip install \
  fastapi \
  sqlalchemy \
  uvicorn \
  websockets

WORKDIR /chat-app

COPY backend/meta-llama ./meta-llama
COPY --from=frontend_build /chat-app/build ./build
COPY backend/app.py backend/chatbot.py backend/db.py ./

CMD ["uvicorn", "app:app"]
