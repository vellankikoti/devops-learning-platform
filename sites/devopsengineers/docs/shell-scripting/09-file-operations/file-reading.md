---
sidebar_position: 2
title: "File Reading: Processing File Contents"
---

# File Reading: Get Data from Files

Scripts need to read files. Get data. Process it.

**Here's the thing: Reading files is common. Learn the methods. Use them.**

## Reading Entire File

```bash
content=$(cat file.txt)          # Read all into variable
cat file.txt                     # Display file
```

**My take**: `cat` reads entire file. Use it for small files. Large files? Use line-by-line.

## Reading Line by Line

```bash
while IFS= read -r line; do
    echo "$line"
    # Process line
done < file.txt
```

**The `IFS=`**: Preserves leading/trailing spaces.

**The `-r`**: Preserves backslashes.

**My take**: Line-by-line is what you'll use most. Process files efficiently.

**Real example**:
```bash
while IFS= read -r server; do
    echo "Checking $server"
    ping -c 1 "$server"
done < servers.txt
```

## Reading into Array

```bash
mapfile -t lines < file.txt      # Read into array
echo "${lines[0]}"               # First line
echo "${lines[@]}"               # All lines
```

**My take**: `mapfile` reads into array. Useful when you need all lines at once.

## Reading Specific Lines

```bash
first_line=$(head -n 1 file.txt)
last_line=$(tail -n 1 file.txt)
first_10=$(head -n 10 file.txt)
```

**My take**: `head` and `tail` get specific lines. Useful for headers and footers.

## Common Patterns

### Process Each Line

```bash
while IFS= read -r line; do
    # Process line
    process_line "$line"
done < file.txt
```

### Skip Empty Lines

```bash
while IFS= read -r line; do
    [ -z "$line" ] && continue
    # Process non-empty line
done < file.txt
```

### Skip Comments

```bash
while IFS= read -r line; do
    [[ "$line" =~ ^# ]] && continue
    # Process non-comment line
done < file.txt
```

## Common Mistakes (I've Made These)

1. **Not using `IFS=`**: Spaces get trimmed. Use `IFS=` to preserve them.

2. **Not using `-r`**: Backslashes get interpreted. Use `-r` to preserve them.

3. **Reading large files entirely**: Use line-by-line for large files. More efficient.

4. **Not checking if file exists**: Files might not exist. Check first.

5. **Not handling empty files**: Empty files cause issues. Handle them.

## Real-World Examples

### Process Config File

```bash
while IFS= read -r line; do
    [[ "$line" =~ ^# ]] && continue
    [[ -z "$line" ]] && continue
    # Process config line
done < config.txt
```

### Read Server List

```bash
while IFS= read -r server; do
    echo "Deploying to $server"
    deploy_to "$server"
done < servers.txt
```

### Process Log File

```bash
while IFS= read -r line; do
    if [[ "$line" =~ error ]]; then
        echo "Error found: $line"
    fi
done < log.txt
```

## What's Next?

Now that you can read files, you can process data. Or learn about [File Writing](/docs/shell-scripting/file-operations/file-writing) to create files.

---

> **Personal note**: When I started, I'd read entire files into variables. Then I learned line-by-line. Now I use it for everything. More efficient. Handles large files. Learn line-by-line reading. It's essential.
