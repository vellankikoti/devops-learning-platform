---
sidebar_position: 1
title: ""Disk Partitions: Organizing Storage""
---

# Disk Partitions: Dividing Your Disk

Partitions divide disks into sections. Like rooms in a house.

**Here's the thing: You'll rarely create partitions. But you need to understand them. They organize storage.**

## What Partitions Are

**Partitions divide physical disks into logical sections**:
- Separate operating systems
- Organize data
- Improve performance
- Enhance security

**My take**: Most systems have partitions already. You usually don't need to create them.

## Viewing Partitions

### lsblk: List Block Devices

```bash
lsblk                             # List all devices
lsblk -f                          # Show filesystems
```

**Output**:
```
NAME   SIZE TYPE MOUNTPOINT
sda    20G  disk
├─sda1 512M part /boot
└─sda2 19.5G part /
```

**My take**: `lsblk` shows partitions. Use it to see disk layout.

### fdisk: Partition Table

```bash
sudo fdisk -l                     # List all partitions
sudo fdisk -l /dev/sda            # Specific device
```

**My take**: `fdisk -l` shows detailed partition information.

## Common Partition Layout

**Typical setup**:
- `/boot` = Boot files (small, ~500MB)
- `/` = Root filesystem (most space)
- `/home` = User data (optional, separate)
- `/var` = Variable data (optional, separate)

**My take**: Most systems have `/boot` and `/`. That's enough. Separate partitions are optional.

## Creating Partitions (Advanced)

### fdisk: Interactive Editor

```bash
sudo fdisk /dev/sda               # Edit partition table
```

**Commands**:
- `p` = Print partition table
- `n` = New partition
- `d` = Delete partition
- `w` = Write and exit
- `q` = Quit without saving

**My take**: `fdisk` is interactive. Be careful. Wrong commands can destroy data.

### parted: Advanced Tool

```bash
sudo parted /dev/sda              # Interactive mode
sudo parted /dev/sda print         # Print partitions
```

**My take**: `parted` is more advanced. Use `fdisk` for basic needs.

## When You Need Partitions

**You'll create partitions when**:
- Installing Linux
- Adding new disk
- Reorganizing storage
- Setting up dual boot

**My take**: Most of the time, partitions already exist. You don't need to create them.

## Common Mistakes (I've Made These)

1. **Deleting wrong partition**: Partitions contain data. Deleting loses data. Be careful.

2. **Not writing changes**: `fdisk` changes aren't saved until you write. Use `w` to save.

3. **Wrong device**: Make sure you're editing the right device. Check with `lsblk`.

4. **Not backing up**: Partition changes can't be undone. Backup first.

5. **Creating too many partitions**: Keep it simple. Most systems don't need many partitions.

## Real-World Examples

### View Partition Layout

```bash
lsblk -f
```

### Check Partition Usage

```bash
df -h
```

### Add New Disk

```bash
# 1. Attach disk
# 2. Create partition
sudo fdisk /dev/sdb
# 3. Format
sudo mkfs.ext4 /dev/sdb1
# 4. Mount
sudo mount /dev/sdb1 /mnt/data
```

## What's Next?

Now that you understand partitions, let's talk about [Filesystems](/docs/linux/storage-management/filesystems) to format them.

---

> **Personal note**: When I started, I thought partitions were complex. Then I realized: most systems already have them. You rarely need to create them. Understand them. But don't overthink them.
