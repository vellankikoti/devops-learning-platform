---
sidebar_position: 2
title: "Security Practices: Writing Secure Scripts"
---

# Security: Write Safe Scripts

Security protects scripts from vulnerabilities. Validate input. Protect data. Limit access.

**Here's the thing: Security matters. Follow practices. Protect your scripts.**

## Input Validation

### Validate User Input

```bash
# Check if provided
if [ -z "$1" ]; then
    echo "Error: Argument required"
    exit 1
fi

# Validate format
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Must be a number"
    exit 1
fi
```

**My take**: Always validate input. Prevent injection attacks.

### Path Validation

```bash
# Prevent directory traversal
if [[ "$file" == *".."* ]]; then
    echo "Error: Invalid path"
    exit 1
fi

# Use absolute paths
file="$(realpath "$file")"
```

**My take**: Validate paths. Prevent directory traversal attacks.

## Credential Security

### Never Hardcode Secrets

```bash
# Bad
PASSWORD="secret123"

# Good
PASSWORD="${DB_PASSWORD}"
```

**My take**: Never hardcode secrets. Use environment variables.

### Use Environment Variables

```bash
# Read from environment
DB_PASSWORD="${DB_PASSWORD}"
API_KEY="${API_KEY}"

# Fail if not set
if [ -z "$DB_PASSWORD" ]; then
    echo "Error: DB_PASSWORD not set"
    exit 1
fi
```

**My take**: Use environment variables for secrets. Don't hardcode them.

## File Operations

### Check Permissions

```bash
if [ ! -r "$file" ]; then
    echo "Error: Cannot read file"
    exit 1
fi
```

**My take**: Check permissions before operations. Prevent errors.

### Use Safe Paths

```bash
# Use absolute paths
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_FILE="${SCRIPT_DIR}/config.txt"
```

**My take**: Use absolute paths. Prevents path manipulation.

## Common Security Practices

### Use set -euo pipefail

```bash
#!/bin/bash
set -euo pipefail
```

**My take**: This catches errors. Prevents undefined variables. Use it.

### Quote Variables

```bash
# Always quote
file="$1"
name="$USER"
```

**My take**: Quoting prevents word splitting. Prevents injection.

### Limit Permissions

```bash
# Scripts should have minimal permissions
chmod 755 script.sh
```

**My take**: Give scripts only needed permissions. Don't use 777.

## Common Mistakes (I've Made These)

1. **Hardcoding secrets**: Secrets in code are exposed. Use environment variables.

2. **Not validating input**: Unvalidated input is dangerous. Validate it.

3. **Not quoting variables**: Unquoted variables are vulnerable. Quote them.

4. **Using eval**: `eval` is dangerous. Avoid it.

5. **Not checking permissions**: Operations can fail. Check permissions.

## Real-World Examples

### Secure Script

```bash
#!/bin/bash
set -euo pipefail

# Validate input
if [ -z "$1" ]; then
    echo "Error: Filename required"
    exit 1
fi

# Validate path
file="$(realpath "$1")"
if [[ "$file" != /safe/path/* ]]; then
    echo "Error: Invalid path"
    exit 1
fi

# Check permissions
if [ ! -r "$file" ]; then
    echo "Error: Cannot read file"
    exit 1
fi

# Process file
process_file "$file"
```

## What's Next?

Now that you understand security, scripts are safer. Or learn about [Performance Optimization](/docs/shell-scripting/best-practices/performance-optimization) to make scripts faster.

---

> **Personal note**: When I started, I'd hardcode secrets. Then I learned security. Now I use environment variables. Validate input. Security matters. Learn it. Use it.
