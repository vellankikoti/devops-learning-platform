---
sidebar_position: 4
title: "File Searching: Finding Files"
---

# File Searching: Find Files

Find files. By name. By type. By content. Search.

**Here's the thing: Finding files is common. Learn find. Use it.**

## find Basics

```bash
find . -name "*.txt"
find /var/log -type f
```

**My take**: `find` finds files. Use it.

## With exec

```bash
find . -name "*.txt" -exec rm {} \;
```

**My take**: `-exec` runs commands. Use it.

## With xargs

```bash
find . -name "*.txt" | xargs rm
```

**My take**: `xargs` passes to commands. Use it.

## Common Patterns

### Find And Process

```bash
find . -name "*.log" -exec gzip {} \;
```

## What's Next?

Now that you understand searching, let's talk about [Batch Operations](/docs/shell-scripting/file-operations/batch-operations).

---

> **Personal note**: find seemed complex at first. Then I learned it. Now I use it constantly. It's powerful. Learn it.


