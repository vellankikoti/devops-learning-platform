---
sidebar_position: 4
title: "Process Substitution: Advanced I/O"
---

# Process Substitution: Advanced Input/Output

Process substitution treats command output as files. Advanced I/O.

**Here's the thing: Process substitution is advanced. Use it when needed.**

## Basic Syntax

```bash
diff <(command1) <(command2)
```

**My take**: `<()` treats output as file. Use it.

## Common Patterns

### Compare Outputs

```bash
diff <(sort file1.txt) <(sort file2.txt)
```

## What's Next?

Now that you understand process substitution, let's talk about [Globbing Patterns](/docs/shell-scripting/advanced-features/globbing-patterns).

---

> **Personal note**: Process substitution seemed complex at first. Then I used it. Now I use it when needed. It's powerful. Learn it.

