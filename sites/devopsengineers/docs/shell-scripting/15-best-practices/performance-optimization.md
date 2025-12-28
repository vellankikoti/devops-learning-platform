---
sidebar_position: 3
title: "Performance Optimization: Making Scripts Fast"
---

# Performance: Make Scripts Fast

Performance optimization makes scripts faster. More efficient. Handle large data.

**Here's the thing: Most scripts are fast enough. But when they're not, optimize them.**

## Avoid Unnecessary Commands

```bash
# Bad: Multiple commands
count=$(ls -1 | wc -l)
files=$(ls -1)

# Good: Single command
files=($(ls -1))
count=${#files[@]}
```

**My take**: Fewer commands = faster. Combine when possible.

## Use Built-in Commands

```bash
# Built-in (faster)
echo "$var"

# External command (slower)
/bin/echo "$var"
```

**My take**: Built-ins are faster. Use them when possible.

## Minimize Subprocesses

```bash
# Bad: Subprocess for each file
for file in $(ls); do
    process "$file"
done

# Good: Use globbing
for file in *; do
    process "$file"
done
```

**My take**: Subprocesses are slow. Minimize them. Use globbing.

## Read Files Efficiently

```bash
# Bad: Read entire file
content=$(cat large_file.txt)

# Good: Process line by line
while IFS= read -r line; do
    process "$line"
done < large_file.txt
```

**My take**: Line-by-line is more efficient for large files. Use it.

## Common Optimizations

### Use Arrays

```bash
# Bad: Multiple variables
file1="a.txt"
file2="b.txt"
file3="c.txt"

# Good: Array
files=("a.txt" "b.txt" "c.txt")
```

**My take**: Arrays are more efficient. Use them for multiple values.

### Avoid Command Substitution

```bash
# Bad: Command substitution in loop
for i in {1..100}; do
    count=$(wc -l file.txt)
done

# Good: Calculate once
count=$(wc -l < file.txt)
for i in {1..100}; do
    # Use $count
done
```

**My take**: Calculate once. Reuse results. Don't recalculate in loops.

## When to Optimize

**Optimize when**:
- Scripts are slow
- Processing large data
- Running frequently
- Resource constrained

**Don't optimize when**:
- Scripts are fast enough
- Running rarely
- Premature optimization

**My take**: Optimize when needed. Don't optimize prematurely.

## Common Mistakes (I've Made These)

1. **Premature optimization**: Optimize when needed. Not before.

2. **Too many subprocesses**: Subprocesses are slow. Minimize them.

3. **Reading entire files**: Large files should be processed line by line.

4. **Not using built-ins**: Built-ins are faster. Use them.

5. **Complex optimizations**: Simple optimizations often help. Don't overcomplicate.

## Real-World Examples

### Efficient File Processing

```bash
# Process large file line by line
while IFS= read -r line; do
    process_line "$line"
done < large_file.txt
```

### Minimize Commands

```bash
# Calculate once
file_count=$(find . -type f | wc -l)
echo "Found $file_count files"
```

## What's Next?

Now that you understand optimization, scripts can be faster. Or review [Best Practices](/docs/shell-scripting/best-practices/code-style) to write better scripts.

---

> **Personal note**: When I started, I'd optimize everything. Then I learned: optimize when needed. Most scripts are fast enough. Don't overthink it.
