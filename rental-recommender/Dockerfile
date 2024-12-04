FROM python:3.12

WORKDIR /rental-recommender

# Install backend web application dependencies
RUN python3 -m pip install \
  boto3 \
  fastapi \
  gdown \
  opentelemetry-api \
  opentelemetry-sdk \
  opentelemetry-instrumentation-fastapi \
  opentelemetry-instrumentation-requests \
  opentelemetry-exporter-otlp \
  pandas \
  pytest \
  requests \
  scikit-learn==1.4.2 \
  uvicorn

COPY app.py ./

CMD ["uvicorn", "app:app", "--host", "0.0.0.0"]
