---
sidebar_position: 3
title: "Configuration Files: Reading Config"
---

# Configuration Files: Externalize Settings

Configuration files store settings. Read them. Use them.

**Here's the thing: Config files separate settings from code. Use them.**

## Reading Config

```bash
# config.conf
HOST=example.com
PORT=8080

# script.sh
source config.conf
echo "$HOST"
```

**My take**: Source config files. Use variables.

## .env Files

```bash
# .env
DB_HOST=localhost
DB_PORT=5432

# Load
set -a
source .env
set +a
```

**My take**: .env files are common. Use them.

## Common Patterns

### Config Function

```bash
load_config() {
    [ -f "$1" ] && source "$1"
}
```

## What's Next?

Now that you understand config files, let's talk about [Reusable Modules](/docs/shell-scripting/modular-scripting/reusable-modules).

---

> **Personal note**: Config files seemed unnecessary at first. Then I used them. Now I use them always. They're useful. Use them.

