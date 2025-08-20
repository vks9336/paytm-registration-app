# Stage 1 - Build Node dependencies
FROM node:18 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --production
COPY . .

# Stage 2 - Runtime with Nginx + Node
FROM nginx:alpine

# Install Node.js in the nginx container
RUN apk add --no-cache nodejs npm

WORKDIR /app
# Copy app
COPY --from=builder /usr/src/app /app
# Copy Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# Start both services
CMD sh -c "cd /app && node app.js & nginx -g 'daemon off;'"

