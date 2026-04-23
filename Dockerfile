# ---------- Builder ----------
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm install --production

COPY . .

# ---------- Runtime ----------
FROM node:18-alpine

WORKDIR /app

# Copy only necessary artifacts
COPY --from=builder /app /app

ENV NODE_ENV=production

EXPOSE 8080

CMD ["node", "server.js"]
