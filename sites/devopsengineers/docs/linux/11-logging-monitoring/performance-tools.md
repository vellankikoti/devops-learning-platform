---
sidebar_position: 4
title: "Performance Tools: Analyze Performance"
---

# Performance Tools: Deep Analysis

Performance tools analyze system performance. CPU. Memory. I/O. Network.

**Here's the thing: Performance tools show what's slow. Use them to find bottlenecks.**

## CPU Analysis

### vmstat: System Statistics

```bash
vmstat                            # Current stats
vmstat 1                          # Every second
vmstat 1 10                       # 10 times, every second
```

**My take**: `vmstat` shows CPU, memory, I/O. Useful overview.

### mpstat: CPU Statistics

```bash
mpstat                            # All CPUs
mpstat -P ALL                     # Per-CPU
mpstat 1                          # Every second
```

**My take**: `mpstat` shows CPU details. Per-CPU statistics.

## Memory Analysis

### free: Memory Usage

```bash
free -h                           # Human-readable
free -m                           # Megabytes
free -s 5                         # Every 5 seconds
```

**My take**: `free` shows memory. Use `-h` for readability.

### Memory Details

```bash
cat /proc/meminfo                 # Detailed memory info
```

**My take**: `/proc/meminfo` has detailed memory info. Read it.

## I/O Analysis

### iostat: I/O Statistics

```bash
# Install
sudo apt install sysstat          # Debian/Ubuntu
sudo dnf install sysstat          # RHEL/CentOS

# Use
iostat                            # Current stats
iostat 1                          # Every second
iostat -x                         # Extended stats
```

**My take**: `iostat` shows I/O statistics. Useful for disk performance.

## Network Analysis

### ifstat: Network Statistics

```bash
# Install
sudo apt install ifstat

# Use
ifstat                            # All interfaces
ifstat -i eth0                    # Specific interface
```

**My take**: `ifstat` shows network statistics. Monitor network performance.

## sar: System Activity Reporter

### Install sar

```bash
sudo apt install sysstat
sudo systemctl enable sysstat
sudo systemctl start sysstat
```

**My take**: `sar` collects historical data. Useful for analysis.

### View sar Data

```bash
sar                              # Today's data
sar -u                           # CPU
sar -r                           # Memory
sar -d                           # Disk
sar -n DEV                       # Network
```

**My take**: `sar` shows historical data. Analyze past performance.

## Common Analysis Patterns

### Check CPU Bottleneck

```bash
vmstat 1
mpstat -P ALL 1
```

### Check Memory Pressure

```bash
free -h
vmstat 1
```

### Check I/O Bottleneck

```bash
iostat -x 1
iotop
```

## Common Mistakes (I've Made These)

1. **Not installing tools**: Install sysstat. It provides many tools.

2. **Not collecting data**: sar collects data. Enable it.

3. **Only checking one metric**: Check CPU, memory, I/O, network. All matter.

4. **Not understanding output**: Learn what the numbers mean. They tell you things.

5. **Ignoring historical data**: sar shows trends. Use it.

## Real-World Examples

### Analyze Performance

```bash
# CPU
mpstat -P ALL 1

# Memory
free -h
vmstat 1

# I/O
iostat -x 1

# Network
ifstat
```

## What's Next?

Now that you can analyze performance, let's talk about [Troubleshooting Techniques](/docs/linux/logging-monitoring/troubleshooting-techniques) to fix problems.

---

> **Personal note**: Performance tools seemed complex at first. Then I learned them. Now I use them to find bottlenecks. They're essential. Learn them.

