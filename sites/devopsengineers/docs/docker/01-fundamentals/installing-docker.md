---
sidebar_position: 3
title: Installing Docker
---

# Installing Docker: Getting Started

**Installing Docker should be simple. And it is. But there are different ways to do it, and choosing the right one matters. Let me show you how.**

## 🎯 The Big Picture

Think of installing Docker like buying a car. You can buy new (Docker Desktop). You can buy used (package managers). You can build from scratch (source). All get you there. But the experience is different.

**Most people should use Docker Desktop (new). It's the easiest. It just works.**

## Installation Options

You have three main options:

1. **Docker Desktop** (Recommended for beginners)
   - GUI application
   - Includes Docker Engine, CLI, and Compose
   - Works on Windows, macOS, and Linux
   - Easiest to install and use

2. **Package Managers** (Recommended for servers)
   - apt, yum, brew, etc.
   - Command-line only
   - More control
   - Better for production servers

3. **From Source** (Advanced)
   - Building from source code
   - Maximum control
   - For developers contributing to Docker

**For most people: Use Docker Desktop. It's the fastest way to get started.**

## Installing Docker Desktop

### macOS

1. **Download Docker Desktop**
   ```bash
   # Visit: https://www.docker.com/products/docker-desktop
   # Or use Homebrew:
   brew install --cask docker
   ```

2. **Open Docker Desktop**
   - Launch from Applications
   - Follow the setup wizard
   - Docker will start automatically

3. **Verify Installation**
   ```bash
   docker --version
   docker run hello-world
   ```

**That's it. Docker is installed.**

### Windows

1. **Download Docker Desktop**
   - Visit: https://www.docker.com/products/docker-desktop
   - Download Docker Desktop for Windows
   - Run the installer

2. **Enable WSL 2** (Recommended)
   - Docker Desktop will prompt you
   - WSL 2 provides better performance
   - Follow the setup wizard

3. **Verify Installation**
   ```powershell
   docker --version
   docker run hello-world
   ```

**That's it. Docker is installed.**

### Linux (Ubuntu/Debian)

**Using Package Manager (Recommended):**

```bash
# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group (optional, to run without sudo)
sudo usermod -aG docker $USER
# Log out and back in for this to take effect
```

**Verify Installation:**
```bash
docker --version
sudo docker run hello-world
```

## Post-Installation Steps

### 1. Verify Docker is Running

```bash
docker info
```

You should see Docker system information. If you get an error, Docker isn't running.

### 2. Test with Hello World

```bash
docker run hello-world
```

You should see:
```
Hello from Docker!
This message shows that your installation appears to be working correctly.
```

### 3. Check Docker Compose

```bash
docker compose version
```

Docker Compose should be installed with Docker Desktop.

## Common Installation Issues

### Issue: "Cannot connect to Docker daemon"

**Solution:**
- Make sure Docker Desktop is running (macOS/Windows)
- On Linux: `sudo systemctl start docker`
- Check permissions: `sudo usermod -aG docker $USER` (then log out/in)

### Issue: "Permission denied"

**Solution:**
- On Linux: Add user to docker group: `sudo usermod -aG docker $USER`
- Or use `sudo` (not recommended for daily use)

### Issue: "Docker Desktop won't start"

**Solution:**
- Check system requirements (RAM, virtualization enabled)
- Restart Docker Desktop
- Check logs in Docker Desktop settings

### Issue: "WSL 2 required" (Windows)

**Solution:**
- Install WSL 2: `wsl --install`
- Enable virtualization in BIOS
- Update Windows

## My Take: Installation Recommendations

**For beginners:** Use Docker Desktop. It's the easiest. It just works.

**For production servers:** Use package managers. More control. Better for automation.

**For developers:** Use Docker Desktop for local development. Use package managers for CI/CD.

**The key?** Start simple. Use Docker Desktop. Learn Docker. Then optimize later.

## Memory Tip: The Car Analogy

- **Docker Desktop**: Buying a new car
  - Everything included
  - Easy to use
  - Just works

- **Package Manager**: Buying a used car
  - More control
  - Need to know what you're doing
  - Can customize

- **From Source**: Building a car
  - Maximum control
  - For experts only
  - Time-consuming

## Key Takeaways

1. **Docker Desktop is easiest** - Recommended for beginners
2. **Package managers for servers** - Better for production
3. **Verify installation** - Always test with `hello-world`
4. **Common issues are fixable** - Usually permissions or Docker not running
5. **Start simple** - Use Docker Desktop, optimize later

## What's Next?

Now that Docker is installed, let's understand how it works. Next: [Docker Architecture](/docs/docker/01-fundamentals/docker-architecture).

---

> **Remember**: Installation is just the beginning. The real learning starts when you use Docker.

