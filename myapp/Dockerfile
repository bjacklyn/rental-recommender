FROM python:3-alpine

RUN python3 -m pip install \
  flask \
  flask_restx \
  opentelemetry-api \
  opentelemetry-sdk \
  opentelemetry-instrumentation-flask \
  opentelemetry-exporter-otlp
#  opentelemetry-exporter-jaeger

RUN mkdir /opt/myapp
COPY app.py /opt/myapp/app.py
