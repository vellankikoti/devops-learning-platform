---
sidebar_position: 4
title: Text Processing Essentials
---

# Text Processing: Viewing and Manipulating Text

You'll process text constantly. Logs. Configs. Data. These tools are essential.

**Master these, and you can work with text efficiently. These are the tools you'll use every day.**

## Viewing Files

### cat: Display Entire File

```bash
cat file.txt                       # Display file
cat file1.txt file2.txt           # Display multiple (concatenated)
cat -n file.txt                   # Show line numbers
```

**What it does**: Shows file contents. All of it.

**When to use**: Small files. Quick viewing.

**Real examples**:
```bash
cat /etc/hostname                  # Show hostname
cat config1.txt config2.txt > combined.txt  # Combine files
```

**My take**: Use `cat` for small files. For large files, use `less`.

### less: View Large Files

```bash
less largefile.txt                 # View file
```

**Navigation**:
- `Space` = Next page
- `b` = Previous page
- `q` = Quit
- `/pattern` = Search
- `n` = Next search result
- `G` = Go to end
- `g` = Go to beginning

**My take**: Use `less` for large files. It's better than `cat` for anything longer than a screen.

**Real example**:
```bash
less /var/log/syslog               # View system log
```

### head: First Lines

```bash
head file.txt                      # First 10 lines
head -n 20 file.txt                # First 20 lines
head -c 100 file.txt               # First 100 characters
```

**What it does**: Shows beginning of file.

**When to use**: Quick peek at file start.

**Real example**:
```bash
head -n 50 /var/log/syslog         # First 50 log entries
```

### tail: Last Lines

```bash
tail file.txt                      # Last 10 lines
tail -n 20 file.txt                # Last 20 lines
tail -f file.txt                   # Follow (watch as it grows)
```

**The `-f` flag**: Follows the file. Shows new lines as they're added.

**Real example**:
```bash
tail -f /var/log/nginx/access.log  # Watch access log in real-time
```

**My take**: `tail -f` is magic. Watch logs in real-time. You'll use it constantly.

## Searching Text

### grep: Find Text

```bash
grep "pattern" file.txt
grep -i "pattern" file.txt         # Case insensitive
grep -n "pattern" file.txt         # Show line numbers
grep -r "pattern" directory/       # Recursive
```

**My take**: `grep` is what you'll use most. Find text in files. Essential.

**Real example**:
```bash
grep -i error /var/log/syslog      # Find errors
```

## Processing Text

### cut: Extract Columns

```bash
cut -d: -f1 /etc/passwd            # Extract first field (usernames)
cut -d',' -f1,3 file.csv           # Extract columns 1 and 3
```

**The `-d` flag**: Delimiter. `-f` flag: Fields.

**Real example**:
```bash
cut -d: -f1 /etc/passwd            # List all usernames
```

**My take**: Useful for structured data. CSV files. Config files with delimiters.

### sort: Sort Lines

```bash
sort file.txt                      # Sort alphabetically
sort -n file.txt                   # Sort numerically
sort -r file.txt                   # Reverse sort
sort -u file.txt                   # Unique (remove duplicates)
```

**Real example**:
```bash
sort /etc/passwd                   # Sort user list
ps aux | sort -k3 -rn              # Sort by CPU usage
```

**My take**: Useful for organizing output. Sorting logs. Finding duplicates.

### uniq: Remove Duplicates

```bash
uniq file.txt                      # Remove consecutive duplicates
sort file.txt | uniq               # Remove all duplicates
uniq -c file.txt                   # Count occurrences
```

**My take**: Usually used with `sort`. `sort | uniq` removes all duplicates.

### wc: Count

```bash
wc file.txt                        # Lines, words, characters
wc -l file.txt                     # Just lines
wc -w file.txt                     # Just words
wc -c file.txt                     # Just characters
```

**Real example**:
```bash
wc -l /var/log/syslog              # Count log lines
```

**My take**: Useful for statistics. How many lines? How many words?

## Combining Commands (Pipes)

```bash
cat file.txt | grep "pattern" | sort | uniq
```

**The pipe `|`**: Sends output of one command to input of next.

**Real examples**:
```bash
ps aux | grep nginx                # Find nginx processes
cat /var/log/syslog | grep error | tail -20  # Last 20 errors
cut -d: -f1 /etc/passwd | sort | uniq  # Sorted unique usernames
```

**My take**: Pipes are powerful. Combine commands. Build pipelines. This is how you process data.

## Common Patterns

### Find Errors in Logs

```bash
grep -i error /var/log/syslog | tail -20
```

### Count Unique Values

```bash
cut -d: -f1 /etc/passwd | sort | uniq | wc -l
```

### Extract Information

```bash
grep "pattern" file.txt | cut -d' ' -f2
```

## Common Mistakes (I've Made These)

1. **Using `cat` on large files**: Don't. Use `less`.

2. **Forgetting `-f` in tail**: `tail -f` follows. `tail` just shows last lines.

3. **Not quoting patterns in grep**: `grep pattern file` works, but `grep "pattern" file` is safer.

4. **Wrong delimiter in cut**: Make sure `-d` matches your data format.

5. **Forgetting to sort before uniq**: `uniq` only removes consecutive duplicates. Sort first.

## What's Next?

Now that you can process text, you can work with logs and data. Combine these tools. Build pipelines. Process anything.

Or learn about [Command History](/docs/linux/command-line-basics/command-history) to work more efficiently.

---

> **Personal note**: When I started, I'd open files in editors to search. Then I learned `grep`. Now I grep everything. It's faster. It's more powerful. Text processing tools changed how I work.
