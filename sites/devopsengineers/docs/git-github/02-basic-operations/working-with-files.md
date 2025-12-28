---
sidebar_position: 5
title: Working with Files
---

# Working with Files: Git's File Management

**Git tracks files. Understanding how Git works with files is understanding version control.**

## 🎯 The Big Picture

Git doesn't track folders. It tracks files. Every file in your repository can be tracked, ignored, or removed. Understanding file states is understanding Git.

**Think of it like this: Git is a filing system. Files can be new, tracked, modified, or ignored. You control what Git pays attention to.**

## File States in Git

Git has four states for files:

1. **Untracked**: File exists but Git doesn't track it
2. **Tracked**: Git is tracking changes to this file
3. **Staged**: File is ready to be committed
4. **Modified**: Tracked file has been changed

```bash
# See file states
git status

# Output shows:
# Untracked files: new-file.txt
# Changes not staged: modified-file.txt
# Changes to be committed: staged-file.txt
```

## Adding Files to Git

### Add a Single File

```bash
# Start tracking a file
git add file.txt

# File is now staged
git status
# Shows: new file: file.txt
```

### Add Multiple Files

```bash
# Add specific files
git add file1.txt file2.txt file3.txt

# Add all files in directory
git add src/

# Add all files matching pattern
git add *.txt
```

### Add All Files

```bash
# Add all files (be careful!)
git add .

# Or add all tracked files that are modified
git add -u
```

**Warning**: `git add .` adds everything, including files you might not want. Use `.gitignore` to exclude files.

## Removing Files from Git

### Remove from Working Directory and Git

```bash
# Remove file and stage removal
git rm file.txt

# Commit the removal
git commit -m "Remove file.txt"
```

### Remove from Git Only (Keep File)

```bash
# Stop tracking but keep file
git rm --cached file.txt

# File remains on disk but Git ignores it
```

**Use when**: You want to keep the file locally but stop tracking it in Git.

### Remove Multiple Files

```bash
# Remove multiple files
git rm file1.txt file2.txt

# Remove directory
git rm -r directory/
```

## Moving and Renaming Files

### Move/Rename with Git

```bash
# Git tracks moves/renames
git mv old-name.txt new-name.txt

# This is equivalent to:
# mv old-name.txt new-name.txt
# git rm old-name.txt
# git add new-name.txt
```

**Why use `git mv`?** Git tracks the rename, preserving history.

### Move/Rename Manually

```bash
# You can also do it manually
mv old-name.txt new-name.txt
git rm old-name.txt
git add new-name.txt
```

**Result**: Same, but Git might not detect it as a rename.

## Ignoring Files (.gitignore)

### Create .gitignore

```bash
# Create .gitignore file
cat > .gitignore << EOF
# Dependencies
node_modules/
vendor/

# Build outputs
dist/
build/
*.o
*.exe

# Environment files
.env
.env.local
.env.*.local

# IDE files
.idea/
.vscode/
*.swp
*.swo
*~

# OS files
.DS_Store
Thumbs.db

# Logs
*.log
logs/
EOF
```

### Common .gitignore Patterns

```bash
# Ignore all files in directory
node_modules/

# Ignore specific file
.env

# Ignore all files with extension
*.log

# Ignore but allow exception
*.log
!important.log

# Ignore in specific directory
src/*.tmp

# Ignore everything except
*
!src/
!README.md
```

### Ignore Already Tracked Files

```bash
# File is already tracked
git rm --cached file.txt

# Add to .gitignore
echo "file.txt" >> .gitignore

# Commit
git add .gitignore
git commit -m "Stop tracking file.txt"
```

## Checking File Status

### See What Changed

```bash
# See modified files
git status

# See detailed changes
git diff

# See staged changes
git diff --staged

# See changes in specific file
git diff file.txt
```

### See File History

```bash
# See commits affecting a file
git log -- file.txt

# See file changes over time
git log -p -- file.txt

# See who changed what
git blame file.txt
```

## Real-World Scenarios

### Scenario 1: Adding New Feature Files

```bash
# Create new files for feature
touch feature.js feature.css feature.html

# Add them all
git add feature.*

# Or add directory
git add feature/
```

### Scenario 2: Removing Old Files

```bash
# Remove deprecated file
git rm old-script.sh

# Commit removal
git commit -m "Remove deprecated script"
```

### Scenario 3: Renaming for Clarity

```bash
# Rename for better clarity
git mv config.js app-config.js

# Commit rename
git commit -m "Rename config.js to app-config.js"
```

### Scenario 4: Ignoring Sensitive Files

```bash
# Add sensitive file to .gitignore
echo ".env" >> .gitignore

# Remove from tracking if already tracked
git rm --cached .env

# Commit
git add .gitignore
git commit -m "Stop tracking .env file"
```

## My Take: File Management Is Foundation

I used to add everything. I'd commit temporary files. I'd track build outputs.

Then I learned: **Good file management is good Git hygiene.**

Now I:
- Use `.gitignore` religiously
- Only track source files
- Remove files I don't need
- Rename files for clarity

**File management is the foundation of good Git practices.**

## Memory Tip: The Filing Cabinet Analogy

Think of Git like a filing cabinet:
- **Untracked**: Files on your desk (not filed)
- **Tracked**: Files in the cabinet (filed)
- **Staged**: Files in the "to file" box (ready to file)
- **Modified**: Files taken out and changed
- **Ignored**: Files you never file (junk)

Once you see it that way, file management makes sense.

## Common Mistakes

### Mistake 1: Adding Everything

```bash
# Don't do this
git add .  # Adds node_modules, .env, build files, etc.
```

**Fix**: Use `.gitignore` to exclude unwanted files.

### Mistake 2: Committing Sensitive Files

```bash
# Don't do this
git add .env
git commit -m "Add config"
# Now your secrets are in Git history!
```

**Fix**: Add sensitive files to `.gitignore` before committing.

### Mistake 3: Not Using .gitignore

```bash
# Don't do this
# Manually avoid adding files every time
```

**Fix**: Create comprehensive `.gitignore` once, use it forever.

## Key Takeaways

1. **Git tracks files, not folders** - Understand file states
2. **Use .gitignore** - Exclude unwanted files
3. **git add selectively** - Don't add everything blindly
4. **git rm for removal** - Properly remove tracked files
5. **git mv for moves** - Preserve rename history

## What's Next?

Now that you can work with files, let's learn about .gitignore in detail. Next: [Understanding .gitignore](/docs/git-github/basic-operations/understanding-gitignore).

---

> **Remember**: Good file management is good Git hygiene. Use .gitignore religiously.

