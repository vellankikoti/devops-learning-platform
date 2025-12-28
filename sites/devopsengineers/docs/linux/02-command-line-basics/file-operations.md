---
sidebar_position: 3
title: File Operations Mastery
---

# File Operations: Create, Copy, Move, Delete

File operations are what you do constantly. Create files. Copy them. Move them. Delete them.

**Master these, and you can work with files efficiently. These are the basics. But basics matter.**

## Creating Files

### touch: Create Empty Files

```bash
touch file.txt                # Create empty file
touch file1.txt file2.txt     # Create multiple
touch existing.txt            # Update timestamp
```

**What it does**: Creates empty files. Or updates the timestamp if the file exists.

**Real example**:
```bash
$ touch test.txt
$ ls -la test.txt
-rw-r--r-- 1 ubuntu ubuntu 0 Dec 28 10:30 test.txt
```

Zero bytes. Empty file.

**My take**: Use `touch` for empty files. Use editors or redirection for files with content.

### Creating Files with Content

```bash
# Method 1: echo
echo "Hello, World!" > file.txt        # Create/overwrite
echo "More text" >> file.txt          # Append

# Method 2: heredoc
cat > file.txt << EOF
Line 1
Line 2
Line 3
EOF

# Method 3: editors
vim file.txt
nano file.txt
```

**The `>` and `>>`**: `>` overwrites. `>>` appends.

**My take**: Use `>` for new files. Use `>>` for adding to existing files. Use heredoc for multi-line content.

## Copying Files

### cp: Copy

```bash
cp file.txt backup.txt                # Copy with new name
cp file.txt /destination/             # Copy to directory
cp file1.txt file2.txt /dest/         # Copy multiple
cp -r directory/ /dest/               # Copy directory (recursive)
cp -i file.txt dest/                  # Interactive (ask before overwrite)
cp -u file.txt dest/                  # Update (only if newer)
cp -p file.txt dest/                  # Preserve permissions/timestamps
cp -v file.txt dest/                  # Verbose (show what's copied)
```

**The `-r` flag**: Required for directories. Recursive copy.

**Real examples**:
```bash
cp config.txt config.txt.backup
cp -r /home/ubuntu/projects /backup/
cp -i *.txt /backup/                 # Ask before overwriting
```

**My take**: `cp -r` for directories. `cp -i` when you're not sure. `cp -v` to see what's happening.

## Moving Files

### mv: Move or Rename

```bash
mv file.txt newname.txt               # Rename
mv file.txt /destination/             # Move
mv file1.txt file2.txt /dest/         # Move multiple
mv -i file.txt dest/                 # Interactive
mv -v file.txt dest/                 # Verbose
```

**What it does**: Moves files. Or renames them. Same command.

**Real examples**:
```bash
mv oldname.txt newname.txt            # Rename
mv file.txt /tmp/                     # Move
mv *.txt /backup/                     # Move all .txt files
```

**My take**: `mv` is simple. It moves. It renames. That's it.

## Deleting Files

### rm: Delete

```bash
rm file.txt                          # Delete file
rm file1.txt file2.txt               # Delete multiple
rm -r directory/                     # Delete directory
rm -f file.txt                       # Force (no confirmation)
rm -rf directory/                    # Force recursive (dangerous!)
rm -i file.txt                       # Interactive (ask first)
rm -v file.txt                       # Verbose
```

**Warning**: `rm -rf` is dangerous. It deletes without asking. Be very careful.

**Real examples**:
```bash
rm old_file.txt
rm -r old_directory/
rm -i *.txt                          # Ask before deleting each
```

**My take**: Use `rm -i` when you're not sure. Use `rm -rf` only when you're absolutely sure. There's no undo.

## Directories

### mkdir: Create Directories

```bash
mkdir dirname
mkdir -p path/to/dir                 # Create parent directories too
mkdir dir1 dir2 dir3                  # Create multiple
```

**The `-p` flag**: Creates parent directories if they don't exist.

**Real example**:
```bash
mkdir -p projects/2024/january
```

**My take**: Use `-p` when creating nested directories. It's safer.

### rmdir: Remove Empty Directories

```bash
rmdir dirname                        # Remove empty directory
rmdir dir1 dir2                      # Remove multiple
```

**What it does**: Removes empty directories only.

**My take**: Use `rm -r` for directories with files. Use `rmdir` only for empty directories.

## Common Patterns

### Backup Before Delete

```bash
cp file.txt file.txt.backup
rm file.txt
```

**My take**: Always backup before deleting important files. You'll thank yourself later.

### Move and Rename

```bash
mv oldname.txt newname.txt            # Same command
```

**My take**: There's no separate rename command. `mv` does both.

### Copy with Timestamp

```bash
cp -p file.txt backup/               # Preserves timestamp
```

**My take**: Use `-p` when timestamps matter. Usually they don't, but sometimes they do.

## Common Mistakes (I've Made These)

1. **Forgetting `-r` for directories**: `cp directory/` doesn't work. Use `cp -r directory/`.

2. **Using `rm` on directories**: `rm directory/` doesn't work. Use `rm -r directory/`.

3. **Accidental overwrite**: `cp file.txt existing.txt` overwrites. Use `cp -i` to be safe.

4. **Deleting wrong thing**: Always double-check before `rm`. There's no undo.

5. **Spaces in paths**: `mv my file.txt` doesn't work. Use quotes: `mv "my file.txt"`.

## Real-World Examples

### Backup Files

```bash
for file in *.txt; do
    cp "$file" "${file}.backup"
done
```

### Clean Up Old Files

```bash
find /tmp -mtime +7 -type f -delete
```

### Organize Files

```bash
mkdir -p documents images scripts
mv *.pdf documents/
mv *.jpg images/
mv *.sh scripts/
```

## What's Next?

Now that you can manipulate files, let's talk about [Text Processing](/docs/linux/command-line-basics/text-processing). We'll cover viewing and processing file contents.

Or practice. Create files. Copy them. Move them. Delete them. Get comfortable.

---

> **Personal note**: When I started, I'd delete files accidentally. Then I learned `rm -i`. Now I use it when I'm not sure. It's saved me from deleting important files many times. Be careful with `rm`. There's no undo.
