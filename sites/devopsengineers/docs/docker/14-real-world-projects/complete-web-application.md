---
sidebar_position: 1
title: Complete Web Application
---

# Complete Web Application: End-to-End Docker Project

**This is it. A complete web application. Dockerized. Production-ready. Real-world. Let's build it.**

## 🎯 The Big Picture

Think of this like building a complete restaurant. Not just the kitchen (backend). Not just the dining room (frontend). Everything. Complete. Production-ready. That's this project.

**This project shows everything. Frontend. Backend. Database. Complete setup. Production-ready. Real-world.**

## Project Overview

**What we're building:**
- Node.js backend API
- React frontend
- PostgreSQL database
- Nginx reverse proxy
- Complete Docker setup
- Production configuration

**Think of it as:** Complete restaurant. All components. Working together.

## Project Structure

```
my-app/
├── backend/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   └── src/
├── nginx/
│   └── nginx.conf
├── docker-compose.yml
└── .env
```

**That's the structure. Clean. Organized.**

## Backend Setup

**Backend Dockerfile:**
```dockerfile
FROM node:18-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine
WORKDIR /app
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

COPY --from=deps /app/node_modules ./node_modules
COPY . .

USER nodejs

HEALTHCHECK --interval=30s CMD node healthcheck.js

EXPOSE 3000
CMD ["node", "server.js"]
```

**Backend server.js:**
```javascript
const express = require('express');
const app = express();

app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

app.get('/api/data', (req, res) => {
  res.json({ message: 'Hello from backend!' });
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Backend running on port 3000');
});
```

**That's the backend. Simple. Works.**

## Frontend Setup

**Frontend Dockerfile:**
```dockerfile
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

**Frontend build:** Standard React app

**That's the frontend. Built. Served.**

## Database Setup

**PostgreSQL in Compose:**
```yaml
services:
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
      POSTGRES_DB: myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data
    secrets:
      - db_password
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U appuser"]
      interval: 10s
    networks:
      - backend
```

**That's the database. Configured. Persistent.**

## Complete Docker Compose

**docker-compose.yml:**
```yaml
services:
  # Backend
  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    image: my-app-backend:1.0.0
    environment:
      NODE_ENV: production
      DATABASE_URL: postgres://appuser:${DB_PASSWORD}@db:5432/myapp
    depends_on:
      db:
        condition: service_healthy
    networks:
      - backend
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
    restart: unless-stopped

  # Frontend
  frontend:
    build:
      context: ./frontend
      dockerfile: Dockerfile
    image: my-app-frontend:1.0.0
    depends_on:
      - backend
    networks:
      - frontend
      - backend
    restart: unless-stopped

  # Database
  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
      POSTGRES_DB: myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data
    secrets:
      - db_password
    networks:
      - backend
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U appuser"]
      interval: 10s
    restart: unless-stopped

  # Nginx
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - frontend
      - backend
    networks:
      - frontend
      - backend
    restart: unless-stopped

volumes:
  postgres-data:

secrets:
  db_password:
    file: ./secrets/db_password.txt

networks:
  frontend:
  backend:
    internal: true
```

**That's the complete setup. Production-ready.**

## Nginx Configuration

**nginx.conf:**
```nginx
events {
    worker_connections 1024;
}

http {
    upstream backend {
        server backend:3000;
    }

    server {
        listen 80;

        location /api {
            proxy_pass http://backend;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
        }

        location / {
            root /usr/share/nginx/html;
            try_files $uri $uri/ /index.html;
        }
    }
}
```

**That's Nginx. Routing. Load balancing.**

## Deployment

**Step 1: Create secrets**
```bash
mkdir -p secrets
echo "my-secret-password" > secrets/db_password.txt
chmod 600 secrets/db_password.txt
```

**Step 2: Build and start**
```bash
docker compose build
docker compose up -d
```

**Step 3: Verify**
```bash
docker compose ps
curl http://localhost/api/data
```

**That's deployment. Simple. Works.**

## Production Enhancements

**Add monitoring:**
```yaml
services:
  prometheus:
    image: prom/prometheus:latest
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro
    networks:
      - monitoring

  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    depends_on:
      - prometheus
    networks:
      - monitoring
```

**Add logging:**
```yaml
services:
  backend:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

**Complete. Production-ready.**

## Key Takeaways

1. **Complete setup** - Frontend, backend, database
2. **Production-ready** - Health checks, secrets, networking
3. **Best practices** - Multi-stage builds, non-root, resource limits
4. **Scalable** - Can add more replicas
5. **Maintainable** - Clean structure, documented

## What's Next?

Now that you've seen a complete web application, let's learn about microservices. Next: [Microservices Architecture](/docs/docker/14-real-world-projects/microservices-architecture).

---

> **Remember**: Complete web application is like a complete restaurant. All components. Working together. Production-ready. Real-world.

