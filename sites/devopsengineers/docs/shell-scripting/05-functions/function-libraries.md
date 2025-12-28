---
sidebar_position: 6
title: "Function Libraries: Reusable Functions"
---

# Function Libraries: Share Functions

Function libraries are files with functions. Source them. Use them.

**Here's the thing: Libraries let you reuse functions. Write once. Use everywhere.**

## Creating Libraries

```bash
# lib.sh
function log_info() {
    echo "[INFO] $1"
}

function log_error() {
    echo "[ERROR] $1" >&2
}
```

**My take**: Libraries are just files with functions. Simple.

## Using Libraries

```bash
#!/bin/bash
source lib.sh

log_info "Starting"
log_error "Failed"
```

**My take**: `source` loads library. Then use functions.

## Common Patterns

### Utility Library

```bash
# utils.sh
function is_file() {
    [ -f "$1" ]
}

function is_dir() {
    [ -d "$1" ]
}
```

### Using It

```bash
source utils.sh

if is_file "test.txt"; then
    echo "File exists"
fi
```

## Common Mistakes (I've Made These)

1. **Not sourcing**: Source libraries before use. Don't forget.

2. **Circular dependencies**: Libraries depending on each other. Avoid it.

3. **Not organizing**: Organize libraries. Group related functions.

## What's Next?

Now that you understand libraries, you can build reusable code. Or review [Functions](/docs/shell-scripting/functions/function-basics) to reinforce.

---

> **Personal note**: Libraries seemed complex at first. Then I learned: just source files. Now I use them constantly. They're useful. Use them.

