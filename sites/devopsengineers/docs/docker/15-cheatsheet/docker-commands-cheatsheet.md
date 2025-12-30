---
sidebar_position: 1
title: Docker Commands Cheatsheet
---

# Docker Commands Cheatsheet: Quick Reference

**All Docker commands. Quick reference. Examples included. That's this cheatsheet.**

## 🎯 How to Use This Cheatsheet

**This is your quick reference. All commands. All purposes. All examples. Bookmark this. Use it daily.**

## Container Commands

### docker run

**Purpose:** Create and start a container

**Basic:**
```bash
docker run nginx
```

**With options:**
```bash
# Run in detached mode
docker run -d nginx

# Run with name
docker run --name my-nginx nginx

# Run with port mapping
docker run -p 8080:80 nginx

# Run with environment variable
docker run -e NODE_ENV=production my-app

# Run with volume mount
docker run -v /host/path:/container/path nginx

# Run with network
docker run --network my-network nginx

# Run with resource limits
docker run --memory="512m" --cpus="1.0" nginx

# Run interactively
docker run -it nginx sh

# Run and remove on exit
docker run --rm nginx
```

### docker ps

**Purpose:** List running containers

**Basic:**
```bash
docker ps
```

**With options:**
```bash
# List all containers (including stopped)
docker ps -a

# Show only IDs
docker ps -q

# Show size
docker ps -s

# Filter by name
docker ps --filter "name=nginx"

# Filter by status
docker ps --filter "status=exited"
```

### docker stop

**Purpose:** Stop running container(s)

**Basic:**
```bash
docker stop container-name
```

**With options:**
```bash
# Stop by ID
docker stop container-id

# Stop multiple
docker stop container1 container2

# Stop all running
docker stop $(docker ps -q)

# Stop with timeout
docker stop -t 10 container-name
```

### docker start

**Purpose:** Start stopped container(s)

**Basic:**
```bash
docker start container-name
```

**With options:**
```bash
# Start and attach
docker start -a container-name

# Start and show logs
docker start -i container-name
```

### docker restart

**Purpose:** Restart container(s)

**Basic:**
```bash
docker restart container-name
```

### docker rm

**Purpose:** Remove container(s)

**Basic:**
```bash
docker rm container-name
```

**With options:**
```bash
# Force remove running container
docker rm -f container-name

# Remove all stopped containers
docker rm $(docker ps -a -q -f status=exited)

# Remove with volumes
docker rm -v container-name
```

### docker exec

**Purpose:** Execute command in running container

**Basic:**
```bash
docker exec container-name command
```

**With options:**
```bash
# Interactive shell
docker exec -it container-name sh

# Run as specific user
docker exec -u root container-name command

# Run in specific directory
docker exec -w /app container-name pwd

# Set environment variable
docker exec -e VAR=value container-name env
```

### docker logs

**Purpose:** View container logs

**Basic:**
```bash
docker logs container-name
```

**With options:**
```bash
# Follow logs
docker logs -f container-name

# Show last N lines
docker logs --tail 100 container-name

# Show with timestamps
docker logs -t container-name

# Show since timestamp
docker logs --since "2024-01-01T00:00:00" container-name

# Show until timestamp
docker logs --until "2024-01-01T12:00:00" container-name
```

### docker inspect

**Purpose:** Inspect container/image/network/volume

**Basic:**
```bash
docker inspect container-name
```

**With options:**
```bash
# Inspect specific field
docker inspect -f '{{.State.Status}}' container-name

# Inspect IP address
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container-name

# Inspect as JSON
docker inspect --format='{{json .Config}}' container-name
```

## Image Commands

### docker build

**Purpose:** Build image from Dockerfile

**Basic:**
```bash
docker build .
```

**With options:**
```bash
# Tag image
docker build -t my-app:1.0 .

# Specify Dockerfile
docker build -f Dockerfile.prod -t my-app:1.0 .

# Build without cache
docker build --no-cache -t my-app:1.0 .

# Build with build args
docker build --build-arg NODE_ENV=production -t my-app:1.0 .

# Build with target stage
docker build --target builder -t my-app:builder .

# Build with progress
docker build --progress=plain -t my-app:1.0 .
```

### docker images

**Purpose:** List images

**Basic:**
```bash
docker images
```

**With options:**
```bash
# Show all images (including intermediate)
docker images -a

# Filter by name
docker images nginx

# Show only IDs
docker images -q

# Filter by label
docker images --filter "label=version=1.0"
```

### docker pull

**Purpose:** Pull image from registry

**Basic:**
```bash
docker pull nginx
```

**With options:**
```bash
# Pull specific tag
docker pull nginx:alpine

# Pull from specific registry
docker pull registry.example.com/my-app:1.0

# Pull all tags
docker pull -a nginx
```

### docker push

**Purpose:** Push image to registry

**Basic:**
```bash
docker push my-app:1.0
```

**With options:**
```bash
# Push to specific registry
docker push registry.example.com/my-app:1.0

# Push with all tags
docker push -a my-app
```

### docker tag

**Purpose:** Tag image

**Basic:**
```bash
docker tag source-image:tag target-image:tag
```

**Example:**
```bash
docker tag my-app:1.0 registry.example.com/my-app:1.0
```

### docker rmi

**Purpose:** Remove image(s)

**Basic:**
```bash
docker rmi image-name
```

**With options:**
```bash
# Force remove
docker rmi -f image-name

# Remove by ID
docker rmi image-id

# Remove multiple
docker rmi image1 image2

# Remove all unused images
docker image prune -a
```

### docker history

**Purpose:** Show image history

**Basic:**
```bash
docker history image-name
```

**With options:**
```bash
# Show without truncation
docker history --no-trunc image-name

# Show human-readable sizes
docker history --human image-name
```

## Network Commands

### docker network ls

**Purpose:** List networks

**Basic:**
```bash
docker network ls
```

### docker network create

**Purpose:** Create network

**Basic:**
```bash
docker network create my-network
```

**With options:**
```bash
# Create with driver
docker network create --driver bridge my-network

# Create with subnet
docker network create --subnet=172.20.0.0/16 my-network

# Create with gateway
docker network create --gateway=172.20.0.1 my-network
```

### docker network inspect

**Purpose:** Inspect network

**Basic:**
```bash
docker network inspect my-network
```

### docker network connect

**Purpose:** Connect container to network

**Basic:**
```bash
docker network connect my-network container-name
```

### docker network disconnect

**Purpose:** Disconnect container from network

**Basic:**
```bash
docker network disconnect my-network container-name
```

### docker network rm

**Purpose:** Remove network

**Basic:**
```bash
docker network rm my-network
```

**With options:**
```bash
# Remove unused networks
docker network prune
```

## Volume Commands

### docker volume ls

**Purpose:** List volumes

**Basic:**
```bash
docker volume ls
```

### docker volume create

**Purpose:** Create volume

**Basic:**
```bash
docker volume create my-volume
```

**With options:**
```bash
# Create with driver
docker volume create --driver local my-volume

# Create with options
docker volume create --opt type=tmpfs --opt device=tmpfs my-volume
```

### docker volume inspect

**Purpose:** Inspect volume

**Basic:**
```bash
docker volume inspect my-volume
```

### docker volume rm

**Purpose:** Remove volume

**Basic:**
```bash
docker volume rm my-volume
```

**With options:**
```bash
# Remove unused volumes
docker volume prune
```

## Docker Compose Commands

### docker compose up

**Purpose:** Start services

**Basic:**
```bash
docker compose up
```

**With options:**
```bash
# Start in detached mode
docker compose up -d

# Build before starting
docker compose up --build

# Start specific service
docker compose up app

# Scale service
docker compose up --scale app=3

# Remove orphans
docker compose up --remove-orphans
```

### docker compose down

**Purpose:** Stop and remove services

**Basic:**
```bash
docker compose down
```

**With options:**
```bash
# Remove volumes
docker compose down -v

# Remove images
docker compose down --rmi all

# Remove orphans
docker compose down --remove-orphans
```

### docker compose ps

**Purpose:** List services

**Basic:**
```bash
docker compose ps
```

### docker compose logs

**Purpose:** View service logs

**Basic:**
```bash
docker compose logs
```

**With options:**
```bash
# Follow logs
docker compose logs -f

# Show specific service
docker compose logs app

# Show last N lines
docker compose logs --tail 100
```

### docker compose exec

**Purpose:** Execute command in service

**Basic:**
```bash
docker compose exec app command
```

**Example:**
```bash
docker compose exec app sh
```

### docker compose build

**Purpose:** Build service images

**Basic:**
```bash
docker compose build
```

**With options:**
```bash
# Build without cache
docker compose build --no-cache

# Build specific service
docker compose build app

# Build and push
docker compose build --push
```

### docker compose pull

**Purpose:** Pull service images

**Basic:**
```bash
docker compose pull
```

### docker compose restart

**Purpose:** Restart services

**Basic:**
```bash
docker compose restart
```

### docker compose stop

**Purpose:** Stop services

**Basic:**
```bash
docker compose stop
```

### docker compose start

**Purpose:** Start services

**Basic:**
```bash
docker compose start
```

## System Commands

### docker system df

**Purpose:** Show disk usage

**Basic:**
```bash
docker system df
```

**With options:**
```bash
# Show detailed usage
docker system df -v
```

### docker system prune

**Purpose:** Remove unused data

**Basic:**
```bash
docker system prune
```

**With options:**
```bash
# Remove all unused data (including images)
docker system prune -a

# Remove volumes too
docker system prune -a --volumes

# Force without prompt
docker system prune -a -f
```

### docker info

**Purpose:** Show Docker system information

**Basic:**
```bash
docker info
```

### docker version

**Purpose:** Show Docker version

**Basic:**
```bash
docker version
```

## Docker Swarm Commands

### docker swarm init

**Purpose:** Initialize Swarm

**Basic:**
```bash
docker swarm init
```

**With options:**
```bash
# Specify advertise address
docker swarm init --advertise-addr 192.168.1.100
```

### docker swarm join

**Purpose:** Join Swarm

**Basic:**
```bash
docker swarm join --token SWMTKN-xxx 192.168.1.100:2377
```

### docker service create

**Purpose:** Create service

**Basic:**
```bash
docker service create --name web nginx
```

**With options:**
```bash
# Create with replicas
docker service create --name web --replicas 3 nginx

# Create with port
docker service create --name web --publish 80:80 nginx

# Create with network
docker service create --name web --network my-network nginx

# Create with constraints
docker service create --name web --constraint 'node.role==worker' nginx
```

### docker service ls

**Purpose:** List services

**Basic:**
```bash
docker service ls
```

### docker service ps

**Purpose:** List service tasks

**Basic:**
```bash
docker service ps web
```

### docker service scale

**Purpose:** Scale service

**Basic:**
```bash
docker service scale web=5
```

### docker service update

**Purpose:** Update service

**Basic:**
```bash
docker service update --image nginx:alpine web
```

### docker service rm

**Purpose:** Remove service

**Basic:**
```bash
docker service rm web
```

## Docker Buildx Commands

### docker buildx build

**Purpose:** Build with BuildKit

**Basic:**
```bash
docker buildx build -t my-app:1.0 .
```

**With options:**
```bash
# Build and push
docker buildx build --push -t my-app:1.0 .

# Build for multiple platforms
docker buildx build --platform linux/amd64,linux/arm64 -t my-app:1.0 .

# Build with cache
docker buildx build --cache-from my-app:buildcache -t my-app:1.0 .
```

### docker buildx create

**Purpose:** Create buildx builder

**Basic:**
```bash
docker buildx create --name my-builder
```

### docker buildx use

**Purpose:** Use builder

**Basic:**
```bash
docker buildx use my-builder
```

## Docker Scout Commands

### docker scout cves

**Purpose:** Scan image for vulnerabilities

**Basic:**
```bash
docker scout cves my-app:1.0
```

**With options:**
```bash
# Scan and output JSON
docker scout cves --format json my-app:1.0

# Scan and fail on critical
docker scout cves --only-severity critical my-app:1.0
```

### docker scout compare

**Purpose:** Compare images

**Basic:**
```bash
docker scout compare my-app:1.0 my-app:2.0
```

## Common Command Combinations

### Clean Everything

```bash
# Stop all containers
docker stop $(docker ps -q)

# Remove all containers
docker rm $(docker ps -a -q)

# Remove all images
docker rmi $(docker images -q)

# Clean everything
docker system prune -a --volumes
```

### View Logs and Stats

```bash
# View logs
docker logs -f container-name

# View stats
docker stats

# View events
docker events
```

### Debug Container

```bash
# Inspect container
docker inspect container-name

# Execute shell
docker exec -it container-name sh

# View logs
docker logs container-name

# Check processes
docker exec container-name ps aux
```

## Quick Reference Table

| Command | Purpose | Example |
|---------|---------|---------|
| `docker run` | Create and start container | `docker run -d nginx` |
| `docker ps` | List containers | `docker ps -a` |
| `docker stop` | Stop container | `docker stop container` |
| `docker start` | Start container | `docker start container` |
| `docker rm` | Remove container | `docker rm container` |
| `docker exec` | Execute in container | `docker exec -it container sh` |
| `docker logs` | View logs | `docker logs -f container` |
| `docker build` | Build image | `docker build -t app:1.0 .` |
| `docker images` | List images | `docker images` |
| `docker pull` | Pull image | `docker pull nginx` |
| `docker push` | Push image | `docker push app:1.0` |
| `docker network ls` | List networks | `docker network ls` |
| `docker volume ls` | List volumes | `docker volume ls` |
| `docker compose up` | Start services | `docker compose up -d` |
| `docker compose down` | Stop services | `docker compose down` |
| `docker system prune` | Clean up | `docker system prune -a` |

## Key Takeaways

1. **Bookmark this cheatsheet** - Quick reference for daily use
2. **Practice commands** - Hands-on experience is key
3. **Use help** - `docker command --help` for details
4. **Combine commands** - Chain commands for efficiency
5. **Use aliases** - Create shortcuts for common commands

## What's Next?

Now that you have the Docker cheatsheet, you're ready for Kubernetes! Next: [Kubernetes Introduction](/docs/kubernetes/intro).

---

> **Remember**: This cheatsheet is your daily reference. Bookmark it. Use it. Master Docker commands. Then move to Kubernetes.

