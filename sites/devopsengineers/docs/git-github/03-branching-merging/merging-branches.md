---
sidebar_position: 2
title: Merging Branches
---

# Merging Branches: Combining Your Work

**Merging is how you combine branches. Understanding merging is understanding how Git brings different lines of work together.**

## 🎯 The Big Picture

Merging takes changes from one branch and combines them with another. It's how features become part of main. It's how work from different people comes together.

**Think of it like this: If branches are different timelines, merging is combining timelines. Git figures out how to bring them together.**

## What Is a Merge?

A **merge** combines the history of two branches. Git creates a merge commit that has two parents - one from each branch.

```bash
# Merge feature branch into main
git checkout main
git merge feature-branch

# Git creates a merge commit
# Output: Merge made by the 'recursive' strategy.
```

## Basic Merge Process

### Step 1: Switch to Target Branch

```bash
# Switch to the branch you want to merge INTO
git checkout main
```

### Step 2: Merge the Source Branch

```bash
# Merge the branch you want to bring IN
git merge feature-branch
```

### Step 3: Handle Conflicts (If Any)

```bash
# If conflicts occur
# Git will tell you which files have conflicts
# Resolve them, then:
git add resolved-file.txt
git commit
```

## Types of Merges

### Fast-Forward Merge

**When**: The target branch hasn't diverged from the source branch.

```bash
# main is behind feature-branch
# No commits on main since feature-branch was created
git checkout main
git merge feature-branch

# Output: Fast-forward
# No merge commit created, just moves pointer forward
```

**Visual**:
```
Before:
main:     A---B
                \
feature:         C---D

After:
main:     A---B---C---D
```

### Three-Way Merge

**When**: Both branches have new commits.

```bash
# Both branches have new commits
git checkout main
git merge feature-branch

# Output: Merge made by the 'recursive' strategy.
# Creates merge commit with two parents
```

**Visual**:
```
Before:
main:     A---B---C
                \
feature:         D---E

After:
main:     A---B---C---F (merge commit)
                \     /
feature:         D---E
```

## Merge Strategies

### Default Strategy (Recursive)

```bash
# Git automatically chooses best strategy
git merge feature-branch
```

**When to use**: Most common case. Git handles it automatically.

### Fast-Forward Only

```bash
# Only allow fast-forward merges
git merge --ff-only feature-branch

# Fails if fast-forward isn't possible
```

**When to use**: You want linear history. No merge commits.

### No Fast-Forward (Always Create Merge Commit)

```bash
# Always create merge commit
git merge --no-ff feature-branch
```

**When to use**: You want to preserve branch history in main.

### Squash Merge

```bash
# Combine all commits into one
git merge --squash feature-branch
git commit -m "Add feature"
```

**When to use**: You want clean history. All feature commits become one.

## Real-World Merge Scenarios

### Scenario 1: Merging Feature Branch

```bash
# Develop feature
git checkout -b feature/auth
# ... make commits ...
git commit -m "Add authentication"

# Merge to main
git checkout main
git merge feature/auth
git push origin main
```

### Scenario 2: Merging Hotfix

```bash
# Create hotfix from main
git checkout -b hotfix/security-patch main

# Fix the issue
git commit -m "Fix security vulnerability"

# Merge back to main
git checkout main
git merge hotfix/security-patch

# Also merge to develop
git checkout develop
git merge hotfix/security-patch
```

### Scenario 3: Merging with Conflicts

```bash
# Try to merge
git merge feature-branch

# Conflicts!
# Auto-merging file.txt
# CONFLICT (content): Merge conflict in file.txt

# Resolve conflicts
vim file.txt
# Edit file, remove conflict markers

# Stage resolved file
git add file.txt

# Complete merge
git commit
```

## Merge Best Practices

### 1. Update Before Merging

```bash
# Always update target branch first
git checkout main
git pull origin main

# Then merge
git merge feature-branch
```

### 2. Test Before Merging

```bash
# Test feature branch
git checkout feature-branch
npm test

# If tests pass, merge
git checkout main
git merge feature-branch
```

### 3. Use Descriptive Merge Messages

```bash
# Good merge message
git merge feature/auth -m "Merge feature/auth: Add JWT authentication"

# Or let Git create default message
git merge feature/auth
# Git creates: "Merge branch 'feature/auth'"
```

### 4. Clean Up After Merge

```bash
# After successful merge, delete feature branch
git branch -d feature-branch

# Delete remote branch
git push origin --delete feature-branch
```

## My Take: Merging Is Collaboration

I used to be scared of merges. I'd think they were complicated. I'd avoid them.

Then I learned: **Merging is just combining work. Git does the hard part.**

Now I merge confidently:
- Feature done? Merge it.
- Hotfix ready? Merge it.
- Conflicts? Resolve them.

**Merging is how work comes together. Master it.**

## Memory Tip: The River Analogy

Think of merging like rivers joining:
- **Branches are rivers** - Different streams of work
- **Merge is confluence** - Where rivers meet
- **Fast-forward** - One river flows into another
- **Three-way** - Two rivers meet at a point
- **Conflicts** - Turbulent water where they meet

Once you see it that way, merging makes sense.

## Common Mistakes

### Mistake 1: Merging Without Updating

```bash
# Don't do this
git checkout main
git merge feature-branch
# main might be outdated!
```

**Fix**: Always `git pull` first.

### Mistake 2: Merging Wrong Direction

```bash
# Don't do this
git checkout feature-branch
git merge main  # Wrong! Should merge INTO main
```

**Fix**: Merge INTO the target branch (usually main).

### Mistake 3: Not Testing Before Merge

```bash
# Don't do this
git merge feature-branch
# Then realize it breaks things
```

**Fix**: Test feature branch before merging.

## Key Takeaways

1. **Merging combines branches** - Brings different work together
2. **Fast-forward vs three-way** - Git chooses automatically
3. **Update before merging** - Always pull first
4. **Test before merging** - Make sure it works
5. **Clean up after merge** - Delete merged branches

## What's Next?

Now that you can merge branches, let's learn about merge strategies in detail. Next: [Merge Strategies](/docs/git-github/branching-merging/merge-strategies).

---

> **Remember**: Merging is collaboration. Git does the hard part. You just need to understand it.

