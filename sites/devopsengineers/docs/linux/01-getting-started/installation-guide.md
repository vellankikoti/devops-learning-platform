---
sidebar_position: 3
title: Installation Guide
---

# Installing Linux: Get It Running

You need Linux running to learn Linux. Here's how to get it.

**Here's the thing: You have options. Cloud. Virtual machine. Physical. Pick what works for you.**

## Three Options

### Option 1: Cloud (Recommended)

**Why**: Matches production. Learn cloud. Free tiers available.

**Best for**: DevOps learning. Cloud skills. Real environments.

**My take**: Start here. It's what you'll use in production anyway.

### Option 2: Virtual Machine

**Why**: Safe. Easy to reset. Try different distros.

**Best for**: Learning. Experimentation. Local development.

**My take**: Good for learning. Safe. Easy to reset.

### Option 3: Physical

**Why**: Full performance. Dedicated machine.

**Best for**: Advanced users. Dedicated Linux machine.

**My take**: Advanced. Only if you're committed.

## Cloud Installation (AWS EC2)

### Step 1: Create Account

1. Go to aws.amazon.com
2. Sign up (free tier available)
3. Verify account

**My take**: Free tier gives you 750 hours/month. Enough to learn.

### Step 2: Launch Instance

**Using Console**:
1. Go to EC2
2. Click "Launch Instance"
3. Choose:
   - **Name**: `linux-learning`
   - **AMI**: Ubuntu Server 22.04 LTS
   - **Instance type**: t2.micro (free tier)
   - **Key pair**: Create new
   - **Network**: Allow SSH (port 22)
4. Launch

**My take**: Ubuntu is easiest. t2.micro is free. Good for learning.

### Step 3: Connect

```bash
# Download key first, then:
chmod 400 your-key.pem
ssh -i your-key.pem ubuntu@your-instance-ip
```

**My take**: SSH is how you connect. Learn it. You'll use it constantly.

## Virtual Machine (VirtualBox)

### Step 1: Install VirtualBox

Download from virtualbox.org. Install it.

**My take**: VirtualBox is free. Works well. Good for learning.

### Step 2: Download Ubuntu ISO

Download Ubuntu Server ISO from ubuntu.com.

**My take**: Server edition is lighter. Good for learning Linux.

### Step 3: Create VM

1. Open VirtualBox
2. Click "New"
3. Set:
   - **Name**: `linux-learning`
   - **Type**: Linux
   - **Version**: Ubuntu (64-bit)
   - **Memory**: 2GB (minimum)
   - **Hard disk**: 20GB (minimum)
4. Create

### Step 4: Install Ubuntu

1. Start VM
2. Select Ubuntu ISO
3. Follow installer
4. Set username/password
5. Install

**My take**: Installation is straightforward. Follow the prompts.

## Post-Installation

### Update System

```bash
sudo apt update
sudo apt upgrade
```

**My take**: Always update after installation. Get latest packages.

### Install Basic Tools

```bash
sudo apt install -y vim curl wget git htop
```

**My take**: Install tools you'll use. These are essentials.

### Configure SSH (If Needed)

```bash
sudo systemctl enable ssh
sudo systemctl start ssh
```

**My take**: SSH lets you connect remotely. Enable it.

## Verification

```bash
uname -a                          # Check Linux version
lsb_release -a                     # Distribution info
whoami                             # Current user
```

**My take**: Verify installation works. Check basics.

## Common Issues

### Can't Connect via SSH

```bash
# Check if SSH is running
sudo systemctl status ssh

# Check firewall
sudo ufw status
```

**My take**: SSH issues are common. Check service. Check firewall.

### No Internet

```bash
# Check network
ip addr show
ping 8.8.8.8
```

**My take**: Network issues happen. Check configuration.

## What's Next?

Now that Linux is installed, let's start with [First Steps](/docs/linux/getting-started/first-steps). Learn the basics.

---

> **Personal note**: When I started, I installed Linux on a physical machine. It was hard. Then I tried cloud. Much easier. Now I use cloud for everything. It's what production uses anyway. Start with cloud.
