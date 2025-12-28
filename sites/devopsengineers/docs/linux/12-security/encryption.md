---
sidebar_position: 3
title: ""Encryption: Protecting Data at Rest""
---

# Encryption: Protect Your Data

Encryption scrambles data. Only authorized users can read it.

**Here's the thing: Encryption protects sensitive data. Use it when needed.**

## What Encryption Does

Encryption protects:
- Data at rest (on disk)
- Data in transit (over network)
- Sensitive information

**My take**: Encryption is like a safe. Data is locked. Only key holders can access.

## Disk Encryption (LUKS)

### Create Encrypted Partition

```bash
# Create encrypted partition
sudo cryptsetup luksFormat /dev/sda1

# Open encrypted partition
sudo cryptsetup luksOpen /dev/sda1 encrypted_data

# Create filesystem
sudo mkfs.ext4 /dev/mapper/encrypted_data

# Mount
sudo mount /dev/mapper/encrypted_data /mnt/encrypted
```

**My take**: LUKS encrypts entire partitions. Full disk encryption.

### Manage Keys

```bash
# Add key
sudo cryptsetup luksAddKey /dev/sda1

# Remove key
sudo cryptsetup luksRemoveKey /dev/sda1
```

**My take**: LUKS supports multiple keys. Add backup keys.

## File Encryption (GPG)

### Encrypt File

```bash
# Encrypt
gpg -c file.txt                    # Encrypt with password

# Decrypt
gpg file.txt.gpg                   # Decrypt
```

**My take**: GPG encrypts individual files. Use it for sensitive files.

## When to Use Encryption

**Use when**:
- Sensitive data
- Compliance requirements
- Data breaches are costly
- Protecting user data

**Don't use when**:
- Public data
- Performance critical
- Don't need protection

**My take**: Use encryption when you need it. It adds overhead. But protects data.

## Common Mistakes (I've Made These)

1. **Losing keys**: Encrypted data is useless without keys. Backup keys.

2. **Not testing recovery**: Test decryption. Make sure you can recover.

3. **Performance impact**: Encryption adds overhead. Consider performance.

4. **Forgetting passwords**: Encrypted data is lost without password. Remember it.

5. **Not encrypting backups**: Backups should be encrypted too. Don't forget.

## Real-World Examples

### Encrypt Disk

```bash
# Format
sudo cryptsetup luksFormat /dev/sdb1

# Open
sudo cryptsetup luksOpen /dev/sdb1 encrypted

# Use
sudo mkfs.ext4 /dev/mapper/encrypted
sudo mount /dev/mapper/encrypted /mnt/secure
```

### Encrypt File

```bash
gpg -c secret.txt
rm secret.txt                      # Remove unencrypted
```

## What's Next?

Now that you understand encryption, you can protect data. Or learn about [Audit Logging](/docs/linux/security/audit-logging) to monitor activity.

---

> **Personal note**: Encryption seemed complex at first. Then I used it. Now I encrypt sensitive data. It's worth it. Protect what matters.
