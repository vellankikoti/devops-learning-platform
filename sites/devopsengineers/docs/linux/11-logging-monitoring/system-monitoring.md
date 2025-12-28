---
sidebar_position: 3
title: "System Monitoring: Watch Your System"
---

# System Monitoring: Know What's Happening

System monitoring shows what's happening. CPU. Memory. Disk. Network.

**Here's the thing: Monitoring shows problems before they become disasters. Learn it. Use it.**

## Real-Time Monitoring

### top: Process Monitor

```bash
top                               # Interactive monitor
```

**Navigation**:
- `q` = Quit
- `M` = Sort by memory
- `P` = Sort by CPU
- `1` = Show all CPUs

**My take**: `top` is basic. But it works. Use it.

### htop: Better top

```bash
htop                              # Better version
```

**My take**: Install htop. It's better than top. More colorful. Easier.

### iotop: I/O Monitor

```bash
sudo iotop                         # Monitor disk I/O
```

**My take**: `iotop` shows disk I/O. Useful when disk is slow.

### nethogs: Network Monitor

```bash
sudo nethogs                       # Monitor network by process
```

**My take**: `nethogs` shows network by process. Useful for network issues.

## Resource Monitoring

### CPU Usage

```bash
top
htop
mpstat                            # CPU statistics
```

**My take**: Monitor CPU. High usage means problems.

### Memory Usage

```bash
free -h                           # Memory usage
top
htop
```

**My take**: Monitor memory. Low memory causes problems.

### Disk Usage

```bash
df -h                             # Disk space
du -sh *                          # Directory sizes
iotop                             # Disk I/O
```

**My take**: Monitor disk. Full disk breaks things.

### Network Usage

```bash
ifstat                            # Network statistics
nethogs                           # By process
```

**My take**: Monitor network. High usage means traffic.

## Common Monitoring Patterns

### Quick System Check

```bash
# CPU and memory
top

# Disk space
df -h

# Disk I/O
sudo iotop
```

### Continuous Monitoring

```bash
# Watch disk space
watch -n 5 df -h

# Watch processes
watch -n 2 'ps aux | head -20'
```

**My take**: `watch` monitors continuously. Useful for tracking changes.

## Common Mistakes (I've Made These)

1. **Not monitoring**: Monitor systems. Find problems early.

2. **Only checking CPU**: Check CPU, memory, disk, network. All matter.

3. **Not using htop**: Install htop. It's better than top.

4. **Ignoring I/O**: Disk I/O can be the problem. Check it.

5. **Not setting up alerts**: Manual monitoring is tedious. Automate it.

## Real-World Examples

### Monitor System

```bash
# CPU and memory
htop

# Disk
df -h
sudo iotop

# Network
sudo nethogs
```

### Find Resource Hogs

```bash
# Top CPU
ps aux --sort=-%cpu | head -10

# Top memory
ps aux --sort=-%mem | head -10
```

## What's Next?

Now that you can monitor systems, let's talk about [Performance Tools](/docs/linux/logging-monitoring/performance-tools) for detailed analysis.

---

> **Personal note**: I used to ignore monitoring. Then systems broke. Now I monitor everything. It prevents problems. Monitor your systems.


