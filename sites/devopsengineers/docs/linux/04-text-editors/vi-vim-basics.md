---
sidebar_position: 1
title: "vi/vim Basics: Essential Editor Skills"
---

# vi/vim: The Editor You Can't Avoid

I avoided vim for years. I used nano. I used GUI editors. Then I had to edit a file on a server. Only vim was available. I panicked.

I learned vim in one afternoon. Out of necessity.

Now? I can't imagine using anything else.

**Here's the thing: vim is on every Linux system. Every single one. Learn it, or learn it when you're panicking at 2 AM. Your choice.**

## Why vim? (The Honest Answer)

**Because it's there.**

That's it. It's on every system. It works over slow connections. It works in terminals. It just works.

**Also**: Once you learn it, it's fast. Really fast. But that's a bonus. The main reason is: it's always there.

## The vim Modes (This Confuses Everyone)

vim has modes. This is what confuses people. But it's actually simple:

1. **Normal mode** - Navigate and give commands (default)
2. **Insert mode** - Type text (like a normal editor)
3. **Command mode** - Save, quit, search

**The key**: You're usually in Normal mode. Press `i` to enter Insert mode. Press `Esc` to go back to Normal mode.

**Memory trick**: Normal = navigate. Insert = type. That's it.

## How to Exit (Learn This First)

**Most important**: Know how to exit before you start.

From Normal mode:
```bash
:q                               # Quit (if no changes)
:q!                              # Quit without saving (your escape hatch)
:wq                              # Write and quit (save and exit)
:x                               # Save and quit (same as :wq)
ZZ                               # Save and quit (Normal mode, faster)
ZQ                               # Quit without saving (Normal mode)
```

**My take**: `:q!` is your friend. When you're stuck, `:q!` gets you out. You'll use it a lot at first.

## Opening vim

```bash
vim file.txt                     # Open file
vim file.txt +10                 # Open at line 10
vim                              # Open without file (create new)
```

**Real example**:
```bash
$ vim /etc/nginx/nginx.conf
```

That's it. File opens. You're in Normal mode.

## Basic Navigation (Normal Mode)

In Normal mode, you navigate. You don't type. This is the confusing part.

### Movement

```bash
h                                # Left
j                                # Down
k                                # Up
l                                # Right
```

**Memory trick**: `h` is left (it's on the left). `l` is right (it's on the right). `j` is down (looks like a down arrow). `k` is up.

### Word Movement

```bash
w                                # Next word
b                                # Previous word
e                                # End of word
```

### Line Movement

```bash
0                                # Beginning of line
$                                # End of line
^                                # First non-blank character
```

### File Movement

```bash
gg                               # Beginning of file
G                                # End of file
50G                              # Go to line 50
:50                              # Go to line 50 (Command mode)
```

**My take**: `gg` and `G` are your friends. Beginning and end of file. You'll use them constantly.

## Entering Insert Mode

Press `i` to enter Insert mode. Now you can type like a normal editor.

```bash
i                                # Insert before cursor
a                                # Insert after cursor
o                                # New line below
O                                # New line above
```

**Memory trick**: `i` = insert. `a` = append (after). `o` = open new line.

**To exit Insert mode**: Press `Esc`. Always. When in doubt, press `Esc`.

## Editing (The Basics)

### Delete

```bash
x                                # Delete character under cursor
dd                               # Delete line
dw                               # Delete word
d$                               # Delete to end of line
```

**Memory trick**: `d` = delete. `dd` = delete line. `dw` = delete word.

### Copy and Paste

```bash
yy                               # Copy line
p                                # Paste after cursor
P                                # Paste before cursor
```

**Memory trick**: `y` = yank (copy). `yy` = copy line. `p` = paste.

### Undo and Redo

```bash
u                                # Undo
Ctrl+r                           # Redo
```

**My take**: `u` is your friend. Make a mistake? `u`. Undo it.

## Search

```bash
/pattern                         # Search forward
?pattern                         # Search backward
n                                # Next match
N                                # Previous match
```

**Real example**:
```bash
/error                           # Find "error"
n                                # Next occurrence
```

**My take**: Search is how you find things. `/` to search. `n` to find next. Simple.

## Replace

```bash
:s/old/new                       # Replace first occurrence in line
:s/old/new/g                     # Replace all in line
:%s/old/new/g                    # Replace all in file
```

**Real example**:
```bash
:%s/oldhost/newhost/g            # Replace all occurrences
```

**Warning**: `:%s` replaces everywhere. Be careful.

## The Commands You'll Actually Use

Here's the truth: You'll use maybe 10 commands regularly. The rest? You'll look up.

**Daily use**:
- `i` - Enter Insert mode
- `Esc` - Exit Insert mode
- `:wq` or `ZZ` - Save and quit
- `:q!` - Quit without saving
- `dd` - Delete line
- `yy` and `p` - Copy and paste
- `/` - Search
- `gg` and `G` - Beginning and end of file

**That's it. That's 90% of what you need.**

## Common Workflow

1. Open file: `vim file.txt`
2. Navigate: Use `h`, `j`, `k`, `l` or `gg`, `G`
3. Edit: Press `i`, make changes, press `Esc`
4. Save: `:wq` or `ZZ`

**That's the workflow. Simple.**

## Common Mistakes (I've Made These)

1. **Stuck in Insert mode**: Press `Esc`. Always. When in doubt, `Esc`.

2. **Can't exit**: `:q!` gets you out. Always.

3. **Accidentally in Command mode**: Press `Esc` to go to Normal mode, then try again.

4. **Deleted too much**: `u` to undo. It's your friend.

5. **Lost in file**: `gg` goes to beginning. `G` goes to end.

## Practice Exercise

Actually do this:

```bash
# Create a test file
vim test.txt

# In vim:
# 1. Press i (enter Insert mode)
# 2. Type some text
# 3. Press Esc (back to Normal mode)
# 4. Press :wq (save and quit)
```

Do it. Actually type it. That's how you learn.

## What's Next?

Now that you know vim basics, let's talk about [Advanced vim](/docs/linux/text-editors/vim-advanced). We'll cover more powerful features. Or stick with the basics. They're enough for most things.

---

> **Personal note**: I hated vim at first. It was confusing. It was different. Then I had to use it. I learned it. Now I love it. The learning curve is steep, but it's worth it. Stick with it.
