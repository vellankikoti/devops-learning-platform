---
sidebar_position: 1
title: Docker Networks
---

# Docker Networks: How Containers Communicate

**Containers need to talk to each other. They need to talk to the internet. They need to be isolated. That's what Docker networking does.**

## 🎯 The Big Picture

Think of Docker networks like a city's road system. You have main roads (bridge network). You have private roads (custom networks). You have highways (host network). You have isolated neighborhoods (none network).

**Different networks for different needs. Understanding them makes containers work together.**

## Why Docker Networking?

**Containers need networking for:**
- **Communication**: Containers talking to each other
- **Isolation**: Separating different applications
- **Access**: Reaching the internet
- **Security**: Controlling what can communicate

**Without networking:**
- Containers are isolated islands
- Can't communicate
- Can't access internet
- Useless

**With networking:**
- Containers can communicate
- Can access internet
- Can be isolated
- Useful

## Default Networks

**Docker creates three default networks:**

### 1. Bridge Network (Default)

**What it is:** Default network for containers. Like a local area network.

**Characteristics:**
- Containers can communicate
- Isolated from host network
- Internal IP addresses
- Port mapping needed for external access

**When to use:**
- Default for most containers
- Single-host deployments
- Development environments

**Think of it as:** A local neighborhood. Houses (containers) can talk to each other. But need address (port mapping) for outsiders.

### 2. Host Network

**What it is:** Container uses host's network directly. No isolation.

**Characteristics:**
- Uses host's network stack
- No port mapping needed
- Direct access to host ports
- Less isolation

**When to use:**
- Performance-critical applications
- When you need direct host access
- Specific use cases

**Think of it as:** Living directly on the main road. No private address. Direct access.

### 3. None Network

**What it is:** No networking. Complete isolation.

**Characteristics:**
- No network access
- Completely isolated
- No internet
- No container communication

**When to use:**
- Security-sensitive containers
- Testing network isolation
- Specific security requirements

**Think of it as:** An isolated cabin. No roads. No communication. Complete isolation.

## Understanding Bridge Network

**Bridge network is the default. Let's understand it:**

**How it works:**
1. Docker creates a virtual bridge (like a network switch)
2. Containers connect to this bridge
3. Containers get internal IP addresses (172.17.0.x)
4. Containers can communicate via these IPs
5. Port mapping exposes ports to host

**Example:**
```
Container A: 172.17.0.2
Container B: 172.17.0.3
Host: Can access via port mapping (8080:80)
```

**Containers can talk to each other by IP or name (if on same network).**

## Listing Networks

**See what networks you have:**

```bash
# List all networks
docker network ls

# Inspect a network
docker network inspect bridge

# See network details
docker network inspect bridge | grep -A 10 Containers
```

**Output:**
```
NETWORK ID     NAME      DRIVER    SCOPE
abc123def456   bridge    bridge    local
def456ghi789   host      host      local
ghi789jkl012   none      null      local
```

## Creating Custom Networks

**Create your own network:**

```bash
# Create a bridge network
docker network create my-network

# Create with specific driver
docker network create --driver bridge my-network

# Create with subnet
docker network create --subnet=192.168.100.0/24 my-network
```

**Why create custom networks?**
- Better organization
- Isolation between applications
- Custom configuration
- Service discovery

**Think of it as:** Creating a new neighborhood. Separate from others. Controlled access.

## Connecting Containers to Networks

**Connect containers to networks:**

```bash
# Connect when running
docker run -d --name web --network my-network nginx

# Connect existing container
docker network connect my-network web

# Disconnect
docker network disconnect my-network web
```

**Multiple networks:**
```bash
# Container can be on multiple networks
docker network connect network1 web
docker network connect network2 web
```

**Think of it as:** A house can have multiple addresses. One in each neighborhood.

## Service Discovery

**Containers can find each other by name:**

**On the same network:**
```bash
# Container A
docker run -d --name web --network my-network nginx

# Container B can reach it by name
docker run -d --name app --network my-network my-app
# Inside app, can connect to: http://web:80
```

**How it works:**
- Docker's built-in DNS
- Resolves container names to IPs
- Automatic service discovery
- Works within same network

**Think of it as:** Phone directory. You know the name. You can call. DNS finds the number.

## The City Road System Analogy

**Think of Docker networks like a city's road system:**

**Bridge network:** Local neighborhood roads
- Houses (containers) can visit each other
- Need address (port mapping) for outsiders
- Private addresses (internal IPs)

**Host network:** Main city roads
- Direct access to main roads
- No private address needed
- Less privacy

**None network:** Isolated cabin
- No roads
- No access
- Complete isolation

**Custom networks:** Gated communities
- Controlled access
- Separate from others
- Custom rules

**Once you see it this way, Docker networking makes perfect sense.**

## Real-World Example: Multi-Container Application

**Let me show you a real example:**

**1. Create network:**
```bash
docker network create app-network
```

**2. Run database:**
```bash
docker run -d \
  --name db \
  --network app-network \
  -e POSTGRES_PASSWORD=secret \
  postgres:14
```

**3. Run application:**
```bash
docker run -d \
  --name app \
  --network app-network \
  -e DB_HOST=db \
  -e DB_PORT=5432 \
  -p 3000:3000 \
  my-app:1.0
```

**What happens:**
- Both containers on `app-network`
- App can connect to `db` by name
- No need for IP addresses
- Port 3000 exposed to host

**Application connects to database using `db` as hostname. Docker DNS resolves it.**

## Network Drivers

**Docker supports different network drivers:**

### Bridge Driver (Default)
- Single host
- Internal networking
- Port mapping for external access

### Host Driver
- Uses host network
- No isolation
- Direct access

### None Driver
- No networking
- Complete isolation

### Overlay Driver
- Multi-host networking
- Docker Swarm
- Cross-host communication

### Macvlan Driver
- Containers get MAC addresses
- Appear as physical devices
- Advanced use cases

**For most use cases, bridge is enough.**

## My Take: Network Strategy

**Here's what I do:**

**Development:**
- Use default bridge network
- Simple and works
- Port mapping for access

**Production:**
- Create custom networks per application
- Isolate different apps
- Use service discovery
- Better security

**The key:** Start simple. Use default bridge. Then create custom networks when needed.

## Memory Tip: The City Road System Analogy

**Docker networks = City road system**

**Bridge:** Neighborhood roads
**Host:** Main city roads
**None:** Isolated cabin
**Custom:** Gated communities

**Once you see it this way, networking makes perfect sense.**

## Common Mistakes

1. **Not understanding default bridge**: Most containers use it
2. **Not using custom networks**: Missing isolation
3. **Not using service discovery**: Hard-coding IPs
4. **Wrong network driver**: Using host when bridge is better
5. **Not cleaning up networks**: They accumulate

## Hands-On Exercise: Create and Use Networks

**1. Create a network:**
```bash
docker network create my-network
```

**2. Run containers on it:**
```bash
docker run -d --name web --network my-network nginx
docker run -d --name app --network my-network alpine sleep 3600
```

**3. Check network:**
```bash
docker network inspect my-network
```

**4. Test connectivity:**
```bash
docker exec app ping web
# Should work! Service discovery by name
```

**5. Clean up:**
```bash
docker stop web app
docker rm web app
docker network rm my-network
```

## Key Takeaways

1. **Docker has default networks** - Bridge, host, none
2. **Bridge is default** - Most containers use it
3. **Create custom networks** - Better organization and isolation
4. **Service discovery works** - Containers find each other by name
5. **Different drivers for different needs** - Bridge for most cases

## What's Next?

Now that you understand Docker networks, let's learn about different network types. Next: [Network Types](/docs/docker/04-networking/network-types).

---

> **Remember**: Docker networking is like a city's road system. Different networks for different needs. Understand them, and containers communicate effectively.

