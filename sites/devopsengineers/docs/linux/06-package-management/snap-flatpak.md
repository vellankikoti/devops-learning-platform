---
sidebar_position: 4
title: "Snap And Flatpak: Modern Package Formats"
---

# Snap and Flatpak: Universal Packages

Snap and Flatpak are modern package formats. They work across distributions.

**Here's the thing: These are universal packages. Install once. Works everywhere.**

## Snap

### Install Snap

```bash
# Ubuntu (usually pre-installed)
sudo snap install package-name

# Other distributions
sudo dnf install snapd              # RHEL/CentOS
```

**My take**: Snap is Canonical's format. Works on many distributions.

### Common Snap Commands

```bash
snap install package-name           # Install
snap remove package-name            # Remove
snap list                           # List installed
snap refresh                       # Update all
snap info package-name              # Package info
```

**Real examples**:
```bash
sudo snap install code              # VS Code
sudo snap install docker
sudo snap install kubectl
```

**My take**: Snap packages are self-contained. Include dependencies.

## Flatpak

### Install Flatpak

```bash
# Ubuntu/Debian
sudo apt install flatpak

# RHEL/CentOS
sudo dnf install flatpak
```

### Add Repositories

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

**My take**: Flatpak needs repositories. Add Flathub. It's the main one.

### Common Flatpak Commands

```bash
flatpak install package-name       # Install
flatpak uninstall package-name      # Remove
flatpak list                       # List installed
flatpak update                     # Update all
flatpak info package-name          # Package info
```

**Real examples**:
```bash
flatpak install flathub org.gimp.GIMP
flatpak install flathub com.spotify.Client
```

**My take**: Flatpak packages are sandboxed. More secure.

## When to Use

**Use Snap/Flatpak when**:
- Package not in distribution repos
- Need latest version
- Want universal packages
- Need sandboxing

**Use distribution packages when**:
- Available in repos
- Want system integration
- Prefer traditional packages

**My take**: Use distribution packages first. Use Snap/Flatpak when needed.

## Common Mistakes (I've Made These)

1. **Not adding Flatpak repo**: Flatpak needs repositories. Add them first.

2. **Too many package formats**: Stick to one or two. Don't mix too many.

3. **Not updating**: Snap and Flatpak update separately. Update them.

4. **Disk space**: Snap packages can be large. Monitor disk usage.

5. **Permissions**: Sandboxed apps have limited permissions. Understand them.

## Real-World Examples

### Install VS Code with Snap

```bash
sudo snap install code --classic
```

### Install GIMP with Flatpak

```bash
flatpak install flathub org.gimp.GIMP
```

## What's Next?

Now that you understand modern packages, let's talk about [Building From Source](/docs/linux/package-management/building-from-source) when packages aren't available.

---

> **Personal note**: I avoided Snap and Flatpak at first. Then I needed a package. Now I use them when needed. They're useful. Learn them.


