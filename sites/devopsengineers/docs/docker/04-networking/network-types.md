---
sidebar_position: 2
title: Network Types
---

# Network Types: Choosing the Right Network

**Not all networks are the same. Each type has a purpose. Understanding when to use which makes your containers work better.**

## 🎯 The Big Picture

Think of network types like different types of roads. You have local streets (bridge). You have highways (host). You have private roads (custom). You have no roads (none). Each serves a different purpose.

**Choosing the right network type is like choosing the right road. It affects speed, access, and isolation.**

## Network Type 1: Bridge Network

**What it is:** Default network. Virtual switch connecting containers.

**Characteristics:**
- ✅ Containers can communicate
- ✅ Isolated from host network
- ✅ Internal IP addresses (172.17.0.x)
- ✅ Port mapping needed for external access
- ✅ Service discovery by name
- ✅ Single host only

**When to use:**
- Default choice for most containers
- Development environments
- Single-host deployments
- When you need isolation

**When NOT to use:**
- Multi-host deployments (use overlay)
- Need direct host network access (use host)
- Maximum performance needed (use host)

**Think of it as:** Local neighborhood roads. Good for local traffic. Need address for outsiders.

**Example:**
```bash
# Uses default bridge network
docker run -d --name web nginx

# Explicitly use bridge
docker run -d --name web --network bridge nginx
```

## Network Type 2: Host Network

**What it is:** Container uses host's network directly. No isolation.

**Characteristics:**
- ✅ Uses host's network stack
- ✅ No port mapping needed
- ✅ Direct access to host ports
- ✅ Better performance (no NAT overhead)
- ❌ Less isolation
- ❌ Port conflicts possible

**When to use:**
- Performance-critical applications
- Need direct host network access
- Running network monitoring tools
- Specific use cases requiring host access

**When NOT to use:**
- Need network isolation
- Multiple containers using same ports
- Security-sensitive applications
- Most general use cases

**Think of it as:** Living directly on the highway. Fast access. No privacy.

**Example:**
```bash
# Uses host network
docker run -d --name web --network host nginx

# Access directly on host port 80
# No -p flag needed
```

**Important:** On Linux, host network works. On macOS/Windows, it's limited (Docker Desktop limitation).

## Network Type 3: None Network

**What it is:** No networking. Complete isolation.

**Characteristics:**
- ✅ Complete isolation
- ✅ No network access
- ✅ No internet access
- ✅ No container communication
- ❌ Completely isolated
- ❌ No external access

**When to use:**
- Security-sensitive containers
- Testing network isolation
- Containers that don't need networking
- Specific security requirements

**When NOT to use:**
- Need any network access
- Need internet access
- Need container communication
- Most use cases

**Think of it as:** An isolated cabin. No roads. No communication. Complete isolation.

**Example:**
```bash
# No network access
docker run -d --name isolated --network none alpine sleep 3600

# Can't ping, can't connect, nothing
```

## Network Type 4: Custom Bridge Networks

**What it is:** Your own bridge network. Custom configuration.

**Characteristics:**
- ✅ Better organization
- ✅ Isolation between applications
- ✅ Custom subnet configuration
- ✅ Service discovery
- ✅ Multiple networks per container

**When to use:**
- Organizing containers by application
- Isolating different applications
- Custom network configuration
- Production deployments

**When NOT to use:**
- Simple single-container apps
- Don't need isolation
- Default bridge is enough

**Think of it as:** Gated communities. Controlled access. Better organization.

**Example:**
```bash
# Create custom network
docker network create --subnet=192.168.100.0/24 app-network

# Use it
docker run -d --name web --network app-network nginx
```

## Network Type 5: Overlay Networks

**What it is:** Multi-host networking. Docker Swarm.

**Characteristics:**
- ✅ Works across multiple hosts
- ✅ Docker Swarm networking
- ✅ Service discovery across hosts
- ✅ Encrypted by default
- ❌ Requires Docker Swarm
- ❌ More complex

**When to use:**
- Docker Swarm deployments
- Multi-host container communication
- Distributed applications
- Production clusters

**When NOT to use:**
- Single host deployments
- Not using Docker Swarm
- Simple applications

**Think of it as:** Interstate highways. Connect different cities (hosts). Long-distance communication.

**Example:**
```bash
# Create overlay network (Swarm mode)
docker network create --driver overlay my-overlay

# Services can use it
docker service create --network my-overlay --name web nginx
```

## Network Type 6: Macvlan Networks

**What it is:** Containers get MAC addresses. Appear as physical devices.

**Characteristics:**
- ✅ Containers appear as physical devices
- ✅ Direct network access
- ✅ No NAT overhead
- ✅ Each container gets MAC address
- ❌ Complex setup
- ❌ Requires network configuration

**When to use:**
- Need containers to appear as physical devices
- Legacy applications expecting physical network
- Specific network requirements
- Advanced use cases

**When NOT to use:**
- Most general use cases
- Don't need MAC addresses
- Default bridge is enough

**Think of it as:** Each container is a separate physical device on the network.

**Example:**
```bash
# Create macvlan network
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 \
  my-macvlan

# Container gets its own MAC and IP
docker run -d --name web --network my-macvlan nginx
```

## Comparison Table

| Network Type | Isolation | Performance | Use Case |
|-------------|-----------|-------------|----------|
| **Bridge** | Medium | Good | Default, most containers |
| **Host** | Low | Best | Performance-critical |
| **None** | Complete | N/A | Security-sensitive |
| **Custom Bridge** | Medium-High | Good | Organized deployments |
| **Overlay** | Medium | Good | Multi-host, Swarm |
| **Macvlan** | Low | Best | Physical device appearance |

## The Road System Analogy

**Think of network types like different roads:**

**Bridge:** Local neighborhood streets
- Good for local traffic
- Some isolation
- Need address for access

**Host:** Main highway
- Direct access
- Fast
- No privacy

**None:** Isolated cabin
- No roads
- Complete isolation
- No access

**Custom Bridge:** Gated community
- Controlled access
- Better organization
- Custom rules

**Overlay:** Interstate highways
- Connect cities (hosts)
- Long distance
- Complex

**Macvlan:** Physical addresses
- Each container is a device
- Direct network access
- Advanced

**Once you see it this way, network types make perfect sense.**

## Real-World Example: Choosing Network Types

**Scenario 1: Web Application**

**Need:** Web server, database, cache. All on same host.

**Solution:** Custom bridge network
```bash
docker network create app-network
docker run -d --name web --network app-network nginx
docker run -d --name db --network app-network postgres
docker run -d --name cache --network app-network redis
```

**Why:** Isolation. Organization. Service discovery.

**Scenario 2: High-Performance Network Tool**

**Need:** Network monitoring. Maximum performance.

**Solution:** Host network
```bash
docker run -d --name monitor --network host network-tool
```

**Why:** Direct host access. No NAT overhead. Better performance.

**Scenario 3: Security-Sensitive Container**

**Need:** Container with sensitive data. No network access.

**Solution:** None network
```bash
docker run -d --name secure --network none secure-app
```

**Why:** Complete isolation. No network attack surface.

## My Take: Network Type Selection

**Here's my decision process:**

**1. Default:** Use bridge network
- Works for 90% of cases
- Simple and effective

**2. Need isolation?** Use custom bridge
- Organize by application
- Better security

**3. Need performance?** Consider host network
- But only if really needed
- Trade isolation for performance

**4. Need multi-host?** Use overlay
- Docker Swarm required
- For distributed apps

**5. Need security?** Use none network
- Complete isolation
- No network access

**The key:** Start with bridge. Change only when you have a specific need.

## Memory Tip: The Road System Analogy

**Network types = Road types**

**Bridge:** Neighborhood streets
**Host:** Main highway
**None:** Isolated cabin
**Custom Bridge:** Gated community
**Overlay:** Interstate highways
**Macvlan:** Physical addresses

**Once you see it this way, choosing network types makes sense.**

## Common Mistakes

1. **Using host network unnecessarily**: Losing isolation
2. **Not using custom networks**: Missing organization
3. **Using overlay without Swarm**: Won't work
4. **Not understanding isolation levels**: Security issues
5. **Over-complicating**: Bridge is enough for most cases

## Hands-On Exercise: Try Different Network Types

**1. Bridge network (default):**
```bash
docker run -d --name web1 nginx
docker network inspect bridge
# See web1 on bridge network
```

**2. Host network:**
```bash
docker run -d --name web2 --network host nginx
# Access directly on port 80
```

**3. None network:**
```bash
docker run -d --name isolated --network none alpine sleep 3600
docker exec isolated ping 8.8.8.8
# Fails! No network
```

**4. Custom bridge:**
```bash
docker network create my-network
docker run -d --name web3 --network my-network nginx
docker network inspect my-network
```

## Key Takeaways

1. **Bridge is default** - Works for most cases
2. **Host for performance** - But loses isolation
3. **None for security** - Complete isolation
4. **Custom bridge for organization** - Better structure
5. **Overlay for multi-host** - Docker Swarm
6. **Macvlan for advanced** - Physical device appearance

## What's Next?

Now that you understand network types, let's learn how to configure networks. Next: [Network Configuration](/docs/docker/04-networking/network-configuration).

---

> **Remember**: Choose the right network type for your needs. Bridge for most cases. Others when you have specific requirements.

