---
sidebar_position: 4
title: "Shebang Line: Understanding #!"
---

# Shebang Line: The First Line

The shebang line tells the system which interpreter to use.

**Here's the thing: The shebang is the first line. It's important. Use it.**

## What It Is

```bash
#!/bin/bash
```

**The `#!`**: That's the shebang. Tells the system what to use.

**My take**: Shebang is simple. But important. Always use it.

## Common Shebangs

### bash

```bash
#!/bin/bash
```

**My take**: Use this for bash scripts. Most common.

### sh

```bash
#!/bin/sh
```

**My take**: Use this for sh scripts. When you need portability.

### Find in PATH

```bash
#!/usr/bin/env bash
```

**My take**: This finds bash in PATH. More portable. Use it.

## Why It Matters

Without shebang, you need to run:
```bash
bash script.sh
```

With shebang, you can run:
```bash
./script.sh
```

**My take**: Shebang makes scripts executable. Use it.

## Common Patterns

### Standard bash

```bash
#!/bin/bash
```

### Portable bash

```bash
#!/usr/bin/env bash
```

## Common Mistakes (I've Made These)

1. **Forgetting shebang**: Always include shebang. First line.

2. **Wrong path**: Use `/bin/bash` or `/usr/bin/env bash`. Check your system.

3. **Spaces**: No spaces after `#!`. It breaks.

4. **Wrong interpreter**: Make sure you use the right one. bash for bash scripts.

## What's Next?

Now that you understand shebang, let's talk about [Making Scripts Executable](/docs/shell-scripting/fundamentals/making-scripts-executable).

---

> **Personal note**: I used to forget shebang. Then scripts wouldn't run. Now I always include it. First line. Always.

