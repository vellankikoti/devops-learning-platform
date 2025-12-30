---
sidebar_position: 3
title: Network Configuration
---

# Network Configuration: Customizing Your Networks

**Default networks work. But sometimes you need more. Custom subnets. Specific IPs. DNS settings. That's network configuration.**

## 🎯 The Big Picture

Think of network configuration like customizing a house. The default house works. But you might want a bigger garage (larger subnet). A specific address (fixed IP). Better security (firewall rules). Custom features.

**Network configuration gives you control. You decide how networks work.**

## Creating Networks with Configuration

**Basic network creation:**
```bash
docker network create my-network
```

**That's it. Works. But you can configure more.**

## Custom Subnet

**Set your own subnet:**

```bash
docker network create --subnet=192.168.100.0/24 my-network
```

**What it does:**
- Creates network with subnet 192.168.100.0/24
- Containers get IPs from 192.168.100.2 to 192.168.100.254
- Gateway is 192.168.100.1

**Why use custom subnet?**
- Avoid conflicts with existing networks
- Organize by application
- Match your network architecture
- Specific IP ranges

**Think of it as:** Choosing a specific neighborhood. Not random. You decide the address range.

**Example:**
```bash
# Create network with custom subnet
docker network create --subnet=10.0.1.0/24 app-network

# Containers get IPs like 10.0.1.2, 10.0.1.3, etc.
docker run -d --name web --network app-network nginx
```

## Custom Gateway

**Set custom gateway:**

```bash
docker network create \
  --subnet=192.168.100.0/24 \
  --gateway=192.168.100.1 \
  my-network
```

**What it does:**
- Sets gateway IP to 192.168.100.1
- Default is usually .1 in subnet
- Can customize if needed

**Why customize gateway?**
- Match existing network architecture
- Specific routing requirements
- Network integration

## IP Address Ranges

**Set IP address range:**

```bash
docker network create \
  --subnet=192.168.100.0/24 \
  --ip-range=192.168.100.0/28 \
  my-network
```

**What it does:**
- Network subnet: 192.168.100.0/24 (256 addresses)
- IP range for containers: 192.168.100.0/28 (16 addresses)
- Limits container IPs to specific range

**Why limit IP range?**
- Reserve IPs for other uses
- Better organization
- Network planning

**Think of it as:** Reserving some addresses. Not all addresses are for containers. Some are reserved.

## DNS Configuration

**Configure DNS servers:**

```bash
docker network create \
  --dns=8.8.8.8 \
  --dns=8.8.4.4 \
  my-network
```

**What it does:**
- Sets DNS servers for containers
- Default: Docker's built-in DNS
- Can use external DNS (Google, Cloudflare, etc.)

**Why customize DNS?**
- Use company DNS
- Specific DNS requirements
- DNS filtering
- Performance optimization

**Multiple DNS servers:**
```bash
docker network create \
  --dns=8.8.8.8 \
  --dns=1.1.1.1 \
  --dns-search=example.com \
  my-network
```

**`--dns-search`:** Adds search domain. Containers can resolve `web` as `web.example.com`.

## Driver Options

**Configure driver-specific options:**

```bash
# Bridge driver options
docker network create \
  --driver bridge \
  -o com.docker.network.bridge.name=my-bridge \
  -o com.docker.network.bridge.enable_icc=true \
  my-network
```

**Common options:**
- `com.docker.network.bridge.name`: Bridge name
- `com.docker.network.bridge.enable_icc`: Inter-container communication
- `com.docker.network.bridge.enable_ip_masquerade`: IP masquerading

**Why configure driver options?**
- Advanced networking requirements
- Integration with existing networks
- Specific network behavior

## Labels

**Add labels to networks:**

```bash
docker network create \
  --label environment=production \
  --label app=web \
  my-network
```

**What it does:**
- Adds metadata to network
- Useful for organization
- Can filter by labels

**Why use labels?**
- Organization
- Automation
- Filtering
- Documentation

**Filter by labels:**
```bash
docker network ls --filter "label=environment=production"
```

## The House Customization Analogy

**Think of network configuration like customizing a house:**

**Custom subnet:** Choosing a specific neighborhood
- Not random
- You decide the address range

**Custom gateway:** Setting the main entrance
- Where traffic enters/exits
- Routing point

**IP range:** Reserving some rooms
- Not all addresses for containers
- Some reserved

**DNS configuration:** Setting up phone directory
- How to find addresses
- Which directory to use

**Driver options:** Advanced features
- Custom bridge settings
- Advanced networking

**Labels:** Adding tags
- Organization
- Filtering

**Once you see it this way, network configuration makes sense.**

## Real-World Example: Production Network Setup

**Let me show you a real production setup:**

**1. Create network for web application:**
```bash
docker network create \
  --subnet=10.0.1.0/24 \
  --gateway=10.0.1.1 \
  --dns=8.8.8.8 \
  --label environment=production \
  --label app=web \
  web-network
```

**2. Create network for database:**
```bash
docker network create \
  --subnet=10.0.2.0/24 \
  --gateway=10.0.2.1 \
  --label environment=production \
  --label app=database \
  db-network
```

**3. Run containers:**
```bash
# Web on web-network
docker run -d --name web --network web-network nginx

# Database on db-network
docker run -d --name db --network db-network postgres
```

**Why this setup?**
- Separate networks for isolation
- Custom subnets for organization
- Labels for management
- Production-ready

## Inspecting Network Configuration

**See network details:**

```bash
# Inspect network
docker network inspect my-network

# Get specific information
docker network inspect -f '{{.IPAM.Config}}' my-network
```

**Shows:**
- Subnet
- Gateway
- Containers
- Configuration
- Everything!

## Updating Network Configuration

**Note:** You can't modify network configuration after creation. You need to:
1. Remove containers
2. Remove network
3. Create new network with new configuration
4. Recreate containers

**That's why planning is important.**

## My Take: Network Configuration Strategy

**Here's what I do:**

**Development:**
- Use default networks
- Simple and works
- No configuration needed

**Production:**
- Custom subnets per application
- Labels for organization
- DNS configuration if needed
- Plan before creating

**The key:** Start simple. Configure only when needed. Plan production networks carefully.

## Memory Tip: The House Customization Analogy

**Network configuration = House customization**

**Subnet:** Choose neighborhood
**Gateway:** Set main entrance
**IP range:** Reserve rooms
**DNS:** Set phone directory
**Options:** Advanced features
**Labels:** Add tags

**Once you see it this way, configuration makes sense.**

## Common Mistakes

1. **Over-configuring**: Defaults work for most cases
2. **Not planning subnets**: IP conflicts
3. **Forgetting labels**: Hard to organize later
4. **Wrong subnet size**: Too small or too large
5. **Not documenting**: Forget why you configured it

## Hands-On Exercise: Configure a Network

**1. Create network with custom subnet:**
```bash
docker network create \
  --subnet=192.168.200.0/24 \
  --gateway=192.168.200.1 \
  my-custom-network
```

**2. Inspect it:**
```bash
docker network inspect my-custom-network
```

**3. Run container on it:**
```bash
docker run -d --name test --network my-custom-network alpine sleep 3600
```

**4. Check IP:**
```bash
docker inspect -f '{{.NetworkSettings.Networks.my-custom-network.IPAddress}}' test
# Should be in 192.168.200.x range
```

**5. Clean up:**
```bash
docker stop test
docker rm test
docker network rm my-custom-network
```

## Key Takeaways

1. **Custom subnet** - Choose your IP range
2. **Custom gateway** - Set routing point
3. **IP ranges** - Reserve addresses
4. **DNS configuration** - Set DNS servers
5. **Labels** - Organize networks
6. **Plan before creating** - Can't modify after creation

## What's Next?

Now that you can configure networks, let's learn about service discovery. Next: [Service Discovery](/docs/docker/04-networking/service-discovery).

---

> **Remember**: Network configuration gives you control. But start simple. Configure only when you need to. Defaults work for most cases.

