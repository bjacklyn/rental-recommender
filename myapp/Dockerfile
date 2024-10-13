FROM python:3-alpine

RUN python3 -m pip install \
  flask \
  flask_restx

RUN mkdir /opt/myapp
COPY app.py /opt/myapp/app.py
