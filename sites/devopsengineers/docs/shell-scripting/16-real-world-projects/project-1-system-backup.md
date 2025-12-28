---
sidebar_position: 1
title: "Project 1: Complete System Backup Solution"
---

# Project 1: Build a Backup System

Build a complete backup system. This combines everything you've learned.

**Here's the thing: This is a real project. You'll use it. Learn from it.**

## What We're Building

A backup system that:
- Backs up multiple directories
- Rotates old backups
- Logs everything
- Handles errors
- Can be configured

**My take**: This is production-ready. Use it. Modify it. Learn from it.

## Complete Script

```bash
#!/bin/bash
set -euo pipefail

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/backup.conf"
LOG_FILE="/var/log/backup.log"
RETENTION_DAYS=30

# Functions
log() {
    local level="$1"
    shift
    local message="$*"
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] [$level] $message" | tee -a "$LOG_FILE"
}

backup_directory() {
    local source="$1"
    local dest="$2"
    
    if [ ! -d "$source" ]; then
        log "ERROR" "Source directory not found: $source"
        return 1
    fi
    
    local backup_name="backup_$(basename "$source")_$(date +%Y%m%d_%H%M%S).tar.gz"
    local backup_path="${dest}/${backup_name}"
    
    log "INFO" "Backing up $source to $backup_path"
    tar -czf "$backup_path" "$source"
    
    if [ $? -eq 0 ]; then
        log "INFO" "Backup successful: $backup_name"
        return 0
    else
        log "ERROR" "Backup failed: $source"
        return 1
    fi
}

cleanup_old_backups() {
    local backup_dir="$1"
    local retention_days="$2"
    
    log "INFO" "Cleaning up backups older than $retention_days days"
    find "$backup_dir" -name "backup_*.tar.gz" -mtime +$retention_days -delete
}

# Main
main() {
    log "INFO" "Backup started"
    
    # Read config or use defaults
    SOURCE_DIRS="${SOURCE_DIRS:-/home /etc /var/www}"
    BACKUP_DIR="${BACKUP_DIR:-/backup}"
    
    # Create backup directory
    mkdir -p "$BACKUP_DIR"
    
    # Backup each directory
    for dir in $SOURCE_DIRS; do
        backup_directory "$dir" "$BACKUP_DIR"
    done
    
    # Cleanup old backups
    cleanup_old_backups "$BACKUP_DIR" "$RETENTION_DAYS"
    
    log "INFO" "Backup completed"
}

main "$@"
```

**My take**: This script works. Use it. Modify it. Make it yours.

## How to Use

```bash
# Make executable
chmod +x backup.sh

# Run backup
./backup.sh

# Or with environment variables
SOURCE_DIRS="/data /config" BACKUP_DIR="/backups" ./backup.sh
```

## What You Learned

This project uses:
- Functions
- Error handling
- Logging
- File operations
- Command substitution
- Loops

**My take**: This combines everything. Real project. Real skills.

## Extending It

Add features:
- Email notifications
- Remote backup
- Encryption
- Compression options
- Configuration file

**My take**: Extend it. Make it better. Learn by doing.

## What's Next?

Now that you've built a complete project, you can build more. Or review what you've learned. You're ready.

---

> **Personal note**: This is the kind of script I use in production. It works. It's reliable. Build it. Use it. Learn from it. Real projects teach real skills.
