---
sidebar_position: 4
title: Recovering Lost Commits
---

# Recovering Lost Commits: Git's Safety Net

**You lost a commit. Don't panic. Git has your back. Understanding how to recover lost commits is understanding Git's safety net.**

## 🎯 The Big Picture

Git rarely loses commits permanently. Even if you reset, delete branches, or make mistakes, commits are usually recoverable. Reflog is your friend.

**Think of it like this: Git is like a time machine with a log. Even if you travel back in time, the log remembers where you were.**

## Using Reflog

### View Reflog

```bash
# See recent actions
git reflog

# Output shows commits, resets, checkouts
# abc1234 HEAD@{0}: commit: Latest commit
# def5678 HEAD@{1}: reset: moving to HEAD~1
# ghi9012 HEAD@{2}: commit: Previous commit
```

### Recover from Reflog

```bash
# Find the commit in reflog
git reflog

# Recover it
git checkout abc1234

# Or create branch from it
git checkout -b recovered-branch abc1234
```

## Common Recovery Scenarios

### Scenario 1: Reset Too Far

```bash
# You reset too far
git reset --hard HEAD~5

# Recover using reflog
git reflog
# Find the commit before reset
git reset --hard HEAD@{1}
```

### Scenario 2: Deleted Branch

```bash
# You deleted a branch
git branch -D feature/branch

# Recover using reflog
git reflog
# Find last commit on that branch
git checkout -b feature/branch abc1234
```

### Scenario 3: Lost Uncommitted Changes

```bash
# You lost uncommitted changes
# Check reflog for stash or commit
git reflog

# Or check fsck for dangling commits
git fsck --lost-found
```

## My Take: Reflog Is Your Safety Net

Reflog is Git's safety net. It remembers everything. Use it when you lose commits.

## Key Takeaways

1. **Reflog remembers** - Git logs all actions
2. **Commits rarely lost** - Usually recoverable
3. **Use reflog** - To find lost commits
4. **Create branch** - To recover safely
5. **Git is safe** - Commits are hard to lose permanently

## What's Next?

You've learned about recovering lost commits. Review [Rolling Back Changes](/docs/git-github/production-scenarios/rolling-back-changes) for more recovery techniques.

---

> **Remember**: Reflog is your safety net. Git rarely loses commits permanently.

