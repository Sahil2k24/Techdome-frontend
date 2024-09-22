# Base image
FROM node:16-alpine AS build

# Set working dir
WORKDIR /app

# Copy yje required packages
COPY package*.json ./

# Install the required dependencies
RUN npm install

# Copy the application files
COPY . .

# Build the frontend application
RUN npm run build

# Use nginx to serve the traffic and copy the built image from the first stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# Expose the port
EXPOSE 80
