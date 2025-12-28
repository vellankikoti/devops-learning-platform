---
sidebar_position: 5
title: Disk Management And Usage
---

# Disk Management: Don't Run Out of Space

Running out of disk space breaks things. Services stop. Systems crash. Data is lost.

**Here's the thing: Monitor disk space. Always. Running out is bad.**

## df: How Much Space Do You Have?

```bash
df -h                             # Human-readable
df -h /                           # Specific filesystem
df -i                             # Inode usage
```

**What it shows**: Disk space usage for filesystems.

**Real example**:
```bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        20G   15G  4.0G  79% /
/dev/sda2       100G   45G   50G  48% /home
```

**What matters**: The `Use%` column. Above 80% is warning. Above 90% is critical.

**My take**: Check `df -h` regularly. Know your disk usage. Prevent problems.

## du: What's Using Space?

```bash
du -h                             # Current directory
du -sh                            # Summary (total)
du -h --max-depth=1 .              # One level deep
du -h *                            # Each item
```

**What it shows**: Disk usage for files and directories.

**Real example**:
```bash
$ du -sh *
2.1G    projects
500M    downloads
100M    documents
```

**My take**: Use `du -sh *` to see what's using space. Find the big stuff.

## Finding Large Files

```bash
find / -type f -size +100M         # Files larger than 100MB
find / -type f -size +1G           # Files larger than 1GB
find / -type f -exec du -h {} \; | sort -rh | head -10  # Top 10 largest
```

**Real example**:
```bash
$ find /var/log -type f -size +100M
/var/log/syslog.1
/var/log/nginx/access.log
```

**My take**: Find large files. Delete old logs. Free up space.

## Common Space Hogs

### Log Files

```bash
du -sh /var/log
find /var/log -type f -size +100M
```

**My take**: Logs grow. They consume space. Rotate them. Delete old ones.

### Temporary Files

```bash
du -sh /tmp
du -sh /var/tmp
```

**My take**: Temp files accumulate. Clean them. They're temporary for a reason.

### Package Cache

```bash
du -sh /var/cache/apt
sudo apt clean                     # Clean package cache
```

**My take**: Package cache grows. Clean it. `apt clean` frees space.

## Cleaning Up

### Log Rotation

```bash
sudo logrotate -f /etc/logrotate.conf
```

**My take**: Logs should rotate automatically. Check if it's working.

### Remove Old Logs

```bash
find /var/log -type f -mtime +30 -delete
```

**My take**: Delete logs older than 30 days. Adjust as needed.

### Clean Package Cache

```bash
sudo apt clean                     # Debian/Ubuntu
sudo dnf clean all                 # RHEL/CentOS
```

**My take**: Clean package cache regularly. Frees space.

### Remove Old Kernels

```bash
sudo apt autoremove                # Debian/Ubuntu
```

**My take**: Old kernels accumulate. Remove them. `autoremove` does it.

## Monitoring Disk Usage

### Check Regularly

```bash
df -h                             # Quick check
```

**My take**: Make it a habit. Check disk space. Prevent problems.

### Set Up Alerts

```bash
# Script to check and alert
if [ $(df -h / | awk 'NR==2 {print $5}' | sed 's/%//') -gt 80 ]; then
    echo "Warning: Disk usage above 80%"
fi
```

**My take**: Automate monitoring. Get alerts before it's critical.

## Common Mistakes (I've Made These)

1. **Not monitoring**: Disk fills up. System breaks. Monitor it.

2. **Ignoring warnings**: 80% is warning. 90% is critical. Don't ignore.

3. **Not cleaning logs**: Logs grow. They consume space. Rotate them.

4. **Deleting wrong files**: Be careful. Don't delete system files.

5. **Not checking regularly**: Check disk space. Make it a habit.

## Real-World Examples

### Check Disk Space

```bash
df -h
```

### Find Large Files

```bash
find / -type f -size +1G 2>/dev/null
```

### Clean Logs

```bash
sudo find /var/log -type f -mtime +30 -delete
```

### Free Up Space

```bash
sudo apt clean
sudo apt autoremove
sudo find /tmp -type f -mtime +7 -delete
```

## What's Next?

Now that you can monitor disk usage, you can prevent problems. Or learn about [Storage Management](/docs/linux/storage-management/partitions) for advanced storage.

---

> **Personal note**: I've had systems crash because disk filled up. Services stopped. Logs couldn't write. It was a mess. Now I monitor disk space. I clean logs. I prevent problems. Monitor disk space. It matters.
