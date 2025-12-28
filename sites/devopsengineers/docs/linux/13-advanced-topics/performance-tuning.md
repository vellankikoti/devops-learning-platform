---
sidebar_position: 5
title: ""Performance Tuning: Optimizing Linux""
---

# Performance Tuning: Make It Fast

Performance tuning optimizes your system. Make it faster. More efficient.

**Here's the thing: Most systems are fast enough. But when they're not, tune them.**

## CPU Tuning

### CPU Governors

```bash
# View current governor
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Set governor
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

**Governors**:
- **performance** = Maximum speed
- **powersave** = Energy efficient
- **ondemand** = Adjusts based on load

**My take**: Performance governor = maximum speed. Use it when you need speed.

## Memory Tuning

### Swap Configuration

```bash
# View swap
free -h

# Adjust swappiness
sudo sysctl -w vm.swappiness=10
```

**My take**: Swap is slow. Reduce swappiness. Use more RAM.

## I/O Tuning

### I/O Scheduler

```bash
# View scheduler
cat /sys/block/sda/queue/scheduler

# Set scheduler
echo deadline | sudo tee /sys/block/sda/queue/scheduler
```

**My take**: I/O scheduler affects disk performance. Choose the right one.

## When to Tune

**Tune when**:
- System is slow
- High workload
- Performance critical
- Resource constrained

**Don't tune when**:
- System is fast enough
- Don't need optimization
- Premature optimization

**My take**: Tune when needed. Don't tune prematurely.

## Common Mistakes (I've Made These)

1. **Premature optimization**: Optimize when needed. Not before.

2. **Too many changes**: Change one thing at a time. Test results.

3. **Not measuring**: Measure before and after. Know if it helps.

4. **Wrong settings**: Settings depend on workload. Choose right ones.

5. **Ignoring defaults**: Defaults are usually good. Don't change unless needed.

## Real-World Examples

### Set Performance Governor

```bash
echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
```

### Reduce Swappiness

```bash
sudo sysctl -w vm.swappiness=10
```

### Set I/O Scheduler

```bash
echo deadline | sudo tee /sys/block/sda/queue/scheduler
```

## What's Next?

Now that you understand tuning, you can optimize performance. Or learn about [Containers](/docs/linux/advanced-topics/containers-lxc) for modern deployment.

---

> **Personal note**: Tuning seemed complex at first. Then I tuned a slow system. Now I understand it. Tune when needed. Don't overthink it.
