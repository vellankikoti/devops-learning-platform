---
sidebar_position: 3
title: Viewing History
---

# Viewing History: Understanding Your Project's Past

**Git's history is your project's story. Learning to read it is learning to understand your codebase.**

## 🎯 The Big Picture

Every commit tells a story. Who changed what. When. Why. Git's history is a complete record of your project's evolution.

## Basic History Commands

### `git log` - The Foundation

```bash
# Full history
git log

# One line per commit
git log --oneline

# Last 5 commits
git log -5

# With file statistics
git log --stat

# With actual changes
git log -p
```

### Visual History

```bash
# Graph view
git log --oneline --graph --all

# Decorated graph
git log --oneline --graph --all --decorate

# Show branch names
git log --oneline --graph --all --decorate --simplify-by-decoration
```

## Finding Specific Commits

### By Author

```bash
# Commits by specific author
git log --author="John Doe"

# Commits by email pattern
git log --author="@example.com"
```

### By Date

```bash
# Since specific date
git log --since="2024-01-01"

# Until specific date
git log --until="2024-12-31"

# Last week
git log --since="1 week ago"

# Between dates
git log --since="2024-01-01" --until="2024-12-31"
```

### By Message

```bash
# Search commit messages
git log --grep="bug fix"

# Case insensitive
git log --grep="bug" -i
```

### By File

```bash
# Commits affecting a file
git log -- file.txt

# Commits affecting a directory
git log -- src/
```

## Understanding Commit Details

### `git show` - See a Commit

```bash
# Show latest commit
git show

# Show specific commit
git show abc1234

# Show with statistics
git show --stat abc1234
```

### `git diff` - See Changes

```bash
# Changes in working directory
git diff

# Changes in staging area
git diff --staged

# Changes between commits
git diff commit1 commit2

# Changes in a file
git diff HEAD~1 HEAD -- file.txt
```

## Real-World Scenarios

### Scenario 1: Who Broke This?

```bash
# Find who last changed a file
git blame file.txt

# Find when a bug was introduced
git log -p -- file.txt | grep -B 10 "buggy code"
```

### Scenario 2: What Changed?

```bash
# What changed in last commit?
git show HEAD

# What changed between versions?
git diff v1.0 v2.0

# What changed in a branch?
git diff main..feature-branch
```

### Scenario 3: Find a Feature

```bash
# Find when feature was added
git log --grep="authentication" --oneline

# See the commit
git show <commit-hash>
```

## My Take: History Is Your Friend

I used to ignore Git history. I'd just work and commit. Never look back.

Then I learned: **History tells you why things are the way they are.**

- Why was this code written this way?
- When was this bug introduced?
- Who knows about this feature?

**History answers questions. Use it.**

## Key Takeaways

1. **`git log` shows history** - Learn its options
2. **`git show` shows commits** - See what changed
3. **`git diff` shows differences** - Compare versions
4. **History tells stories** - Use it to understand code
5. **Search is powerful** - Find commits by author, date, message

## What's Next?

Now that you can view history, let's learn about undoing changes. Next: [Undoing Changes](/docs/git-github/basic-operations/undoing-changes).

---

> **Remember**: History is your project's memory. Learn to read it.
