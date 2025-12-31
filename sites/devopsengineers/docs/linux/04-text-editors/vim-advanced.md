---
sidebar_position: 2
title: "Vim Advanced: Power User Techniques"
---

# vim Advanced: When You're Ready for More

Once you know vim basics, you can learn advanced features. They make you faster. Much faster.

**Here's the thing: Advanced vim is powerful. But you don't need it to start. Learn basics first. Then come back here.**

## Advanced Navigation

### Word Movement

```bash
w                                # Next word start
W                                # Next WORD (ignores punctuation)
e                                # End of word
E                                # End of WORD
b                                # Previous word
B                                # Previous WORD
```

**The difference**: `w` treats punctuation as word boundaries. `W` ignores punctuation.

**My take**: Use `w` most of the time. `W` is useful when punctuation gets in the way.

### Line Movement

```bash
0                                # Beginning of line
^                                # First non-blank character
$                                # End of line
g_                               # Last non-blank character
```

**My take**: `^` and `$` are useful. Skip leading/trailing spaces.

### Screen Movement

```bash
H                                # Top of screen
M                                # Middle of screen
L                                # Bottom of screen
zz                               # Center cursor
```

**My take**: `zz` centers the cursor. Useful when you're lost.

## Advanced Editing

### Text Objects

```bash
ci"                              # Change inside quotes
ci(                              # Change inside parentheses
ci{                              # Change inside braces
ca"                              # Change around quotes (includes quotes)
```

**The `ci` and `ca`**: `ci` = change inside, `ca` = change around.

**Real example**:
```bash
# Text: "Hello World"
# Cursor on Hello
ci"                              # Changes to: ""
# Type: Hi
# Result: "Hi World"
```

**My take**: Text objects are powerful. Learn them. They save time.

### More Text Objects

```bash
diw                              # Delete inner word
daw                              # Delete around word
ciw                              # Change inner word
yiw                              # Yank inner word
```

**My take**: Text objects work with any command. `d`, `c`, `y`. Powerful.

## Macros

### Recording Macros

```bash
qa                               # Start recording macro 'a'
# Do your edits
q                                # Stop recording
@a                               # Play macro 'a'
@@                               # Repeat last macro
```

**Real example**:
```bash
# Record macro to add semicolon to end of line
qa                               # Start recording
A;                               # Append semicolon
<Esc>                            # Back to normal mode
j                                # Next line
q                                # Stop recording

# Now use it
@a                               # Execute macro
10@a                             # Execute 10 times
```

**My take**: Macros automate repetitive edits. Learn them. They're powerful.

## Search and Replace

### Advanced Search

```bash
/pattern                         # Search forward
?pattern                         # Search backward
n                                # Next match
N                                # Previous match
*                                # Search for word under cursor
#                                # Search backward for word
```

**My take**: `*` searches for the word under cursor. Very useful.

### Replace

```bash
:s/old/new                       # Replace first in line
:s/old/new/g                     # Replace all in line
:%s/old/new/g                    # Replace all in file
:%s/old/new/gc                   # Replace with confirmation
```

**Real example**:
```bash
:%s/oldhost/newhost/g            # Replace all occurrences
```

**My take**: `:%s` replaces everywhere. Be careful. Use `c` for confirmation.

## Visual Mode

### Visual Selection

```bash
v                                # Character visual mode
V                                # Line visual mode
Ctrl+v                           # Block visual mode
```

**My take**: Visual mode selects text. Then you can delete, change, yank.

### Visual Commands

```bash
# Select text, then:
d                                # Delete
c                                # Change
y                                # Yank
>                                # Indent right
<                                # Indent left
```

**My take**: Visual mode + commands = powerful editing.

## Registers

### Using Registers

```bash
"ayy                             # Yank line to register 'a'
"ap                              # Paste from register 'a'
"a10yy                           # Yank 10 lines to register 'a'
```

**My take**: Registers store text. Useful for multiple clipboard items.

## Marks

### Setting Marks

```bash
ma                               # Set mark 'a' at cursor
'a                               # Jump to mark 'a'
``                               # Jump to previous position
```

**My take**: Marks remember positions. Jump back quickly.

## What You'll Actually Use

**Daily use**:
- Text objects (`ci"`, `diw`)
- Visual mode (`v`, `V`)
- Search and replace (`:%s`)
- Macros (for repetitive tasks)

**The rest?** Learn when you need them.

## Common Patterns

### Change Inside Quotes

```bash
ci"                              # Change inside quotes
```

### Delete Word

```bash
diw                              # Delete inner word
```

### Indent Block

```bash
# Visual mode, select lines
>                                # Indent right
```

## What's Next?

Now that you know advanced vim, you're fast. Or stick with basics. They're enough for most things.

---

> **Personal note**: I learned vim basics first. Then I learned advanced features slowly. As I needed them. Don't try to learn everything at once. Learn basics. Use them. Then learn more.
