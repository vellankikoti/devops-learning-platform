---
sidebar_position: 5
title: Production Compose
---

# Production Compose: Running Compose in Production

**Development Compose files work. But production needs more. Security. Performance. Reliability. Monitoring. That's what production Compose is about.**

## 🎯 The Big Picture

Think of production Compose like a professional kitchen vs home kitchen. Home kitchen (development) is simple. Professional kitchen (production) has safety standards, quality controls, monitoring systems.

**Production Compose files are professional-grade. Secure. Reliable. Monitored. Production-ready.**

## Development vs Production

**Development Compose:**
- Simple configuration
- Bind mounts for code
- Debug mode enabled
- No security hardening
- Works for development

**Production Compose:**
- Secure configuration
- Named volumes only
- Optimized settings
- Security hardening
- Monitoring enabled
- Production-ready

**The difference:** Development works. Production is secure and reliable.

## Production Best Practices

### 1. Use Specific Image Tags

**Don't do this:**
```yaml
services:
  app:
    image: nginx:latest
```

**Do this:**
```yaml
services:
  app:
    image: nginx:1.21-alpine
```

**Why:** Predictable. Reproducible. No surprises.

### 2. Use Named Volumes Only

**Don't do this:**
```yaml
services:
  app:
    volumes:
      - ./data:/app/data  # Bind mount
```

**Do this:**
```yaml
services:
  app:
    volumes:
      - app-data:/app/data  # Named volume

volumes:
  app-data:
```

**Why:** Portable. Managed. Secure.

### 3. Set Resource Limits

**Add resource limits:**
```yaml
services:
  app:
    image: my-app:1.0
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
```

**Why:** Prevent resource exhaustion. Fair resource sharing.

### 4. Use Health Checks

**Add health checks:**
```yaml
services:
  app:
    image: my-app:1.0
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

**Why:** Know when service is healthy. Automatic recovery.

### 5. Set Restart Policies

**Always restart:**
```yaml
services:
  app:
    image: my-app:1.0
    restart: unless-stopped
```

**Options:**
- `no` - Don't restart
- `always` - Always restart
- `on-failure` - Restart on failure
- `unless-stopped` - Restart unless manually stopped

**Why:** Automatic recovery. High availability.

### 6. Use Secrets Management

**Don't hard-code secrets:**
```yaml
# BAD
environment:
  DB_PASSWORD: my-secret-password
```

**Do use secrets:**
```yaml
# GOOD
secrets:
  db_password:
    file: ./secrets/db_password.txt

services:
  db:
    secrets:
      - db_password
```

**Or use Docker secrets:**
```yaml
secrets:
  db_password:
    external: true

services:
  db:
    secrets:
      - db_password
```

**Why:** Secure. Not in files. Managed properly.

## Real-World Production Compose File

**Let me show you a production-ready file:**

```yaml
services:
  # PostgreSQL Database
  postgres:
    image: postgres:14-alpine
    environment:
      POSTGRES_USER: ${DB_USER}
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
      POSTGRES_DB: ${DB_NAME}
    volumes:
      - postgres-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5
      start_period: 30s
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '2.0'
          memory: 2G
        reservations:
          cpus: '1.0'
          memory: 1G
    networks:
      - backend
    secrets:
      - db_password

  # Redis Cache
  redis:
    image: redis:7-alpine
    command: redis-server --requirepass ${REDIS_PASSWORD} --appendonly yes
    volumes:
      - redis-data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
    networks:
      - backend

  # Application
  app:
    build:
      context: .
      dockerfile: Dockerfile.prod
    environment:
      NODE_ENV: production
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: ${DB_USER}
      DB_PASSWORD_FILE: /run/secrets/db_password
      DB_NAME: ${DB_NAME}
      REDIS_HOST: redis
      REDIS_PASSWORD: ${REDIS_PASSWORD}
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    restart: unless-stopped
    deploy:
      replicas: 2
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M
    networks:
      - backend
      - frontend
    secrets:
      - db_password

  # Nginx Web Server
  nginx:
    image: nginx:1.21-alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
      - nginx-cache:/var/cache/nginx
    depends_on:
      app:
        condition: service_healthy
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost/health"]
      interval: 30s
      timeout: 10s
      retries: 3
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 256M
    networks:
      - frontend

volumes:
  postgres-data:
    driver: local
  redis-data:
    driver: local
  nginx-cache:
    driver: local

networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true  # No external access

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

**What makes this production-ready:**
- Specific image tags
- Named volumes only
- Resource limits
- Health checks
- Restart policies
- Secrets management
- Network isolation
- Multiple replicas
- Monitoring ready

## The Professional Kitchen Analogy

**Think of production Compose like a professional kitchen:**

**Development:** Home kitchen
- Simple setup
- Basic tools
- Works for cooking

**Production:** Professional kitchen
- Safety standards
- Quality controls
- Monitoring systems
- Professional-grade

**Once you see it this way, production Compose makes perfect sense.**

## Monitoring and Logging

**Add monitoring:**

```yaml
services:
  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml:ro
      - prometheus-data:/prometheus
    ports:
      - "9090:9090"

  grafana:
    image: grafana/grafana
    volumes:
      - grafana-data:/var/lib/grafana
    ports:
      - "3000:3000"
    depends_on:
      - prometheus
```

**Add logging:**
```yaml
services:
  app:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

## My Take: Production Compose Strategy

**Here's what I do for production:**

**Security:**
- Secrets management
- Network isolation
- No bind mounts
- Read-only where possible

**Reliability:**
- Health checks
- Restart policies
- Resource limits
- Multiple replicas

**Monitoring:**
- Health checks
- Logging
- Metrics
- Alerts

**The key:** Security first. Reliability second. Monitoring always.

## Memory Tip: The Professional Kitchen Analogy

**Production Compose = Professional kitchen**

**Development:** Home kitchen (simple)
**Production:** Professional kitchen (standards, monitoring, quality)

**Once you see it this way, production Compose makes perfect sense.**

## Common Mistakes

1. **Using latest tags**: Unpredictable
2. **Bind mounts in production**: Not portable, security risk
3. **No resource limits**: Resource exhaustion
4. **No health checks**: Don't know when unhealthy
5. **Hard-coded secrets**: Security risk

## Key Takeaways

1. **Production needs more than development** - Security, reliability, monitoring
2. **Use specific image tags** - Predictable and reproducible
3. **Use named volumes only** - Portable and secure
4. **Set resource limits** - Prevent exhaustion
5. **Add health checks** - Know when healthy
6. **Use secrets management** - Secure configuration
7. **Monitor everything** - Know what's happening

## What's Next?

Congratulations! You've completed the Docker Compose module. Now let's learn about Docker Hub and registries. Next: [Docker Hub](/docs/docker/07-docker-hub-registry/docker-hub).

---

> **Remember**: Production Compose is like a professional kitchen. Security standards. Quality controls. Monitoring systems. Production-ready. Always.

