---
sidebar_position: 1
title: "Parameter Expansion: Advanced Variable Manipulation"
---

# Parameter Expansion: Advanced Variable Tricks

Parameter expansion manipulates variables. Defaults. Substrings. Patterns.

**Here's the thing: Parameter expansion is powerful. But you don't need it to start. Learn basics first. Then come back here.**

## Default Values

```bash
${var:-default}                  # Use default if var is empty
${var:=default}                  # Set to default if empty
${var:+alternate}                # Use alternate if var is set
${var:?error}                    # Error if var is empty
```

**Real example**:
```bash
name=""
echo "${name:-Guest}"            # Output: Guest

port="${PORT:-8080}"            # Use PORT or default to 8080
```

**My take**: Default values are useful. Use them for configuration.

## String Length

```bash
name="John"
echo "${#name}"                  # Length: 4
```

**My take**: String length is useful. Count characters.

## Substring

```bash
text="Hello World"
echo "${text:0:5}"               # Hello (start at 0, length 5)
echo "${text:6}"                  # World (from position 6)
```

**My take**: Substrings extract parts of strings. Useful for parsing.

## Pattern Matching

```bash
file="backup.tar.gz"
echo "${file%.*}"                # backup.tar (remove shortest .* from end)
echo "${file%%.*}"               # backup (remove longest .* from end)
echo "${file#*.}"               # tar.gz (remove shortest * from start)
echo "${file##*.}"               # gz (remove longest * from start)
```

**My take**: Pattern matching manipulates strings. Useful for filenames.

## Common Uses

### Default Values

```bash
BACKUP_DIR="${BACKUP_DIR:-/backup}"
PORT="${PORT:-8080}"
```

### Extract Filename

```bash
file="/path/to/file.txt"
filename="${file##*/}"           # file.txt
extension="${file##*.}"          # txt
```

### Remove Extension

```bash
file="backup.tar.gz"
name="${file%.*}"                # backup.tar
```

## What You'll Actually Use

**Daily use**:
- Default values (`${var:-default}`)
- String length (`${#var}`)
- Pattern matching (for filenames)

**The rest?** Learn when you need them.

## Common Mistakes (I've Made These)

1. **Wrong syntax**: `${var-default}` doesn't work. Use `${var:-default}` (colon required).

2. **Not quoting**: Quote expansions. Spaces break things.

3. **Too complex**: Keep it simple. Complex expansions are hard to read.

4. **Not understanding patterns**: Pattern matching is tricky. Learn it slowly.

5. **Overusing**: Don't use advanced features when simple works.

## Real-World Examples

### Configuration with Defaults

```bash
SERVER="${SERVER:-localhost}"
PORT="${PORT:-8080}"
DEBUG="${DEBUG:-false}"
```

### Process Filenames

```bash
file="/var/log/app.log"
filename="${file##*/}"           # app.log
name="${filename%.*}"             # app
```

## What's Next?

Now that you know parameter expansion, you can manipulate variables powerfully. Or stick with basics. They're enough for most things.

---

> **Personal note**: I learned parameter expansion slowly. As I needed it. Don't try to learn everything at once. Learn defaults. Use them. Then learn more.
