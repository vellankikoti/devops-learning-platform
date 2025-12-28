---
sidebar_position: 6
title: "File Descriptors: stdin, stdout, stderr"
---

# File Descriptors: Input And Output Channels

File descriptors are channels. stdin. stdout. stderr. Understand them.

**Here's the thing: File descriptors are channels. 0 is stdin. 1 is stdout. 2 is stderr. Learn them.**

## Standard Descriptors

- **0** = stdin (input)
- **1** = stdout (output)
- **2** = stderr (errors)

**My take**: Three standard descriptors. Learn them.

## Redirecting

```bash
command 1> output.log    # stdout
command 2> error.log    # stderr
command 0< input.txt   # stdin
```

**My take**: Redirect descriptors. Use numbers.

## Custom Descriptors

```bash
exec 3> custom.log
echo "Hello" >&3
exec 3>&-
```

**My take**: Custom descriptors are advanced. Use when needed.

## Common Patterns

### Separate Outputs

```bash
command > output.log 2> error.log
```

## What's Next?

Now that you understand descriptors, you can control I/O. Or review [Input/Output](/docs/shell-scripting/input-output/reading-input) to reinforce.

---

> **Personal note**: File descriptors seemed complex at first. Then I learned: 0, 1, 2. Now I use them. They're useful. Learn them.


