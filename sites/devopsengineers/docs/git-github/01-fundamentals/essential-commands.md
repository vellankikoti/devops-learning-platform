---
sidebar_position: 5
title: Essential Git Commands
---

# Essential Git Commands: The Commands You'll Use Every Day

**These are the commands you'll use 90% of the time. Master these, and you can do most Git work.**

## 🎯 The Big Picture

You don't need to memorize every Git command. You need to master the essential ones. These are the commands that do 90% of the work.

## The Essential Commands

### 1. `git status` - See What's Changed

```bash
git status
```

**What it does**: Shows the state of your working directory and staging area.

**When to use**: Always. Before and after every operation.

**Example output**:
```
On branch main
Changes not staged for commit:
  modified:   file.txt

Changes to be committed:
  new file:   newfile.txt
```

**Pro tip**: Use `git status -s` for short format.

### 2. `git add` - Stage Changes

```bash
# Stage a specific file
git add file.txt

# Stage all changes
git add .

# Stage all changes in a directory
git add src/

# Stage specific patterns
git add *.txt
```

**What it does**: Moves changes from working directory to staging area.

**When to use**: Before every commit.

**Pro tip**: Review changes with `git diff` before staging.

### 3. `git commit` - Save Changes

```bash
# Commit with message
git commit -m "Add new feature"

# Commit and stage all tracked files
git commit -a -m "Update files"

# Commit without opening editor
git commit -m "Message" --no-edit
```

**What it does**: Creates a permanent snapshot of staged changes.

**When to use**: After staging changes you want to save.

**Pro tip**: Write clear commit messages. Future you will thank you.

### 4. `git log` - View History

```bash
# View commit history
git log

# One line per commit
git log --oneline

# Show last 5 commits
git log -5

# Show with file changes
git log --stat

# Show with actual changes
git log -p
```

**What it does**: Shows the commit history.

**When to use**: To see what changed, when, and by whom.

**Pro tip**: Use `git log --oneline --graph --all` for a visual history.

### 5. `git diff` - See Changes

```bash
# See unstaged changes
git diff

# See staged changes
git diff --staged

# See changes in a file
git diff file.txt

# See changes between commits
git diff commit1 commit2
```

**What it does**: Shows differences between versions.

**When to use**: Before staging, to review what changed.

**Pro tip**: Use `git diff --color-words` for word-level diffs.

### 6. `git clone` - Copy a Repository

```bash
# Clone a repository
git clone https://github.com/user/repo.git

# Clone to a specific directory
git clone https://github.com/user/repo.git my-project

# Clone a specific branch
git clone -b branch-name https://github.com/user/repo.git
```

**What it does**: Downloads a repository and creates a local copy.

**When to use**: When you want to work on an existing project.

**Pro tip**: Use SSH URLs for repositories you have access to.

### 7. `git pull` - Get Latest Changes

```bash
# Pull latest changes
git pull

# Pull from specific remote
git pull origin main

# Pull with rebase
git pull --rebase
```

**What it does**: Downloads and merges changes from remote repository.

**When to use**: Before starting work, to get latest changes.

**Pro tip**: Always pull before pushing.

### 8. `git push` - Send Changes

```bash
# Push to remote
git push

# Push to specific remote and branch
git push origin main

# Push and set upstream
git push -u origin main
```

**What it does**: Uploads your commits to remote repository.

**When to use**: After committing changes you want to share.

**Pro tip**: Use `-u` flag on first push to set upstream.

### 9. `git branch` - Manage Branches

```bash
# List branches
git branch

# Create a branch
git branch feature-branch

# Delete a branch
git branch -d feature-branch

# Force delete
git branch -D feature-branch
```

**What it does**: Lists, creates, and deletes branches.

**When to use**: When working on features or fixes.

**Pro tip**: Use `git branch -a` to see all branches including remotes.

### 10. `git checkout` - Switch Branches

```bash
# Switch to a branch
git checkout branch-name

# Create and switch to branch
git checkout -b new-branch

# Switch to a file version
git checkout commit-hash -- file.txt
```

**What it does**: Switches between branches or restores files.

**When to use**: To work on different branches or restore files.

**Pro tip**: Use `git switch` (newer Git) instead of `git checkout` for branches.

## Command Combinations (Real-World Usage)

### Daily Workflow

```bash
# Start of day
git pull                    # Get latest changes
git status                  # See what's changed

# During work
git add file.txt            # Stage changes
git commit -m "Message"     # Save changes

# End of day
git push                    # Share changes
```

### Review Before Committing

```bash
git status                  # See what changed
git diff                    # Review unstaged changes
git add file.txt            # Stage
git diff --staged           # Review staged changes
git commit -m "Message"     # Commit
```

### Working with Branches

```bash
git branch                   # List branches
git checkout -b feature     # Create and switch
# ... make changes ...
git add .
git commit -m "Feature"
git push -u origin feature  # Push new branch
```

## My Take: Less Is More

I used to try to learn every Git command. I'd look up obscure commands. I'd memorize flags I never used.

Then I realized: **Most Git work uses the same 10 commands.**

Master these. Use them daily. Then learn more as you need them.

**Don't memorize everything. Master the essentials.**

## Memory Tip: The Daily Commands

Remember the daily workflow:
1. **`git status`** - What's changed?
2. **`git add`** - Stage it
3. **`git commit`** - Save it
4. **`git push`** - Share it
5. **`git pull`** - Get updates

That's 80% of Git work right there.

## Common Mistakes

### Mistake 1: Not Checking Status

```bash
# Don't do this
git commit -m "Update"
# Error: nothing to commit
```

**Fix**: Always run `git status` first.

### Mistake 2: Forgetting to Stage

```bash
# Don't do this
git commit -m "Update"
# Error: nothing to commit
```

**Fix**: Stage with `git add` before committing.

### Mistake 3: Vague Commit Messages

```bash
# Don't do this
git commit -m "Update"
git commit -m "Fix"
git commit -m "Changes"
```

**Fix**: Write descriptive messages: "Add user authentication feature"

## Key Takeaways

1. **10 essential commands** - These do 90% of the work
2. **`git status` is your friend** - Use it constantly
3. **Workflow**: status → add → commit → push
4. **Master the basics first** - Then learn advanced commands
5. **Practice daily** - These commands become muscle memory

## What's Next?

Now that you know the essential commands, let's start using them. Next: [Initializing Repositories](/docs/git-github/basic-operations/initializing-repositories).

---

> **Remember**: Master these 10 commands, and you can do most Git work. Don't overthink it.

