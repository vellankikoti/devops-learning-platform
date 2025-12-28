---
sidebar_position: 5
title: Command History And Efficiency
---

# Command History: Don't Retype Everything

Your terminal remembers everything you type. Use that memory.

**Here's the thing: History saves time. Reuse commands. Don't retype. Work faster.**

## Basic History

### View History

```bash
history                           # All commands
history | less                    # Page by page
history | grep "pattern"          # Search history
history | tail -20                # Last 20
```

**My take**: `history` shows what you've done. Search it. Reuse it.

### Navigate History

```bash
↑ (Up arrow)                      # Previous command
↓ (Down arrow)                    # Next command
Ctrl+R                            # Reverse search
```

**My take**: Arrow keys navigate. `Ctrl+R` searches. Use both.

## History Shortcuts

### Reuse Last Command

```bash
!!                                # Last command
```

**Real example**:
```bash
$ sudo apt update
$ !!                              # Runs: sudo apt update
```

**My take**: `!!` reruns last command. Useful when you forget sudo.

### Reuse by Number

```bash
!42                               # Command #42 from history
```

**My take**: Rarely used. But useful when you know the number.

### Reuse by Pattern

```bash
!git                              # Last command starting with "git"
!?pattern                         # Last command containing "pattern"
```

**Real example**:
```bash
$ git status
$ git commit -m "fix"
$ !git                            # Runs: git commit -m "fix"
```

**My take**: `!git` runs last git command. Useful for repeating similar commands.

### Fix Last Command

```bash
^old^new                          # Replace old with new
```

**Real example**:
```bash
$ sudo apt updte                  # Typo
$ ^updte^update                   # Fixes and runs: sudo apt update
```

**My take**: Fix typos quickly. `^old^new` is magic.

### Last Argument

```bash
!$                                # Last argument of previous command
```

**Real example**:
```bash
$ ls /var/log
$ cd !$                           # cd /var/log
```

**My take**: `!$` is the last argument. Useful for chaining commands.

## Ctrl+R: Reverse Search

```bash
Ctrl+R                            # Start search
# Type pattern
# Press Ctrl+R to find next
# Press Enter to run
```

**Real example**:
```bash
# Press Ctrl+R
# Type "nginx"
# Finds: sudo systemctl restart nginx
# Press Enter to run
```

**My take**: `Ctrl+R` is powerful. Search history interactively. Use it.

## Aliases: Your Own Shortcuts

```bash
alias ll='ls -la'
alias la='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
```

**Add to `~/.bashrc`**:
```bash
echo "alias ll='ls -la'" >> ~/.bashrc
source ~/.bashrc
```

**My take**: Create aliases for commands you use often. Saves typing.

## Common Aliases

```bash
alias ll='ls -la'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
```

**My take**: These are common. Use them. Or create your own.

## History Configuration

```bash
# In ~/.bashrc
HISTSIZE=10000                     # History size
HISTFILESIZE=20000                 # History file size
HISTCONTROL=ignoredups            # Ignore duplicates
HISTCONTROL=ignoreboth             # Ignore duplicates and commands starting with space
```

**My take**: Increase history size. Keep more commands. Useful.

## Common Mistakes (I've Made These)

1. **Not using history**: Retyping commands. Use history. Save time.

2. **Not using `Ctrl+R`**: Searching manually. Use `Ctrl+R`. It's faster.

3. **Not creating aliases**: Typing long commands. Create aliases. Save typing.

4. **Forgetting `!!`**: Retyping with sudo. Use `!!`. It's faster.

5. **Not configuring history**: Default size is small. Increase it.

## Real-World Examples

### Rerun with sudo

```bash
apt update                        # Forgot sudo
sudo !!                           # Runs: sudo apt update
```

### Fix Typo

```bash
sudo apt instll nginx             # Typo
^instll^install                   # Fixes: sudo apt install nginx
```

### Chain Commands

```bash
ls /var/log
cd !$                             # cd /var/log
```

## What's Next?

Now that you can use history, you work faster. Or learn about [Text Processing](/docs/linux/command-line-basics/text-processing) to work with files.

---

> **Personal note**: When I started, I'd retype everything. Then I learned history. Now I reuse commands constantly. History saves hours. Learn it. Use it.
