---
sidebar_position: 3
title: YUM/DNF Package Management (RHEL/CentOS)
---

# YUM/DNF: Red Hat Package Management

YUM and DNF manage packages on Red Hat systems. DNF is the new YUM.

**Here's the thing: DNF is replacing YUM. Learn DNF. It's the future.**

## DNF: The Modern YUM

### Update Package List

```bash
sudo dnf check-update              # Check for updates
sudo dnf update                    # Update all packages
```

**My take**: DNF is the new YUM. Use it on newer systems.

### Install Packages

```bash
sudo dnf install package-name
sudo dnf install package1 package2  # Multiple packages
sudo dnf install -y package-name   # Auto-confirm
```

**Real examples**:
```bash
sudo dnf install nginx
sudo dnf install httpd mysql-server
sudo dnf install -y git vim curl
```

**My take**: `dnf install` is what you'll use. Simple. Works.

### Remove Packages

```bash
sudo dnf remove package-name
sudo dnf remove --noautoremove package-name  # Keep dependencies
```

**My take**: `dnf remove` removes packages. Use it.

### Search Packages

```bash
dnf search keyword
dnf search "web server"
```

**My take**: Search when you don't know the exact package name.

### Show Package Info

```bash
dnf info package-name
```

**My take**: Use this before installing. See what you're getting.

## YUM: The Legacy Tool

### Basic Commands

```bash
sudo yum install package-name
sudo yum update
sudo yum remove package-name
sudo yum search keyword
```

**My take**: YUM works. But DNF is better. Use DNF if available.

## Common Patterns

### Update System

```bash
sudo dnf update
```

### Install Development Tools

```bash
sudo dnf groupinstall "Development Tools"
```

### Clean Up

```bash
sudo dnf clean all                 # Clean cache
sudo dnf autoremove                # Remove unused packages
```

## Differences from APT

**APT (Debian/Ubuntu)**:
- `apt update` then `apt upgrade`
- `apt install`
- `apt remove`

**DNF (RHEL/CentOS)**:
- `dnf update` (does both)
- `dnf install`
- `dnf remove`

**My take**: Similar concepts. Different commands. Learn both.

## Common Mistakes (I've Made These)

1. **Using YUM when DNF available**: DNF is better. Use it.

2. **Not updating first**: Update before installing. Get latest versions.

3. **Forgetting sudo**: Package management needs root. Use sudo.

4. **Not cleaning cache**: Cache grows. Clean it occasionally.

5. **Removing wrong packages**: Be careful. Don't remove system packages.

## Real-World Examples

### Install Web Server

```bash
sudo dnf install httpd
sudo systemctl start httpd
sudo systemctl enable httpd
```

### Install Development Tools

```bash
sudo dnf groupinstall "Development Tools"
```

## What's Next?

Now that you understand DNF, let's talk about [Snap and Flatpak](/docs/linux/package-management/snap-flatpak) for modern packages.

---

> **Personal note**: I learned YUM first. Then DNF came. Now I use DNF. It's faster. It's better. Learn DNF.


