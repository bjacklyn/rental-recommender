FROM python:3.12

WORKDIR /chat-app

# Install LLM dependencies
RUN python3 -m pip install \
  torch \
  transformers

COPY backend/meta-llama ./meta-llama

# Install backend web application dependencies
RUN python3 -m pip install \
  fastapi \
  opentelemetry-api \
  opentelemetry-sdk \
  opentelemetry-instrumentation-fastapi \
  opentelemetry-instrumentation-requests \
  opentelemetry-exporter-otlp \
  psycopg2 \
  pytest \
  sqlalchemy \
  uvicorn \
  websockets

COPY --from=frontend_build /chat-app/build ./build
COPY backend/app.py backend/chatbot.py backend/db.py backend/tracing.py ./
ENV DEV_MODE=true
RUN python3 -m pip install \
    accelerate \
    redis \
    pytest \
    pytest-cov