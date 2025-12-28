---
sidebar_position: 1
title: Backup Automation Scripts
---

# Backup Scripts: Protect Your Data

Backup scripts protect data automatically. Run on schedule. No manual work.

**Here's the thing: Backups are essential. Automated backups are better. Learn to write them.**

## Basic Backup

```bash
#!/bin/bash
SOURCE="/home/user/documents"
BACKUP="/backup/documents"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="backup_${DATE}.tar.gz"

mkdir -p "$BACKUP"
tar -czf "${BACKUP}/${BACKUP_FILE}" "$SOURCE"

if [ $? -eq 0 ]; then
    echo "Backup successful: ${BACKUP_FILE}"
else
    echo "Backup failed!"
    exit 1
fi
```

**My take**: Basic backup is simple. Tar with timestamp. Works.

## Complete Backup Script

```bash
#!/bin/bash
set -euo pipefail

SOURCE_DIR="${1:-/data}"
BACKUP_DIR="${2:-/backup}"
RETENTION_DAYS=7

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Generate backup name
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
BACKUP_PATH="${BACKUP_DIR}/${BACKUP_NAME}"

# Create backup
echo "Creating backup..."
tar -czf "$BACKUP_PATH" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_NAME"
    
    # Remove old backups
    find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -delete
    echo "Cleaned up backups older than $RETENTION_DAYS days"
else
    echo "Backup failed!"
    exit 1
fi
```

**My take**: Complete backup includes retention. Clean up old backups. Prevents disk full.

## Common Patterns

### Database Backup

```bash
#!/bin/bash
DB_NAME="mydb"
BACKUP_DIR="/backup/db"
DATE=$(date +%Y%m%d_%H%M%S)

mysqldump "$DB_NAME" | gzip > "${BACKUP_DIR}/${DB_NAME}_${DATE}.sql.gz"
```

### Incremental Backup

```bash
#!/bin/bash
SOURCE="/data"
BACKUP="/backup"
DATE=$(date +%Y%m%d)

# Full backup on first of month
if [ "$(date +%d)" = "01" ]; then
    tar -czf "${BACKUP}/full_${DATE}.tar.gz" "$SOURCE"
else
    # Incremental backup
    tar -czf "${BACKUP}/inc_${DATE}.tar.gz" --newer-mtime="1 day ago" "$SOURCE"
fi
```

## Scheduling Backups

### Cron

```bash
# Edit crontab
crontab -e

# Daily backup at 2 AM
0 2 * * * /path/to/backup.sh

# Weekly backup on Sunday
0 3 * * 0 /path/to/backup.sh
```

**My take**: Use cron for scheduling. Simple. Reliable.

## Common Mistakes (I've Made These)

1. **Not testing restore**: Backups are useless if you can't restore. Test restores.

2. **No retention policy**: Backups accumulate. Clean them up.

3. **Backing up to same disk**: If disk fails, backups are lost. Use different disk.

4. **Not checking if backup succeeded**: Check exit codes. Verify backups.

5. **No monitoring**: Backups can fail silently. Monitor them. Get alerts.

## Real-World Examples

### Automated Backup with Rotation

```bash
#!/bin/bash
set -euo pipefail

SOURCE="/var/www/html"
BACKUP_DIR="/backup/web"
MAX_BACKUPS=7

BACKUP_NAME="web_$(date +%Y%m%d_%H%M%S).tar.gz"
tar -czf "${BACKUP_DIR}/${BACKUP_NAME}" "$SOURCE"

# Keep only last N backups
ls -t "${BACKUP_DIR}"/web_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -f
```

## What's Next?

Now that you can write backup scripts, your data is protected. Or learn about [CI/CD Scripts](/docs/shell-scripting/devops-integration/ci-cd-scripts) for deployment automation.

---

> **Personal note**: I've lost data before. Then I learned backups. Now I backup everything. Automatically. Backups are insurance. Write them. Use them.
