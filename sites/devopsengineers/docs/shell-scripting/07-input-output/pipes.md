---
sidebar_position: 5
title: "Pipes: Connecting Commands"
---

# Pipes: Chain Commands

Pipes connect commands. Output of one becomes input of next.

**Here's the thing: Pipes chain commands. Powerful. Use them.**

## Basic Pipe

```bash
command1 | command2
```

**My take**: `|` pipes output. Simple.

## Common Patterns

### Filter

```bash
ls -l | grep ".txt"
```

### Count

```bash
ls | wc -l
```

### Sort

```bash
cat file.txt | sort
```

## Pipeline Failures

```bash
set -o pipefail
command1 | command2
```

**My take**: `pipefail` catches failures in pipes. Use it.

## Common Patterns

### Long Pipeline

```bash
cat file.txt | grep "pattern" | sort | uniq
```

## What's Next?

Now that you understand pipes, let's talk about [File Descriptors](/docs/shell-scripting/input-output/file-descriptors).

---

> **Personal note**: Pipes seemed simple at first. Then I learned they're powerful. Now I use them constantly. They're essential. Learn them.


