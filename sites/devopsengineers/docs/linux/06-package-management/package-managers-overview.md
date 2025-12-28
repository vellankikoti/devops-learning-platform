---
sidebar_position: 1
title: Package Managers Overview
---

# Package Managers: Installing Software

Package managers install software. Update it. Remove it. They handle dependencies.

**Here's the thing: Package managers make Linux easy. Learn them. Use them.**

## What Package Managers Do

Package managers:
- Install software
- Update software
- Remove software
- Handle dependencies (software that other software needs)

**My take**: Package managers are like app stores. But better. They handle everything.

## Common Package Managers

### APT (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install package-name
sudo apt upgrade
```

**My take**: APT is for Debian/Ubuntu. Most common. Learn it.

### YUM/DNF (RHEL/CentOS)

```bash
sudo yum install package-name      # Old
sudo dnf install package-name      # New
```

**My take**: DNF is the new YUM. Use DNF on newer systems.

### Snap/Flatpak

```bash
sudo snap install package-name
flatpak install package-name
```

**My take**: Snap and Flatpak are modern. Universal packages. Use them when available.

## Why Use Package Managers

**Benefits**:
- Easy installation
- Dependency handling
- Updates
- Security patches
- Uninstallation

**My take**: Always use package managers. Don't compile from source unless you have to.

## Common Patterns

### Update System

```bash
# Debian/Ubuntu
sudo apt update && sudo apt upgrade

# RHEL/CentOS
sudo dnf update
```

### Install Software

```bash
# Debian/Ubuntu
sudo apt install nginx

# RHEL/CentOS
sudo dnf install nginx
```

## What's Next?

Now that you understand package managers, let's talk about [APT](/docs/linux/package-management/apt-debian-ubuntu) for Debian/Ubuntu.

---

> **Personal note**: When I started, I'd compile from source. Then I learned package managers. Now I use them for everything. They're easier. They're better. Use them.

