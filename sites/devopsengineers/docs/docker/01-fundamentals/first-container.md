---
sidebar_position: 5
title: Your First Container
---

# Your First Container: Hello, Docker!

**This is it. The moment of truth. Your first container. It's simple. It's powerful. And it's the beginning of everything.**

## 🎯 The Big Picture

Think of running your first container like your first "Hello, World!" program. It's simple. It's exciting. And it proves everything works.

**This is where you go from "I've heard of Docker" to "I've used Docker."**

## The Hello World Container

Let's start with the simplest possible container:

```bash
docker run hello-world
```

**That's it. One command. Your first container.**

## What Just Happened?

Let me break down what happened when you ran that command:

1. **Docker checked locally**: "Do I have the `hello-world` image?"
2. **Docker pulled the image**: Downloaded from Docker Hub (if not found)
3. **Docker created a container**: Set up the environment
4. **Docker ran the container**: Executed the application
5. **Docker showed output**: Displayed the message
6. **Docker stopped the container**: Cleaned up

**All in one command. All in seconds.**

## Understanding the Output

When you run `docker run hello-world`, you should see:

```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
 3. The Docker daemon created a new container from that image.
 4. The Docker daemon ran the container.
 5. The Docker daemon streamed that output to the Docker client.
```

**This confirms everything is working.**

## Running a Real Container

Now let's run something more interesting. Let's run nginx (a web server):

```bash
docker run -d -p 8080:80 --name my-nginx nginx
```

**What each part means:**
- `docker run`: Run a container
- `-d`: Run in detached mode (background)
- `-p 8080:80`: Map port 8080 on host to port 80 in container
- `--name my-nginx`: Give the container a name
- `nginx`: The image to use

**Now visit http://localhost:8080 in your browser.**

You should see the nginx welcome page. **Your first real container is running!**

## Checking Your Container

Let's see what's running:

```bash
docker ps
```

You should see:
```
CONTAINER ID   IMAGE   COMMAND   CREATED   STATUS   PORTS                  NAMES
abc123def456   nginx   ...       1 min ago Up 1 min 0.0.0.0:8080->80/tcp  my-nginx
```

**Your container is running!**

## Viewing Container Logs

See what the container is doing:

```bash
docker logs my-nginx
```

You'll see nginx access logs. **This is how you debug containers.**

## Stopping Your Container

Stop the container:

```bash
docker stop my-nginx
```

Check it's stopped:

```bash
docker ps -a
```

The `-a` flag shows all containers, including stopped ones.

## Removing Your Container

Clean up:

```bash
docker rm my-nginx
```

**Container removed. Clean slate.**

## Hands-On Exercise: Run Multiple Containers

Let's run a few containers to see Docker in action:

```bash
# Run nginx
docker run -d -p 8080:80 --name web nginx

# Run redis
docker run -d -p 6379:6379 --name cache redis

# Run a Python app
docker run -d -p 5000:5000 --name app python:3.9 python -m http.server 5000
```

**Check all running containers:**
```bash
docker ps
```

You should see three containers running. **Three different applications. One command each.**

## Understanding Container States

Containers have states:

- **Created**: Container created but not started
- **Running**: Container is running
- **Paused**: Container is paused
- **Stopped**: Container is stopped
- **Removed**: Container is deleted

**Check states:**
```bash
docker ps          # Running containers
docker ps -a       # All containers
docker ps -q       # Just IDs
```

## Common First Container Commands

Here are the commands you'll use most:

```bash
# Run a container
docker run <image>

# List running containers
docker ps

# List all containers
docker ps -a

# Stop a container
docker stop <container>

# Start a stopped container
docker start <container>

# Remove a container
docker rm <container>

# View logs
docker logs <container>

# Execute command in running container
docker exec -it <container> <command>
```

## Real-World Example: Running a Web Application

Let's run a real web application:

```bash
# Run a Node.js app
docker run -d \
  -p 3000:3000 \
  --name my-app \
  node:18 \
  node -e "require('http').createServer((req,res)=>{res.end('Hello from Docker!')}).listen(3000)"
```

**Visit http://localhost:3000**

You should see "Hello from Docker!"

**This is a real application running in a container.**

## My Take: The First Container Experience

I remember my first container. It was `hello-world`. Simple. But it clicked.

**That's when I realized: This is different. This is powerful.**

Containers aren't just VMs. They're something new. Something better.

**Your first container is the beginning. Everything builds from here.**

## Memory Tip: The First Step Analogy

Running your first container is like:
- Your first "Hello, World!" program
- Your first drive in a car
- Your first flight

**It's simple. But it's the beginning of everything.**

## Common Mistakes

1. **Forgetting to use `-d`**: Container runs in foreground (blocks terminal)
2. **Not mapping ports**: Can't access the application
3. **Not naming containers**: Hard to manage later
4. **Not checking logs**: Missing important information
5. **Not cleaning up**: Containers accumulate over time

## Troubleshooting

### Container won't start

```bash
# Check logs
docker logs <container>

# Check what went wrong
docker inspect <container>
```

### Can't access application

```bash
# Check port mapping
docker ps

# Check if container is running
docker ps -a
```

### Container exits immediately

```bash
# Check logs
docker logs <container>

# Run interactively to see errors
docker run -it <image> /bin/sh
```

## Key Takeaways

1. **`docker run` is your main command** - It does everything
2. **Containers run in seconds** - Fast startup is Docker's strength
3. **Port mapping is essential** - `-p host:container` maps ports
4. **Check logs for debugging** - `docker logs` is your friend
5. **Clean up containers** - Remove what you don't need

## What's Next?

Congratulations! You've run your first container. Now let's understand images. Next: [Understanding Images](/docs/docker/02-images/understanding-images).

---

> **Remember**: Your first container is just the beginning. The real power comes when you build your own images and deploy your own applications.

