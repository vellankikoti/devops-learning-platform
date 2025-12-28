---
sidebar_position: 1
title: Network Fundamentals
---

# Networking: Connecting Systems

Networking is how systems talk to each other. IP addresses. Ports. Protocols.

**Here's the thing: Understanding networking is essential. Servers communicate. Services listen. Everything connects.**

## The Basic Concept

**IP addresses** = Where systems are
**Ports** = Which service
**Protocols** = How they talk

**Think of it like mail**: IP is the address. Port is the apartment number. Protocol is the language.

## Network Interfaces

### View Interfaces

```bash
ip addr show                      # All interfaces (modern)
ifconfig                          # All interfaces (legacy)
```

**Common interfaces**:
- **eth0, eth1** = Ethernet
- **wlan0** = Wireless
- **lo** = Loopback (localhost)
- **docker0** = Docker bridge

**My take**: Use `ip addr`. It's modern. `ifconfig` is legacy.

### Interface States

```bash
ip link show
```

**States**: UP = active, DOWN = inactive.

**My take**: Interfaces need to be UP to work. Check if they're UP.

## IP Addresses

### Understanding IPs

**IPv4 format**: `192.168.1.100/24`
- **192.168.1.100** = IP address
- **/24** = Subnet mask

**Private ranges**:
- **10.0.0.0/8** = Large networks
- **172.16.0.0/12** = Medium networks
- **192.168.0.0/16** = Small networks (home/office)

**My take**: Private IPs are internal. Public IPs are internet. Most servers use private IPs.

### View IP Configuration

```bash
ip addr show                      # All interfaces
ip addr show eth0                 # Specific interface
hostname -I                       # All IPs
```

**My take**: `ip addr` shows IPs. Use it to see network configuration.

## Ports

### Understanding Ports

**Ports identify services**:
- **22** = SSH
- **80** = HTTP
- **443** = HTTPS
- **3306** = MySQL
- **5432** = PostgreSQL

**My take**: Ports are like apartment numbers. Each service has a port.

### View Listening Ports

```bash
ss -tlnp                          # Listening ports (modern)
netstat -tlnp                      # Listening ports (legacy)
```

**My take**: Use `ss`. It's modern. `netstat` is legacy.

**Real example**:
```bash
$ ss -tlnp
State   Recv-Q  Send-Q  Local Address:Port  Peer Address:Port
LISTEN  0       128     0.0.0.0:22          0.0.0.0:*
LISTEN  0       128     0.0.0.0:80          0.0.0.0:*
```

Port 22 (SSH) and port 80 (HTTP) are listening.

## Testing Connectivity

### ping: Test Connection

```bash
ping hostname
ping 8.8.8.8                      # Google DNS
ping -c 4 hostname                 # 4 packets
```

**What it does**: Tests if host is reachable.

**My take**: `ping` is basic connectivity test. Use it to check if things are reachable.

### Test Ports

```bash
telnet hostname 22                 # Test port 22
nc -zv hostname 22                 # Test port 22 (netcat)
```

**My take**: Test if ports are open. Useful for troubleshooting.

## Common Network Commands

### hostname

```bash
hostname                           # Show hostname
hostname -I                        # Show IPs
sudo hostnamectl set-hostname newname  # Change hostname
```

### route

```bash
ip route show                      # Show routing table
```

**My take**: Routing table shows how traffic is routed. Usually you don't need to change it.

## Common Patterns

### Check Network

```bash
ip addr show
ping 8.8.8.8
ss -tlnp
```

### Troubleshoot Connection

```bash
ping hostname                      # Can you reach it?
ss -tlnp | grep 22                 # Is SSH listening?
```

## Common Mistakes (I've Made These)

1. **Not checking if interface is UP**: Interfaces need to be UP. Check with `ip link`.

2. **Wrong IP address**: Make sure you're using the right IP. Check with `ip addr`.

3. **Port not listening**: Services need to listen on ports. Check with `ss -tlnp`.

4. **Firewall blocking**: Firewalls can block ports. Check firewall rules.

5. **Wrong network**: Make sure you're on the right network. Check routing.

## Real-World Examples

### Check Network Configuration

```bash
ip addr show
ip route show
hostname -I
```

### Test Connectivity

```bash
ping 8.8.8.8
ping google.com
```

### Check Listening Ports

```bash
ss -tlnp | grep nginx
```

## What's Next?

Now that you understand networking basics, let's talk about [SSH](/docs/linux/networking/ssh-configuration) for remote access.

---

> **Personal note**: When I started, networking was confusing. IPs. Ports. Protocols. Then I learned the basics. Now it makes sense. Networking is just connections. Learn the basics. The rest follows.
