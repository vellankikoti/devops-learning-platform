---
sidebar_position: 2
title: "Command Substitution: Using Command Output"
---

# Command Substitution: Use Command Output

Command substitution runs commands and uses their output. Like asking a question and using the answer.

**Here's the thing: Command substitution is common. Learn it. Use it.**

## Modern Syntax: $()

```bash
current_date=$(date)
username=$(whoami)
files=$(ls)

echo "Date: $current_date"
echo "User: $username"
```

**The `$()`**: Runs command, captures output.

**My take**: Use `$()`. It's modern. It's preferred. It works.

## Old Syntax: Backticks

```bash
# Old syntax (avoid)
current_date=`date`
username=`whoami`
```

**My take**: Backticks work, but `$()` is better. Use `$()`.

## Common Uses

### Dynamic Values

```bash
# Current date
backup_name="backup_$(date +%Y%m%d).tar.gz"

# Hostname
log_file="/var/log/$(hostname).log"

# User home
user_home=$(getent passwd $USER | cut -d: -f6)
```

**My take**: Use command substitution for dynamic values. Dates. Hostnames. Paths.

### Calculations

```bash
count=$(ls -1 | wc -l)
total=$(( $(du -s /path | cut -f1) / 1024 ))
```

**My take**: Combine with arithmetic. Calculate values.

### Process Output

```bash
# Get process count
nginx_count=$(ps aux | grep nginx | grep -v grep | wc -l)

# Get disk usage
disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
```

**My take**: Process command output. Extract information.

## Common Patterns

### Generate Filenames

```bash
backup_file="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
```

### Get Configuration

```bash
max_backups=$(grep "MAX_BACKUPS" config.txt | cut -d= -f2)
```

### Check Status

```bash
if [ "$(systemctl is-active nginx)" = "active" ]; then
    echo "Nginx is running"
fi
```

## Common Mistakes (I've Made These)

1. **Using backticks**: Use `$()`. It's better. More readable.

2. **Not quoting**: Quote command substitution. `"$(command)"` not `$(command)`.

3. **Nested substitution**: `$($(command))` works, but be careful. It's complex.

4. **Command fails**: If command fails, substitution is empty. Check exit codes.

5. **Too complex**: Keep it simple. Complex substitutions are hard to read.

## Real-World Examples

### Backup with Timestamp

```bash
backup_file="backup_$(date +%Y%m%d_%H%M%S).tar.gz"
tar -czf "$backup_file" /data
```

### Get System Info

```bash
hostname=$(hostname)
uptime=$(uptime -p)
memory=$(free -h | awk '/^Mem:/ {print $2}')
```

### Process Count

```bash
nginx_count=$(pgrep -c nginx)
echo "Nginx processes: $nginx_count"
```

## What's Next?

Now that you can use command output, scripts become dynamic. Or learn about [Parameter Expansion](/docs/shell-scripting/advanced-features/parameter-expansion) for more variable tricks.

---

> **Personal note**: When I started, I'd run commands separately. Then I learned command substitution. Now I use it constantly. It makes scripts dynamic. Learn it. Use it.
