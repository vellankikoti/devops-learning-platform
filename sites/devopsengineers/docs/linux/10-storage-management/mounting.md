---
sidebar_position: 3
title: ""Mounting: Accessing Filesystems""
---

# Mounting: Make Filesystems Accessible

Mounting attaches filesystems to the directory tree. Without mounting, you can't access the filesystem.

**Here's the thing: Mounting is how you access storage. Learn it. Use it.**

## Basic Mounting

### mount: Attach Filesystem

```bash
sudo mount /dev/sda1 /mnt/data
sudo mount -t ext4 /dev/sda1 /mnt/data
```

**The format**: `mount device mountpoint`

**My take**: Mounting is simple. Device to mount point. That's it.

### umount: Detach Filesystem

```bash
sudo umount /mnt/data            # By mount point
sudo umount /dev/sda1            # By device
```

**My take**: Unmounting detaches. Do it before removing devices.

## Mount Options

```bash
# Read-only
sudo mount -o ro /dev/sda1 /mnt/data

# Read-write
sudo mount -o rw /dev/sda1 /mnt/data

# No access time (performance)
sudo mount -o noatime /dev/sda1 /mnt/data
```

**My take**: Options control how filesystem is mounted. Use them when needed.

## Automatic Mounting

### /etc/fstab: Filesystem Table

```bash
# Edit fstab
sudo vim /etc/fstab

# Format: device mountpoint filesystem options dump pass
/dev/sda1 /mnt/data ext4 defaults 0 2
```

**My take**: `/etc/fstab` mounts filesystems at boot. Use it for permanent mounts.

### Mount All

```bash
sudo mount -a                     # Mount all in fstab
```

**My take**: `mount -a` mounts everything in fstab. Useful after editing.

## Common Patterns

### Mount USB Drive

```bash
# Find device
lsblk

# Mount
sudo mount /dev/sdb1 /mnt/usb

# Use it
cd /mnt/usb

# Unmount when done
sudo umount /mnt/usb
```

### Permanent Mount

```bash
# Add to /etc/fstab
UUID=xxx /mnt/data ext4 defaults 0 2

# Test
sudo mount -a
```

**My take**: Use UUIDs in fstab. More reliable than device names.

## Common Mistakes (I've Made These)

1. **Mounting to non-empty directory**: Mount point should be empty. Or use files that won't conflict.

2. **Not unmounting**: Unmount before removing devices. Prevents data loss.

3. **Wrong device**: Double-check device name. Mounting wrong device is bad.

4. **Mount point doesn't exist**: Create mount point first. `mkdir -p /mnt/data`

5. **Forgetting fstab syntax**: fstab syntax is strict. One mistake breaks boot.

## Real-World Examples

### Mount New Disk

```bash
# Create mount point
sudo mkdir -p /mnt/data

# Mount
sudo mount /dev/sdb1 /mnt/data

# Add to fstab for permanent
echo "/dev/sdb1 /mnt/data ext4 defaults 0 2" | sudo tee -a /etc/fstab
```

### Check Mounts

```bash
mount                             # All mounts
df -h                             # Mounted filesystems
```

## What's Next?

Now that you can mount filesystems, you can access storage. Or learn about [LVM](/docs/linux/storage-management/lvm-basics) for flexible storage management.

---

> **Personal note**: When I started, I'd forget to unmount. Then I'd get errors. Now I always unmount. It's a habit. Mount. Use. Unmount. Simple.
