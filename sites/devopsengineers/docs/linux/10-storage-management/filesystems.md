---
sidebar_position: 2
title: ""Filesystems: Formatting Partitions""
---

# Filesystems: Making Partitions Usable

Filesystems organize data on partitions. Without a filesystem, you can't use the partition.

**Here's the thing: You'll mostly use ext4. It's the default. It works. Learn the others when you need them.**

## Common Filesystems

### ext4: The Standard

**What**: Default on most Linux systems.

**Characteristics**:
- Journaling (crash recovery)
- Good performance
- Reliable
- 16TB max file size

**My take**: Use ext4. It's the default. It works. Don't overthink it.

### xfs: High Performance

**What**: Better for large files and high I/O.

**Characteristics**:
- Excellent for large files
- High I/O performance
- 8EB max file size

**When to use**: Databases. Large files. High performance needs.

**My take**: Use xfs when you need performance. Otherwise, ext4 is fine.

### btrfs: Advanced Features

**What**: Modern filesystem with advanced features.

**Characteristics**:
- Snapshots
- Compression
- Copy-on-write
- RAID support

**When to use**: When you need snapshots or advanced features.

**My take**: btrfs is advanced. Use it when you need its features. Otherwise, ext4.

## Creating Filesystems

### mkfs: Make Filesystem

```bash
sudo mkfs.ext4 /dev/sda1          # Create ext4
sudo mkfs.xfs /dev/sda1           # Create xfs
sudo mkfs.btrfs /dev/sda1         # Create btrfs
```

**My take**: `mkfs` creates filesystems. Simple. Works.

### Format with Label

```bash
sudo mkfs.ext4 -L "data" /dev/sda1
```

**My take**: Labels help identify filesystems. Use them.

## Checking Filesystems

```bash
sudo fsck /dev/sda1               # Check filesystem
sudo fsck.ext4 /dev/sda1          # Check ext4
```

**My take**: `fsck` checks filesystems. Run it if something seems wrong.

## Common Patterns

### Format New Partition

```bash
# 1. Create partition (fdisk)
sudo fdisk /dev/sda

# 2. Format
sudo mkfs.ext4 /dev/sda1

# 3. Mount
sudo mount /dev/sda1 /mnt/data
```

## Common Mistakes (I've Made These)

1. **Formatting wrong device**: Double-check device name. Formatting destroys data.

2. **Not mounting after format**: Formatting doesn't mount. Mount manually.

3. **Wrong filesystem type**: Use ext4 for general use. Others when needed.

4. **Not labeling**: Labels help identify. Use them.

5. **Formatting mounted filesystem**: Unmount first. Then format.

## Real-World Examples

### Format New Disk

```bash
# List devices
lsblk

# Format
sudo mkfs.ext4 -L "backup" /dev/sdb1

# Mount
sudo mount /dev/sdb1 /backup
```

## What's Next?

Now that you can create filesystems, let's talk about [Mounting](/docs/linux/storage-management/mounting) to use them.

---

> **Personal note**: When I started, I thought filesystems were complex. Then I realized: use ext4. It works. Learn others when you need them. Don't overthink it.
