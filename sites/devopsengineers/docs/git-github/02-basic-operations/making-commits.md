---
sidebar_position: 2
title: Making Commits
---

# Making Commits: Saving Your Work

**Commits are Git's way of saving your work. Understanding commits is understanding Git's history.**

## 🎯 The Big Picture

A commit is a snapshot of your project at a specific point in time. Every commit is permanent. Every commit is history. Every commit is a safety net.

**Think of commits like save points in a video game. You can always go back.**

## What Is a Commit?

A **commit** is:
- A snapshot of your project
- A permanent record of changes
- A point in history you can return to
- Identified by a unique hash (SHA-1)

```bash
# Make a commit
git add file.txt
git commit -m "Add new feature"

# Output shows the commit hash
# [main abc1234] Add new feature
#  1 file changed, 10 insertions(+)
```

## The Commit Process

### Step 1: Stage Changes

```bash
# Stage specific files
git add file1.txt file2.txt

# Or stage all changes
git add .
```

### Step 2: Commit

```bash
# Commit with message
git commit -m "Your commit message"

# Or commit without -m (opens editor)
git commit
```

## Commit Messages: The Art

**Good commit messages are critical. They're your project's history.**

### Good Commit Messages

```bash
# Descriptive and specific
git commit -m "Add user authentication with JWT tokens"

# Explains what and why
git commit -m "Fix memory leak in image processing module"

# References issues
git commit -m "Fix #123: Resolve database connection timeout"
```

### Bad Commit Messages

```bash
# Too vague
git commit -m "Update"

# Not helpful
git commit -m "Fix"

# No context
git commit -m "Changes"
```

### Commit Message Best Practices

1. **Use present tense**: "Add feature" not "Added feature"
2. **Be specific**: What changed and why
3. **Keep first line short**: Under 50 characters
4. **Add details if needed**: Use multi-line messages
5. **Reference issues**: Link to tickets or PRs

### Multi-Line Commit Messages

```bash
git commit

# Opens editor, write:
# Add user authentication
#
# Implement JWT token-based authentication for API endpoints.
# Includes token generation, validation, and refresh logic.
# Fixes security vulnerability in session management.
#
# Closes #123
```

## Commit Options

### Commit All Tracked Files

```bash
# Stage and commit all modified tracked files
git commit -a -m "Update all files"

# Equivalent to:
git add -u
git commit -m "Update all files"
```

**Note**: This only stages tracked files. New files still need `git add`.

### Amend Last Commit

```bash
# Add forgotten file to last commit
git add forgotten-file.txt
git commit --amend -m "Updated message"

# Or just update message
git commit --amend -m "Better message"
```

**Warning**: Don't amend commits that are already pushed (unless you know what you're doing).

### Empty Commit

```bash
# Create commit with no changes (useful for triggers)
git commit --allow-empty -m "Trigger CI/CD pipeline"
```

## Viewing Commits

### See Commit History

```bash
# Full history
git log

# One line per commit
git log --oneline

# Last 5 commits
git log -5

# With file changes
git log --stat

# With actual code changes
git log -p
```

### See Specific Commit

```bash
# Show commit details
git show abc1234

# Show commit with file changes
git show abc1234 --stat
```

## Commit Anatomy

Every commit contains:
- **Hash**: Unique identifier (SHA-1)
- **Author**: Who made it
- **Date**: When it was made
- **Message**: What changed
- **Parent**: Previous commit(s)
- **Tree**: Snapshot of files

```bash
$ git show abc1234

commit abc1234567890abcdef1234567890abcdef1234
Author: Your Name <your.email@example.com>
Date:   Mon Jan 15 10:30:00 2024 +0000

    Add user authentication

    Implement JWT token-based authentication.

diff --git a/auth.js b/auth.js
...
```

## Real-World Commit Patterns

### Pattern 1: Feature Development

```bash
# Start feature
git checkout -b feature/auth

# Make changes
vim auth.js
git add auth.js
git commit -m "Add JWT token generation"

# More changes
vim auth.js
git add auth.js
git commit -m "Add token validation logic"

# Finish feature
git add .
git commit -m "Complete authentication feature"
```

### Pattern 2: Bug Fixes

```bash
# Create fix branch
git checkout -b fix/memory-leak

# Fix the bug
vim memory-leak.js
git add memory-leak.js
git commit -m "Fix memory leak in image processing"

# Test and verify
# Then merge
```

### Pattern 3: Daily Work

```bash
# Morning: Get latest
git pull

# During day: Small commits
git add file1.txt
git commit -m "Update configuration"

git add file2.txt
git commit -m "Fix typo in documentation"

# End of day: Push
git push
```

## My Take: Commit Often

I used to make huge commits. Hours of work. Dozens of files. One massive commit.

Then I learned: **Small, frequent commits are better.**

- Easier to review
- Easier to understand
- Easier to revert if needed
- Better history

**Commit like you're telling a story. Each commit is a chapter.**

## Memory Tip: The Photo Album Analogy

Think of commits like photos in an album:
- **Each commit is a photo** - A snapshot in time
- **Commit message is the caption** - Describes what's in the photo
- **History is the album** - All photos in order
- **You can go back** - Look at any photo anytime

## Common Mistakes

### Mistake 1: Vague Messages

```bash
# Don't do this
git commit -m "Update"
```

**Fix**: Be specific: "Add user login validation"

### Mistake 2: Too Many Changes

```bash
# Don't do this
# Change 20 files, fix 5 bugs, add 3 features
git add .
git commit -m "Update everything"
```

**Fix**: Make separate commits for separate changes.

### Mistake 3: Forgetting to Stage

```bash
# Don't do this
git commit -m "Update"
# Error: nothing to commit
```

**Fix**: Always stage with `git add` first.

## Key Takeaways

1. **Commits are permanent snapshots** - They're your history
2. **Write good commit messages** - Future you will thank you
3. **Commit often** - Small commits are better than big ones
4. **Stage before committing** - Use `git add` first
5. **Commits are safety nets** - You can always go back

## Hands-On: Make Your First Commit

Let's commit something real:

```bash
# Create a file
echo "# My Project" > README.md

# Stage it
git add README.md

# Commit it
git commit -m "Add README file"

# View your commit
git log --oneline
```

![First Commit Hands-On](/img/git-github/hands-on/first-commit-hands-on.png)

**What you should see**:
- Your commit hash
- Your commit message
- Author and timestamp

**Try it**: Make a commit, then use `git show` to see the details.

## What's Next?

Now that you can make commits, let's learn about viewing and understanding history. Next: [Viewing History](/docs/git-github/basic-operations/viewing-history).

Or practice with: [Hands-On Exercises](/docs/git-github/basic-operations/hands-on-exercises).

---

> **Remember**: Every commit is a chapter in your project's story. Make it count.

