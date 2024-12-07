FROM node:22 AS frontend_build

WORKDIR /web-app

COPY ./package.json ./package-lock.json ./
RUN npm install
RUN npm run build
