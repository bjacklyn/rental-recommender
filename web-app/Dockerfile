# Use the official Node.js image as the base image
FROM node:18-alpine AS frontend_build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire application code into the container
#COPY ./node_modules/ ./node_modules
COPY ./src/ ./src
COPY ./public/ ./public
COPY ./.env ./.env

RUN npm run build

# Expose port 3000 for the React app
#EXPOSE 3000

# Start the React application
#CMD ["npm", "start"]
#CMD ["uvicorn", "app:app", "--host", "0.0.0.0"]


# Stage 2: Serve the app with the FastAPI backend
FROM python:3.12

WORKDIR /web-app

RUN python3 -m pip install \
  fastapi \
  uvicorn

COPY app.py .

COPY --from=frontend_build /usr/src/app/build ./build
