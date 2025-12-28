---
sidebar_position: 6
title: ""SSH: Secure Remote Access""
---

# SSH: Access Servers from Anywhere

SSH is how you connect to Linux servers remotely. It's encrypted. It's secure. It's essential.

**Here's the thing: You'll SSH into servers constantly. Learn it well.**

## What SSH Actually Does

SSH (Secure Shell) gives you encrypted remote access. You can:
- Run commands on remote servers
- Transfer files securely
- Tunnel traffic
- Access servers from anywhere

**That's it. But that's everything.**

## Basic Connection

```bash
ssh username@hostname
ssh username@192.168.1.100       # With IP
ssh -p 2222 username@hostname    # Custom port
```

**Real examples**:
```bash
ssh ubuntu@54.123.45.67
ssh -p 2222 admin@server.example.com
```

**The format**: `ssh user@host`. Simple.

**Exiting**: Type `exit` or press `Ctrl+D`. That's it.

## Running Commands Remotely

```bash
ssh user@host "command"
```

**Real examples**:
```bash
ssh ubuntu@server "df -h"        # Check disk usage
ssh ubuntu@server "sudo systemctl status nginx"
```

**My take**: Useful for quick commands. Don't need to log in fully.

## SSH Keys (The Right Way)

Passwords are annoying. Keys are better.

**Why keys**:
- More secure
- No password typing
- Required for automation
- Works with CI/CD

**My take**: Use keys. Always. Passwords are for beginners.

## Generating Keys

```bash
ssh-keygen -t ed25519            # Modern (recommended)
ssh-keygen -t rsa -b 4096        # RSA (older, but works)
```

**With email**:
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

**Files created**:
- `~/.ssh/id_ed25519` = Private key (keep secret!)
- `~/.ssh/id_ed25519.pub` = Public key (share this)

**My take**: Use ed25519. It's modern. It's secure. RSA works, but ed25519 is better.

## Copying Key to Server

```bash
# Easy way
ssh-copy-id username@hostname

# Manual way
cat ~/.ssh/id_ed25519.pub | ssh username@hostname "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"
```

**The easy way**: `ssh-copy-id` does everything. Use it.

**The manual way**: Copy the public key, add it to `~/.ssh/authorized_keys` on the server.

**My take**: Use `ssh-copy-id`. It's easier. Less error-prone.

## Testing Keys

```bash
ssh username@hostname
```

If it works without a password, keys are set up correctly.

**My take**: Test it. Make sure it works. Then you're set.

## SSH Config (Make Life Easier)

Create `~/.ssh/config`:

```
Host myserver
    HostName 54.123.45.67
    User ubuntu
    Port 22
    IdentityFile ~/.ssh/id_ed25519
```

**Then connect**:
```bash
ssh myserver                     # Instead of ssh ubuntu@54.123.45.67
```

**My take**: Use SSH config. Saves typing. Makes life easier.

## Common Options

```bash
ssh -v user@host                 # Verbose (debugging)
ssh -X user@host                 # X11 forwarding
ssh -L 8080:localhost:80 user@host  # Port forwarding
```

**My take**: You'll rarely use these. But they're useful when you need them.

## SCP: Copy Files Over SSH

```bash
# Copy to server
scp file.txt user@host:/path/

# Copy from server
scp user@host:/path/file.txt ./

# Copy directory
scp -r directory/ user@host:/path/
```

**Real examples**:
```bash
scp config.txt ubuntu@server:/etc/nginx/
scp ubuntu@server:/var/log/nginx/access.log ./
```

**My take**: SCP is simple. Use it for file transfers.

## SFTP: Interactive File Transfer

```bash
sftp user@host
```

**Commands**:
- `put file.txt` - Upload
- `get file.txt` - Download
- `ls` - List remote
- `lls` - List local
- `exit` - Quit

**My take**: SCP is easier for single files. SFTP is better for multiple files.

## SSH Tunneling (Port Forwarding)

```bash
# Local forwarding
ssh -L 8080:localhost:80 user@host

# Remote forwarding
ssh -R 8080:localhost:80 user@host
```

**What it does**: Forwards ports through SSH. Useful for accessing services.

**My take**: Advanced. You'll use it rarely. But useful when you need it.

## Security Best Practices

### Disable Password Authentication

Edit `/etc/ssh/sshd_config`:
```
PasswordAuthentication no
```

**My take**: Once keys work, disable passwords. More secure.

### Change Default Port

Edit `/etc/ssh/sshd_config`:
```
Port 2222
```

**My take**: Reduces automated attacks. Not essential, but helps.

### Disable Root Login

Edit `/etc/ssh/sshd_config`:
```
PermitRootLogin no
```

**My take**: Always do this. Root shouldn't SSH directly.

## Common Mistakes (I've Made These)

1. **Wrong key permissions**: Private keys should be 600. `chmod 600 ~/.ssh/id_ed25519`

2. **Forgetting to restart SSH**: After changing config, restart: `sudo systemctl restart sshd`

3. **Wrong username**: Make sure you're using the right username. `ubuntu` on Ubuntu, `ec2-user` on Amazon Linux, etc.

4. **Firewall blocking**: Make sure port 22 (or your custom port) is open.

5. **Key in wrong place**: Public key goes in `~/.ssh/authorized_keys` on the server, not locally.

## What's Next?

Now that you can SSH into servers, you can manage them remotely. Or learn about [Networking Fundamentals](/docs/linux/networking/network-fundamentals) to understand how networks work.

---

> **Personal note**: When I started, I'd type passwords constantly. Then I learned SSH keys. Now I never type passwords. Keys are the way. Learn them. Use them. Your future self will thank you.
