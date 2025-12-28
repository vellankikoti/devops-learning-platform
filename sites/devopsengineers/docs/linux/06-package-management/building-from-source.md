---
sidebar_position: 5
title: "Building From Source: Compiling Software"
---

# Building From Source: When Packages Aren't Available

Sometimes you need to compile from source. When packages aren't available. Or you need a specific version.

**Here's the thing: Compiling from source is a last resort. Use packages when possible. But sometimes you need to compile.**

## When to Build From Source

**Build from source when**:
- Package not available
- Need specific version
- Need custom configuration
- Development/testing

**Use packages when**:
- Available in repos
- Standard version works
- Don't need customization

**My take**: Use packages first. Compile only when necessary.

## The Build Process

### 1. Install Build Tools

```bash
# Debian/Ubuntu
sudo apt install build-essential

# RHEL/CentOS
sudo dnf groupinstall "Development Tools"
```

**My take**: Build tools are essential. Install them first.

### 2. Get Source Code

```bash
# Download tarball
wget https://example.com/software.tar.gz
tar -xzf software.tar.gz
cd software/

# Or clone from Git
git clone https://github.com/user/software.git
cd software/
```

**My take**: Get source code. Extract it. Navigate to it.

### 3. Configure

```bash
./configure
# Or
./configure --prefix=/usr/local
```

**My take**: Configure sets up the build. Use options if needed.

### 4. Build

```bash
make
```

**My take**: `make` compiles the software. Takes time.

### 5. Install

```bash
sudo make install
```

**My take**: `make install` installs the software. Needs root.

## Common Build Patterns

### Standard Build

```bash
./configure
make
sudo make install
```

### Custom Prefix

```bash
./configure --prefix=/opt/software
make
sudo make install
```

**My take**: Custom prefix installs to specific location. Useful for organization.

### Check Dependencies

```bash
./configure
# Shows missing dependencies
```

**My take**: Configure shows what's missing. Install dependencies first.

## Common Mistakes (I've Made These)

1. **Missing dependencies**: Install build tools and dependencies first.

2. **Wrong directory**: Make sure you're in the source directory.

3. **Not reading README**: README has instructions. Read it.

4. **Skipping configure**: Always run configure first. It sets up the build.

5. **Not checking version**: Make sure you have the right version. Check requirements.

## Real-World Examples

### Build From Tarball

```bash
wget https://example.com/software-1.0.tar.gz
tar -xzf software-1.0.tar.gz
cd software-1.0/
./configure
make
sudo make install
```

### Build From Git

```bash
git clone https://github.com/user/software.git
cd software/
./autogen.sh                    # If needed
./configure
make
sudo make install
```

## What's Next?

Now that you understand building from source, you can install anything. Or review [Package Management](/docs/linux/package-management/package-managers-overview) to use packages.

---

> **Personal note**: I used to compile everything from source. Then I learned package managers. Now I compile only when necessary. Packages are easier. Use them.

