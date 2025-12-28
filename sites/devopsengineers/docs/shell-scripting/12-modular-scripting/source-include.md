---
sidebar_position: 1
title: "Source and Include: Reusing Code"
---

# Source and Include: Reuse Code

Source lets you reuse code from other files. Like libraries. Write once. Use many times.

**Here's the thing: Source makes scripts modular. Share functions. Avoid duplication. Use it.**

## Basic source

```bash
source functions.sh
. functions.sh                   # Same thing (shorthand)
```

**The `.`**: Shorthand for `source`. Same thing.

**My take**: Use `.` or `source`. Both work. `.` is shorter.

## Example Library

**functions.sh**:
```bash
#!/bin/bash
# Common functions

log_info() {
    echo "[INFO] $*"
}

log_error() {
    echo "[ERROR] $*" >&2
}

backup_file() {
    local file="$1"
    cp "$file" "${file}.backup"
}
```

**script.sh**:
```bash
#!/bin/bash
source functions.sh

log_info "Script started"
backup_file "important.txt"
log_info "Script completed"
```

**My take**: Put common functions in a file. Source it. Reuse them.

## Why Use source?

**Benefits**:
- Share functions across scripts
- Avoid code duplication
- Organize code
- Easier maintenance

**My take**: Source makes scripts cleaner. More maintainable. Use it.

## Common Patterns

### Shared Utilities

```bash
# utils.sh
log() {
    echo "[$(date)] $*"
}

error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# script.sh
source utils.sh
log "Starting"
```

### Configuration

```bash
# config.sh
SERVER="localhost"
PORT=8080
DEBUG=false

# script.sh
source config.sh
echo "Connecting to $SERVER:$PORT"
```

## Common Mistakes (I've Made These)

1. **Not using absolute paths**: Relative paths break if you change directories. Use absolute paths or `$SCRIPT_DIR`.

2. **Sourcing multiple times**: Source runs the file. If it has side effects, they happen multiple times.

3. **Circular dependencies**: File A sources B, B sources A. Breaks things. Avoid it.

4. **Not checking if file exists**: Source fails if file doesn't exist. Check first.

5. **Global variables**: Sourced files share variables. Be careful with names.

## Real-World Examples

### Shared Logging

```bash
# lib/logger.sh
log() {
    local level="$1"
    shift
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] [$level] $*"
}

# scripts/deploy.sh
source lib/logger.sh
log "INFO" "Deploying application"
```

### Common Functions

```bash
# lib/common.sh
validate_file() {
    if [ ! -f "$1" ]; then
        echo "Error: File not found: $1"
        return 1
    fi
}

# scripts/backup.sh
source lib/common.sh
validate_file "$backup_file"
```

## What's Next?

Now that you can reuse code, scripts become modular. Or learn about [Automation Patterns](/docs/shell-scripting/automation-patterns/backup-scripts) to automate tasks.

---

> **Personal note**: When I started, I'd copy functions between scripts. Then I learned source. Now I put common functions in libraries. Scripts are cleaner. Easier to maintain. Source is worth it.
