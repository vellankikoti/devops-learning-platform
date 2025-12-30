---
sidebar_position: 3
title: Container Management
---

# Container Management: Controlling Your Containers

**You'll run many containers. You'll need to manage them. Start them. Stop them. Check their status. View their logs. That's container management.**

## 🎯 The Big Picture

Think of container management like managing a hotel. You have many rooms (containers). You need to know which are occupied (running). Which are empty (stopped). Which need cleaning (removed). You need to check on guests (logs). Handle requests (exec commands).

**Container management is about control. Knowing what's running. Being able to control it.**

## Listing Containers

**See what containers you have:**

```bash
# Running containers
docker ps

# All containers (including stopped)
docker ps -a

# Just container IDs
docker ps -q

# Last container (most recent)
docker ps -l
```

**Output:**
```
CONTAINER ID   IMAGE     COMMAND       CREATED        STATUS        PORTS     NAMES
abc123def456   nginx     "nginx -g..." 2 hours ago    Up 2 hours    80/tcp    web
def456ghi789   redis     "redis-server" 1 day ago     Up 1 day      6379/tcp  cache
```

**What you see:**
- **CONTAINER ID**: Unique identifier
- **IMAGE**: What image it's from
- **COMMAND**: What command it's running
- **CREATED**: When it was created
- **STATUS**: Current state (Up, Exited, etc.)
- **PORTS**: Port mappings
- **NAMES**: Container name

**Filter containers:**
```bash
# By name
docker ps --filter "name=web"

# By status
docker ps --filter "status=running"

# By image
docker ps --filter "ancestor=nginx"
```

## Starting Containers

**Start a stopped container:**

```bash
# By name
docker start web

# By ID
docker start abc123def456

# Multiple containers
docker start web cache db
```

**What happens:**
- Container starts
- Application runs
- Container enters "Running" state

**Start with options:**
```bash
# Start and attach (see output)
docker start -a web

# Start in interactive mode
docker start -i web
```

## Stopping Containers

**Stop a running container:**

```bash
# Graceful stop (SIGTERM, then SIGKILL after timeout)
docker stop web

# Force stop (SIGKILL immediately)
docker kill web
```

**Difference:**
- `docker stop`: Sends SIGTERM first. Gives application time to clean up. Then SIGKILL if needed.
- `docker kill`: Sends SIGKILL immediately. Force stop. No cleanup.

**Use `stop` normally. Use `kill` only when necessary.**

**Stop multiple:**
```bash
docker stop web cache db
```

**Stop with timeout:**
```bash
docker stop -t 30 web
# Wait 30 seconds before force killing
```

## Restarting Containers

**Restart a container:**

```bash
docker restart web
```

**What happens:**
1. Container stops
2. Container starts
3. Application restarts

**Why restart?**
- Apply configuration changes
- Recover from issues
- Refresh application state

**Restart with timeout:**
```bash
docker restart -t 10 web
# Wait 10 seconds before restarting
```

## Pausing Containers

**Pause a running container:**

```bash
docker pause web
```

**What happens:**
- Container processes are frozen
- State is preserved
- No CPU usage
- Memory is kept

**Why pause?**
- Temporarily stop without losing state
- Debugging
- Resource management

**Unpause:**
```bash
docker unpause web
```

**Container resumes from where it paused.**

## Removing Containers

**Delete containers:**

```bash
# Remove stopped container
docker rm web

# Force remove (even if running)
docker rm -f web

# Remove multiple
docker rm web cache db

# Remove all stopped containers
docker container prune
```

**What happens:**
- Container is deleted
- Writable layer removed
- Cannot be recovered

**Be careful:** Removing is permanent. Make sure you don't need the container.

**Remove with volumes:**
```bash
docker rm -v web
# Also removes associated volumes
```

## Inspecting Containers

**See detailed information:**

```bash
docker inspect web
```

**Shows everything:**
- Configuration
- State
- Network settings
- Mounts
- Environment variables
- Everything!

**Get specific information:**
```bash
# Get IP address
docker inspect -f '{{.NetworkSettings.IPAddress}}' web

# Get state
docker inspect -f '{{.State.Status}}' web

# Get exit code
docker inspect -f '{{.State.ExitCode}}' web

# Get environment variables
docker inspect -f '{{.Config.Env}}' web
```

## Executing Commands in Containers

**Run commands in running containers:**

```bash
# Execute command
docker exec web ls /app

# Interactive shell
docker exec -it web /bin/bash

# Run as specific user
docker exec -u root web whoami
```

**What it does:**
- Runs command inside container
- Doesn't restart container
- Useful for debugging

**Think of it as:** Calling the hotel room. Asking the guest to do something.

**Common use cases:**
```bash
# Check logs
docker exec web tail -f /var/log/app.log

# Check processes
docker exec web ps aux

# Edit file
docker exec -it web vi /app/config.json

# Run database migration
docker exec web npm run migrate
```

## The Hotel Management Analogy

**Think of container management like hotel management:**

**Listing (`docker ps`):** Check which rooms are occupied

**Starting (`docker start`):** Guest checks in

**Stopping (`docker stop`):** Guest checks out

**Restarting (`docker restart`):** Guest checks out and back in

**Pausing (`docker pause`):** Guest is in room but frozen

**Removing (`docker rm`):** Room is demolished

**Inspecting (`docker inspect`):** Check room details

**Executing (`docker exec`):** Call the room, ask guest to do something

**Once you see it this way, container management makes perfect sense.**

## Real-World Example: Managing a Web Application

**Let me show you a real workflow:**

**1. Start the application:**
```bash
docker run -d --name web -p 8080:80 nginx
```

**2. Check it's running:**
```bash
docker ps
# Should show web is running
```

**3. Check logs (if needed):**
```bash
docker logs web
```

**4. Execute command to check status:**
```bash
docker exec web nginx -t
# Test nginx configuration
```

**5. Restart to apply changes:**
```bash
docker restart web
```

**6. Stop when done:**
```bash
docker stop web
```

**7. Remove when no longer needed:**
```bash
docker rm web
```

## Container Statistics

**See resource usage:**

```bash
# Live statistics
docker stats

# For specific container
docker stats web

# One-time snapshot
docker stats --no-stream web
```

**Shows:**
- CPU usage
- Memory usage
- Network I/O
- Block I/O

**Useful for:**
- Monitoring
- Debugging performance
- Resource planning

## Bulk Operations

**Stop all running containers:**
```bash
docker stop $(docker ps -q)
```

**Remove all stopped containers:**
```bash
docker container prune
```

**Remove all containers (careful!):**
```bash
docker rm -f $(docker ps -aq)
```

**Start all stopped containers:**
```bash
docker start $(docker ps -aq)
```

## My Take: Container Management Workflow

**Here's my daily workflow:**

**Morning:**
1. `docker ps` - See what's running
2. Check logs if needed
3. Restart if issues

**During day:**
1. `docker exec` - Debug issues
2. `docker stats` - Monitor resources
3. `docker restart` - Apply changes

**Evening:**
1. `docker ps -a` - See all containers
2. `docker container prune` - Clean up stopped
3. Remove unused containers

**Weekly:**
1. Review all containers
2. Remove old/unused ones
3. Update images

**This keeps things organized and efficient.**

## Memory Tip: The Hotel Management Analogy

**Container management = Hotel management**

**List:** Check room status
**Start:** Guest checks in
**Stop:** Guest checks out
**Restart:** Guest checks out and back in
**Pause:** Guest frozen
**Remove:** Room demolished
**Inspect:** Check room details
**Exec:** Call room, ask guest

**Once you see it this way, management makes perfect sense.**

## Common Mistakes

1. **Not checking status**: Don't know what's running
2. **Using kill instead of stop**: Loses data
3. **Not removing stopped containers**: They accumulate
4. **Not using names**: Hard to manage
5. **Not inspecting when debugging**: Missing information

## Hands-On Exercise: Manage Containers

**1. Run a container:**
```bash
docker run -d --name test nginx
```

**2. Check it's running:**
```bash
docker ps
```

**3. Check statistics:**
```bash
docker stats test
# Press Ctrl+C to exit
```

**4. Execute a command:**
```bash
docker exec test nginx -v
```

**5. Inspect it:**
```bash
docker inspect test
```

**6. Stop it:**
```bash
docker stop test
```

**7. Remove it:**
```bash
docker rm test
```

## Key Takeaways

1. **`docker ps` lists containers** - See what's running
2. **`docker start/stop/restart` controls containers** - Basic lifecycle
3. **`docker exec` runs commands** - Debugging and management
4. **`docker inspect` shows details** - Everything about container
5. **`docker rm` removes containers** - Clean up regularly
6. **Use names** - Easier to manage

## What's Next?

Now that you can manage containers, let's learn how to view and manage logs. Next: [Container Logs](/docs/docker/03-containers/container-logs).

---

> **Remember**: Container management is about control. Know what's running. Be able to control it. That's how you manage containers effectively.

