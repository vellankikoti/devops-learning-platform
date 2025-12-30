---
sidebar_position: 4
title: Backup & Recovery
---

# Backup & Recovery: Insurance for Your Data

**Data is valuable. Databases. Application data. Configuration. It needs to be backed up. It needs to be recoverable. That's backup and recovery.**

## 🎯 The Big Picture

Think of backup and recovery like insurance. You hope you never need it. But when you do, you're glad you have it. Backup and recovery is insurance for your data.

**Backup and recovery protects your data. Ensures it's safe. Ensures it can be restored. It's essential for production.**

## Why Backup Matters

**The problem without backups:**
- Data loss when container fails
- Data loss when disk fails
- Data loss when host fails
- Can't recover
- Business impact

**The solution with backups:**
- Data safe when container fails
- Data safe when disk fails
- Data safe when host fails
- Can recover
- Business continuity

**Real example:** I once lost a database. No backup. Days of work gone. With backups, I would have recovered in minutes. Never again.

**Backups aren't optional. They're essential.**

## What to Backup

**Backup everything important:**

**Databases:**
- PostgreSQL data
- MySQL data
- MongoDB data
- Redis data

**Application data:**
- User uploads
- Configuration files
- Application state

**Volumes:**
- Named volumes
- Important bind mounts

**Think of it as:** Backup anything you can't recreate. Anything valuable. Anything important.

## Backup Strategies

### Strategy 1: Volume Backups

**Backup Docker volumes:**

```bash
# Stop container
docker stop postgres

# Backup volume
docker run --rm \
  -v postgres-data:/data \
  -v $(pwd)/backups:/backup \
  alpine tar czf /backup/postgres-$(date +%Y%m%d).tar.gz /data

# Start container
docker start postgres
```

**Why:** Simple. Works. Good for small setups.

### Strategy 2: Database Dumps

**Backup database directly:**

```bash
# PostgreSQL dump
docker exec postgres pg_dump -U appuser myapp > backup-$(date +%Y%m%d).sql

# MySQL dump
docker exec mysql mysqldump -u appuser myapp > backup-$(date +%Y%m%d).sql

# MongoDB dump
docker exec mongodb mongodump --out /backup/$(date +%Y%m%d)
```

**Why:** Database-specific. Optimized. Smaller backups.

### Strategy 3: Automated Backups

**Schedule automated backups:**

```yaml
services:
  postgres:
    image: postgres:16-alpine
    volumes:
      - postgres-data:/var/lib/postgresql/data

  backup:
    image: postgres:16-alpine
    volumes:
      - postgres-data:/data:ro
      - backup-storage:/backup
    command: >
      sh -c "
        while true; do
          pg_dump -h postgres -U appuser myapp > /backup/backup-$$(date +%Y%m%d-%H%M%S).sql
          find /backup -name '*.sql' -mtime +7 -delete
          sleep 86400
        done
      "
    depends_on:
      - postgres
    environment:
      PGPASSWORD: ${DB_PASSWORD}

volumes:
  postgres-data:
  backup-storage:
```

**Why:** Automated. Consistent. Reliable.

## The Insurance Analogy

**Think of backup and recovery like insurance:**

**Backup:** Insurance policy
**Recovery:** Claim process
**Testing:** Policy verification
**Retention:** Policy duration

**Once you see it this way, backup and recovery makes perfect sense.**

## Recovery Strategies

### Strategy 1: Volume Restore

**Restore from volume backup:**

```bash
# Stop container
docker stop postgres
docker rm postgres

# Restore volume
docker run --rm \
  -v postgres-data:/data \
  -v $(pwd)/backups:/backup \
  alpine tar xzf /backup/postgres-20240115.tar.gz -C /

# Start container
docker run -d \
  --name postgres \
  -v postgres-data:/var/lib/postgresql/data \
  postgres:16-alpine
```

**Why:** Complete restore. Works for volumes.

### Strategy 2: Database Restore

**Restore from database dump:**

```bash
# PostgreSQL restore
docker exec -i postgres psql -U appuser myapp < backup-20240115.sql

# MySQL restore
docker exec -i mysql mysql -u appuser myapp < backup-20240115.sql

# MongoDB restore
docker exec mongodb mongorestore /backup/20240115
```

**Why:** Database-specific. Faster. Selective restore.

### Strategy 3: Point-in-Time Recovery

**Restore to specific time:**

```bash
# PostgreSQL point-in-time recovery
# Requires WAL archiving setup
docker exec postgres psql -U appuser -c "SELECT pg_start_backup('backup');"
# ... backup process ...
docker exec postgres psql -U appuser -c "SELECT pg_stop_backup();"
```

**Why:** Precise recovery. To exact time.

## Backup Best Practices

### 1. Backup Regularly

**Schedule backups:**
- Databases: Daily (or more)
- Application data: Daily
- Configuration: Weekly
- Full system: Monthly

**Why:** Recent backups. Less data loss.

### 2. Test Restores

**Test recovery regularly:**
- Monthly restore tests
- Verify backups work
- Document process
- Train team

**Why:** Know it works. Before you need it.

### 3. Store Off-Site

**Backup locations:**
- Local (fast restore)
- Cloud (off-site)
- Multiple locations (redundancy)

**Why:** Disaster recovery. Multiple copies.

### 4. Encrypt Backups

**Encrypt sensitive backups:**
```bash
# Encrypt backup
tar czf - /data | gpg --encrypt > backup.tar.gz.gpg

# Decrypt restore
gpg --decrypt backup.tar.gz.gpg | tar xzf -
```

**Why:** Security. Compliance.

### 5. Document Process

**Document:**
- What to backup
- How to backup
- How to restore
- Recovery time objectives
- Recovery point objectives

**Why:** Clear process. Faster recovery.

## Real-World Example: Complete Backup Setup

**Complete automated backup:**

```yaml
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_USER: appuser
      POSTGRES_PASSWORD: ${DB_PASSWORD}
      POSTGRES_DB: myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - backend

  backup:
    image: postgres:16-alpine
    volumes:
      - backup-storage:/backup
      - ./backup-script.sh:/backup-script.sh:ro
    environment:
      PGPASSWORD: ${DB_PASSWORD}
      DB_HOST: postgres
      DB_USER: appuser
      DB_NAME: myapp
    command: /backup-script.sh
    depends_on:
      - postgres
    networks:
      - backend
    restart: unless-stopped

volumes:
  postgres-data:
  backup-storage:
```

**Backup script:**
```bash
#!/bin/sh
# backup-script.sh

while true; do
  BACKUP_FILE="/backup/backup-$(date +%Y%m%d-%H%M%S).sql"
  
  # Create backup
  pg_dump -h $DB_HOST -U $DB_USER $DB_NAME > $BACKUP_FILE
  
  # Compress
  gzip $BACKUP_FILE
  
  # Upload to S3 (optional)
  # aws s3 cp $BACKUP_FILE.gz s3://backups/
  
  # Delete old backups (keep 7 days)
  find /backup -name "*.sql.gz" -mtime +7 -delete
  
  # Wait 24 hours
  sleep 86400
done
```

**Complete backup. Automated. Reliable.**

## My Take: Backup Strategy

**Here's what I do:**

**Development:**
- Manual backups
- Before major changes
- Simple process

**Staging:**
- Automated daily backups
- Test restores monthly
- Document process

**Production:**
- Automated frequent backups
- Multiple backup locations
- Test restores regularly
- Disaster recovery plan
- Encrypted backups

**The key:** Backup regularly. Test restores. Store off-site. Document everything.

## Memory Tip: The Insurance Analogy

**Backup & Recovery = Insurance**

**Backup:** Policy
**Recovery:** Claim
**Testing:** Verification
**Retention:** Duration

**Once you see it this way, backup makes perfect sense.**

## Common Mistakes

1. **Not backing up**: Data loss
2. **Not testing restores**: Don't know if works
3. **Only local backups**: Lost in disaster
4. **Not encrypting**: Security risk
5. **No documentation**: Can't restore

## Hands-On Exercise: Backup and Restore

**1. Create data:**
```bash
docker run -d --name test-db \
  -e POSTGRES_PASSWORD=secret \
  -v test-data:/var/lib/postgresql/data \
  postgres:16-alpine

# Create some data
docker exec test-db psql -U postgres -c "CREATE DATABASE testdb;"
```

**2. Backup:**
```bash
docker run --rm \
  -v test-data:/data:ro \
  -v $(pwd):/backup \
  alpine tar czf /backup/backup.tar.gz /data
```

**3. Verify backup:**
```bash
ls -lh backup.tar.gz
# Should see backup file
```

**4. Destroy data:**
```bash
docker stop test-db
docker rm test-db
docker volume rm test-data
```

**5. Restore:**
```bash
# Create new volume
docker volume create test-data

# Restore
docker run --rm \
  -v test-data:/data \
  -v $(pwd):/backup \
  alpine tar xzf /backup/backup.tar.gz -C /

# Verify
docker run -d --name test-db \
  -v test-data:/var/lib/postgresql/data \
  postgres:16-alpine

docker exec test-db psql -U postgres -c "\l"
# Should show testdb database restored!
```

## Key Takeaways

1. **Backup regularly** - Recent backups, less data loss
2. **Test restores** - Know it works before you need it
3. **Store off-site** - Disaster recovery
4. **Encrypt backups** - Security
5. **Document process** - Faster recovery
6. **Automate backups** - Consistent, reliable

## What's Next?

Now that you understand backup and recovery, let's learn about scaling containers. Next: [Scaling Containers](/docs/docker/09-production-deployment/scaling-containers).

---

> **Remember**: Backup and recovery is like insurance. You hope you never need it. But when you do, you're glad you have it. Backup regularly. Test restores. Document everything.

