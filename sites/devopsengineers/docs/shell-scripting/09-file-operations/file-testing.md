---
sidebar_position: 1
title: "File Testing: Checking File Properties"
---

# File Testing: Check Before You Use

Before using files, check if they exist. Check permissions. Check type.

**Here's the thing: File tests prevent errors. Use them. Your scripts will be more reliable.**

## Basic File Tests

### Existence and Type

```bash
[ -e file ]                      # File exists (any type)
[ -f file ]                      # Regular file
[ -d dir ]                       # Directory
[ -L file ]                      # Symbolic link
```

**My take**: `-f` for files. `-d` for directories. `-e` for anything. Use `-f` and `-d` most.

### Permissions

```bash
[ -r file ]                      # Readable
[ -w file ]                      # Writable
[ -x file ]                      # Executable
[ -s file ]                      # Non-empty (size > 0)
```

**My take**: Check permissions before using files. Prevents errors.

## Using File Tests

### Basic Check

```bash
if [ -f "$file" ]; then
    echo "File exists"
    process_file "$file"
else
    echo "File not found"
fi
```

**My take**: Always check before using. Prevents errors.

### Check Multiple Conditions

```bash
if [ -f "$file" ] && [ -r "$file" ]; then
    echo "File exists and is readable"
fi
```

**My take**: Combine tests. Check multiple conditions.

## Common Patterns

### Check Before Processing

```bash
if [ ! -f "$file" ]; then
    echo "Error: File not found: $file"
    exit 1
fi

process_file "$file"
```

### Check Directory

```bash
if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
fi
```

### Check Permissions

```bash
if [ ! -r "$file" ]; then
    echo "Error: Cannot read $file"
    exit 1
fi
```

## Common Mistakes (I've Made These)

1. **Not checking existence**: Files might not exist. Check first.

2. **Forgetting quotes**: `[ -f $file ]` breaks with spaces. Use `[ -f "$file" ]`.

3. **Wrong test**: Using `-f` for directories. Use `-d` for directories.

4. **Not checking permissions**: Files might not be readable. Check permissions.

5. **Assuming files exist**: Don't assume. Check. Always.

## Real-World Examples

### Process File if Exists

```bash
if [ -f "$config_file" ]; then
    source "$config_file"
else
    echo "Using default configuration"
fi
```

### Create Directory if Missing

```bash
if [ ! -d "$backup_dir" ]; then
    mkdir -p "$backup_dir"
fi
```

### Check Before Backup

```bash
if [ -f "$file" ] && [ -r "$file" ]; then
    cp "$file" "${file}.backup"
else
    echo "Cannot backup $file"
fi
```

## What's Next?

Now that you can test files, scripts are more reliable. Or learn about [File Reading](/docs/shell-scripting/file-operations/file-reading) to read file contents.

---

> **Personal note**: When I started, I'd assume files exist. Then scripts would break. Now I always check. File tests prevent errors. Use them.
