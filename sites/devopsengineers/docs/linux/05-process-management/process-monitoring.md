---
sidebar_position: 5
title: "Process Monitoring: Watch Processes"
---

# Process Monitoring: Real-Time Watching

Process monitoring watches processes in real-time. See what's happening. Find problems.

**Here's the thing: Monitoring processes shows problems. Use it to find what's wrong.**

## Real-Time Monitoring

### top: Basic Monitor

```bash
top                               # Interactive monitor
```

**Navigation**:
- `q` = Quit
- `M` = Sort by memory
- `P` = Sort by CPU
- `1` = Show all CPUs
- `k` = Kill process

**My take**: `top` is basic. But it works. Use it.

### htop: Better Monitor

```bash
htop                              # Better version
```

**My take**: Install htop. It's better. More colorful. Easier to use.

### watch: Monitor Commands

```bash
watch -n 2 'ps aux | grep nginx'  # Every 2 seconds
watch -n 5 'systemctl status nginx'
```

**My take**: `watch` monitors commands. Useful for tracking.

## Process Trees

### pstree: Process Tree

```bash
pstree                            # Process tree
pstree -p                         # With PIDs
pstree -u                         # With users
```

**My take**: `pstree` shows process relationships. Useful for understanding.

### Process Hierarchy

```bash
# Find parent process
ps -o ppid= -p PID

# Find child processes
ps --ppid PID
```

**My take**: Understanding hierarchy helps. Find parents. Find children.

## Monitoring Specific Processes

### Monitor by Name

```bash
top -p $(pgrep -d, nginx)
```

**My take**: Monitor specific processes. Useful for services.

### Monitor by User

```bash
top -u username
```

**My take**: Monitor user's processes. See what they're doing.

## Common Monitoring Patterns

### Watch Service

```bash
watch -n 2 'systemctl status nginx'
```

### Monitor Resource Usage

```bash
htop
# Sort by CPU or memory
```

### Find Resource Hogs

```bash
ps aux --sort=-%cpu | head -10    # Top CPU
ps aux --sort=-%mem | head -10    # Top memory
```

## Common Mistakes (I've Made These)

1. **Not monitoring**: Monitor processes. Find problems early.

2. **Only checking CPU**: Check CPU, memory, I/O. All matter.

3. **Not using htop**: Install htop. It's better than top.

4. **Ignoring process trees**: Trees show relationships. Understand them.

5. **Not setting up alerts**: Manual monitoring is tedious. Automate it.

## Real-World Examples

### Monitor Web Server

```bash
htop
# Filter for nginx
# Watch CPU and memory
```

### Find Slow Process

```bash
ps aux --sort=-%cpu | head -10
```

### Monitor Process Tree

```bash
pstree -p nginx
```

## What's Next?

Now that you can monitor processes, you can find problems. Or review [Process Management](/docs/linux/process-management/understanding-processes) to understand processes better.

---

> **Personal note**: I used to ignore monitoring. Then processes broke. Now I monitor constantly. It prevents problems. Monitor your processes.


