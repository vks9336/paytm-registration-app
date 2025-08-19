# Stage 1 - Node app
FROM node:18 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2 - Nginx with Node app
FROM nginx:alpine
COPY --from=builder /usr/src/app /app
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /app
CMD ["sh", "-c", "node app.js & nginx -g 'daemon off;'"]

