---
sidebar_position: 2
title: "IP Configuration: Setting Up Networks"
---

# IP Configuration: Configure Network Interfaces

IP configuration sets up network interfaces. Assign IPs. Configure routing.

**Here's the thing: IP configuration is essential. Learn it. You'll configure networks constantly.**

## Modern Tools: ip Command

### View Configuration

```bash
ip addr show                       # All interfaces
ip addr show eth0                 # Specific interface
ip link show                      # Link status
```

**My take**: Use `ip` command. It's modern. `ifconfig` is legacy.

### Configure IP Address

```bash
# Add IP address
sudo ip addr add 192.168.1.100/24 dev eth0

# Remove IP address
sudo ip addr del 192.168.1.100/24 dev eth0

# Flush all addresses
sudo ip addr flush dev eth0
```

**My take**: `ip addr` manages IP addresses. Use it.

### Bring Interface Up/Down

```bash
sudo ip link set eth0 up          # Bring up
sudo ip link set eth0 down        # Bring down
```

**My take**: Interfaces need to be up to work. Check status.

## Legacy Tools: ifconfig

### View Configuration

```bash
ifconfig                           # All interfaces
ifconfig eth0                      # Specific interface
```

**My take**: `ifconfig` works. But `ip` is better. Use `ip`.

### Configure IP

```bash
sudo ifconfig eth0 192.168.1.100 netmask 255.255.255.0
sudo ifconfig eth0 up
```

**My take**: `ifconfig` is legacy. Use `ip` instead.

## NetworkManager: GUI Tool

### nmcli Commands

```bash
# List connections
nmcli connection show

# Show active
nmcli connection show --active

# Add connection
sudo nmcli connection add type ethernet con-name myconnection ifname eth0

# Set IP
sudo nmcli connection modify myconnection ipv4.addresses 192.168.1.100/24
sudo nmcli connection modify myconnection ipv4.method manual

# Activate
sudo nmcli connection up myconnection
```

**My take**: `nmcli` is NetworkManager's CLI. Useful for complex setups.

## Persistent Configuration

### /etc/netplan/ (Ubuntu 18+)

```yaml
# /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    eth0:
      dhcp4: true
      # Or static:
      # addresses:
      #   - 192.168.1.100/24
      # gateway4: 192.168.1.1
      # nameservers:
      #   addresses: [8.8.8.8, 8.8.4.4]
```

**Apply**:
```bash
sudo netplan apply
```

**My take**: Netplan is Ubuntu's new way. Use it on Ubuntu.

### /etc/network/interfaces (Debian)

```bash
# /etc/network/interfaces
auto eth0
iface eth0 inet static
    address 192.168.1.100
    netmask 255.255.255.0
    gateway 192.168.1.1
    dns-nameservers 8.8.8.8 8.8.4.4
```

**My take**: Traditional Debian way. Still works.

## Common Patterns

### Static IP Configuration

```bash
# Using ip (temporary)
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ip link set eth0 up
sudo ip route add default via 192.168.1.1
```

### DHCP Configuration

```bash
# Using dhclient
sudo dhclient eth0
```

**My take**: DHCP is easier. Use it when possible.

## Common Mistakes (I've Made These)

1. **Not bringing interface up**: Interfaces need to be up. Check with `ip link`.

2. **Wrong subnet mask**: Subnet mask must match network. Check it.

3. **No default gateway**: Without gateway, no internet. Set it.

4. **Not making persistent**: Temporary changes are lost on reboot. Make them persistent.

5. **Wrong interface name**: Interface names matter. Check with `ip link`.

## Real-World Examples

### Configure Static IP

```bash
# Temporary
sudo ip addr add 192.168.1.100/24 dev eth0
sudo ip link set eth0 up
sudo ip route add default via 192.168.1.1

# Persistent (Ubuntu)
sudo vim /etc/netplan/01-netcfg.yaml
sudo netplan apply
```

## What's Next?

Now that you can configure IPs, let's talk about [Network Troubleshooting](/docs/linux/networking/network-troubleshooting) when networks don't work.

---

> **Personal note**: When I started, I'd use `ifconfig`. Then I learned `ip`. Now I use `ip` for everything. It's better. Learn it.


