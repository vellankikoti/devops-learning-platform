---
sidebar_position: 5
title: ""Disk Quotas: Limiting User Storage""
---

# Disk Quotas: Limit Storage

Disk quotas limit how much space users can use. Prevents one user from filling the disk.

**Here's the thing: Quotas are useful for multi-user systems. You might not need them. But when you do, they're essential.**

## What Quotas Do

Quotas limit:
- Disk space per user/group
- Number of files (inodes)
- Prevent disk full issues

**My take**: Quotas are like storage allowances. Each user gets a limit.

## Enabling Quotas

### Edit /etc/fstab

```bash
# Add usrquota,grpquota to options
UUID=xxx /home ext4 defaults,usrquota,grpquota 0 2
```

**My take**: Enable quotas in fstab. Then remount.

### Remount and Enable

```bash
sudo mount -o remount /home
sudo quotacheck -ugam
sudo quotaon -ug /home
```

**My take**: Remount. Check quotas. Enable them.

## Setting Quotas

### edquota: Edit Quotas

```bash
sudo edquota username
```

**Quota format**:
```
Filesystem  blocks  soft  hard  inodes  soft  hard
/dev/sda1   1000    5000  10000  100    500   1000
```

**Fields**:
- **blocks** = Current usage
- **soft** = Soft limit (warning)
- **hard** = Hard limit (enforced)

**My take**: Soft limit warns. Hard limit enforces. Set both.

## Checking Quotas

```bash
quota username                     # User quota
quota -g groupname                # Group quota
repquota /home                    # All quotas
```

**My take**: Check quotas to see usage. Monitor them.

## When to Use Quotas

**Use quotas when**:
- Multiple users share disk
- Need to prevent disk full
- Want to control usage
- Compliance requirements

**Don't use quotas when**:
- Single user system
- Don't need limits
- Simple setup

**My take**: Quotas are for multi-user systems. Use them when needed.

## Common Mistakes (I've Made These)

1. **Not enabling in fstab**: Quotas must be enabled in fstab. Don't forget.

2. **Not running quotacheck**: Run quotacheck after enabling. Creates quota files.

3. **Wrong limits**: Set reasonable limits. Too low frustrates users. Too high defeats purpose.

4. **Not monitoring**: Quotas need monitoring. Check usage regularly.

5. **Forgetting to enable**: Enable quotas after setup. `quotaon` enables them.

## Real-World Examples

### Set User Quota

```bash
# Enable quotas
sudo edquota username
# Set limits in editor

# Check quota
quota username
```

### Set Group Quota

```bash
sudo edquota -g developers
```

## What's Next?

Now that you understand quotas, you can limit storage. Or learn about [Backup Strategies](/docs/linux/storage-management/backup-strategies) to protect data.

---

> **Personal note**: Quotas seemed unnecessary at first. Then I had a user fill the disk. Now I use quotas. They prevent problems. Use them on multi-user systems.
