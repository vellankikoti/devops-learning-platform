---
sidebar_position: 2
title: APT Package Management (Debian/Ubuntu)
---

# APT: Installing Software the Easy Way

APT is how you install software on Debian and Ubuntu. It's simple. It works. Learn it.

**Here's the thing: You'll install software constantly. APT makes it easy.**

## What APT Actually Does

APT manages software packages. It:
- Installs software
- Updates software
- Removes software
- Handles dependencies (software that other software needs)

**That's it. But that's everything.**

## The Commands You'll Actually Use

### Update Package List

```bash
sudo apt update
```

**What it does**: Refreshes the list of available packages. Like updating a catalog.

**When to use**: Before installing or upgrading. Always run this first.

**My take**: Run `apt update` before installing anything. It ensures you get the latest versions.

### Install Packages

```bash
sudo apt install package-name
sudo apt install package1 package2 package3  # Multiple
sudo apt install -y package-name            # Auto-confirm
```

**Real examples**:
```bash
sudo apt install nginx
sudo apt install python3 python3-pip
sudo apt install -y curl wget git
```

**The `-y` flag**: Auto-confirms. Useful in scripts. Saves typing.

**My take**: `apt install` is what you'll use most. Simple. Works.

### Upgrade Packages

```bash
sudo apt upgrade                  # Upgrade all
sudo apt upgrade package-name     # Upgrade specific
```

**What it does**: Upgrades installed packages to latest versions.

**When to use**: After `apt update`. Keeps your system updated.

**My take**: Run `apt update && apt upgrade` regularly. Keeps things current.

### Remove Packages

```bash
sudo apt remove package-name      # Remove (keeps config)
sudo apt remove --purge package-name  # Remove with config
```

**The difference**: `remove` keeps configuration files. `--purge` removes everything.

**My take**: Use `remove` normally. Use `--purge` when you want to completely remove something.

### Search Packages

```bash
apt search keyword
apt search "web server"
```

**What it does**: Searches for packages.

**Real example**:
```bash
$ apt search nginx
nginx/bionic 1.14.0-0ubuntu1.7 amd64
  small, powerful, scalable web/proxy server
```

**My take**: Use this when you don't know the exact package name.

### Show Package Info

```bash
apt show package-name
```

**What it does**: Shows information about a package.

**Real example**:
```bash
$ apt show nginx
Package: nginx
Version: 1.14.0
Description: small, powerful, scalable web/proxy server
...
```

**My take**: Use this before installing. See what you're getting.

### List Installed Packages

```bash
apt list --installed
apt list --installed | grep nginx
```

**What it does**: Shows installed packages.

**My take**: Useful for seeing what's installed. Or checking if something is installed.

### Clean Up

```bash
sudo apt autoremove               # Remove unused packages
sudo apt autoclean                # Clean package cache
```

**What they do**: `autoremove` removes packages that were installed as dependencies but aren't needed anymore. `autoclean` cleans the package cache.

**My take**: Run these occasionally. Frees up space.

## The Workflow

**Installing software**:
```bash
sudo apt update                   # Refresh list
sudo apt install package-name     # Install
```

**Updating system**:
```bash
sudo apt update                   # Refresh list
sudo apt upgrade                  # Upgrade everything
```

**Removing software**:
```bash
sudo apt remove package-name      # Remove
sudo apt autoremove               # Clean up
```

**That's the workflow. Simple.**

## Common Packages You'll Install

```bash
sudo apt install nginx            # Web server
sudo apt install mysql-server    # Database
sudo apt install docker.io       # Docker
sudo apt install git             # Version control
sudo apt install curl wget       # Download tools
sudo apt install vim nano        # Text editors
sudo apt install htop            # Process monitor
```

**These are the packages you'll actually install.** Web servers. Databases. Tools.

## Troubleshooting

### Package Not Found

```bash
sudo apt update                   # Refresh list first
```

**My take**: If package not found, run `apt update`. The list might be stale.

### Broken Dependencies

```bash
sudo apt --fix-broken install
```

**What it does**: Fixes broken dependencies.

**My take**: If installation fails, try this. It fixes dependency issues.

### Locked Package Manager

```bash
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
```

**What it does**: Removes locks if package manager is stuck.

**My take**: If `apt` is locked, remove the locks. Then try again.

## The Truth About APT

APT is simple. It works. It handles dependencies automatically.

**But here's the thing**: Sometimes it's slow. Sometimes packages conflict. Sometimes things break.

**My take**: APT is reliable. But things break. That's Linux. Fix it and move on.

## What's Next?

Now that you can install software, you're set. Or learn about [System Services](/docs/linux/system-services/systemd-overview) to manage what runs automatically.

---

> **Personal note**: When I started, I'd install packages without `apt update` first. Then I'd wonder why packages weren't found. Now I always run `apt update` first. It's a habit. A good habit.
