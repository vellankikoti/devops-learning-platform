---
sidebar_position: 2
title: Compose Files
---

# Compose Files: Writing docker-compose.yml

**docker-compose.yml is the blueprint for your application. It defines everything. Services. Networks. Volumes. Configuration. Understanding how to write it makes Compose powerful.**

## 🎯 The Big Picture

Think of docker-compose.yml like a recipe card. It lists all ingredients (services). How to prepare them (configuration). How they work together (networking). One card. Complete meal.

**Writing a good Compose file is like writing a good recipe. Clear. Complete. Works every time.**

## File Structure (Modern Compose - No Version Field!)

**Basic structure (modern Compose - no version needed):**

```yaml
services:             # Your containers
  service-name:
    # Service configuration

networks:             # Custom networks (optional)
  network-name:
    # Network configuration

volumes:              # Named volumes (optional)
  volume-name:
    # Volume configuration

configs:              # Config files (optional)
  config-name:
    # Config configuration

secrets:              # Secrets (optional)
  secret-name:
    # Secret configuration
```

**Think of it as:** Multiple sections. Services (what to run). Networks (how to connect). Volumes (where to store data). Configs and secrets (modern features for better security).

**Important:** The `version` field is deprecated in modern Docker Compose. Docker Compose automatically detects the format. Your files are cleaner without it!

## Service Configuration

**A service is a container. Configure it:**

```yaml
services:
  web:
    image: nginx              # Docker image
    container_name: my-web    # Container name (optional)
    ports:                    # Port mappings
      - "8080:80"
    environment:              # Environment variables
      - NODE_ENV=production
    volumes:                  # Volume mounts
      - ./data:/app/data
    networks:                 # Networks to join
      - app-network
    depends_on:               # Dependencies
      - db
    restart: always           # Restart policy
```

**Each option configures the container. All in one place.**

## Image vs Build

**Two ways to get an image:**

### Using Existing Image

```yaml
services:
  web:
    image: nginx:latest
```

**Use when:** Image exists in registry. Simple. Fast.

### Building from Dockerfile

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
```

**Or shorter:**
```yaml
services:
  app:
    build: .
```

**Use when:** You have a Dockerfile. Need to build custom image.

**Think of it as:** Using a pre-made dish (image) vs cooking from recipe (build).

## Port Mappings

**Map container ports to host:**

```yaml
services:
  web:
    image: nginx
    ports:
      - "8080:80"           # host:container
      - "8443:443"          # Multiple ports
      - "3000"              # Random host port
```

**Format:** `"host-port:container-port"`

**Examples:**
- `"8080:80"` - Host 8080 → Container 80
- `"3000"` - Random host port → Container 3000
- `"127.0.0.1:8080:80"` - Only localhost

## Environment Variables

**Set environment variables:**

```yaml
services:
  app:
    image: my-app
    environment:
      - NODE_ENV=production
      - DB_HOST=db
      - DB_PORT=5432
```

**Or using a file:**
```yaml
services:
  app:
    image: my-app
    env_file:
      - .env
```

**Or both:**
```yaml
services:
  app:
    image: my-app
    env_file:
      - .env
    environment:
      - DEBUG=true  # Overrides .env
```

## Volumes

**Mount volumes:**

```yaml
services:
  db:
    image: postgres:14
    volumes:
      # Named volume
      - postgres-data:/var/lib/postgresql/data
      
      # Bind mount
      - ./config:/etc/postgresql
      
      # Anonymous volume
      - /tmp
```

**Define volumes:**
```yaml
volumes:
  postgres-data:
```

**Think of it as:** Where to store data. Named volumes for persistence. Bind mounts for development.

## Networks

**Configure networking:**

```yaml
services:
  web:
    image: nginx
    networks:
      - frontend
      - backend

networks:
  frontend:
  backend:
    driver: bridge
```

**Default network:**
- All services on same Compose file share default network
- Can reach each other by service name
- No configuration needed

**Custom networks:**
- Isolate services
- Better organization
- Custom configuration

## Dependencies

**Define service dependencies:**

```yaml
services:
  db:
    image: postgres:14

  app:
    image: my-app
    depends_on:
      - db
```

**What it does:**
- Starts `db` before `app`
- Waits for `db` to start (not ready)
- Ensures order

**Health checks:**
```yaml
services:
  db:
    image: postgres:14
    healthcheck:
      test: ["CMD-SHELL", "pg_isready"]
      interval: 10s
      timeout: 5s
      retries: 5

  app:
    image: my-app
    depends_on:
      db:
        condition: service_healthy
```

**Now waits for `db` to be healthy, not just started.**

## The Recipe Card Analogy

**Think of docker-compose.yml like a recipe card:**

**Services:** Ingredients
- What you need
- How much
- How to prepare

**Networks:** How ingredients combine
- Which go together
- How they connect

**Volumes:** Storage
- Where to keep things
- What to preserve

**Dependencies:** Order of operations
- What to do first
- What depends on what

**Once you see it this way, Compose files make perfect sense.**

## Real-World Example: Complete Application

**Let me show you a complete example with modern best practices:**

```yaml
services:
  # PostgreSQL Database
  postgres:
    image: postgres:16-alpine
    container_name: app-postgres
    environment:
      POSTGRES_USER: ${DB_USER:-appuser}
      POSTGRES_PASSWORD_FILE: /run/secrets/db_password
      POSTGRES_DB: ${DB_NAME:-myapp}
      POSTGRES_INITDB_ARGS: "-E UTF8 --locale=C"
    volumes:
      - postgres-data:/var/lib/postgresql/data
      - ./init-scripts:/docker-entrypoint-initdb.d:ro
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U ${DB_USER:-appuser} -d ${DB_NAME:-myapp}"]
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
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  # Redis Cache
  redis:
    image: redis:7-alpine
    container_name: app-redis
    command: >
      redis-server
      --requirepass ${REDIS_PASSWORD}
      --appendonly yes
      --maxmemory 256mb
      --maxmemory-policy allkeys-lru
    volumes:
      - redis-data:/data
    healthcheck:
      test: ["CMD", "redis-cli", "--raw", "incr", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 512M
    networks:
      - backend

  # Node.js Application
  app:
    build:
      context: .
      dockerfile: Dockerfile
      args:
        NODE_ENV: production
    container_name: app-backend
    environment:
      NODE_ENV: ${NODE_ENV:-production}
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: ${DB_USER:-appuser}
      DB_NAME: ${DB_NAME:-myapp}
      DB_PASSWORD_FILE: /run/secrets/db_password
      REDIS_HOST: redis
      REDIS_PORT: 6379
      REDIS_PASSWORD: ${REDIS_PASSWORD}
      PORT: 3000
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
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

  # Nginx Web Server
  nginx:
    image: nginx:alpine
    container_name: app-nginx
    ports:
      - "${HTTP_PORT:-80}:80"
      - "${HTTPS_PORT:-443}:443"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/conf.d:/etc/nginx/conf.d:ro
      - ./ssl:/etc/nginx/ssl:ro
      - nginx-cache:/var/cache/nginx
      - nginx-logs:/var/log/nginx
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
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

volumes:
  postgres-data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /var/lib/docker/volumes/postgres-data
  redis-data:
    driver: local
  nginx-cache:
    driver: local
  nginx-logs:
    driver: local

networks:
  frontend:
    driver: bridge
    ipam:
      config:
        - subnet: 172.20.0.0/16
  backend:
    driver: bridge
    internal: false
    ipam:
      config:
        - subnet: 172.21.0.0/16

secrets:
  db_password:
    file: ./secrets/db_password.txt
```

**What this example includes:**
- ✅ No version field (modern standard)
- ✅ Specific image tags (alpine, version numbers)
- ✅ Health checks for all services
- ✅ Proper dependency conditions
- ✅ Resource limits and reservations
- ✅ Secrets management (modern feature)
- ✅ Logging configuration
- ✅ Network isolation with custom subnets
- ✅ Container names for easier management
- ✅ Restart policies
- ✅ Environment variable defaults
- ✅ Volume driver options

**One file. Complete application. Production-ready. Modern best practices.**

## Best Practices

### 1. Use Specific Image Tags

**Don't do this:**
```yaml
services:
  web:
    image: nginx:latest
```

**Do this:**
```yaml
services:
  web:
    image: nginx:1.21-alpine
```

**Why:** Predictable. Reproducible. No surprises.

### 2. Use Health Checks

**Add health checks:**
```yaml
services:
  db:
    image: postgres:14
    healthcheck:
      test: ["CMD-SHELL", "pg_isready"]
      interval: 10s
      timeout: 5s
      retries: 5
```

**Why:** Know when service is ready. Better dependencies.

### 3. Use Named Volumes

**Don't do this:**
```yaml
services:
  db:
    volumes:
      - /data
```

**Do this:**
```yaml
services:
  db:
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

**Why:** Manageable. Portable. Better practice.

### 4. Document with Comments

**Add comments:**
```yaml
services:
  # PostgreSQL database
  postgres:
    image: postgres:14
    # Database credentials
    environment:
      POSTGRES_PASSWORD: secret
```

**Why:** Clear. Understandable. Maintainable.

## My Take: Writing Compose Files

**I've written hundreds of Compose files. Here's what I learned:**

**Start simple:**
- Get it working first
- Add complexity later
- Test as you go

**Use best practices:**
- Specific image tags
- Health checks
- Named volumes
- Proper dependencies

**Document:**
- Add comments
- Explain why
- Make it clear

**The key:** Start simple. Add features. Test. Iterate.

## Memory Tip: The Recipe Card Analogy

**docker-compose.yml = Recipe card**

**Services:** Ingredients
**Networks:** How to combine
**Volumes:** Storage
**Dependencies:** Order

**Once you see it this way, Compose files make perfect sense.**

## Common Mistakes

1. **Using `latest` tags**: Unpredictable
2. **Not using health checks**: Dependencies don't work properly
3. **Anonymous volumes**: Hard to manage
4. **Wrong indentation**: YAML is sensitive
5. **Not testing**: Assumes it works

## Hands-On Exercise: Write a Compose File

**1. Create docker-compose.yml (modern style - no version needed):**
```yaml
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html:ro
```

**2. Create html directory:**
```bash
mkdir html
echo "<h1>Hello from Compose!</h1>" > html/index.html
```

**3. Run it:**
```bash
docker compose up -d
```

**4. Test it:**
```bash
curl http://localhost:8080
# Should see: Hello from Compose!
```

**5. Check logs:**
```bash
docker compose logs web
```

**6. Stop it:**
```bash
docker compose down
```

## Key Takeaways

1. **docker-compose.yml defines your application** - Services, networks, volumes
2. **Use specific image tags** - Predictable and reproducible
3. **Add health checks** - Know when services are ready
4. **Use named volumes** - Manageable and portable
5. **Document with comments** - Clear and maintainable

## What's Next?

Now that you can write Compose files, let's learn about multi-container applications. Next: [Multi-Container Apps](/docs/docker/06-docker-compose/multi-container-apps).

---

> **Remember**: docker-compose.yml is like a recipe card. Clear. Complete. Works every time. Write it well, and your application runs smoothly.

