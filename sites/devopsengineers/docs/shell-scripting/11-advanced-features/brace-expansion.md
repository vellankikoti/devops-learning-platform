---
sidebar_position: 2
title: "Brace Expansion: Generate Patterns"
---

# Brace Expansion: Generate Strings

Brace expansion generates strings. Ranges. Lists. Useful.

**Here's the thing: Brace expansion generates strings. Learn it. Use it.**

## Ranges

```bash
echo {1..10}
echo {a..z}
```

**My take**: Ranges generate sequences. Use them.

## Lists

```bash
echo {file1,file2,file3}.txt
```

**My take**: Lists generate combinations. Use them.

## Common Patterns

### Generate Files

```bash
touch file{1..5}.txt
```

## What's Next?

Now that you understand brace expansion, let's talk about [Process Substitution](/docs/shell-scripting/advanced-features/process-substitution).

---

> **Personal note**: Brace expansion seemed unnecessary at first. Then I used it. Now I use it constantly. It's useful. Learn it.


