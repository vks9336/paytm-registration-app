# Stage 1: Build Node app
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Final container with Node & Nginx
FROM node:18-alpine
WORKDIR /app

# Copy app from builder stage
COPY --from=builder /app /app

# Copy Nginx config and install Nginx
RUN apk add --no-cache nginx && \
    mkdir -p /run/nginx

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# Start Node and Nginx
CMD ["sh", "-c", "node app.js & nginx -g 'daemon off;'"]
