---
sidebar_position: 1
title: "Kernel Basics: Understanding the Core"
---

# Kernel: The Heart of Linux

The kernel is the core of Linux. It manages everything.

**Here's the thing: You'll rarely touch the kernel. But understanding it helps you understand Linux.**

## What the Kernel Does

The kernel:
- Manages hardware
- Controls processes
- Handles memory
- Provides system calls

**My take**: The kernel is like the engine. You don't see it. But everything depends on it.

## Kernel Information

### View Version

```bash
uname -r                         # Kernel release
uname -a                         # All system info
```

**Output**: `5.15.0-91-generic`

**Format**: `major.minor.patch-build`

**My take**: `uname -r` shows kernel version. That's what you need to know.

### Kernel Modules

```bash
# List loaded modules
lsmod

# Module information
modinfo module_name

# Load module
sudo modprobe module_name

# Remove module
sudo modprobe -r module_name
```

**My take**: Modules extend kernel. Load them when needed.

## Kernel Parameters

### sysctl: View/Set Parameters

```bash
# View all
sysctl -a

# View specific
sysctl kernel.hostname

# Set parameter
sudo sysctl -w kernel.hostname=newhost
```

**My take**: `sysctl` controls kernel parameters. Use it to tune system.

## When You'll Touch the Kernel

**You'll touch kernel when**:
- Loading drivers
- Tuning parameters
- Troubleshooting
- Performance optimization

**Most of the time**: You won't touch it. It just works.

**My take**: Kernel usually works. Touch it when you need to.

## Common Mistakes (I've Made These)

1. **Changing parameters without understanding**: Kernel parameters affect system. Understand before changing.

2. **Removing wrong modules**: Removing modules can break things. Be careful.

3. **Not checking version**: Kernel version matters. Check it.

4. **Too many parameters**: Don't change too many parameters. Change what you need.

5. **Not testing**: Test kernel changes. They affect the whole system.

## Real-World Examples

### Check Kernel Version

```bash
uname -r
```

### Load Module

```bash
sudo modprobe nvidia
```

### View Parameters

```bash
sysctl kernel.hostname
```

## What's Next?

Now that you understand the kernel, you understand Linux better. Or learn about [Kernel Modules](/docs/linux/advanced-topics/modules) to extend functionality.

---

> **Personal note**: The kernel seemed mysterious at first. Then I learned it. Now I understand Linux better. The kernel is the foundation. Learn it.
