---
sidebar_position: 3
title: ""Nano: Simple Text Editor""
---

# nano: The Editor for When vim is Too Much

nano is simple. No modes. No complexity. Just type and edit.

**Here's the thing: If vim feels overwhelming, use nano. It's fine. It works.**

## Why nano?

**Because it's simple.**

That's it. No modes. No commands to memorize. Just type. Edit. Save.

**My take**: Use nano for quick edits. Use vim when you need power. Both are fine.

## Opening nano

```bash
nano file.txt                      # Open file
nano                                # New file
nano +10 file.txt                  # Open at line 10
```

**That's it. Simple.**

## The Interface

**Bottom of screen shows commands**:
```
^G Get Help  ^O Write Out  ^W Where Is  ^K Cut Text  ^J Justify  ^C Cur Pos
^X Exit      ^R Read File  ^\ Replace   ^U Uncut Text^T To Spell  ^_ Go To Line
```

**The `^` means Ctrl**. `^X` = Ctrl+X.

**My take**: Commands are shown. No memorization needed. That's nano's strength.

## Essential Commands

### Save and Exit

```bash
Ctrl+X                             # Exit (prompts to save)
Ctrl+O                             # Write Out (save)
```

**My take**: `Ctrl+X` to exit. It asks if you want to save. Simple.

### Navigation

```bash
Ctrl+F                             # Forward (right)
Ctrl+B                             # Backward (left)
Ctrl+P                             # Previous line (up)
Ctrl+N                             # Next line (down)
Ctrl+A                             # Beginning of line
Ctrl+E                             # End of line
Ctrl+V                             # Next page
Ctrl+Y                             # Previous page
```

**Or just use arrow keys**. They work too.

**My take**: Arrow keys are easier. Use them. Ctrl keys work, but arrows are simpler.

### Editing

**Just type**. No special mode. Backspace works. Delete works. Normal editing.

**My take**: This is why nano is simple. No modes. Just edit.

### Cut, Copy, Paste

```bash
Ctrl+K                             # Cut line
Ctrl+U                             # Paste
```

**My take**: Cut and paste. Simple. Works.

### Search

```bash
Ctrl+W                             # Where Is (search)
Ctrl+W again                       # Next match
```

**My take**: Search works. Simple. Fine for basic needs.

## When to Use nano

**Use nano when**:
- Quick edits
- Simple changes
- You're learning
- vim feels too complex

**Use vim when**:
- You need power
- You're comfortable with it
- You're editing on servers

**My take**: Both are fine. Use what works for you. nano for simplicity. vim for power.

## Common Workflow

1. Open file: `nano file.txt`
2. Edit: Just type
3. Save: `Ctrl+O`, then Enter
4. Exit: `Ctrl+X`

**That's it. Simple.**

## Common Mistakes (I've Made These)

1. **Forgetting to save**: `Ctrl+O` saves. Don't forget.

2. **Exiting without saving**: `Ctrl+X` asks. Say yes if you want to save.

3. **Trying to use vim commands**: nano is different. Don't mix them up.

4. **Not seeing the commands**: Look at bottom of screen. Commands are there.

5. **Thinking it's too simple**: Simple is fine. It works. Use it.

## What's Next?

Now that you know nano, you can edit files easily. Or learn [vim](/docs/linux/text-editors/vi-vim-basics) for more power.

---

> **Personal note**: I used nano for years. Then I learned vim. Now I use vim. But nano is fine. It works. Don't let anyone tell you it's not good enough. Use what works for you.
