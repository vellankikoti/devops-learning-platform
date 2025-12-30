---
sidebar_position: 3
title: Multi-Container Apps
---

# Multi-Container Apps: Building Complete Applications

**Real applications have multiple services. Database. Cache. Application. Web server. They need to work together. Docker Compose makes that easy.**

## 🎯 The Big Picture

Think of multi-container apps like a restaurant. You have kitchen (database). You have storage (cache). You have chefs (application). You have servers (web server). They all work together. One can't work without others.

**Docker Compose orchestrates all these services. Makes them work together. As one complete application.**

## What is a Multi-Container App?

**A multi-container app has multiple services working together:**

**Typical stack:**
- **Database** - Stores data
- **Cache** - Speeds up access
- **Application** - Business logic
- **Web Server** - Serves requests

**Each is a container. All work together. That's a multi-container app.**

## Real-World Example: Web Application Stack

**Let me show you a complete stack:**

```yaml
services:
  # PostgreSQL Database
  postgres:
    image: postgres:14-alpine
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U appuser"]
      interval: 10s
      timeout: 5s
      retries: 5
    networks:
      - backend

  # Redis Cache
  redis:
    image: redis:7-alpine
    volumes:
      - redis-data:/data
    command: redis-server --appendonly yes
    networks:
      - backend

  # Node.js Application
  app:
    build: .
    environment:
      NODE_ENV: production
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: appuser
      DB_PASSWORD: ${DB_PASSWORD}
      DB_NAME: myapp
      REDIS_HOST: redis
      REDIS_PORT: 6379
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_started
    networks:
      - backend
      - frontend
    restart: unless-stopped

  # Nginx Web Server
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./ssl:/etc/nginx/ssl:ro
    depends_on:
      - app
    networks:
      - frontend
    restart: unless-stopped

volumes:
  postgres-data:
  redis-data:

networks:
  frontend:
  backend:
```

**What this does:**
- Complete web application
- Database with persistence
- Cache for performance
- Application with dependencies
- Web server for serving
- All connected. All working together.

## Service Communication

**Services communicate using service names:**

**In the application code:**
```javascript
// Connect to database
const db = connect('postgres', 5432);
// 'postgres' is the service name!

// Connect to Redis
const redis = connect('redis', 6379);
// 'redis' is the service name!
```

**How it works:**
- Docker Compose creates a network
- Services can reach each other by name
- Automatic DNS resolution
- No IP addresses needed

**Think of it as:** All services in same building. They know each other's room numbers (names). Can visit each other easily.

## The Restaurant Analogy

**Think of multi-container apps like a restaurant:**

**Database (postgres):** Kitchen storage
- Stores ingredients (data)
- Persistent (refrigerator)
- Always available

**Cache (redis):** Quick access storage
- Fast access (counter)
- Temporary (prepared items)
- Speeds up service

**Application (app):** Chefs
- Prepare dishes (process requests)
- Use ingredients (database)
- Use prepared items (cache)
- Create final product

**Web Server (nginx):** Waiters
- Serve customers (handle requests)
- Get orders from chefs (app)
- Present final dish (serve response)

**All work together. One can't work without others. That's a multi-container app.**

## Dependency Management

**Services depend on each other:**

```yaml
services:
  db:
    image: postgres:14

  app:
    depends_on:
      - db
```

**What `depends_on` does:**
- Starts `db` before `app`
- Ensures order
- But doesn't wait for readiness

**With health checks:**
```yaml
services:
  db:
    image: postgres:14
    healthcheck:
      test: ["CMD-SHELL", "pg_isready"]
      interval: 10s

  app:
    depends_on:
      db:
        condition: service_healthy
```

**Now waits for `db` to be healthy, not just started.**

## Network Isolation

**Separate networks for different layers:**

```yaml
networks:
  frontend:    # Public-facing
  backend:     # Internal services
```

**Why:**
- Security (isolate public from private)
- Organization (clear separation)
- Control (who can access what)

**Frontend network:**
- Web server (nginx)
- Public access

**Backend network:**
- Database (postgres)
- Cache (redis)
- Application (app)
- Internal only

**Think of it as:** Restaurant has dining area (frontend) and kitchen (backend). Customers in dining area. Kitchen is private.

## Volume Management

**Persistent data for each service:**

```yaml
volumes:
  postgres-data:    # Database data
  redis-data:       # Cache data
```

**Why separate volumes:**
- Isolation
- Easy backup
- Easy restore
- Clear ownership

**Each service has its own data. Organized. Manageable.**

## Scaling Services

**Scale specific services:**

```bash
# Scale app to 3 instances
docker compose up -d --scale app=3
```

**What happens:**
- Creates 3 app containers
- All share same network
- Load balanced (if configured)
- Database and cache shared

**Useful for:**
- High traffic
- Load distribution
- Availability

**Note:** Not all services can scale. Database usually can't (use replication instead).

## My Take: Multi-Container Apps

**I build multi-container apps daily. Here's what I learned:**

**Start simple:**
- Get one service working
- Add another
- Test connections
- Iterate

**Use proper structure:**
- Separate networks
- Named volumes
- Health checks
- Dependencies

**Test everything:**
- Each service individually
- Service communication
- Complete stack
- Failure scenarios

**The key:** Build incrementally. Test constantly. Structure properly.

## Memory Tip: The Restaurant Analogy

**Multi-container apps = Restaurant**

**Database:** Kitchen storage
**Cache:** Quick access
**Application:** Chefs
**Web Server:** Waiters
**Networks:** Dining area vs kitchen
**Volumes:** Storage areas

**Once you see it this way, multi-container apps make perfect sense.**

## Common Mistakes

1. **Not using health checks**: Dependencies don't work properly
2. **Wrong network setup**: Services can't communicate
3. **Not isolating networks**: Security issues
4. **Shared volumes incorrectly**: Data conflicts
5. **Not testing dependencies**: Services start in wrong order

## Hands-On Exercise: Build a Multi-Container App

**1. Create docker-compose.yml:**
```yaml
services:
  db:
    image: postgres:14-alpine
    environment:
      POSTGRES_PASSWORD: secret
    volumes:
      - db-data:/var/lib/postgresql/data

  app:
    image: node:18-alpine
    command: node -e "console.log('App running, DB:', process.env.DB_HOST)"
    environment:
      DB_HOST: db
    depends_on:
      - db

volumes:
  db-data:
```

**2. Run it:**
```bash
docker compose up
```

**3. Check logs:**
```bash
docker compose logs app
# Should show: App running, DB: db
```

**4. Verify connection:**
```bash
docker compose exec app ping db
# Should work! Service discovery!
```

**5. Clean up:**
```bash
docker compose down -v
```

## Key Takeaways

1. **Multi-container apps have multiple services** - Database, cache, app, web server
2. **Services communicate by name** - Automatic DNS resolution
3. **Use dependencies** - Ensure proper startup order
4. **Isolate networks** - Security and organization
5. **Use separate volumes** - Data isolation and management

## What's Next?

Now that you understand multi-container apps, let's learn about environment variables in Compose. Next: [Environment Variables](/docs/docker/06-docker-compose/environment-variables).

---

> **Remember**: Multi-container apps are like restaurants. Multiple services work together. Each has a role. All connected. All orchestrated by Compose.

