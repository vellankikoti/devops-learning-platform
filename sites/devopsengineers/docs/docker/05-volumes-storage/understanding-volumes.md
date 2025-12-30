---
sidebar_position: 1
title: Understanding Volumes
---

# Understanding Volumes: Persistent Data in Containers

**Containers are ephemeral. They're temporary. When they're deleted, everything inside is gone. But data needs to persist. That's what volumes are for.**

## 🎯 The Big Picture

Think of volumes like a safety deposit box. The container is your hotel room. When you check out (container stops), your room is cleaned (container deleted). But your valuables (data) are in the safety deposit box (volume). They're safe. They persist.

**Volumes are how you keep data safe. How you make it persist. How you share it between containers.**

## Why Volumes?

**The problem:**
- Containers are temporary
- When container is deleted, data is lost
- Applications need persistent data
- Databases need to store data
- Logs need to be saved

**The solution:**
- Volumes store data outside containers
- Data persists when containers are deleted
- Data can be shared between containers
- Data survives container restarts

**Without volumes:**
- Data is lost when container stops
- Can't share data between containers
- Can't persist database data
- Everything is temporary

**With volumes:**
- Data persists
- Can share data
- Database data survives
- Everything is permanent (until you delete the volume)

## What is a Volume?

**A volume is a directory on the host filesystem.** Docker manages it. Containers can mount it.

**Key characteristics:**
- Stored outside container
- Managed by Docker
- Persists when container is deleted
- Can be shared between containers
- Can be backed up
- Can be restored

**Think of it as:** A shared folder. Outside the container. Managed by Docker. Persists forever (until deleted).

## Container Filesystem Layers

**Understanding why volumes are needed:**

**Container filesystem has layers:**
```
Writable Layer (your changes)
    ↓
Image Layers (read-only)
```

**When container is deleted:**
- Writable layer is deleted
- All changes are lost
- Data is gone

**Volumes bypass this:**
- Data stored outside writable layer
- Not deleted when container is deleted
- Persists independently

**Think of it as:** Writing on a whiteboard (writable layer) vs writing in a notebook (volume). Whiteboard is erased. Notebook persists.

## Volume Types

**Docker has three ways to handle data:**

### 1. Volumes (Named Volumes)

**What it is:** Docker-managed storage. Best practice.

**Characteristics:**
- Managed by Docker
- Stored in Docker's directory
- Portable across hosts
- Best for production

**Think of it as:** A safety deposit box. Managed by the bank (Docker). Safe. Portable.

### 2. Bind Mounts

**What it is:** Mount host directory directly. Development use.

**Characteristics:**
- Direct host directory access
- Good for development
- Not portable
- Host path dependent

**Think of it as:** A shared folder on your computer. Direct access. Not portable.

### 3. tmpfs Mounts

**What it is:** In-memory storage. Temporary data.

**Characteristics:**
- Stored in memory
- Very fast
- Lost on container stop
- Good for temporary data

**Think of it as:** RAM. Fast. Temporary. Lost when power goes off.

**We'll cover each in detail. For now, understand volumes are the main solution.**

## Creating Volumes

**Create a volume:**

```bash
# Create a volume
docker volume create my-volume

# Create with specific driver
docker volume create --driver local my-volume

# Create with options
docker volume create \
  --driver local \
  --opt type=none \
  --opt device=/path/to/data \
  my-volume
```

**What happens:**
- Docker creates a directory
- Manages it
- Ready to use

**List volumes:**
```bash
docker volume ls
```

**Inspect volume:**
```bash
docker volume inspect my-volume
```

**Shows:**
- Mount point (where data is stored)
- Driver
- Options
- Everything!

## Using Volumes

**Mount volume in container:**

```bash
# Using -v flag
docker run -d \
  --name web \
  -v my-volume:/app/data \
  nginx

# Using --mount flag (newer, recommended)
docker run -d \
  --name web \
  --mount source=my-volume,target=/app/data \
  nginx
```

**What it does:**
- Mounts `my-volume` to `/app/data` in container
- Data written to `/app/data` is stored in volume
- Persists when container is deleted

**Format:** `-v volume-name:container-path`

**Think of it as:** Connecting the safety deposit box (volume) to your room (container). You can access it. It's safe.

## Real-World Example: Database with Volume

**Let me show you a real example:**

**1. Create volume:**
```bash
docker volume create postgres-data
```

**2. Run database with volume:**
```bash
docker run -d \
  --name postgres \
  -v postgres-data:/var/lib/postgresql/data \
  -e POSTGRES_PASSWORD=secret \
  postgres:14
```

**What happens:**
- Database data stored in `postgres-data` volume
- Data persists when container stops
- Data persists when container is deleted
- Can recreate container, data is still there

**3. Stop and remove container:**
```bash
docker stop postgres
docker rm postgres
# Data is still in postgres-data volume!
```

**4. Recreate container:**
```bash
docker run -d \
  --name postgres \
  -v postgres-data:/var/lib/postgresql/data \
  postgres:14
# Data is back! Volume persisted.
```

**That's the power of volumes. Data survives container lifecycle.**

## The Safety Deposit Box Analogy

**Think of volumes like safety deposit boxes:**

**Container:** Your hotel room
- Temporary
- Cleaned when you leave
- Everything inside is lost

**Volume:** Safety deposit box
- Permanent
- Managed by bank (Docker)
- Your valuables (data) are safe
- Accessible from any room (container)

**When you check out (delete container):**
- Room is cleaned (container deleted)
- Safety deposit box remains (volume persists)
- Your valuables are safe (data persists)

**When you check in again (new container):**
- New room (new container)
- Same safety deposit box (same volume)
- Your valuables are still there (data is back)

**Once you see it this way, volumes make perfect sense.**

## Volume Location

**Where are volumes stored?**

**Linux:**
```
/var/lib/docker/volumes/
```

**macOS/Windows (Docker Desktop):**
```
Inside Docker Desktop VM
```

**You usually don't need to know. Docker manages it. But it's good to know where your data is.**

**Find volume location:**
```bash
docker volume inspect my-volume
# Shows "Mountpoint" - that's where data is
```

## Sharing Volumes Between Containers

**Multiple containers can use the same volume:**

```bash
# Create volume
docker volume create shared-data

# Container 1 writes data
docker run -d \
  --name writer \
  -v shared-data:/data \
  alpine sh -c "echo 'Hello' > /data/file.txt"

# Container 2 reads data
docker run -d \
  --name reader \
  -v shared-data:/data \
  alpine cat /data/file.txt
# Output: Hello
```

**Both containers see the same data. They share the volume.**

**Think of it as:** Multiple people (containers) sharing the same safety deposit box (volume). They all see the same contents.

## My Take: Why Volumes Matter

**I learned volumes the hard way. I ran a database without a volume. Container crashed. Data was gone. Hours of work lost.**

**Now I always use volumes for:**
- Databases
- Application data
- Logs
- Configuration files
- Anything that needs to persist

**The rule:** If data matters, use a volume. Always.

## Memory Tip: The Safety Deposit Box Analogy

**Volumes = Safety deposit boxes**

**Container:** Hotel room (temporary)
**Volume:** Safety deposit box (permanent)
**Data:** Valuables (persists)
**Sharing:** Multiple people, same box

**Once you see it this way, volumes make perfect sense.**

## Common Mistakes

1. **Not using volumes for databases**: Data lost when container stops
2. **Using wrong volume type**: Not understanding differences
3. **Not backing up volumes**: Data loss if volume is deleted
4. **Not naming volumes**: Hard to manage
5. **Forgetting volumes exist**: They accumulate

## Hands-On Exercise: Create and Use a Volume

**1. Create volume:**
```bash
docker volume create my-data
```

**2. Run container with volume:**
```bash
docker run -d \
  --name test \
  -v my-data:/data \
  alpine sh -c "echo 'Hello from volume' > /data/test.txt && sleep 3600"
```

**3. Check data:**
```bash
docker exec test cat /data/test.txt
# Output: Hello from volume
```

**4. Stop and remove container:**
```bash
docker stop test
docker rm test
# Volume still exists!
```

**5. Recreate container:**
```bash
docker run -d \
  --name test2 \
  -v my-data:/data \
  alpine cat /data/test.txt
# Output: Hello from volume
# Data persisted!
```

**6. Clean up:**
```bash
docker stop test2
docker rm test2
docker volume rm my-data
```

## Key Takeaways

1. **Volumes persist data** - Survives container deletion
2. **Volumes are managed by Docker** - Stored in Docker's directory
3. **Volumes can be shared** - Multiple containers can use same volume
4. **Use volumes for important data** - Databases, logs, application data
5. **Volumes are the solution** - For persistent data in containers

## What's Next?

Now that you understand volumes, let's learn about different volume types. Next: [Volume Types](/docs/docker/05-volumes-storage/volume-types).

---

> **Remember**: Volumes are like safety deposit boxes. Your data is safe. It persists. It survives container lifecycle. Always use volumes for important data.

