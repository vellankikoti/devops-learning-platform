---
sidebar_position: 5
title: "awk Advanced: Complex Processing"
---

# awk Advanced: Complex Text Processing

Advanced awk uses arrays. Functions. Control flow. Reports.

**Here's the thing: Advanced awk is powerful. But complex. Learn basics first.**

## Arrays

```bash
awk '{count[$1]++} END {for (i in count) print i, count[i]}' file.txt
```

**My take**: Arrays in awk are useful. Use them.

## Functions

```bash
awk '{print length($0)}' file.txt
```

**My take**: awk has functions. Use them.

## Common Patterns

### Generate Reports

```bash
awk '{sum+=$2} END {print sum}' file.txt
```

## What's Next?

Now that you understand advanced awk, let's talk about [cut, sort, uniq](/docs/shell-scripting/text-processing/cut-sort-uniq).

---

> **Personal note**: Advanced awk seemed too complex. Then I learned it gradually. Now I use it when needed. It's powerful. Learn it.

