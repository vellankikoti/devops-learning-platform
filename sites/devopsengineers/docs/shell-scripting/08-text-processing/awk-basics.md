---
sidebar_position: 4
title: "awk Basics: Text Processing Language"
---

# awk Basics: Process Text

awk processes text. Fields. Records. Patterns. Actions.

**Here's the thing: awk is powerful. Learn it. It's useful.**

## Basic Usage

```bash
awk '{print $1}' file.txt
```

**My take**: `$1` is first field. Print it.

## Fields

```bash
awk -F: '{print $1}' /etc/passwd
```

**My take**: `-F` sets field separator. Use it.

## Patterns

```bash
awk '/pattern/ {print}' file.txt
```

**My take**: Patterns match lines. Use them.

## Common Patterns

### Print Specific Fields

```bash
awk '{print $1, $3}' file.txt
```

## What's Next?

Now that you understand awk basics, let's talk about [awk Advanced](/docs/shell-scripting/text-processing/awk-advanced).

---

> **Personal note**: awk seemed complex at first. Then I learned basics. Now I use it. It's powerful. Learn it.


