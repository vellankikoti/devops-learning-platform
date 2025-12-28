---
sidebar_position: 1
title: "grep: Advanced Text Searching"
---

# grep: Find Anything in Files

grep searches for text in files. That's it. But it's powerful.

**Here's the thing: You'll use grep constantly. Searching logs. Finding patterns. Extracting information. Learn it well.**

## Basic grep

```bash
grep "pattern" file.txt
grep "error" /var/log/syslog
```

**That's it. Simple.**

## Common Options

### Case Insensitive

```bash
grep -i "pattern" file.txt        # Ignore case
grep -i "error" /var/log/syslog   # Finds ERROR, error, Error
```

**The `-i` flag**: Makes search case-insensitive.

**My take**: Use `-i` when you don't care about case. Which is often.

### Show Line Numbers

```bash
grep -n "pattern" file.txt        # Show line numbers
```

**The `-n` flag**: Shows which line matches.

**My take**: Useful for finding where things are. Use it.

### Invert Match

```bash
grep -v "pattern" file.txt        # Show lines NOT matching
grep -v "^#" file.txt             # Exclude comment lines
```

**The `-v` flag**: Shows lines that don't match.

**My take**: Useful for filtering. Exclude what you don't want.

### Recursive Search

```bash
grep -r "pattern" directory/      # Search recursively
grep -R "pattern" .               # Search from current directory
```

**The `-r` or `-R` flag**: Searches in subdirectories.

**Real example**:
```bash
grep -r "password" /etc/          # Find "password" in all config files
```

**My take**: Use this for searching multiple files. Very common.

### Show Filenames Only

```bash
grep -l "pattern" *.txt           # Show only filenames with matches
grep -L "pattern" *.txt           # Show filenames without matches
```

**The `-l` flag**: Just filenames. Not the matches.

**My take**: Useful when you just need to know which files have matches.

### Count Matches

```bash
grep -c "pattern" file.txt        # Count matches per file
```

**The `-c` flag**: Shows count, not matches.

**My take**: Useful for statistics. How many times does something appear?

### Context Lines

```bash
grep -A 3 "pattern" file.txt      # 3 lines after match
grep -B 3 "pattern" file.txt      # 3 lines before match
grep -C 3 "pattern" file.txt      # 3 lines before and after
```

**Real example**:
```bash
grep -C 5 "error" /var/log/syslog  # Show 5 lines before and after errors
```

**My take**: Useful for logs. See what happened before and after errors.

## Regular Expressions (The Powerful Part)

### Basic Patterns

```bash
grep "^pattern" file.txt          # Lines starting with pattern
grep "pattern$" file.txt          # Lines ending with pattern
grep "^$" file.txt                # Empty lines
```

**The `^` and `$`**: Start and end of line.

**My take**: Learn these. They're useful.

### Character Classes

```bash
grep "[0-9]" file.txt             # Contains digit
grep "[a-z]" file.txt             # Contains lowercase
grep "[A-Z]" file.txt             # Contains uppercase
grep "[0-9][0-9][0-9]" file.txt   # Three digits
```

**My take**: Useful for finding patterns. Numbers. Letters. Combinations.

### Wildcards

```bash
grep "file.*\.txt" file.txt       # file followed by anything, then .txt
grep "error.*" file.txt           # error followed by anything
```

**The `.*`**: Matches anything.

**My take**: Useful for flexible patterns.

## Common Patterns

### Find Errors

```bash
grep -i error /var/log/syslog
grep -i "error\|fail\|critical" /var/log/syslog
```

**My take**: Searching logs for errors. You'll do this constantly.

### Find IP Addresses

```bash
grep -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" file.txt
```

**The `-E` flag**: Extended regex.

**My take**: Complex pattern. But useful when you need it.

### Find Empty Lines

```bash
grep "^$" file.txt
```

**My take**: Simple. But useful for cleaning files.

### Exclude Comments

```bash
grep -v "^#" file.txt             # Exclude lines starting with #
grep -v "^$" file.txt             # Exclude empty lines
grep -v "^#" file.txt | grep -v "^$"  # Exclude both
```

**My take**: Useful for processing config files.

## Combining with Other Commands

### Pipe to grep

```bash
ps aux | grep nginx
df -h | grep "/$"
```

**My take**: This is what you'll do most. Filter command output.

### grep with find

```bash
find /etc -name "*.conf" -exec grep -l "pattern" {} \;
```

**My take**: Find files, then grep in them. Powerful combination.

## Common Mistakes (I've Made These)

1. **Not quoting patterns**: `grep pattern file` works, but `grep "pattern" file` is safer. Quote it.

2. **Forgetting -i**: Case-sensitive by default. Use `-i` when you don't care about case.

3. **Not using -r for directories**: `grep pattern dir` doesn't work. Use `grep -r pattern dir`.

4. **Wrong regex syntax**: Basic grep uses basic regex. Use `-E` for extended regex.

5. **Not escaping special characters**: Characters like `.` and `*` are special. Escape them with `\`.

## Real-World Examples

### Search Logs for Errors

```bash
grep -i error /var/log/syslog | tail -20
```

### Find Configuration Values

```bash
grep -r "Listen" /etc/nginx/
```

### Count Occurrences

```bash
grep -c "GET" /var/log/nginx/access.log
```

### Find with Context

```bash
grep -C 10 "error" /var/log/syslog
```

## What's Next?

Now that you can search files, you can find anything. Combine grep with other commands. Build powerful pipelines.

Or learn about [sed and awk](/docs/shell-scripting/text-processing/sed-basics) for more advanced text processing.

---

> **Personal note**: When I started, I'd open files and search manually. Then I learned grep. Now I grep everything. It's faster. It's more powerful. grep changed how I work with files.
