---
sidebar_position: 5
title: "Firewall firewalld: RHEL/CentOS Firewall"
---

# firewalld: RHEL/CentOS Firewall

firewalld is the firewall for RHEL/CentOS. It's easier than iptables.

**Here's the thing: firewalld is simpler than iptables. Use it on RHEL/CentOS.**

## What firewalld Does

firewalld:
- Manages firewall rules
- Uses zones (public, internal, etc.)
- Easier than iptables
- Dynamic updates

**My take**: firewalld is easier. Use it on RHEL/CentOS.

## Basic Commands

### Check Status

```bash
sudo firewall-cmd --state
sudo systemctl status firewalld
```

**My take**: Check if firewalld is running. Enable it if not.

### View Zones

```bash
firewall-cmd --get-zones
firewall-cmd --get-active-zones
```

**My take**: Zones organize rules. Public. Internal. DMZ. Use them.

### View Rules

```bash
firewall-cmd --list-all
firewall-cmd --list-all --zone=public
```

**My take**: `--list-all` shows everything. Use it.

## Common Operations

### Allow Services

```bash
# Allow SSH
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# Allow HTTP
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

# Allow HTTPS
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

**My take**: `--permanent` makes it persistent. `--reload` applies changes.

### Allow Ports

```bash
# Allow port
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload

# Remove port
sudo firewall-cmd --permanent --remove-port=8080/tcp
sudo firewall-cmd --reload
```

**My take**: Allow ports when services aren't predefined.

### Set Default Zone

```bash
sudo firewall-cmd --set-default-zone=public
```

**My take**: Set default zone. Most interfaces use it.

## Common Zones

- **public** = Untrusted networks (default)
- **internal** = Trusted internal networks
- **dmz** = Demilitarized zone
- **work** = Work networks
- **home** = Home networks

**My take**: Use public for internet. Internal for trusted networks.

## Common Patterns

### Basic Web Server

```bash
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload
```

### Allow Custom Port

```bash
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload
```

## Common Mistakes (I've Made These)

1. **Forgetting --permanent**: Without `--permanent`, rules are temporary.

2. **Not reloading**: After changes, reload. `firewall-cmd --reload`

3. **Locking yourself out**: Allow SSH before blocking. Always.

4. **Wrong zone**: Make sure you're modifying the right zone.

5. **Not checking status**: Check if firewalld is running. Enable it.

## Real-World Examples

### Configure Firewall

```bash
# Enable firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Allow services
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

# Verify
firewall-cmd --list-all
```

## What's Next?

Now that you understand firewalld, you can secure RHEL/CentOS systems. Or review [Networking](/docs/linux/networking/network-fundamentals) to understand networks better.

---

> **Personal note**: firewalld seemed unnecessary at first. Then I used it. Now I prefer it over iptables. It's simpler. Use it on RHEL/CentOS.

