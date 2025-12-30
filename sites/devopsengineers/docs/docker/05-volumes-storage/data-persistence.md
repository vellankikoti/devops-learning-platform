---
sidebar_position: 4
title: Data Persistence
---

# Data Persistence: Keeping Your Data Safe

**Data is valuable. Databases. Logs. Application data. It needs to persist. It needs to be safe. It needs to survive container restarts, updates, and failures.**

## 🎯 The Big Picture

Think of data persistence like insurance. You hope you never need it. But when you do, you're glad you have it. Data persistence is insurance for your data.

**Data persistence means:**
- Data survives container restarts
- Data survives container updates
- Data survives container failures
- Data survives host reboots
- Data is backed up
- Data can be restored

## Why Data Persistence Matters

**The problem without persistence:**
- Container stops → Data lost
- Container updates → Data lost
- Container crashes → Data lost
- Host reboots → Data lost
- Everything is temporary

**The solution with persistence:**
- Container stops → Data safe
- Container updates → Data safe
- Container crashes → Data safe
- Host reboots → Data safe
- Everything is permanent

**Real example:** I once lost a database because I didn't use a volume. Container crashed. Data was gone. Hours of work lost. Never again.

## Persistence Strategies

**Three main strategies:**

### 1. Named Volumes (Recommended)

**Best for:** Production, databases, important data

**Why:**
- Managed by Docker
- Portable
- Easy to backup
- Isolated
- Best practice

**Example:**
```bash
docker volume create db-data
docker run -d \
  --name postgres \
  -v db-data:/var/lib/postgresql/data \
  postgres:14
```

**Data persists. Always.**

### 2. Bind Mounts

**Best for:** Development, configuration, logs

**Why:**
- Direct access
- Easy to edit
- Good for development
- Not portable

**Example:**
```bash
docker run -d \
  --name app \
  -v /host/logs:/app/logs \
  my-app
```

**Good for development. Not for production databases.**

### 3. External Storage

**Best for:** Production, high availability, shared storage

**Why:**
- NFS, CIFS, cloud storage
- Shared across hosts
- High availability
- Enterprise-grade

**Example:**
```bash
docker volume create \
  --driver local \
  --opt type=nfs \
  --opt device=:/nfs/data \
  nfs-data
```

**Advanced. For production clusters.**

## Database Persistence

**Databases MUST persist data:**

**PostgreSQL example:**
```bash
# Create volume
docker volume create postgres-data

# Run database
docker run -d \
  --name postgres \
  -v postgres-data:/var/lib/postgresql/data \
  -e POSTGRES_PASSWORD=secret \
  postgres:14

# Data is persisted in postgres-data volume
```

**What happens:**
- Database writes to volume
- Data persists when container stops
- Data persists when container is deleted
- Can recreate container, data is back

**Always use volumes for databases. Always.**

## Application Data Persistence

**Applications need persistent data too:**

**Example:**
```bash
# Create volume for app data
docker volume create app-data

# Run application
docker run -d \
  --name app \
  -v app-data:/app/data \
  my-app:1.0

# Application data is persisted
```

**What to persist:**
- User uploads
- Application state
- Cache (if needed)
- Configuration (sometimes)

## Log Persistence

**Logs need to persist:**

**Option 1: Volume**
```bash
docker volume create app-logs
docker run -d \
  --name app \
  -v app-logs:/app/logs \
  my-app
```

**Option 2: Bind mount**
```bash
docker run -d \
  --name app \
  -v /host/logs:/app/logs \
  my-app
```

**Option 3: Logging driver**
```bash
docker run -d \
  --name app \
  --log-driver json-file \
  --log-opt max-size=10m \
  my-app
```

**Choose based on needs. Volume for portability. Bind mount for easy access.**

## Backup Strategies

**Backing up volumes:**

**1. Manual backup:**
```bash
# Stop container
docker stop postgres

# Backup volume
docker run --rm \
  -v postgres-data:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/postgres-backup.tar.gz /data

# Start container
docker start postgres
```

**2. Automated backup:**
```bash
# Use backup container
docker run -d \
  --name backup \
  -v postgres-data:/data \
  -v backup-storage:/backup \
  backup-image \
  /backup-script.sh
```

**3. Cloud backup:**
- Use cloud storage drivers
- Automatic backups
- Off-site storage
- Disaster recovery

## Restore Strategies

**Restoring from backup:**

**1. Stop container:**
```bash
docker stop postgres
docker rm postgres
```

**2. Restore volume:**
```bash
docker run --rm \
  -v postgres-data:/data \
  -v $(pwd):/backup \
  alpine tar xzf /backup/postgres-backup.tar.gz -C /
```

**3. Start container:**
```bash
docker run -d \
  --name postgres \
  -v postgres-data:/var/lib/postgresql/data \
  postgres:14
```

**Data is restored. Container works with old data.**

## The Insurance Analogy

**Think of data persistence like insurance:**

**Without insurance (no volumes):**
- Accident happens (container crashes)
- You lose everything (data is gone)
- No recovery (can't restore)
- Start over (recreate data)

**With insurance (volumes):**
- Accident happens (container crashes)
- Insurance covers it (volume persists)
- You recover (restore from backup)
- Continue (data is back)

**Once you see it this way, data persistence makes perfect sense.**

## Best Practices

### 1. Always Use Volumes for Databases

**Don't do this:**
```bash
docker run -d --name postgres postgres:14
# Data is lost when container stops!
```

**Do this:**
```bash
docker volume create postgres-data
docker run -d \
  --name postgres \
  -v postgres-data:/var/lib/postgresql/data \
  postgres:14
# Data persists!
```

### 2. Name Your Volumes

**Don't do this:**
```bash
docker run -d -v /data nginx
# Anonymous volume, hard to manage
```

**Do this:**
```bash
docker volume create web-data
docker run -d -v web-data:/data nginx
# Named volume, easy to manage
```

### 3. Backup Regularly

**Set up automated backups:**
- Daily backups for databases
- Weekly backups for application data
- Test restore procedures
- Store backups off-site

### 4. Document Volumes

**Document which volumes are used:**
```bash
# postgres-data: PostgreSQL database data
# app-logs: Application logs
# user-uploads: User uploaded files
```

**Why:** Know what each volume contains. Easier to manage.

## My Take: Data Persistence Strategy

**Here's what I do:**

**Production:**
- Named volumes for everything important
- Automated backups daily
- Test restore procedures monthly
- Document all volumes
- Monitor volume usage

**Development:**
- Bind mounts for code
- Named volumes for databases
- No backups needed
- Easy to reset

**The key:** Always use volumes for important data. Always backup. Always test restore.

## Memory Tip: The Insurance Analogy

**Data persistence = Insurance**

**Without:** Lose everything when accident happens
**With:** Recover from accident
**Backup:** Insurance policy
**Restore:** Claim process

**Once you see it this way, data persistence makes perfect sense.**

## Common Mistakes

1. **Not using volumes for databases**: Data lost when container stops
2. **Not backing up volumes**: Can't restore when needed
3. **Not testing restore**: Restore fails when needed
4. **Not documenting volumes**: Don't know what each contains
5. **Not monitoring volume usage**: Disk fills up

## Hands-On Exercise: Data Persistence

**1. Create volume:**
```bash
docker volume create test-data
```

**2. Run container with data:**
```bash
docker run -d \
  --name test \
  -v test-data:/data \
  alpine sh -c "echo 'Important data' > /data/file.txt && sleep 3600"
```

**3. Verify data:**
```bash
docker exec test cat /data/file.txt
# Output: Important data
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
  -v test-data:/data \
  alpine cat /data/file.txt
# Output: Important data
# Data persisted!
```

**6. Backup volume:**
```bash
docker run --rm \
  -v test-data:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/backup.tar.gz /data
```

**7. Restore test:**
```bash
# Create new volume
docker volume create test-data2

# Restore
docker run --rm \
  -v test-data2:/data \
  -v $(pwd):/backup \
  alpine tar xzf /backup/backup.tar.gz -C /

# Verify
docker run --rm -v test-data2:/data alpine cat /data/file.txt
# Output: Important data
# Restore worked!
```

## Key Takeaways

1. **Always use volumes for important data** - Databases, application data
2. **Backup regularly** - Daily for databases, weekly for apps
3. **Test restore procedures** - Know it works before you need it
4. **Document volumes** - Know what each contains
5. **Monitor volume usage** - Prevent disk fill-up
6. **Data persistence is insurance** - Hope you never need it, glad when you do

## What's Next?

Congratulations! You've completed the Volumes & Storage module. Now let's learn about Docker Compose. Next: [Compose Basics](/docs/docker/06-docker-compose/compose-basics).

---

> **Remember**: Data persistence is like insurance. Always use volumes for important data. Always backup. Always test restore. Your data is valuable. Protect it.

