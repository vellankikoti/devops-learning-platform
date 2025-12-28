---
sidebar_position: 2
title: Installing Git
---

# Installing Git: Getting Started

**Before you can use Git, you need to install it. Here's how to get Git running on your system.**

## 🎯 The Big Picture

Installing Git is straightforward. But the setup after installation? That's where most people skip steps. Don't. Configure Git properly now, and you'll thank yourself later.

## Installation by Platform

### Linux (Ubuntu/Debian)

```bash
# Update package list
sudo apt update

# Install Git
sudo apt install git

# Verify installation
git --version
```

### Linux (RHEL/CentOS/Fedora)

```bash
# Using yum (older versions)
sudo yum install git

# Using dnf (newer versions)
sudo dnf install git

# Verify installation
git --version
```

### macOS

**Option 1: Using Homebrew (Recommended)**
```bash
# Install Homebrew if you don't have it
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git
brew install git

# Verify installation
git --version
```

**Option 2: Using Xcode Command Line Tools**
```bash
# This installs Git along with other developer tools
xcode-select --install
```

### Windows

**Option 1: Git for Windows (Recommended)**
1. Download from: https://git-scm.com/download/win
2. Run the installer
3. Use default options (they're good)
4. Verify in Command Prompt or PowerShell:
   ```cmd
   git --version
   ```

**Option 2: Using Chocolatey**
```powershell
choco install git
```

## Post-Installation Configuration

**This is critical. Don't skip this.**

### 1. Set Your Identity

Git needs to know who you are. This appears in every commit.

```bash
# Set your name
git config --global user.name "Your Name"

# Set your email
git config --global user.email "your.email@example.com"

# Verify
git config --global user.name
git config --global user.email
```

**Pro Tip**: Use the email associated with your GitHub/GitLab account. This links your commits to your profile.

### 2. Set Your Default Editor

Git needs an editor for commit messages. Choose one you're comfortable with.

```bash
# For VS Code
git config --global core.editor "code --wait"

# For vim
git config --global core.editor "vim"

# For nano
git config --global core.editor "nano"

# For Windows Notepad
git config --global core.editor "notepad"
```

### 3. Set Default Branch Name

Modern Git uses `main` instead of `master`. Set it as default:

```bash
git config --global init.defaultBranch main
```

### 4. Set Line Ending Handling

**Important for cross-platform work:**

```bash
# On Windows
git config --global core.autocrlf true

# On macOS/Linux
git config --global core.autocrlf input
```

This prevents line ending issues when working across platforms.

### 5. Enable Helpful Defaults

```bash
# Enable color output
git config --global color.ui auto

# Enable push.default (simple is safest)
git config --global push.default simple

# Enable pull.rebase (cleaner history)
git config --global pull.rebase false
```

## Verify Your Installation

Run these commands to verify everything works:

```bash
# Check Git version
git --version

# Check your configuration
git config --list --global

# Test Git is working
git init test-repo
cd test-repo
echo "# Test" > README.md
git add README.md
git commit -m "Test commit"
cd ..
rm -rf test-repo
```

If all commands succeed, you're ready!

## Common Issues and Fixes

### Issue: "git: command not found"

**Solution**: Git isn't in your PATH. Add it:
- **Linux/macOS**: Check installation path, add to PATH in `~/.bashrc` or `~/.zshrc`
- **Windows**: Restart terminal after installation

### Issue: "Permission denied" errors

**Solution**: Check file permissions and ownership:
```bash
# Check Git installation location
which git

# Verify permissions
ls -l $(which git)
```

### Issue: Wrong user name/email in commits

**Solution**: Update your Git config:
```bash
git config --global user.name "Correct Name"
git config --global user.email "correct@email.com"
```

## My Take: Configuration Matters

I've seen people skip configuration. They use Git for months with wrong settings. Then they realize their commits have the wrong email. Or they can't push because of line ending issues.

**Configure Git properly from the start. It takes 5 minutes. It saves hours later.**

## Memory Tip: The Setup Checklist

Remember: **Install → Configure → Verify**

1. **Install**: Get Git on your system
2. **Configure**: Set name, email, editor, defaults
3. **Verify**: Test that everything works

## Key Takeaways

1. **Install Git** - Use package manager or official installer
2. **Configure identity** - Set name and email (critical!)
3. **Set editor** - Choose an editor you know
4. **Set defaults** - Branch name, line endings, colors
5. **Verify** - Test that everything works

## What's Next?

Now that Git is installed and configured, let's create your first repository. Next: [Understanding Repositories](/docs/git-github/fundamentals/understanding-repositories).

---

> **Remember**: Configuration takes 5 minutes but saves hours. Do it right the first time.

