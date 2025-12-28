---
sidebar_position: 4
title: ""LVM: Logical Volume Manager""
---

# LVM: Flexible Storage

LVM provides flexible storage management. Resize volumes. Combine disks. Create snapshots.

**Here's the thing: LVM is advanced. You might not need it. But when you do, it's powerful.**

## What LVM Does

LVM abstracts physical storage:
- **Physical Volumes (PV)** = Physical disks
- **Volume Groups (VG)** = Pool of disks
- **Logical Volumes (LV)** = Virtual partitions

**Think of it like this**: Combine disks into a pool. Create virtual volumes from the pool. Resize as needed.

**My take**: LVM is like virtual storage. Flexible. Powerful. But complex.

## Basic LVM

### Create Physical Volume

```bash
sudo pvcreate /dev/sda1
sudo pvcreate /dev/sdb
```

**My take**: Physical volumes are disks for LVM. Create them first.

### Create Volume Group

```bash
sudo vgcreate myvg /dev/sda1 /dev/sdb
```

**My take**: Volume groups pool physical volumes. Combine disks.

### Create Logical Volume

```bash
sudo lvcreate -L 10G -n mylv myvg
```

**My take**: Logical volumes are virtual partitions. Create from volume group.

### Use Logical Volume

```bash
# Format
sudo mkfs.ext4 /dev/myvg/mylv

# Mount
sudo mount /dev/myvg/mylv /mnt/data
```

**My take**: Use logical volumes like regular partitions. Format. Mount. Use.

## Resizing Volumes

### Extend Logical Volume

```bash
# Extend LV
sudo lvextend -L +5G /dev/myvg/mylv

# Resize filesystem
sudo resize2fs /dev/myvg/mylv
```

**My take**: LVM lets you resize without repartitioning. That's the power.

## When to Use LVM

**Use LVM when**:
- You need to resize volumes
- You have multiple disks
- You need snapshots
- Storage needs change

**Don't use LVM when**:
- Simple setup is enough
- You don't need flexibility
- You're learning basics

**My take**: LVM is powerful. But you might not need it. Use it when you do.

## Common Mistakes (I've Made These)

1. **Too complex for simple needs**: LVM adds complexity. Use it when needed.

2. **Not understanding layers**: PV → VG → LV. Understand the layers.

3. **Resizing without resizing filesystem**: Extend LV, then resize filesystem.

4. **Removing wrong volume**: Be careful. Removing volumes loses data.

5. **Not backing up**: LVM is complex. Backup before major changes.

## Real-World Examples

### Create LVM Setup

```bash
# Create PVs
sudo pvcreate /dev/sda1 /dev/sdb

# Create VG
sudo vgcreate datavg /dev/sda1 /dev/sdb

# Create LV
sudo lvcreate -L 20G -n datalv datavg

# Format and mount
sudo mkfs.ext4 /dev/datavg/datalv
sudo mount /dev/datavg/datalv /data
```

## What's Next?

Now that you understand LVM, you have flexible storage. Or learn about [Disk Quotas](/docs/linux/storage-management/disk-quotas) to limit usage.

---

> **Personal note**: LVM seemed complex at first. Then I used it. Now I appreciate it. It's powerful. But you might not need it. Use it when you do.
