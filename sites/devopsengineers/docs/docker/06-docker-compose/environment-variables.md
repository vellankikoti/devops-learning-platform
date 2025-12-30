---
sidebar_position: 4
title: Environment Variables
---

# Environment Variables in Compose: Configuring Your Services

**Environment variables configure your services. Database passwords. API keys. Feature flags. They change between environments. Managing them properly makes your Compose files flexible.**

## 🎯 The Big Picture

Think of environment variables like settings on a phone. Same phone (container). Different settings (variables). Different behavior. That's environment variables.

**Environment variables make your Compose files flexible. Same file. Different environments. Different configurations.**

## Why Environment Variables?

**The problem without variables:**
```yaml
services:
  db:
    environment:
      POSTGRES_PASSWORD: my-secret-password
      # Hard-coded! Can't change!
```

**The solution with variables:**
```yaml
services:
  db:
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      # From environment! Flexible!
```

**That's the difference. Hard-coded vs flexible. Inflexible vs configurable.**

## Setting Environment Variables

**Three ways to set variables:**

### 1. In docker-compose.yml

```yaml
services:
  app:
    environment:
      - NODE_ENV=production
      - DB_HOST=db
      - DB_PORT=5432
```

**Use when:** Default values. Development. Simple cases.

### 2. From .env File

**Create .env file:**
```
DB_PASSWORD=secret123
API_KEY=sk_live_abc123
DEBUG=false
```

**Use in Compose:**
```yaml
services:
  db:
    environment:
      POSTGRES_PASSWORD: ${DB_PASSWORD}
```

**Docker Compose automatically reads .env file.**

**Use when:** Sensitive data. Different per environment. Best practice.

### 3. From Shell Environment

```bash
# Set in shell
export DB_PASSWORD=secret123

# Use in Compose
docker compose up
```

**Compose reads from shell environment.**

**Use when:** CI/CD pipelines. Temporary values. Override defaults.

## Variable Substitution

**Docker Compose substitutes variables:**

```yaml
services:
  app:
    environment:
      DB_HOST: ${DB_HOST:-localhost}
      DB_PORT: ${DB_PORT:-5432}
```

**Syntax:** `${VARIABLE:-default}`

**What it means:**
- Use `DB_HOST` if set
- Otherwise use `localhost` (default)

**Think of it as:** Fallback values. If variable not set, use default.

## Real-World Example: Complete Configuration

**Let me show you a real example:**

**.env file:**
```
# Database
DB_PASSWORD=super-secret-password
DB_NAME=myapp
DB_USER=appuser

# Application
NODE_ENV=production
API_KEY=sk_live_abc123def456
DEBUG=false

# Redis
REDIS_PASSWORD=redis-secret
```

**docker-compose.yml:**
```yaml
services:
  postgres:
    image: postgres:14-alpine
    environment:
      POSTGRES_USER: ${DB_USER:-postgres}
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: ${DB_NAME:-myapp}
    volumes:
      - postgres-data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    command: redis-server --requirepass ${REDIS_PASSWORD}
    volumes:
      - redis-data:/data

  app:
    build: .
    environment:
      NODE_ENV: ${NODE_ENV:-development}
      DB_HOST: postgres
      DB_PORT: 5432
      DB_USER: ${DB_USER}
      DB_PASSWORD: ${DB_PASSWORD}
      DB_NAME: ${DB_NAME}
      REDIS_HOST: redis
      REDIS_PASSWORD: ${REDIS_PASSWORD}
      API_KEY: ${API_KEY}
      DEBUG: ${DEBUG:-false}
    depends_on:
      - postgres
      - redis

volumes:
  postgres-data:
  redis-data:
```

**What this does:**
- Reads from .env file
- Uses defaults when not set
- Configures all services
- Flexible and secure

## The Phone Settings Analogy

**Think of environment variables like phone settings:**

**Same phone (container):** Same hardware
**Different settings (variables):** Different behavior
**.env file:** Settings file
**Defaults:** Factory settings

**Once you see it this way, environment variables make perfect sense.**

## Best Practices

### 1. Use .env for Sensitive Data

**Don't commit secrets:**
```yaml
# BAD - Hard-coded in file
POSTGRES_PASSWORD: my-secret-password
```

**Do use .env:**
```yaml
# GOOD - From .env file
POSTGRES_PASSWORD: ${DB_PASSWORD}
```

**Add .env to .gitignore:**
```
.env
.env.local
.env.*.local
```

### 2. Provide Defaults

**Use defaults:**
```yaml
environment:
  DB_PORT: ${DB_PORT:-5432}
  NODE_ENV: ${NODE_ENV:-development}
```

**Why:** Works out of the box. No configuration needed for development.

### 3. Document Variables

**Add comments:**
```yaml
# Database configuration
# DB_PASSWORD: PostgreSQL password (required)
# DB_NAME: Database name (default: myapp)
```

**Or create .env.example:**
```
# Database
DB_PASSWORD=your-password-here
DB_NAME=myapp
DB_USER=appuser

# Application
NODE_ENV=production
API_KEY=your-api-key-here
```

**Why:** Clear documentation. Easy to set up.

### 4. Use Different .env Files

**For different environments:**
```
.env.development
.env.staging
.env.production
```

**Load specific file:**
```bash
docker compose --env-file .env.production up
```

**Why:** Different configs per environment. Easy to manage.

## My Take: Environment Variable Strategy

**Here's what I do:**

**Development:**
- .env file with defaults
- Easy to edit
- No secrets (use defaults)

**Staging/Production:**
- .env file from secrets manager
- Never commit
- Rotate regularly

**The key:** Use .env for everything. Never hard-code. Always provide defaults.

## Memory Tip: The Phone Settings Analogy

**Environment variables = Phone settings**

**Container:** Phone
**Variables:** Settings
**.env file:** Settings file
**Defaults:** Factory settings

**Once you see it this way, environment variables make perfect sense.**

## Common Mistakes

1. **Hard-coding secrets**: Security risk
2. **Committing .env**: Secrets in git
3. **No defaults**: Breaks without configuration
4. **Not documenting**: Hard to know what's needed
5. **Wrong syntax**: Variables don't substitute

## Hands-On Exercise: Use Environment Variables

**1. Create .env file:**
```
MESSAGE=Hello from environment variable
PORT=3000
```

**2. Create docker-compose.yml:**
```yaml
services:
  app:
    image: alpine
    command: sh -c "echo ${MESSAGE} && sleep 3600"
    environment:
      - MESSAGE=${MESSAGE:-Default message}
      - PORT=${PORT:-8080}
```

**3. Run it:**
```bash
docker compose up
# Should show: Hello from environment variable
```

**4. Override from shell:**
```bash
MESSAGE="Hello from shell" docker compose up
# Should show: Hello from shell
```

**5. Check variables:**
```bash
docker compose exec app env | grep MESSAGE
# Shows the variable value
```

## Key Takeaways

1. **Environment variables configure services** - Flexible configuration
2. **Use .env file for sensitive data** - Never commit secrets
3. **Provide defaults** - Works out of the box
4. **Document variables** - Clear what's needed
5. **Use different .env files** - Per environment

## What's Next?

Now that you understand environment variables, let's learn about production Compose files. Next: [Production Compose](/docs/docker/06-docker-compose/production-compose).

---

> **Remember**: Environment variables are like phone settings. Same container. Different settings. Different behavior. Use .env files. Never hard-code secrets.

