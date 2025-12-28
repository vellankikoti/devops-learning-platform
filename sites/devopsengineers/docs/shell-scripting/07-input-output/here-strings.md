---
sidebar_position: 4
title: "Here Strings: Short Input"
---

# Here Strings: Quick Input

Here strings are short here documents. One line. Quick.

**Here's the thing: Here strings are quick. Use them for simple input.**

## Basic Syntax

```bash
command <<< "input"
```

**My take**: `<<<` is here string. Quick input.

## Common Use

```bash
grep "pattern" <<< "text to search"
```

**My take**: Here strings are quick. Use them.

## Common Patterns

### Quick Input

```bash
tr 'a-z' 'A-Z' <<< "hello"
```

## What's Next?

Now that you understand here strings, let's talk about [Pipes](/docs/shell-scripting/input-output/pipes).

---

> **Personal note**: Here strings seemed unnecessary at first. Then I used them. Now I use them for quick input. They're useful. Learn them.


