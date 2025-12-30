---
sidebar_position: 2
title: Private Registries
---

# Private Registries: Your Own Image Library

**Docker Hub is public. Sometimes you need private. Proprietary code. Internal applications. Security-sensitive images. That's what private registries are for.**

## 🎯 The Big Picture

Think of private registries like a private library. Only authorized members can access. Your organization's books. Secure. Controlled. That's a private registry.

**Private registries give you control. Security. Privacy. They're essential for production.**

## What is a Private Registry?

**A private registry is your own Docker image repository.**

**What it provides:**
- Private image storage
- Access control
- Security scanning
- Team collaboration
- On-premises or cloud

**Think of it as:** Your own library. You control access. You control security. You control everything.

## Why Private Registries?

**The problem with public registries:**
- Proprietary code exposed
- Security concerns
- Compliance requirements
- No control over access

**The solution with private registries:**
- Code stays private
- Better security
- Compliance friendly
- Full access control

**That's why private registries exist. They give you control.**

## Types of Private Registries

### 1. Docker Hub Private Repositories

**What it is:** Private repositories on Docker Hub.

**Characteristics:**
- Free tier available
- Easy to set up
- Managed by Docker
- Good for small teams

**When to use:**
- Small teams
- Simple requirements
- Docker Hub is enough

**Think of it as:** Private room in public library. Still in library. But private access.

### 2. Self-Hosted Registry

**What it is:** Run your own registry server.

**Characteristics:**
- Full control
- On-premises
- Custom configuration
- Requires maintenance

**When to use:**
- Need full control
- On-premises requirement
- Custom needs
- Large scale

**Think of it as:** Your own library building. You own it. You maintain it.

### 3. Cloud Registries

**What it is:** Managed registries in cloud.

**Examples:**
- AWS ECR (Elastic Container Registry)
- Google Container Registry
- Azure Container Registry
- GitHub Container Registry

**Characteristics:**
- Managed service
- Integrated with cloud
- Scalable
- Pay per use

**When to use:**
- Using cloud platform
- Want managed service
- Need scalability
- Cloud integration

**Think of it as:** Cloud library service. Managed. Scalable. Integrated.

## Setting Up Docker Hub Private Repository

**Step 1: Create repository on Docker Hub**
1. Go to https://hub.docker.com
2. Click "Create Repository"
3. Set name and visibility to "Private"
4. Create repository

**Step 2: Login to Docker Hub**
```bash
docker login
# Enter username and password
```

**Step 3: Tag your image**
```bash
docker tag my-app:1.0 username/private-app:1.0
```

**Step 4: Push to private repository**
```bash
docker push username/private-app:1.0
```

**That's it. Your image is now private.**

## Setting Up Self-Hosted Registry

**Run Docker Registry:**

```bash
# Run registry container
docker run -d \
  --name registry \
  -p 5000:5000 \
  -v registry-data:/var/lib/registry \
  registry:2
```

**What this does:**
- Runs Docker Registry
- Accessible on port 5000
- Data stored in volume
- Basic setup

**Push to self-hosted registry:**
```bash
# Tag image
docker tag my-app:1.0 localhost:5000/my-app:1.0

# Push
docker push localhost:5000/my-app:1.0
```

**Pull from self-hosted registry:**
```bash
docker pull localhost:5000/my-app:1.0
```

## Securing Self-Hosted Registry

**Add authentication:**

**Step 1: Create password file**
```bash
htpasswd -Bbn username password > auth/htpasswd
```

**Step 2: Run registry with auth**
```bash
docker run -d \
  --name registry \
  -p 5000:5000 \
  -v $(pwd)/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -v registry-data:/var/lib/registry \
  registry:2
```

**Step 3: Login**
```bash
docker login localhost:5000
# Enter username and password
```

**Now registry is secured. Requires authentication.**

## Using Cloud Registries

### AWS ECR Example

**Step 1: Create repository**
```bash
aws ecr create-repository --repository-name my-app
```

**Step 2: Get login token**
```bash
aws ecr get-login-password --region us-east-1 | \
  docker login --username AWS --password-stdin \
  123456789012.dkr.ecr.us-east-1.amazonaws.com
```

**Step 3: Tag and push**
```bash
docker tag my-app:1.0 \
  123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:1.0

docker push \
  123456789012.dkr.ecr.us-east-1.amazonaws.com/my-app:1.0
```

**That's it. Image is in AWS ECR.**

### Google Container Registry Example

**Step 1: Configure gcloud**
```bash
gcloud auth configure-docker
```

**Step 2: Tag and push**
```bash
docker tag my-app:1.0 \
  gcr.io/my-project/my-app:1.0

docker push \
  gcr.io/my-project/my-app:1.0
```

## The Private Library Analogy

**Think of private registries like private libraries:**

**Docker Hub Private:** Private room in public library
- Still in public library
- But private access
- Easy to set up

**Self-Hosted:** Your own library building
- You own it
- You control it
- You maintain it

**Cloud Registry:** Managed library service
- Cloud provider manages
- Scalable
- Integrated

**Once you see it this way, private registries make perfect sense.**

## Best Practices

### 1. Use Authentication

**Always secure your registry:**
- Require authentication
- Use strong passwords
- Rotate credentials
- Use tokens when possible

### 2. Scan Images

**Scan for vulnerabilities:**
- Use registry scanning
- Check regularly
- Update vulnerable images
- Document findings

### 3. Tag Properly

**Use semantic versioning:**
```bash
docker tag my-app:1.0 registry.example.com/my-app:1.0.0
docker tag my-app:1.0 registry.example.com/my-app:latest
```

**Why:** Clear versions. Easy to track.

### 4. Limit Access

**Control who can access:**
- Use access control lists
- Limit to needed teams
- Review access regularly
- Remove unused access

## My Take: Private Registry Strategy

**Here's what I do:**

**Development:**
- Docker Hub private repos
- Simple and works
- Free tier enough

**Production:**
- Cloud registry (ECR, GCR, ACR)
- Managed service
- Integrated with CI/CD
- Better security

**Enterprise:**
- Self-hosted or cloud
- Based on requirements
- Full control or managed
- Compliance considerations

**The key:** Choose based on needs. Start simple. Scale as needed.

## Memory Tip: The Private Library Analogy

**Private registries = Private libraries**

**Docker Hub Private:** Private room
**Self-Hosted:** Own building
**Cloud:** Managed service

**Once you see it this way, private registries make perfect sense.**

## Common Mistakes

1. **No authentication**: Security risk
2. **Using HTTP**: Use HTTPS
3. **Not scanning images**: Vulnerabilities
4. **Poor access control**: Too many have access
5. **Not backing up**: Lose images

## Hands-On Exercise: Set Up Private Registry

**1. Run local registry:**
```bash
docker run -d \
  --name registry \
  -p 5000:5000 \
  -v registry-data:/var/lib/registry \
  registry:2
```

**2. Tag an image:**
```bash
docker tag nginx:alpine localhost:5000/my-nginx:1.0
```

**3. Push to registry:**
```bash
docker push localhost:5000/my-nginx:1.0
```

**4. Verify:**
```bash
curl http://localhost:5000/v2/_catalog
# Should show: {"repositories":["my-nginx"]}
```

**5. Pull from registry:**
```bash
docker pull localhost:5000/my-nginx:1.0
```

**6. Clean up:**
```bash
docker stop registry
docker rm registry
docker volume rm registry-data
```

## Key Takeaways

1. **Private registries store private images** - Control access
2. **Multiple types available** - Docker Hub, self-hosted, cloud
3. **Always use authentication** - Security essential
4. **Scan images regularly** - Find vulnerabilities
5. **Choose based on needs** - Start simple, scale up

## What's Next?

Now that you understand private registries, let's learn about publishing images. Next: [Image Publishing](/docs/docker/07-docker-hub-registry/image-publishing).

---

> **Remember**: Private registries are like private libraries. You control access. You control security. Essential for production.

