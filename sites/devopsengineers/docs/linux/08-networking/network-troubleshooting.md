---
sidebar_position: 3
title: "Network Troubleshooting: Fixing Connectivity"
---

# Network Troubleshooting: Fix Connection Problems

Networks break. Connections fail. You need to fix them.

**Here's the thing: Network troubleshooting is systematic. Check one thing at a time. Find the problem.**

## Basic Checks

### Check Interface Status

```bash
ip link show
ip addr show
```

**My take**: Check if interface is up. Check if it has an IP. Start here.

### Test Connectivity

```bash
ping 8.8.8.8                      # Test internet
ping google.com                   # Test DNS
ping 192.168.1.1                  # Test gateway
```

**My take**: `ping` tests connectivity. Use it to isolate problems.

## Troubleshooting Steps

### 1. Check Interface

```bash
ip link show
# Is it UP?
```

**My take**: Interface must be UP. If DOWN, bring it up.

### 2. Check IP Address

```bash
ip addr show
# Does it have an IP?
```

**My take**: Interface needs an IP. If missing, configure it.

### 3. Check Gateway

```bash
ip route show
# Is default route set?
```

**My take**: Gateway is needed for external access. Check it.

### 4. Test Local Network

```bash
ping 192.168.1.1                  # Gateway
ping 192.168.1.100               # Another host
```

**My take**: Test local network first. Then test internet.

### 5. Test DNS

```bash
nslookup google.com
dig google.com
```

**My take**: DNS must work for names. Test it.

## Common Tools

### ping: Test Connectivity

```bash
ping -c 4 8.8.8.8                # 4 packets
ping -c 4 google.com              # Test DNS too
```

**My take**: `ping` is basic. Use it first.

### traceroute: Trace Path

```bash
traceroute google.com
tracepath google.com              # Alternative
```

**My take**: `traceroute` shows the path. Useful for finding where it breaks.

### netstat/ss: View Connections

```bash
ss -tlnp                          # Listening ports
ss -tn                            # Active connections
netstat -tlnp                     # Legacy
```

**My take**: `ss` is modern. `netstat` is legacy. Use `ss`.

### tcpdump: Packet Capture

```bash
sudo tcpdump -i eth0
sudo tcpdump -i eth0 port 80
```

**My take**: `tcpdump` captures packets. Advanced. Use when needed.

## Common Problems

### No IP Address

```bash
# Check DHCP
sudo dhclient eth0

# Or set static
sudo ip addr add 192.168.1.100/24 dev eth0
```

**My take**: No IP = no network. Get an IP.

### Can't Reach Gateway

```bash
# Check gateway
ip route show

# Add gateway
sudo ip route add default via 192.168.1.1
```

**My take**: Gateway is needed. Set it.

### DNS Not Working

```bash
# Check DNS
cat /etc/resolv.conf

# Test DNS
nslookup google.com
```

**My take**: DNS must work. Check configuration.

## Common Mistakes (I've Made These)

1. **Not checking interface status**: Interface must be UP. Check first.

2. **Skipping steps**: Troubleshoot systematically. Don't skip steps.

3. **Not testing locally first**: Test local network before testing internet.

4. **Ignoring DNS**: DNS problems look like connectivity problems. Check DNS.

5. **Not checking firewall**: Firewalls can block. Check them.

## Real-World Examples

### Debug Network Issue

```bash
# 1. Check interface
ip link show

# 2. Check IP
ip addr show

# 3. Test gateway
ping 192.168.1.1

# 4. Test internet
ping 8.8.8.8

# 5. Test DNS
ping google.com
```

### Find Network Problems

```bash
# Check routing
ip route show

# Check DNS
cat /etc/resolv.conf

# Test connectivity
ping -c 4 8.8.8.8
traceroute google.com
```

## What's Next?

Now that you can troubleshoot networks, let's talk about [Firewall iptables](/docs/linux/networking/firewall-iptables) to secure networks.

---

> **Personal note**: Network problems used to frustrate me. Then I learned systematic troubleshooting. Now I check one thing at a time. Find the problem. Fix it. It's methodical.


