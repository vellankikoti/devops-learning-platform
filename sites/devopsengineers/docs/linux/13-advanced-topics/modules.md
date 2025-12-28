---
sidebar_position: 2
title: ""Kernel Modules: Extending the Kernel""
---

# Kernel Modules: Extend the Kernel

Kernel modules extend kernel functionality. Load them. Remove them. As needed.

**Here's the thing: Modules are like plugins. Add functionality without rebuilding kernel.**

## What Modules Are

Modules are:
- Hardware drivers
- Filesystem support
- Network protocols
- Loaded/unloaded as needed

**My take**: Modules extend kernel. Load them when needed. Remove when not.

## Module Management

### List Modules

```bash
lsmod                            # List loaded modules
lsmod | grep nvidia             # Specific module
```

**My take**: `lsmod` shows loaded modules. Use it to see what's loaded.

### Module Information

```bash
modinfo module_name              # Module details
```

**My take**: `modinfo` shows module information. Use it to understand modules.

### Load/Remove Modules

```bash
# Load module
sudo modprobe module_name

# Remove module
sudo modprobe -r module_name

# Load with options
sudo modprobe module_name option=value
```

**My take**: `modprobe` loads and removes modules. Use it to manage modules.

## Common Modules

### Hardware Drivers

```bash
# Graphics
modprobe nvidia

# Network
modprobe e1000

# Storage
modprobe nvme
```

**My take**: Modules provide drivers. Load them for hardware support.

## When You'll Use Modules

**You'll use modules when**:
- Adding hardware support
- Loading drivers
- Troubleshooting devices
- Extending functionality

**Most of the time**: Modules load automatically. You don't need to touch them.

**My take**: Modules usually work automatically. Touch them when you need to.

## Common Mistakes (I've Made These)

1. **Removing wrong module**: Removing modules can break things. Be careful.

2. **Not checking dependencies**: Modules have dependencies. Check them.

3. **Loading manually when not needed**: Modules load automatically. Don't load manually unless needed.

4. **Not understanding options**: Module options affect behavior. Understand them.

5. **Removing system modules**: Don't remove system modules. They're needed.

## Real-World Examples

### Load Driver

```bash
sudo modprobe nvidia
```

### Check Module

```bash
lsmod | grep nvidia
modinfo nvidia
```

### Remove Module

```bash
sudo modprobe -r nvidia
```

## What's Next?

Now that you understand modules, you can extend the kernel. Or learn about [Performance Tuning](/docs/linux/advanced-topics/performance-tuning) to optimize system.

---

> **Personal note**: Modules seemed complex at first. Then I used them. Now I understand them. They're simple. Load. Use. Remove. That's it.
