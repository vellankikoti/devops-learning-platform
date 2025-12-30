---
sidebar_position: 4
title: Service Discovery
---

# Service Discovery: Finding Containers by Name

**Containers need to find each other. You could use IP addresses. But IPs change. Names don't. That's service discovery.**

## 🎯 The Big Picture

Think of service discovery like a phone directory. You don't memorize phone numbers (IPs). You remember names. You look up the number. Service discovery does that for containers.

**Containers find each other by name. Docker's DNS resolves names to IPs. Automatic. Simple. Works.**

## What is Service Discovery?

**Service discovery is finding services by name, not IP.**

**Without service discovery:**
```javascript
// Hard-code IP address
const dbHost = '172.17.0.5';
// Problem: IP changes when container restarts
```

**With service discovery:**
```javascript
// Use container name
const dbHost = 'db';
// Works! Docker DNS resolves it
```

**That's the difference. Names are stable. IPs change.**

## How Docker Service Discovery Works

**Docker has built-in DNS:**

1. **Container starts** - Gets a name
2. **Docker registers name** - In DNS
3. **Other containers query** - "What's the IP of 'db'?"
4. **Docker DNS responds** - "172.17.0.5"
5. **Container connects** - Using the IP

**All automatic. You just use the name.**

**Think of it as:** Phone directory. You ask for "John". Directory gives you the number. You call.

## Using Service Discovery

**Basic usage:**

**1. Create network:**
```bash
docker network create app-network
```

**2. Run database:**
```bash
docker run -d --name db --network app-network postgres
```

**3. Run application:**
```bash
docker run -d --name app --network app-network my-app
```

**4. Application connects:**
```javascript
// Inside app container
const dbHost = 'db';  // Not IP, just name!
const connection = connect(dbHost, 5432);
// Works! Docker DNS resolves 'db' to IP
```

**That's it. Use the name. Docker handles the rest.**

## Container Names as Hostnames

**Container name = Hostname**

**On the same network:**
```bash
# Container named 'web'
docker run -d --name web --network my-network nginx

# Another container can reach it
docker run -d --name app --network my-network my-app
# Inside app: http://web:80 works!
```

**Key points:**
- Use container name as hostname
- Works within same network
- Automatic DNS resolution
- No configuration needed

## Multiple Containers, Same Name Pattern

**Docker Compose creates multiple containers:**

```yaml
services:
  web:
    image: nginx
  app:
    image: my-app
```

**Service discovery:**
- `web` resolves to web container
- `app` resolves to app container
- Automatic within Compose network

**We'll cover Compose later. But service discovery works the same way.**

## The Phone Directory Analogy

**Think of service discovery like a phone directory:**

**Container name:** Person's name
**IP address:** Phone number
**Docker DNS:** Phone directory
**Query:** "What's John's number?"
**Response:** "555-1234"
**Connection:** Call that number

**You remember names. Directory finds numbers. That's service discovery.**

## Real-World Example: Web Application

**Let me show you a real example:**

**1. Create network:**
```bash
docker network create app-network
```

**2. Run database:**
```bash
docker run -d \
  --name postgres-db \
  --network app-network \
  -e POSTGRES_PASSWORD=secret \
  postgres:14
```

**3. Run Redis cache:**
```bash
docker run -d \
  --name redis-cache \
  --network app-network \
  redis:7
```

**4. Run application:**
```bash
docker run -d \
  --name web-app \
  --network app-network \
  -e DB_HOST=postgres-db \
  -e REDIS_HOST=redis-cache \
  my-app:1.0
```

**Application code:**
```javascript
// Connect to database
const db = connect(process.env.DB_HOST, 5432);
// DB_HOST='postgres-db' resolves to IP automatically

// Connect to Redis
const redis = connect(process.env.REDIS_HOST, 6379);
// REDIS_HOST='redis-cache' resolves to IP automatically
```

**No IPs needed. Just names. Docker handles resolution.**

## DNS Resolution Details

**How DNS resolution works:**

**1. Container queries:** "What's the IP of 'db'?"

**2. Docker DNS checks:**
- Is 'db' on same network? → Return IP
- Not on same network? → Check other networks
- Not found? → Forward to external DNS

**3. Response:** IP address (or not found)

**All transparent. You just use the name.**

## Testing Service Discovery

**Test if service discovery works:**

**1. Run two containers:**
```bash
docker network create test-network
docker run -d --name server --network test-network nginx
docker run -d --name client --network test-network alpine sleep 3600
```

**2. Test connectivity:**
```bash
# Ping by name
docker exec client ping server

# Should work! Service discovery resolved 'server' to IP
```

**3. Test HTTP:**
```bash
# Curl by name
docker exec client wget -O- http://server:80

# Should work! Service discovery resolved 'server' to IP
```

**If it works, service discovery is working!**

## Limitations

**Service discovery has limits:**

**1. Same network required:**
- Containers must be on same network
- Different networks = no service discovery
- Use container name, not IP

**2. Container must be running:**
- Stopped containers don't resolve
- Must be running for DNS to work

**3. Name must be unique:**
- Two containers can't have same name
- Use unique names

**4. No load balancing:**
- One name = one IP
- For load balancing, use Docker Swarm or external load balancer

## Best Practices

### 1. Use Descriptive Names

**Don't do this:**
```bash
docker run -d --name c1 nginx
docker run -d --name c2 postgres
```

**Do this:**
```bash
docker run -d --name web-server nginx
docker run -d --name postgres-db postgres
```

**Why:** Clear names. Easy to understand. Better service discovery.

### 2. Use Environment Variables

**Don't hard-code:**
```javascript
const dbHost = 'db';
```

**Do use environment variables:**
```javascript
const dbHost = process.env.DB_HOST || 'db';
```

**Why:** Flexible. Can override. Better configuration.

### 3. Document Dependencies

**Document which containers depend on which:**

```bash
# web-app depends on:
# - postgres-db (database)
# - redis-cache (cache)
```

**Why:** Clear dependencies. Easier to understand. Better documentation.

## My Take: Service Discovery Benefits

**I used to hard-code IPs. Then containers restarted. IPs changed. Everything broke.**

**Service discovery changed that:**
- Use names, not IPs
- IPs can change, names don't
- Automatic resolution
- Simple and works

**The key:** Always use container names. Never hard-code IPs. Service discovery handles the rest.

## Memory Tip: The Phone Directory Analogy

**Service discovery = Phone directory**

**Name:** Person's name (container name)
**IP:** Phone number (IP address)
**DNS:** Directory (Docker DNS)
**Query:** "What's John's number?"
**Resolution:** Directory finds number

**Once you see it this way, service discovery makes perfect sense.**

## Common Mistakes

1. **Hard-coding IPs**: Breaks when containers restart
2. **Not using same network**: Service discovery doesn't work
3. **Using wrong names**: Can't find containers
4. **Not testing**: Assume it works, but doesn't
5. **Forgetting dependencies**: Don't know what depends on what

## Hands-On Exercise: Test Service Discovery

**1. Create network:**
```bash
docker network create test-net
```

**2. Run server:**
```bash
docker run -d --name server --network test-net nginx
```

**3. Run client:**
```bash
docker run -d --name client --network test-net alpine sleep 3600
```

**4. Test ping:**
```bash
docker exec client ping -c 3 server
# Should work! Service discovery resolved 'server'
```

**5. Test HTTP:**
```bash
docker exec client wget -O- http://server:80
# Should work! Service discovery resolved 'server'
```

**6. Check DNS:**
```bash
docker exec client nslookup server
# Shows IP address resolved by Docker DNS
```

**7. Clean up:**
```bash
docker stop server client
docker rm server client
docker network rm test-net
```

## Key Takeaways

1. **Service discovery finds containers by name** - Not IP addresses
2. **Docker has built-in DNS** - Automatic resolution
3. **Use container names as hostnames** - Simple and works
4. **Same network required** - Different networks don't resolve
5. **Names are stable** - IPs change, names don't
6. **Always use names** - Never hard-code IPs

## What's Next?

Congratulations! You've completed the Networking module. Now let's learn about volumes and storage. Next: [Understanding Volumes](/docs/docker/05-volumes-storage/understanding-volumes).

---

> **Remember**: Service discovery is like a phone directory. You remember names. Directory finds numbers. Use container names. Never hard-code IPs.

