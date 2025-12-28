---
sidebar_position: 3
title: "File Writing: Creating and Modifying Files"
---

# File Writing: Create and Modify Files

Scripts need to write files. Create logs. Generate configs. Save data.

**Here's the thing: Writing files is common. Learn the methods. Use them.**

## Basic Writing

### Overwrite

```bash
echo "content" > file.txt
```

**The `>`**: Overwrites file. Creates if doesn't exist.

**My take**: Use `>` to create new files or overwrite existing.

### Append

```bash
echo "more content" >> file.txt
```

**The `>>`**: Appends to file. Creates if doesn't exist.

**My take**: Use `>>` to add to existing files. Logs. Output.

## Multiple Lines

### Heredoc

```bash
cat > file.txt << EOF
Line 1
Line 2
Line 3
EOF
```

**My take**: Heredoc is useful for multi-line content. Configs. Templates.

### printf

```bash
printf "Name: %s\nAge: %d\n" "John" 25 > file.txt
```

**My take**: `printf` formats output. Useful for structured data.

## tee: Write and Display

```bash
echo "content" | tee file.txt    # Write and display
echo "content" | tee -a file.txt  # Append and display
```

**My take**: `tee` writes and shows output. Useful for logging with visibility.

## Common Patterns

### Logging

```bash
echo "[$(date)] Message" >> log.txt
```

**My take**: Append to logs. Don't overwrite. Use `>>`.

### Generate Config

```bash
cat > config.txt << EOF
server=$SERVER
port=$PORT
EOF
```

**My take**: Generate configs from variables. Useful for automation.

### Write with Error Handling

```bash
if ! echo "content" > file.txt; then
    echo "Error: Cannot write to file.txt"
    exit 1
fi
```

**My take**: Check if write succeeds. Handle errors.

## Common Mistakes (I've Made These)

1. **Using `>` instead of `>>`**: Overwrites logs. Use `>>` for logs.

2. **Not checking if write succeeds**: Writes can fail. Check them.

3. **Not quoting content**: Spaces break things. Quote content.

4. **Writing to wrong location**: Check path. Make sure directory exists.

5. **Not handling permissions**: Files might not be writable. Check permissions.

## Real-World Examples

### Log Messages

```bash
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> /var/log/app.log
}

log "Application started"
log "Processing file: $file"
```

### Generate Config

```bash
cat > /etc/app/config.conf << EOF
# Generated on $(date)
SERVER=$SERVER
PORT=$PORT
DEBUG=$DEBUG
EOF
```

### Write Backup Script

```bash
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        cp "$file" "${file}.backup"
        echo "Backed up: $file" >> backup.log
    fi
}
```

## What's Next?

Now that you can write files, scripts can create output. Or learn about [Error Handling](/docs/shell-scripting/error-handling/exit-codes) to handle failures.

---

> **Personal note**: When I started, I'd overwrite logs constantly. Then I learned `>>`. Now I append. Logs are preserved. Small detail. Big difference.
