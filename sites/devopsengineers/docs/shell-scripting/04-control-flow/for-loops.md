---
sidebar_position: 3
title: "for Loops: Repeating Actions"
---

# for Loops: Do the Same Thing Many Times

Loops repeat code. That's it.

**But here's the thing: Loops make scripts powerful. Process multiple files. Iterate over data. Automate repetitive tasks.**

Without loops, you'd write the same code many times. With loops, you write it once and repeat.

## Basic for Loop

```bash
for item in list; do
    # commands
done
```

**Example**:
```bash
for fruit in apple banana orange; do
    echo "I like $fruit"
done
```

**Output**:
```
I like apple
I like banana
I like orange
```

**That's it. Simple.**

## Looping Over Files

```bash
for file in *.txt; do
    echo "Processing $file"
    # Process file
done
```

**The `*.txt` matches all .txt files**. Bash expands it before the loop runs.

**Real example**:
```bash
for file in *.log; do
    echo "Analyzing $file"
    grep -i error "$file"
done
```

**My take**: This is what you'll use most. Process all files matching a pattern.

## Looping Over Numbers

```bash
for i in {1..10}; do
    echo "Number: $i"
done
```

**The `{1..10}` generates numbers 1 through 10**. Bash expands it.

**Real example**:
```bash
for i in {1..5}; do
    echo "Attempt $i"
    # Try something
done
```

## Looping Over Arrays

```bash
fruits=("apple" "banana" "orange")
for fruit in "${fruits[@]}"; do
    echo "$fruit"
done
```

**The `"${fruits[@]}"` expands to all array elements**. Quotes are important.

**My take**: This is how you loop through arrays. Use `@`, not `*`. Quote it.

## Looping Over Command Output

```bash
for file in $(ls *.txt); do
    echo "Processing $file"
done
```

**Command substitution in loops**. The `$(ls *.txt)` runs first, then the loop iterates.

**Warning**: This breaks if filenames have spaces. Use arrays instead.

**Better way**:
```bash
files=(*.txt)
for file in "${files[@]}"; do
    echo "Processing $file"
done
```

**My take**: Avoid command substitution in loops. Use arrays. It's safer.

## Nested Loops

```bash
for dir in dir1 dir2 dir3; do
    for file in "$dir"/*.txt; do
        echo "Processing $file in $dir"
    done
done
```

**Loops inside loops**. Useful when you need to process directories and files.

**Real example**:
```bash
for server in server1 server2 server3; do
    for log in /var/log/$server/*.log; do
        echo "Checking $log on $server"
        grep -i error "$log"
    done
done
```

## Loop Control

### break - Exit Loop

```bash
for file in *.txt; do
    if [ ! -f "$file" ]; then
        break                      # Exit loop
    fi
    process_file "$file"
done
```

**`break` exits the loop**. Stops iterating.

### continue - Skip to Next

```bash
for file in *.txt; do
    if [ ! -f "$file" ]; then
        continue                   # Skip to next
    fi
    process_file "$file"
done
```

**`continue` skips to the next iteration**. Skips the rest of the loop body.

## Common Patterns

### Process All Files

```bash
for file in /path/to/files/*; do
    if [ -f "$file" ]; then
        process_file "$file"
    fi
done
```

### Retry Logic

```bash
for i in {1..3}; do
    if command; then
        echo "Success on attempt $i"
        break
    else
        echo "Attempt $i failed"
    fi
done
```

### Iterate Over Lines

```bash
while IFS= read -r line; do
    echo "Processing: $line"
done < file.txt
```

**Read file line by line**. Useful for processing logs.

## Common Mistakes (I've Made These)

1. **Forgetting `done`**: Every `for` needs a `done`. You'll forget it.

2. **Not quoting variables**: `"$file"` not `$file`. Spaces break things.

3. **Using `*` in arrays**: Use `@` for arrays. `*` gives one string.

4. **Command substitution in loops**: Breaks with spaces. Use arrays instead.

5. **Forgetting braces in arrays**: `` `${array[@]}` `` not `$array[@]`.

## What's Next?

Now that you understand loops, you can process multiple things. Combine loops with conditionals. Combine loops with functions. Build powerful scripts.

Or practice. Write loops. Process files. Iterate over data. Get comfortable.

---

> **Personal note**: When I started, I'd write the same code ten times. Process file1. Process file2. Process file3. Then I learned loops. Now I write it once and loop. Loops changed how I write scripts. Learn them. Use them.
