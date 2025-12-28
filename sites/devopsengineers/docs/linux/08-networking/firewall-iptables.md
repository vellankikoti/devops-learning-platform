---
sidebar_position: 4
title: "Firewall iptables: Basic Rules"
---

# iptables: Linux Firewall

iptables is Linux's firewall. It filters traffic. Blocks unwanted connections.

**Here's the thing: iptables is powerful. But complex. Learn basics. Use UFW if you can.**

## What iptables Does

iptables:
- Filters network traffic
- Blocks unwanted connections
- Allows specific traffic
- NAT (Network Address Translation)

**My take**: iptables is the firewall. Learn it. But use UFW if you can.

## Basic Concepts

### Chains

- **INPUT** = Incoming traffic
- **OUTPUT** = Outgoing traffic
- **FORWARD** = Forwarded traffic

**My take**: Three chains. INPUT is what you'll use most.

### Actions

- **ACCEPT** = Allow
- **DROP** = Block silently
- **REJECT** = Block with response

**My take**: ACCEPT allows. DROP blocks. Use DROP for security.

## Basic Rules

### View Rules

```bash
sudo iptables -L                  # List rules
sudo iptables -L -n              # Numeric (faster)
sudo iptables -L -v              # Verbose
```

**My take**: `iptables -L` shows rules. Use `-n` for speed.

### Allow Traffic

```bash
# Allow SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow HTTPS
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```

**My take**: `-A` appends. `-p` is protocol. `--dport` is destination port.

### Block Traffic

```bash
# Block all incoming (default)
sudo iptables -P INPUT DROP

# Block specific port
sudo iptables -A INPUT -p tcp --dport 8080 -j DROP
```

**My take**: `-P` sets policy. DROP blocks everything by default.

### Allow Loopback

```bash
sudo iptables -A INPUT -i lo -j ACCEPT
```

**My take**: Always allow loopback. System needs it.

## Common Ruleset

```bash
# Flush existing rules
sudo iptables -F

# Set default policies
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# Allow loopback
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow established connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP/HTTPS
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```

**My take**: This is a basic ruleset. Use it as a starting point.

## Save Rules

```bash
# Debian/Ubuntu
sudo iptables-save > /etc/iptables/rules.v4

# Or use iptables-persistent
sudo apt install iptables-persistent
sudo netfilter-persistent save
```

**My take**: Rules are lost on reboot. Save them.

## Common Mistakes (I've Made These)

1. **Locking yourself out**: Allow SSH before blocking everything. Always.

2. **Not saving rules**: Rules are lost on reboot. Save them.

3. **Wrong chain**: Use INPUT for incoming. OUTPUT for outgoing.

4. **Too restrictive**: Blocking everything breaks things. Be careful.

5. **Not testing**: Test rules. Make sure they work.

## Real-World Examples

### Basic Web Server Rules

```bash
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
sudo iptables -P INPUT DROP
```

## What's Next?

Now that you understand iptables, let's talk about [firewalld](/docs/linux/networking/firewall-firewalld) for RHEL/CentOS systems.

---

> **Personal note**: iptables seemed complex at first. Then I learned basics. Now I use it. But I prefer UFW for simplicity. Use what works for you.


