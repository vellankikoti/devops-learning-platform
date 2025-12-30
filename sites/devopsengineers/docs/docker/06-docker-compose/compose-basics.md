---
sidebar_position: 1
title: Compose Basics
---

# Docker Compose Basics: Orchestrating Multiple Containers

**Running one container is easy. Running ten containers? Managing them? Connecting them? That's where Docker Compose comes in.**

## 🎯 The Big Picture

Think of Docker Compose like a conductor of an orchestra. Individual musicians (containers) can play. But the conductor (Compose) makes them play together. In harmony. At the right time. With the right connections.

**Docker Compose orchestrates multiple containers. One file. One command. Everything runs together.**

## What is Docker Compose?

**Docker Compose is a tool for defining and running multi-container Docker applications.**

**What it does:**
- Defines multiple containers in one file
- Manages their lifecycle together
- Sets up networking between them
- Configures volumes
- Handles dependencies

**Think of it as:** A recipe for a complete meal. Not just one dish. Multiple dishes. All prepared together. All served together.

## Why Docker Compose?

**The problem without Compose:**
```bash
# Run database
docker run -d --name db -e POSTGRES_PASSWORD=secret postgres

# Run Redis
docker run -d --name redis redis

# Run application
docker run -d --name app --link db --link redis my-app

# Run nginx
docker run -d --name web -p 80:80 --link app nginx

# Too many commands! Hard to manage!
```

**The solution with Compose:**
```bash
# One command
docker compose up

# Everything runs together!
```

**That's the difference. One file. One command. Everything works.**

## Your First docker-compose.yml

**Let's start simple (modern Compose - no version needed!):**

```yaml
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
```

**That's it. A complete Compose file. Modern Docker Compose doesn't require the version field.**

**What it does:**
- Defines one service: `web`
- Uses `nginx:alpine` image (specific tag, best practice)
- Maps port 8080 to 80

**Run it:**
```bash
docker compose up
```

**One command. Container runs. That's Compose.**

**Important:** Modern Docker Compose doesn't require the `version` field. It's automatically detected. Cleaner. Simpler.

## Understanding docker-compose.yml

**Basic structure (modern Compose - no version field needed):**

```yaml
services:             # Define your services (containers)
  service-name:       # Name of service
    image: image-name # Docker image to use
    ports:            # Port mappings
      - "host:container"
    environment:      # Environment variables
      - KEY=value
    volumes:          # Volume mounts
      - volume:path
```

**Think of it as:** A blueprint. Defines what containers to run. How to configure them. How they connect.

**Note:** The `version` field is deprecated in modern Docker Compose. Docker Compose automatically detects the format. Cleaner files. Less clutter.

## Real-World Example: Web Application

**Let me show you a real example with best practices:**

```yaml
services:
  # Database
  db:
    image: postgres:14
    environment:
      POSTGRES_PASSWORD: secret
      POSTGRES_DB: myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data

  # Redis cache
  redis:
    image: redis:7

  # Web application
  app:
    build: .
    environment:
      DB_HOST: db
      REDIS_HOST: redis
    depends_on:
      - db
      - redis

  # Web server
  web:
    image: nginx
    ports:
      - "80:80"
    depends_on:
      - app

volumes:
  postgres-data:
```

**What this does:**
- Runs PostgreSQL database
- Runs Redis cache
- Runs web application
- Runs nginx web server
- All connected. All working together.

**One file. One command. Complete application.**

## The Orchestra Conductor Analogy

**Think of Docker Compose like an orchestra conductor:**

**Individual containers:** Musicians
- Can play alone
- But better together

**Docker Compose:** Conductor
- Coordinates all musicians
- Sets the tempo
- Ensures harmony
- Makes them play together

**docker-compose.yml:** Sheet music
- Defines what to play
- When to play
- How to play together

**Once you see it this way, Docker Compose makes perfect sense.**

## Basic Commands

**Start services:**
```bash
docker compose up
```

**Start in background:**
```bash
docker compose up -d
```

**Stop services:**
```bash
docker compose down
```

**View logs:**
```bash
docker compose logs
```

**View specific service logs:**
```bash
docker compose logs web
```

**List services:**
```bash
docker compose ps
```

**Restart services:**
```bash
docker compose restart
```

## Service Dependencies

**Services can depend on each other:**

```yaml
services:
  db:
    image: postgres:14

  app:
    image: my-app
    depends_on:
      - db
```

**What `depends_on` does:**
- Waits for `db` to start before starting `app`
- Ensures order
- Doesn't wait for `db` to be ready (just started)

**Think of it as:** App needs database. Wait for database to start. Then start app.

## Networking in Compose

**Services on same Compose file are on same network:**

```yaml
services:
  db:
    image: postgres:14

  app:
    image: my-app
    # Can connect to db using hostname 'db'
    # No need to specify network!
```

**Service discovery works automatically:**
- Services can reach each other by name
- `db` hostname resolves to db service
- `app` hostname resolves to app service
- Automatic DNS resolution

**Think of it as:** All services in same neighborhood. They know each other's addresses. Can visit each other.

## My Take: Why Compose Matters

**I used to run containers manually. One command per container. Managing dependencies. Setting up networks. It was chaos.**

**Docker Compose changed that:**
- One file defines everything
- One command runs everything
- Dependencies handled automatically
- Networking configured automatically

**The key:** Compose makes multi-container applications manageable. Simple. Predictable.

## Memory Tip: The Orchestra Conductor Analogy

**Docker Compose = Orchestra conductor**

**Containers:** Musicians
**Compose:** Conductor
**docker-compose.yml:** Sheet music
**Commands:** Conducting gestures

**Once you see it this way, Compose makes perfect sense.**

## Common Mistakes

1. **Not using Compose for multi-container apps**: Managing manually is hard
2. **Wrong file name**: Must be `docker-compose.yml` or `compose.yml`
3. **Not understanding dependencies**: Services start in wrong order
4. **Forgetting volumes**: Data doesn't persist
5. **Not using service names**: Can't connect services

## Hands-On Exercise: Your First Compose File

**Step 1: Create docker-compose.yml (modern style):**
```yaml
services:
  web:
    image: nginx:alpine
    ports:
      - "8080:80"
    restart: unless-stopped
```

**Step 2: Run it:**
```bash
docker compose up
# Or in background:
docker compose up -d
```

**Step 3: Verify it's running:**
```bash
docker compose ps
# Should show web service running
```

**Step 4: Access it:**
```bash
curl http://localhost:8080
# Should see nginx welcome page
```

**Step 5: View logs:**
```bash
docker compose logs web
# Or follow logs:
docker compose logs -f web
```

**Step 6: Stop it:**
```bash
# Press Ctrl+C if running in foreground, or:
docker compose down
# Or stop without removing:
docker compose stop
```

**Step 7: Clean up:**
```bash
docker compose down -v
# Removes containers and volumes
```

**Congratulations! You just used Docker Compose with modern best practices!**

## Key Takeaways

1. **Docker Compose orchestrates multiple containers** - One file, one command
2. **docker-compose.yml defines services** - Blueprint for your application
3. **Services can depend on each other** - `depends_on` ensures order
4. **Networking is automatic** - Services can reach each other by name
5. **One command runs everything** - `docker compose up`

## What's Next?

Now that you understand Compose basics, let's learn how to write Compose files properly. Next: [Compose Files](/docs/docker/06-docker-compose/compose-files).

---

> **Remember**: Docker Compose is like an orchestra conductor. It makes multiple containers work together. One file. One command. Everything runs.

