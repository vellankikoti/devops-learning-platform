---
sidebar_position: 4
title: Rebase
---

# Rebase: Rewriting History

**Rebase is Git's way of rewriting history. Understanding rebase is understanding how to create clean, linear history.**

## 🎯 The Big Picture

Rebase takes commits from one branch and replays them on top of another branch. It creates linear history. It's powerful. It's dangerous if misused.

**Think of it like this: If merge is combining timelines, rebase is rewriting one timeline to come after another. It makes history linear.**

## What Is Rebase?

**Rebase** takes the commits from your branch and replays them on top of another branch. It rewrites history to make it linear.

```bash
# Rebase feature branch on top of main
git checkout feature-branch
git rebase main

# Your commits are now on top of main
```

## Basic Rebase

### Rebase Your Branch

```bash
# Start on feature branch
git checkout feature-branch

# Rebase on main
git rebase main

# Your commits are now on top of latest main
```

### What Happens

```
Before:
main:     A---B---C
                \
feature:         D---E

After:
main:     A---B---C
                    \
feature:             D'---E'
```

**Note**: Commits D and E become D' and E' (new commit hashes).

## Interactive Rebase

Interactive rebase lets you edit commits as you rebase.

```bash
# Rebase last 3 commits interactively
git rebase -i HEAD~3

# Opens editor with:
# pick abc1234 Commit 1
# pick def5678 Commit 2
# pick ghi9012 Commit 3

# You can:
# - pick: Keep commit as is
# - reword: Change commit message
# - edit: Edit commit
# - squash: Combine with previous
# - drop: Remove commit
```

### Interactive Rebase Options

```bash
# pick: Use commit as is
pick abc1234 Commit message

# reword: Change commit message
reword abc1234 Old message

# edit: Edit commit
edit abc1234 Commit message

# squash: Combine with previous
squash abc1234 Commit message

# drop: Remove commit
drop abc1234 Commit message
```

## Common Rebase Operations

### Clean Up Commits

```bash
# Rebase last 5 commits
git rebase -i HEAD~5

# Change some to squash, some to reword
# Result: Cleaner commit history
```

### Change Commit Messages

```bash
# Rebase to change message
git rebase -i HEAD~3

# Change 'pick' to 'reword' for commit
# Git opens editor for new message
```

### Combine Commits

```bash
# Rebase to combine commits
git rebase -i HEAD~5

# Change 'pick' to 'squash' for commits you want to combine
# Git combines them into one
```

## Rebase vs Merge

### Merge

```
main:     A---B-------M (merge commit)
                \     /
feature:         C---D
```

**Pros**: Preserves history, safe  
**Cons**: Creates merge commits

### Rebase

```
main:     A---B
                \
feature:         C---D
```

After rebase:
```
main:     A---B---C---D
```

**Pros**: Linear history, clean  
**Cons**: Rewrites history

## When to Use Rebase

### Use Rebase When:
- Working on feature branch alone
- Want linear history
- Haven't pushed yet (or can force push)
- Cleaning up commits before merge

### Don't Use Rebase When:
- Branch is shared with others
- Others have based work on your commits
- You're not comfortable with force push

## Real-World Rebase Scenarios

### Scenario 1: Clean Up Before Merge

```bash
# Feature branch with messy commits
git checkout feature-branch

# Clean up commits
git rebase -i main

# Combine related commits, fix messages
# Result: Clean history ready to merge
```

### Scenario 2: Update Feature Branch

```bash
# main has new commits
git checkout feature-branch

# Rebase on latest main
git rebase main

# Your commits are now on top of latest main
```

### Scenario 3: Fix Commit History

```bash
# You made commits with typos
git rebase -i HEAD~5

# Change 'pick' to 'reword' for commits with typos
# Fix messages
# Result: Clean commit history
```

## Rebase Conflicts

Rebase can have conflicts, just like merge.

```bash
# Rebase with conflicts
git rebase main

# Conflict in file.txt
# Resolve it:
vim file.txt
git add file.txt

# Continue rebase
git rebase --continue

# If more conflicts, repeat
```

### Abort Rebase

```bash
# If rebase goes wrong
git rebase --abort

# Returns to state before rebase
```

## My Take: Rebase Is Powerful

I used to avoid rebase. I thought it was dangerous. I stuck to merge.

Then I learned: **Rebase is powerful. Use it when appropriate.**

Now I rebase:
- Before merging feature branches (clean history)
- To update branches (latest main)
- To fix commit messages (cleaner history)

**Rebase is a tool. Use it wisely.**

## Memory Tip: The Movie Analogy

Think of rebase like editing a movie:
- **Merge**: Two movies playing side by side
- **Rebase**: One movie edited to come after another
- **Interactive**: You're the editor, choosing what to keep

Once you see it that way, rebase makes sense.

## Common Mistakes

### Mistake 1: Rebasing Shared Branches

```bash
# Don't do this
git checkout main
git rebase feature-branch
git push --force  # Others have this branch!
```

**Fix**: Only rebase branches you own, or coordinate with team.

### Mistake 2: Forgetting to Continue

```bash
# Don't do this
git rebase main
# Resolve conflicts
git add file.txt
# Forget to continue!
```

**Fix**: Always `git rebase --continue` after resolving conflicts.

### Mistake 3: Rebasing Public Commits

```bash
# Don't do this
git rebase -i HEAD~10
git push --force  # If others have these commits!
```

**Fix**: Only rebase commits that haven't been shared.

## Key Takeaways

1. **Rebase rewrites history** - Creates linear history
2. **Interactive rebase** - Edit commits as you rebase
3. **Use before merge** - Clean history before merging
4. **Don't rebase shared branches** - Only your own branches
5. **Powerful but dangerous** - Use wisely

## What's Next?

Now that you understand rebase, let's learn about handling conflicts during rebase. Next: [Conflict Resolution in Branches](/docs/git-github/branching-merging/conflict-resolution-in-branches).

---

> **Remember**: Rebase is powerful. Use it to create clean history, but be careful with shared branches.

