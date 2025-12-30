---
sidebar_position: 2
title: Running Containers
---

# Running Containers: The Art of docker run

**`docker run` is the most important Docker command. It's also the most complex. Understanding all its options will make you a Docker expert.**

## 🎯 The Big Picture

Think of `docker run` like ordering at a restaurant. You can order the basic dish (simple run). Or you can customize everything: table location (port mapping), special requests (environment variables), dietary restrictions (resource limits).

**The more you customize, the more control you have. The more control you have, the better your containers run.**

## The Basic docker run

**Simplest form:**
```bash
docker run nginx
```

**What happens:**
1. Docker checks if `nginx` image exists locally
2. If not, pulls it from Docker Hub
3. Creates a container
4. Starts the container
5. Runs the default command

**That's it. One command. Container running.**

**But wait...** The container runs in the foreground. Your terminal is blocked. You can't do anything else.

**That's where options come in.**

## Essential Options

### -d: Detached Mode (Background)

**Run container in background:**

```bash
docker run -d nginx
```

**What it does:**
- Container runs in background
- Terminal is free
- You get container ID back
- Container keeps running

**Think of it as:** Ordering food to go. You get it. You leave. Food is prepared in the background.

**Check it's running:**
```bash
docker ps
```

### --name: Give Container a Name

**Name your containers:**

```bash
docker run -d --name my-nginx nginx
```

**Why name containers?**
- Easier to reference: `docker stop my-nginx` vs `docker stop abc123def456`
- Better organization
- Clearer logs

**Without name:** Docker generates random name like `happy_penguin`

**With name:** You control it. `my-nginx`, `web-server`, `api-backend`

### -p: Port Mapping

**Map container ports to host ports:**

```bash
docker run -d -p 8080:80 nginx
```

**Format:** `-p host-port:container-port`

**What it means:**
- Host port 8080 → Container port 80
- Access via `http://localhost:8080`
- Container's port 80 is accessible

**Think of it as:** Room number mapping. Hotel room 8080 (host) connects to room 80 (container).

**Multiple ports:**
```bash
docker run -d -p 8080:80 -p 8443:443 nginx
```

**All host ports:**
```bash
docker run -d -p 80:80 nginx
# Maps host port 80 to container port 80
```

### -e: Environment Variables

**Set environment variables:**

```bash
docker run -d -e NODE_ENV=production -e PORT=3000 my-app
```

**What it does:**
- Sets `NODE_ENV=production` in container
- Sets `PORT=3000` in container
- Application can read these: `process.env.NODE_ENV`

**Multiple variables:**
```bash
docker run -d \
  -e NODE_ENV=production \
  -e DB_HOST=db.example.com \
  -e DB_PORT=5432 \
  my-app
```

**From file:**
```bash
docker run -d --env-file .env my-app
```

**Think of it as:** Setting preferences when ordering. "No onions. Extra spicy. Table by the window."

### -v: Volume Mounting

**Mount host directories into container:**

```bash
docker run -d -v /host/data:/container/data nginx
```

**Format:** `-v host-path:container-path`

**What it means:**
- Host directory `/host/data` → Container `/container/data`
- Files are shared
- Changes persist on host

**Think of it as:** Shared storage. Like a shared drive between your computer and the container.

**We'll cover volumes in detail later. For now, know this is how you share files.**

### --rm: Auto-Remove

**Remove container when it stops:**

```bash
docker run --rm nginx
```

**What it does:**
- Container runs
- When it stops, Docker removes it automatically
- No manual cleanup needed

**Why use it?**
- One-time tasks
- Testing
- Don't want to accumulate containers

**Think of it as:** Disposable containers. Use once. Throw away.

### -it: Interactive Terminal

**Run container interactively:**

```bash
docker run -it ubuntu /bin/bash
```

**What it does:**
- `-i`: Interactive (keeps STDIN open)
- `-t`: TTY (allocates pseudo-terminal)
- Together: Interactive terminal

**You get a shell inside the container. You can type commands. You're inside.**

**Think of it as:** Sitting at the table. You can talk to the chef. Give instructions.

**Exit:** Type `exit` or press `Ctrl+D`

### --restart: Restart Policy

**Auto-restart containers:**

```bash
docker run -d --restart=always nginx
```

**Options:**
- `no` - Don't restart (default)
- `always` - Always restart
- `on-failure` - Restart on failure
- `unless-stopped` - Restart unless manually stopped

**Why use it?**
- High availability
- Automatic recovery
- Production deployments

**Think of it as:** Auto-renewal. If something goes wrong, automatically try again.

## Real-World Examples

### Example 1: Web Server

```bash
docker run -d \
  --name web \
  -p 8080:80 \
  --restart=always \
  nginx
```

**What it does:**
- Runs nginx in background
- Named `web`
- Accessible on port 8080
- Auto-restarts if it crashes

**Access:** `http://localhost:8080`

### Example 2: Node.js Application

```bash
docker run -d \
  --name api \
  -p 3000:3000 \
  -e NODE_ENV=production \
  -e DB_HOST=db.example.com \
  -v /app/logs:/app/logs \
  --restart=on-failure \
  my-node-app:1.0
```

**What it does:**
- Runs Node.js app
- Port 3000
- Production environment
- Database connection
- Logs directory mounted
- Restarts on failure

### Example 3: Database

```bash
docker run -d \
  --name postgres \
  -e POSTGRES_PASSWORD=secret \
  -e POSTGRES_DB=myapp \
  -v /data/postgres:/var/lib/postgresql/data \
  -p 5432:5432 \
  postgres:14
```

**What it does:**
- Runs PostgreSQL
- Sets password and database
- Persistent data storage
- Accessible on port 5432

## Combining Options

**You can combine all options:**

```bash
docker run -d \
  --name my-app \
  -p 8080:80 \
  -e ENV=production \
  -v /host/data:/app/data \
  --restart=always \
  --rm \
  my-app:1.0
```

**Read it like this:**
- Run in background (`-d`)
- Name it `my-app` (`--name`)
- Map port 8080 (`-p`)
- Set environment variable (`-e`)
- Mount volume (`-v`)
- Auto-restart (`--restart`)
- Auto-remove (`--rm`)
- Use image `my-app:1.0`

## The Restaurant Order Analogy

**Think of `docker run` options like customizing a restaurant order:**

**Basic order (`docker run nginx`):** "I'll have the nginx dish."

**With options:**
- `-d`: "To go, please" (background)
- `--name`: "Call it 'my-nginx'" (name)
- `-p 8080:80`: "Serve it at table 8080" (port mapping)
- `-e NODE_ENV=production`: "Make it production style" (environment)
- `-v /data:/app`: "Use this shared storage" (volume)
- `--restart=always`: "If something goes wrong, remake it" (restart policy)
- `-it`: "I want to sit here and watch" (interactive)

**The more options, the more customized your order.**

## Common Patterns

### Pattern 1: Development Server

```bash
docker run -d \
  --name dev-server \
  -p 3000:3000 \
  -v $(pwd):/app \
  -e NODE_ENV=development \
  node:18 npm run dev
```

**Why:**
- Mounts current directory (live code changes)
- Development environment
- Accessible on port 3000

### Pattern 2: Production Server

```bash
docker run -d \
  --name prod-server \
  -p 80:80 \
  -e NODE_ENV=production \
  --restart=always \
  my-app:1.0
```

**Why:**
- Production environment
- Standard port 80
- Auto-restart
- Specific version

### Pattern 3: One-Time Task

```bash
docker run --rm \
  -v $(pwd):/data \
  node:18 \
  node script.js
```

**Why:**
- `--rm` removes after completion
- Mounts current directory
- Runs script
- Cleans up automatically

## My Take: docker run Mastery

**I used to just run containers. Then I learned the options. Then everything changed.**

**The key options I use daily:**
1. `-d` - Always run in background
2. `--name` - Always name containers
3. `-p` - Always map ports explicitly
4. `-e` - Set environment variables
5. `--restart=always` - For production

**Master these five, and you've mastered `docker run`.**

## Memory Tip: The Restaurant Order Analogy

**docker run = Restaurant order**

**Basic:** "I'll have nginx"
**With options:** "I'll have nginx, to go, call it my-nginx, serve at table 8080, production style, with shared storage, auto-remake if wrong"

**Once you see it this way, docker run makes perfect sense.**

## Common Mistakes

1. **Forgetting `-d`**: Container blocks terminal
2. **Not naming containers**: Hard to manage
3. **Wrong port mapping**: Can't access application
4. **Not setting environment variables**: Application misconfigured
5. **Forgetting `--rm`**: Containers accumulate

## Hands-On Exercise: Run a Custom Container

**1. Run nginx in background:**
```bash
docker run -d --name web nginx
```

**2. Check it's running:**
```bash
docker ps
```

**3. Access it (need port mapping):**
```bash
docker run -d --name web2 -p 8080:80 nginx
# Now access http://localhost:8080
```

**4. Run with environment variable:**
```bash
docker run -d -e MESSAGE="Hello Docker" my-app
```

**5. Run interactively:**
```bash
docker run -it ubuntu /bin/bash
# You're inside! Type commands. Exit with 'exit'
```

## Key Takeaways

1. **`docker run` creates and starts containers** - One command does both
2. **`-d` runs in background** - Frees your terminal
3. **`--name` names containers** - Easier to manage
4. **`-p` maps ports** - Makes containers accessible
5. **`-e` sets environment variables** - Configures applications
6. **Combine options** - Full control over containers

## What's Next?

Now that you can run containers, let's learn how to manage them. Next: [Container Management](/docs/docker/03-containers/container-management).

---

> **Remember**: `docker run` is powerful. Learn the options. Master them. They're your tools for controlling containers.

