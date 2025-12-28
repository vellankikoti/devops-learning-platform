---
sidebar_position: 4
title: The Git Workflow
---

# The Git Workflow: How Git Actually Works

**Understanding Git's workflow is understanding how to use Git. Master this, and everything else makes sense.**

## 🎯 The Big Picture

Git's workflow is simple: **Edit → Stage → Commit → Repeat.**

But understanding *why* each step exists is what separates beginners from experts.

## The Three States

Git has three states for your files:

1. **Working Directory**: Your actual files (where you edit)
2. **Staging Area**: Files marked to be committed (the "index")
3. **Repository**: Committed snapshots (the history)

```
Working Directory → git add → Staging Area → git commit → Repository
```

## The Basic Workflow

### Step 1: Edit Files (Working Directory)

```bash
# Edit a file
echo "# My Project" > README.md

# Check status
git status
# Output: README.md is "untracked" or "modified"
```

**What's happening?** You're editing files in your working directory. Git sees the changes but hasn't saved them yet.

### Step 2: Stage Changes (Staging Area)

```bash
# Stage a file
git add README.md

# Or stage all changes
git add .

# Check status
git status
# Output: README.md is "staged for commit"
```

**What's happening?** You're telling Git: "These changes are ready to be saved." Git copies the changes to the staging area.

**Why stage?** It lets you choose what to commit. You can stage some changes and leave others for later.

### Step 3: Commit (Repository)

```bash
# Commit staged changes
git commit -m "Add README"

# Check status
git status
# Output: "working tree clean"
```

**What's happening?** Git takes everything in the staging area and creates a permanent snapshot (commit) in the repository.

**Why commit?** Commits are permanent history. They're your safety net. You can always go back to any commit.

## Visualizing the Workflow

```
┌─────────────────┐
│ Working         │  ← You edit files here
│ Directory       │
└────────┬────────┘
         │ git add
         ▼
┌─────────────────┐
│ Staging Area    │  ← You choose what to save
│ (Index)         │
└────────┬────────┘
         │ git commit
         ▼
┌─────────────────┐
│ Repository      │  ← Permanent history
│ (.git folder)   │
└─────────────────┘
```

## Real-World Example

Let's say you're working on a script:

```bash
# 1. Edit the script
vim deploy.sh

# 2. Stage the changes
git add deploy.sh

# 3. Commit
git commit -m "Add deployment script"

# 4. Make more changes
vim deploy.sh

# 5. Stage and commit again
git add deploy.sh
git commit -m "Fix deployment script bug"
```

**Each commit is a snapshot. You can go back to any one.**

## Why This Workflow?

### Why Three States?

**Working Directory**: You need a place to edit files.

**Staging Area**: You need to choose what to commit. Not everything is ready at once.

**Repository**: You need permanent history. Once committed, it's saved forever.

### Why Not Just Commit Directly?

You *could* skip staging:

```bash
# This stages and commits in one step
git commit -a -m "Message"
```

But staging gives you control:
- Review changes before committing
- Commit related changes together
- Leave unrelated changes for later

**Staging is a feature, not a burden.**

## Common Workflow Patterns

### Pattern 1: Small, Frequent Commits

```bash
# Make a small change
git add file1.txt
git commit -m "Fix typo in file1"

# Make another small change
git add file2.txt
git commit -m "Update file2"
```

**When to use**: Working on multiple small fixes.

### Pattern 2: Group Related Changes

```bash
# Make multiple related changes
git add file1.txt file2.txt file3.txt
git commit -m "Add authentication feature"
```

**When to use**: Completing a feature with multiple files.

### Pattern 3: Commit Everything

```bash
# Stage all changes
git add .

# Commit
git commit -m "Update project"
```

**When to use**: End of day, saving all work.

## My Take: Workflow Is Everything

I used to skip staging. I'd commit everything at once. My commit history was messy.

Then I learned to stage thoughtfully. My commits became logical. My history became readable.

**The workflow isn't just about saving changes. It's about creating good history.**

## Memory Tip: The Photo Album Analogy

Think of Git like a photo album:
- **Working Directory**: Taking photos (editing files)
- **Staging Area**: Choosing which photos to print (selecting changes)
- **Repository**: The photo album (permanent history)

You don't print every photo. You choose the good ones. Same with commits.

## Common Mistakes

### Mistake 1: Forgetting to Stage

```bash
# This won't work
git commit -m "Message"
# Error: nothing to commit
```

**Fix**: Always stage before committing (unless using `-a` flag).

### Mistake 2: Staging Too Much

```bash
# Don't do this
git add .  # Stages everything, including temporary files
git commit -m "Update"
```

**Fix**: Use `.gitignore` to exclude files, or stage specific files.

### Mistake 3: Not Committing Often

```bash
# Don't do this
# Work for hours without committing
# Then lose everything when something breaks
```

**Fix**: Commit frequently. Small commits are better than big ones.

## Key Takeaways

1. **Three states**: Working Directory → Staging → Repository
2. **Workflow**: Edit → Stage → Commit → Repeat
3. **Staging is important** - It lets you choose what to commit
4. **Commit frequently** - Small commits are better than big ones
5. **Workflow creates history** - Good workflow = good history

## What's Next?

Now that you understand the workflow, let's learn the essential commands. Next: [Essential Git Commands](/docs/git-github/fundamentals/essential-commands).

---

> **Remember**: The workflow is simple. Master it, and Git becomes easy.

