---
sidebar_position: 1
title: Docker Swarm
---

# Docker Swarm: Native Container Orchestration

**Docker Swarm is Docker's built-in orchestration. No extra tools. No complexity. Just Docker. That's Docker Swarm.**

## 🎯 The Big Picture

Think of Docker Swarm like a team manager. One person (single Docker host) works. But a team (multiple Docker hosts)? You need a manager (Swarm). Coordinates work. Distributes load. That's Docker Swarm.

**Docker Swarm orchestrates containers across multiple hosts. Built into Docker. Simple. Effective.**

## What is Docker Swarm?

**Docker Swarm is Docker's native orchestration:**

**What it does:**
- Manages multiple Docker hosts
- Orchestrates containers
- Load balances traffic
- Handles failures
- Scales services

**Think of it as:** Team manager. Coordinates team. Distributes work. Handles problems.

## Why Docker Swarm?

**The problem without Swarm:**
- Manual container management
- No automatic scaling
- No load balancing
- No failure handling
- Single host limitation

**The solution with Swarm:**
- Automatic management
- Auto-scaling
- Load balancing
- Failure handling
- Multiple hosts

**Real example:** I once managed containers on multiple hosts manually. It was chaos. With Swarm, it's automatic. Never again.

**Swarm isn't optional for multi-host. It's essential.**

## Swarm Architecture

**Swarm components:**

**Manager nodes:**
- Control cluster
- Schedule services
- Manage state

**Worker nodes:**
- Run containers
- Execute tasks
- Report status

**Think of it as:** Manager (boss). Workers (employees). Clear roles.

## Setting Up Swarm

**Step 1: Initialize Swarm**
```bash
# On manager node
docker swarm init
```

**Output:**
```
Swarm initialized: current node (abc123) is now a manager.

To add a worker to this swarm, run the following command:
    docker swarm join --token SWMTKN-1-xxx 192.168.1.100:2377

To add a manager to this swarm, run:
    docker swarm join-token manager
```

**Step 2: Add Worker Nodes**
```bash
# On worker node
docker swarm join --token SWMTKN-1-xxx 192.168.1.100:2377
```

**Step 3: Verify**
```bash
# On manager node
docker node ls
```

**That's Swarm setup. Simple. Works.**

## The Team Manager Analogy

**Think of Swarm like a team manager:**

**Manager node:** Team manager
- Coordinates team
- Assigns work
- Monitors progress

**Worker nodes:** Team members
- Do the work
- Report status
- Follow instructions

**Once you see it this way, Swarm makes perfect sense.**

## Creating Services

**Create a service:**

```bash
docker service create \
  --name web \
  --replicas 3 \
  --publish 80:80 \
  nginx:alpine
```

**What this does:**
- Creates service named "web"
- Runs 3 replicas
- Publishes port 80
- Uses nginx:alpine image

**Check service:**
```bash
docker service ls
docker service ps web
```

**That's services. Simple. Powerful.**

## Scaling Services

**Scale service:**

```bash
# Scale to 5 replicas
docker service scale web=5

# Scale to 2 replicas
docker service scale web=2
```

**What happens:**
- Swarm creates/destroys containers
- Distributes across nodes
- Load balances automatically

**Think of it as:** Manager assigns more/fewer workers. Automatic.

## Updating Services

**Update service:**

```bash
# Update image
docker service update --image nginx:1.21-alpine web

# Update replicas
docker service update --replicas 5 web

# Rolling update
docker service update --update-parallelism 1 --update-delay 10s web
```

**What happens:**
- Rolling update
- Zero downtime
- Automatic rollback on failure

**That's updates. Smooth. Automatic.**

## Service Configuration

**Complete service example:**

```bash
docker service create \
  --name app \
  --replicas 3 \
  --publish 3000:3000 \
  --mount type=volume,source=app-data,target=/data \
  --network app-network \
  --env NODE_ENV=production \
  --constraint 'node.role==worker' \
  --update-parallelism 1 \
  --update-delay 10s \
  --restart-condition on-failure \
  my-app:1.0
```

**What this includes:**
- Replicas
- Port publishing
- Volume mounting
- Network
- Environment variables
- Constraints
- Update strategy
- Restart policy

**Complete service. Production-ready.**

## Real-World Example: Complete Swarm Setup

**Complete production setup:**

**1. Initialize Swarm:**
```bash
docker swarm init --advertise-addr 192.168.1.100
```

**2. Add workers:**
```bash
# On each worker
docker swarm join --token SWMTKN-1-xxx 192.168.1.100:2377
```

**3. Create overlay network:**
```bash
docker network create --driver overlay app-network
```

**4. Create services:**
```bash
# Database service
docker service create \
  --name db \
  --network app-network \
  --mount type=volume,source=db-data,target=/var/lib/postgresql/data \
  postgres:16-alpine

# Application service
docker service create \
  --name app \
  --replicas 3 \
  --network app-network \
  --publish 80:3000 \
  --env DATABASE_URL=postgres://db:5432/mydb \
  my-app:1.0
```

**5. Create load balancer:**
```bash
docker service create \
  --name nginx \
  --replicas 2 \
  --publish 80:80 \
  --network app-network \
  nginx:alpine
```

**Complete Swarm setup. Production-ready.**

## Best Practices

### 1. Use Manager Nodes Wisely

**Manager nodes:**
- 3-5 managers for HA
- Odd number (quorum)
- Don't run workloads

**Why:** Stability. Quorum. Performance.

### 2. Use Constraints

**Place containers strategically:**
```bash
--constraint 'node.role==worker'
--constraint 'node.labels.env==production'
```

**Why:** Control placement. Optimize resources.

### 3. Use Health Checks

**Monitor service health:**
```bash
--health-cmd "curl -f http://localhost/health"
--health-interval 30s
```

**Why:** Know when unhealthy. Automatic recovery.

### 4. Use Secrets

**Manage secrets securely:**
```bash
echo "password" | docker secret create db_password -
docker service create --secret db_password app
```

**Why:** Secure. Not in images.

### 5. Monitor Swarm

**Monitor cluster:**
```bash
docker node ls
docker service ls
docker service ps web
```

**Why:** Know what's happening. Troubleshoot issues.

## My Take: Swarm Strategy

**Here's what I do:**

**Small deployments:**
- Single manager
- 2-3 workers
- Simple services

**Medium deployments:**
- 3 managers (HA)
- 5-10 workers
- Complex services

**Large deployments:**
- 5 managers (HA)
- 20+ workers
- Full orchestration

**The key:** Start simple. Scale up. Use Swarm for simplicity. Kubernetes for complexity.

## Memory Tip: The Team Manager Analogy

**Docker Swarm = Team manager**

**Manager:** Boss
**Workers:** Employees
**Services:** Tasks
**Scaling:** Assigning workers

**Once you see it this way, Swarm makes perfect sense.**

## Common Mistakes

1. **Too many managers**: Wasted resources
2. **No health checks**: Don't know when unhealthy
3. **No constraints**: Poor placement
4. **Not monitoring**: Don't know what's happening
5. **Secrets in images**: Security risk

## Hands-On Exercise: Set Up Swarm

**1. Initialize Swarm:**
```bash
docker swarm init
```

**2. Create service:**
```bash
docker service create --name test --replicas 3 nginx:alpine
```

**3. Check service:**
```bash
docker service ls
docker service ps test
```

**4. Scale service:**
```bash
docker service scale test=5
```

**5. Update service:**
```bash
docker service update --image nginx:1.21-alpine test
```

**6. Remove service:**
```bash
docker service rm test
```

## Key Takeaways

1. **Docker Swarm is built-in orchestration** - No extra tools needed
2. **Manager and worker nodes** - Clear roles
3. **Services are the unit of work** - Not containers
4. **Automatic scaling and load balancing** - Built-in
5. **Rolling updates** - Zero downtime
6. **Simple but powerful** - Good for many use cases

## What's Next?

Now that you understand Docker Swarm, let's learn about BuildKit. Next: [BuildKit](/docs/docker/11-advanced-topics/buildkit).

---

> **Remember**: Docker Swarm is like a team manager. Coordinates team. Distributes work. Handles problems. Built into Docker. Simple. Effective.

