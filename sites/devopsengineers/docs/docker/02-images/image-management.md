---
sidebar_position: 5
title: Image Management
---

# Image Management: Organizing Your Docker Images

**You'll create many images. You'll pull many images. They'll accumulate. Without management, your disk fills up. Your builds slow down. Chaos ensues.**

## 🎯 The Big Picture

Think of image management like organizing a library. You have books (images). Some you use often. Some you never use. Some are outdated. Without organization, you can't find anything. With organization, everything has its place.

**Image management is about:**
- **Finding images** - What do you have?
- **Organizing images** - Tag them properly
- **Cleaning up** - Remove what you don't need
- **Sharing images** - Push to registries

## Listing Images

**See what images you have:**

```bash
docker images
```

**Output:**
```
REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
nginx         latest    abc123def456   2 days ago     133MB
my-app        1.0       def456ghi789   1 week ago     250MB
my-app        latest    def456ghi789   1 week ago     250MB
node          18        ghi789jkl012   3 weeks ago    900MB
```

**What you see:**
- **REPOSITORY**: Image name
- **TAG**: Version/label
- **IMAGE ID**: Unique identifier
- **CREATED**: When it was built
- **SIZE**: Disk space used

**Filter images:**
```bash
# Show only my-app images
docker images my-app

# Show images older than 24 hours
docker images --filter "dangling=true"

# Show only tagged images
docker images --filter "dangling=false"
```

## Understanding Image Sizes

**Why images take space:**

**Base images:**
- `ubuntu:20.04` - ~70MB
- `alpine:latest` - ~5MB
- `node:18` - ~900MB
- `node:18-alpine` - ~170MB

**Your images:**
- Built on top of base images
- Each layer adds size
- Dependencies add size

**Check image layers:**
```bash
docker history nginx
```

**Shows:**
- Each layer
- Size of each layer
- Commands that created each layer

## Tagging Images

**Tags are labels. They identify versions.**

**Format:** `repository:tag`

**Examples:**
```bash
# Version tag
docker tag my-app:latest my-app:1.0

# Environment tag
docker tag my-app:latest my-app:production

# Date tag
docker tag my-app:latest my-app:2024-01-15

# Multiple tags
docker tag my-app:latest my-app:1.0 my-app:production
```

**Why tag?**
- Identify versions
- Track deployments
- Rollback to specific versions
- Organize by environment

**Best practices:**
- Use semantic versioning: `1.0.0`, `1.1.0`, `2.0.0`
- Tag by environment: `dev`, `staging`, `production`
- Tag by date: `2024-01-15`
- Never use only `latest` in production

## Removing Images

**Remove a specific image:**

```bash
# By name and tag
docker rmi my-app:1.0

# By image ID
docker rmi abc123def456

# Force remove (even if in use)
docker rmi -f my-app:1.0
```

**Remove multiple images:**
```bash
# Remove all my-app images
docker rmi $(docker images my-app -q)

# Remove all untagged images (dangling)
docker image prune

# Remove all unused images
docker image prune -a
```

**Be careful:** Removing images deletes them permanently. Make sure you don't need them.

## Cleaning Up: The Prune Commands

**Docker provides prune commands to clean up:**

### Remove Dangling Images

**Dangling images:** Untagged images. Leftover from builds.

```bash
docker image prune
```

**Removes:** Images without tags, not used by containers.

### Remove All Unused Images

```bash
docker image prune -a
```

**Removes:** All images not used by containers.

**Warning:** This removes a lot. Use carefully.

### Remove Everything

```bash
docker system prune -a
```

**Removes:**
- All stopped containers
- All unused networks
- All unused images
- All build cache

**Nuclear option.** Use when you need space.

## The Library Analogy: Organizing Books

**Think of image management like a library:**

**Listing images:** "What books do we have?"
- Check the catalog (docker images)
- See what's available
- Find what you need

**Tagging images:** "Label the books"
- Fiction, Non-fiction (tags)
- Author, Title (repository)
- Edition (version tag)

**Removing images:** "Remove old books"
- Books no one reads (unused images)
- Outdated editions (old tags)
- Make space for new books

**The goal:** Organized library. Easy to find. Easy to manage.

## Inspecting Images

**See detailed information about an image:**

```bash
docker inspect nginx
```

**Shows:**
- Image ID
- Created date
- Architecture
- Environment variables
- Exposed ports
- Entrypoint
- Cmd
- Layers
- Everything!

**Useful for:**
- Understanding image configuration
- Debugging issues
- Learning from images

**Inspect specific fields:**
```bash
# Get only architecture
docker inspect -f '{{.Architecture}}' nginx

# Get only created date
docker inspect -f '{{.Created}}' nginx
```

## Pulling Images

**Download images from registries:**

```bash
# Pull latest tag
docker pull nginx

# Pull specific tag
docker pull nginx:1.21

# Pull from private registry
docker pull registry.example.com/my-app:1.0
```

**What happens:**
1. Docker checks if image exists locally
2. If not, downloads from registry
3. Shows progress
4. Image is now available locally

**Pull without running:**
```bash
# Just pull, don't run
docker pull nginx
```

## Pushing Images

**Upload images to registries:**

```bash
# Tag for registry
docker tag my-app:1.0 registry.example.com/my-app:1.0

# Push to registry
docker push registry.example.com/my-app:1.0
```

**What happens:**
1. Docker authenticates with registry
2. Uploads image layers
3. Pushes to registry
4. Image is now available to others

**Push to Docker Hub:**
```bash
# Tag with your username
docker tag my-app:1.0 username/my-app:1.0

# Push
docker push username/my-app:1.0
```

## Image Layers: Understanding Sharing

**Images share layers. This saves space.**

**Example:**
```
Image A: [Ubuntu] [Node.js] [My App v1]
Image B: [Ubuntu] [Node.js] [My App v2]
         ↑         ↑
    Shared layers (only stored once)
```

**Check layer sharing:**
```bash
docker images
# Shows actual disk usage, not logical size
```

**Docker is smart:** If two images share layers, Docker stores them once.

## Real-World Example: Managing Production Images

**Here's how I manage images in production:**

**1. Tag by version:**
```bash
docker tag my-app:latest my-app:1.0.0
docker tag my-app:latest my-app:1.0.0-production
```

**2. Push to registry:**
```bash
docker push registry.example.com/my-app:1.0.0
docker push registry.example.com/my-app:1.0.0-production
```

**3. Keep last 5 versions:**
```bash
# Remove old versions (keep 1.0.0, 0.9.0, 0.8.0, 0.7.0, 0.6.0)
docker rmi my-app:0.5.0
```

**4. Clean up weekly:**
```bash
# Remove dangling images
docker image prune -f

# Remove images older than 30 days
docker image prune -a --filter "until=720h"
```

## My Take: Image Management Strategy

**I've learned this the hard way:**

1. **Tag everything** - Never use only `latest`
2. **Clean regularly** - Weekly cleanup prevents disk issues
3. **Keep backups** - Push important images to registry
4. **Monitor disk space** - Images accumulate quickly
5. **Use .dockerignore** - Prevents large build contexts

**My routine:**
- Tag images with version + date
- Push to registry immediately
- Clean up local images weekly
- Keep last 5 versions in registry

## Memory Tip: The Library Analogy

**Image management = Library management**

**Listing:** Check catalog (docker images)
**Tagging:** Label books (tags)
**Removing:** Remove old books (prune)
**Pulling:** Get books from other libraries (pull)
**Pushing:** Share books with others (push)

**Once you see it this way, image management makes sense.**

## Common Mistakes

1. **Not tagging images**: Can't identify versions
2. **Using only `latest`**: Dangerous in production
3. **Never cleaning up**: Disk fills up
4. **Removing images too aggressively**: Lose important images
5. **Not pushing to registry**: Lose images if local disk fails

## Hands-On Exercise: Image Management Workflow

**1. Build an image:**
```bash
docker build -t my-app:1.0 .
```

**2. Tag it:**
```bash
docker tag my-app:1.0 my-app:latest
docker tag my-app:1.0 my-app:production
```

**3. List images:**
```bash
docker images my-app
```

**4. Inspect image:**
```bash
docker inspect my-app:1.0
```

**5. Check disk usage:**
```bash
docker system df
```

**6. Clean up:**
```bash
docker image prune
```

## Key Takeaways

1. **List images with `docker images`** - See what you have
2. **Tag images properly** - Use versions, not just `latest`
3. **Remove unused images** - Use `prune` commands
4. **Push to registries** - Backup important images
5. **Clean regularly** - Prevents disk issues

## What's Next?

Now that you can manage images, let's learn how to optimize them. Next: [Image Optimization](/docs/docker/02-images/image-optimization).

---

> **Remember**: Image management is like organizing a library. Tag everything. Clean regularly. Keep what you need. Remove what you don't.

