---
sidebar_position: 2
title: "Script Libraries: Reusable Code"
---

# Script Libraries: Share Code

Script libraries share code. Reusable functions. Common utilities.

**Here's the thing: Libraries let you reuse code. Write once. Use everywhere.**

## Creating Libraries

```bash
# lib.sh
function log_info() {
    echo "[INFO] $1"
}
```

**My take**: Libraries are files with functions. Simple.

## Using Libraries

```bash
source lib.sh
log_info "Message"
```

**My take**: Source libraries. Use functions.

## Common Patterns

### Utility Library

```bash
# utils.sh
function is_file() {
    [ -f "$1" ]
}
```

## What's Next?

Now that you understand libraries, let's talk about [Configuration Files](/docs/shell-scripting/modular-scripting/configuration-files).

---

> **Personal note**: Libraries seemed unnecessary at first. Then I used them. Now I use them constantly. They're useful. Use them.


