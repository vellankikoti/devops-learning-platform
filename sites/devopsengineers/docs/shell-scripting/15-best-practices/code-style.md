---
sidebar_position: 1
title: "Code Style: Writing Readable Scripts"
---

# Code Style: Make Scripts Readable

Code style makes scripts readable. Maintainable. Professional.

**Here's the thing: Style matters. Consistent code is easier to read. Easier to maintain. Use it.**

## Indentation

```bash
# Use 4 spaces (or tabs consistently)
if [ condition ]; then
    echo "True"
    if [ nested ]; then
        echo "Nested"
    fi
else
    echo "False"
fi
```

**My take**: Consistent indentation is essential. Use spaces or tabs. But be consistent.

## Naming

```bash
# Variables: lowercase_with_underscores
user_name="John"
backup_dir="/backup"

# Constants: UPPERCASE
MAX_RETRIES=3
DEFAULT_PORT=8080

# Functions: lowercase_with_underscores
backup_files() {
    # Function body
}
```

**My take**: Descriptive names are self-documenting. Use them.

## Quoting

```bash
# Always quote variables
name="$USER"
file="$1"

# Quote in conditions
if [ "$name" = "John" ]; then
    echo "Hello, $name"
fi
```

**My take**: Quote variables. Always. Spaces break things without quotes.

## Comments

```bash
# Explain WHY, not WHAT
# Bad: "Set variable to 5"
count=5

# Good: "Limit retries to prevent infinite loops"
MAX_RETRIES=5
```

**My take**: Comment why, not what. Code should be self-explanatory.

## Functions

```bash
# Small, focused functions
backup_file() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Error: File not found"
        return 1
    fi
    cp "$file" "${file}.backup"
}
```

**My take**: Small functions are easier to understand. Use them.

## Common Style Rules

### Use set -euo pipefail

```bash
#!/bin/bash
set -euo pipefail
```

**My take**: Use this. Always. It catches errors early.

### Use local variables

```bash
my_function() {
    local var="value"
    # Use var
}
```

**My take**: Use `local` in functions. Prevents conflicts.

### Check exit codes

```bash
if ! command; then
    echo "Error: Command failed"
    exit 1
fi
```

**My take**: Check exit codes. Handle errors.

## Common Mistakes (I've Made These)

1. **Inconsistent indentation**: Makes code hard to read. Be consistent.

2. **Bad names**: `x`, `tmp`, `data` are bad names. Use descriptive names.

3. **Not quoting**: Variables break with spaces. Quote them.

4. **Too many comments**: Code should be self-explanatory. Comment only when needed.

5. **Long functions**: Long functions are hard to understand. Keep them short.

## Real-World Examples

### Good Style

```bash
#!/bin/bash
set -euo pipefail

# Configuration
BACKUP_DIR="${BACKUP_DIR:-/backup}"
MAX_BACKUPS=7

# Functions
backup_file() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "Error: File not found: $file"
        return 1
    fi
    cp "$file" "${file}.backup"
}

# Main
main() {
    backup_file "$1"
}

main "$@"
```

## What's Next?

Now that you understand style, scripts are more readable. Or learn about [Security Practices](/docs/shell-scripting/best-practices/security-practices) to write secure scripts.

---

> **Personal note**: When I started, my code had no style. Then I learned style. Now my scripts are readable. Maintainable. Style matters. Learn it. Use it.
