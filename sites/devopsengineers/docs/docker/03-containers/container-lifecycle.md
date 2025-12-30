---
sidebar_position: 1
title: Container Lifecycle
---

# Container Lifecycle: From Creation to Destruction

**A container has a life. It's created. It runs. It stops. It's removed. Understanding this lifecycle is understanding containers.**

## 🎯 The Big Picture

Think of a container's lifecycle like a hotel room. A guest checks in (created). The guest stays (running). The guest checks out (stopped). The room is cleaned (removed).

**That's the container lifecycle. Simple. Predictable. Manageable.**

## Container States

**A container can be in one of these states:**

1. **Created** - Container created but not started
2. **Running** - Container is running
3. **Paused** - Container is paused (frozen)
4. **Restarting** - Container is restarting
5. **Exited** - Container stopped (but not removed)
6. **Dead** - Container failed and cannot be restarted
7. **Removed** - Container deleted (gone forever)

**The lifecycle flow:**
```
Created → Running → Exited → Removed
         ↓
      Paused
         ↓
      Running
         ↓
    Restarting
         ↓
      Running
```

## State 1: Created

**What it is:** Container is created but not started.

**How to create:**
```bash
docker create nginx
```

**What happens:**
- Docker creates the container
- Sets up filesystem
- Configures networking
- But doesn't start it

**Why create without starting?**
- Prepare container before starting
- Configure everything first
- Start when ready

**Think of it as:** Room is ready. Guest hasn't arrived yet.

## State 2: Running

**What it is:** Container is running. Application is active.

**How to run:**
```bash
# Create and start
docker run nginx

# Start existing container
docker start <container-id>
```

**What happens:**
- Container starts
- Application runs
- Processes are active
- Container is doing work

**Think of it as:** Guest is in the room. Using the facilities.

## State 3: Paused

**What it is:** Container is frozen. Processes are paused.

**How to pause:**
```bash
docker pause <container-id>
```

**What happens:**
- All processes are paused
- Container state is frozen
- No CPU usage
- Memory is preserved

**Why pause?**
- Temporarily stop without losing state
- Debugging
- Resource management

**Think of it as:** Guest is in the room. But frozen in time.

**Unpause:**
```bash
docker unpause <container-id>
```

## State 4: Restarting

**What it is:** Container is restarting. Between stopped and running.

**When it happens:**
- Container crashes
- Restart policy triggers
- Manual restart

**What happens:**
- Container stops
- Docker waits (backoff)
- Container starts again
- Process repeats if it crashes again

**Think of it as:** Guest checked out. But coming back soon.

## State 5: Exited

**What it is:** Container stopped. But not removed.

**How containers exit:**
- Application finishes (exit code 0)
- Application crashes (exit code non-zero)
- You stop it manually
- System stops it (OOM, etc.)

**What happens:**
- Container stops
- Processes terminate
- Filesystem preserved
- Can be restarted

**Think of it as:** Guest checked out. Room is empty. But room still exists.

**Check exit code:**
```bash
docker inspect <container-id> | grep ExitCode
```

**Exit codes:**
- `0` - Success
- `1-255` - Error (application-specific)

## State 6: Dead

**What it is:** Container failed completely. Cannot be restarted.

**When it happens:**
- Fatal errors
- Cannot recover
- Must be removed and recreated

**Think of it as:** Room is destroyed. Cannot be used.

## State 7: Removed

**What it is:** Container is deleted. Gone forever.

**How to remove:**
```bash
docker rm <container-id>
```

**What happens:**
- Container is deleted
- Writable layer removed
- Cannot be recovered
- Must recreate to use again

**Think of it as:** Room is demolished. Doesn't exist anymore.

## The Hotel Room Analogy

**Think of container lifecycle like a hotel room:**

**Created:** Room is ready. Key is made. But no guest yet.

**Running:** Guest checked in. Using the room. Active.

**Paused:** Guest is in room. But frozen. Time stopped.

**Restarting:** Guest checked out. But coming back. Room being prepared.

**Exited:** Guest checked out. Room is empty. But room exists.

**Dead:** Room is destroyed. Cannot be used.

**Removed:** Room is demolished. Doesn't exist.

**Once you see it this way, the lifecycle makes perfect sense.**

## Container Lifecycle Commands

**Create:**
```bash
docker create nginx
```

**Start:**
```bash
docker start <container-id>
```

**Run (create + start):**
```bash
docker run nginx
```

**Stop:**
```bash
docker stop <container-id>
```

**Pause:**
```bash
docker pause <container-id>
```

**Unpause:**
```bash
docker unpause <container-id>
```

**Restart:**
```bash
docker restart <container-id>
```

**Kill (force stop):**
```bash
docker kill <container-id>
```

**Remove:**
```bash
docker rm <container-id>
```

## Checking Container Status

**List containers:**
```bash
# Running containers
docker ps

# All containers (including stopped)
docker ps -a

# Just IDs
docker ps -q
```

**Inspect container:**
```bash
docker inspect <container-id>
```

**Shows:**
- State
- Exit code
- Created date
- Started date
- Finished date
- Everything!

**Check specific state:**
```bash
docker inspect -f '{{.State.Status}}' <container-id>
# Output: running, exited, paused, etc.
```

## Restart Policies

**Docker can automatically restart containers:**

**Options:**
- `no` - Don't restart (default)
- `always` - Always restart
- `on-failure` - Restart only on failure
- `unless-stopped` - Restart unless manually stopped

**Set restart policy:**
```bash
docker run --restart=always nginx
```

**Why use restart policies?**
- Automatic recovery
- High availability
- Resilience

**Real example:**
```bash
# Web server that should always run
docker run -d --restart=always --name web nginx

# If it crashes, Docker restarts it automatically
```

## Real-World Example: Web Server Lifecycle

**Let me show you a real example:**

**1. Create container:**
```bash
docker create --name web nginx
# State: Created
```

**2. Start container:**
```bash
docker start web
# State: Running
```

**3. Check status:**
```bash
docker ps
# Shows: web is running
```

**4. Stop container:**
```bash
docker stop web
# State: Exited
```

**5. Check status:**
```bash
docker ps -a
# Shows: web is exited
```

**6. Restart container:**
```bash
docker start web
# State: Running again
```

**7. Remove container:**
```bash
docker rm web
# State: Removed (gone forever)
```

## My Take: Understanding the Lifecycle

**I used to just run containers. I didn't think about states. Then I had to debug. Then I understood.**

**Understanding the lifecycle helps you:**
- Debug issues (what state is it in?)
- Manage containers (when to stop, when to remove)
- Optimize resources (remove stopped containers)
- Troubleshoot (why did it exit?)

**The lifecycle isn't theoretical. It's practical. It's how you manage containers.**

## Memory Tip: The Hotel Room Analogy

**Container lifecycle = Hotel room lifecycle**

**Created:** Room ready, no guest
**Running:** Guest active
**Paused:** Guest frozen
**Restarting:** Guest coming back
**Exited:** Guest left, room empty
**Dead:** Room destroyed
**Removed:** Room demolished

**Once you see it this way, the lifecycle makes perfect sense.**

## Common Mistakes

1. **Not checking state**: Don't know if container is running
2. **Not removing stopped containers**: They accumulate
3. **Using kill instead of stop**: Force stop loses data
4. **Not using restart policies**: Manual restarts are tedious
5. **Confusing stop and remove**: Stop doesn't delete

## Key Takeaways

1. **Containers have states** - Created, Running, Paused, Exited, etc.
2. **Lifecycle is predictable** - Created → Running → Exited → Removed
3. **Check state with `docker ps`** - See what's running
4. **Use restart policies** - Automatic recovery
5. **Remove stopped containers** - Clean up regularly

## What's Next?

Now that you understand the lifecycle, let's learn how to run containers properly. Next: [Running Containers](/docs/docker/03-containers/running-containers).

---

> **Remember**: A container has a life. Understand its states. Manage its lifecycle. That's how you work with containers.

