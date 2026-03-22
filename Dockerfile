FROM node:latest
#FROM oven/bun:latest

WORKDIR /app

# Install dependencies
COPY package.json ./
RUN npm install

# Default command (can be overridden in docker-compose)
CMD ["npm", "run", "dev"]
