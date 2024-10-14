FROM python:3-alpine

RUN python3 -m pip install \
  flask \
  flask_restx \
  opentelemetry-api \
  opentelemetry-sdk \
  opentelemetry-instrumentation-flask \
  opentelemetry-instrumentation-logging \
  opentelemetry-exporter-otlp

RUN mkdir /opt/myapp
COPY app.py /opt/myapp/app.py
