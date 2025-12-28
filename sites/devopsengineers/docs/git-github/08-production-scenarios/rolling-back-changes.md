---
sidebar_position: 2
title: Rolling Back Changes
---

# Rolling Back Changes: The Undo Button for Git

**Things break. Code has bugs. Deployments fail. Git lets you go back. Here's how.**

## 🎯 The Big Picture

Rolling back is Git's superpower. When something breaks, you don't panic. You go back to when it worked.

**Master rollbacks, and you'll sleep better at night.**

## When to Roll Back

Roll back when:
- A deployment breaks production
- A commit introduces a critical bug
- You need to revert a feature
- You want to undo recent changes

**Rollbacks are safety nets. Use them without shame.**

## Types of Rollbacks

### 1. Undo Uncommitted Changes

**Situation**: You made changes but haven't committed yet. You want to discard them.

```bash
# See what would be discarded
git status

# Discard changes in working directory
git checkout -- file.txt

# Discard all uncommitted changes
git checkout -- .

# Or use restore (newer Git)
git restore file.txt
git restore .
```

**Warning**: This is permanent. Make sure you want to lose these changes.

### 2. Unstage Changes

**Situation**: You staged changes but want to unstage them.

```bash
# Unstage a file
git reset HEAD file.txt

# Unstage all files
git reset HEAD

# Or use restore (newer Git)
git restore --staged file.txt
```

### 3. Undo Last Commit (Keep Changes)

**Situation**: You committed but want to undo the commit, keeping your changes.

```bash
# Undo commit, keep changes staged
git reset --soft HEAD~1

# Undo commit, keep changes unstaged
git reset --mixed HEAD~1
# Or just:
git reset HEAD~1

# See the result
git status
```

### 4. Undo Last Commit (Discard Changes)

**Situation**: You committed but want to completely undo it.

```bash
# Undo commit and discard changes
git reset --hard HEAD~1

# Warning: This is destructive!
```

### 5. Revert a Commit (Safe Method)

**Situation**: You want to undo a commit that's already been pushed.

```bash
# Revert creates a new commit that undoes changes
git revert HEAD

# Revert a specific commit
git revert abc1234

# Revert multiple commits
git revert HEAD~3..HEAD
```

**Why revert instead of reset?** Revert is safe for shared branches. It doesn't rewrite history.

## Production Rollback Scenarios

### Scenario 1: Quick Production Fix

**Situation**: Bad code deployed to production. Need immediate rollback.

```bash
# 1. Find the last good commit
git log --oneline -10

# 2. Revert the bad commit (if it's the latest)
git revert HEAD
git push

# Or reset to last good commit (if you control the branch)
git reset --hard <good-commit-hash>
git push --force  # Only if you're sure!
```

**Important**: Use `revert` if others have pulled. Use `reset` only if you're certain.

### Scenario 2: Rollback Multiple Commits

**Situation**: Last 3 commits broke something. Need to go back.

```bash
# Option 1: Revert (safe)
git revert HEAD~2..HEAD
git push

# Option 2: Reset (if branch is private)
git reset --hard HEAD~3
git push --force
```

### Scenario 3: Rollback a Specific File

**Situation**: One file is broken. Rest is fine.

```bash
# Restore file from specific commit
git checkout <good-commit-hash> -- file.txt

# Or from HEAD (last commit)
git checkout HEAD -- file.txt

# Stage and commit
git add file.txt
git commit -m "Rollback file.txt to working version"
git push
```

### Scenario 4: Emergency Hotfix Rollback

**Situation**: Production is down. Need to rollback immediately.

```bash
# 1. Create hotfix branch from last good commit
git checkout -b hotfix/rollback <good-commit-hash>

# 2. Merge to main (or deploy directly)
git checkout main
git merge hotfix/rollback

# 3. Push and deploy
git push

# 4. Fix the issue in a new branch
git checkout -b fix/production-issue
# ... fix the issue ...
```

## Advanced Rollback Techniques

### Using Reflog

**Situation**: You reset too far. Need to find a lost commit.

```bash
# See recent actions
git reflog

# Output shows commits you can recover
# abc1234 HEAD@{0}: reset: moving to HEAD~3
# def5678 HEAD@{1}: commit: Good commit

# Recover the commit
git checkout def5678
# Or
git reset --hard def5678
```

### Partial Rollback

**Situation**: Some changes in a commit are good, some are bad.

```bash
# Use interactive rebase
git rebase -i HEAD~5

# Mark commit as 'edit'
# Make changes
git add file.txt
git commit --amend
git rebase --continue
```

## My Take: Rollbacks Are Normal

I used to think rollbacks meant I failed. I'd try to fix forward. I'd avoid going back.

Then I learned: **Rollbacks are tools. They're not failures. They're safety nets.**

Now I rollback without hesitation:
- Bad deployment? Rollback.
- Critical bug? Rollback.
- Wrong feature? Rollback.

**Fix forward when you can. Rollback when you must.**

## Memory Tip: The Time Machine Analogy

Think of rollbacks like a time machine:
- **Reset**: Go back in time, change history
- **Revert**: Create a new timeline that undoes changes
- **Checkout**: Visit a point in time, see what it was like
- **Reflog**: Your time travel log

Once you see it that way, rollbacks make sense.

## Common Mistakes

### Mistake 1: Force Pushing to Shared Branches

```bash
# Don't do this on shared branches
git reset --hard HEAD~1
git push --force  # Others have this commit!
```

**Fix**: Use `revert` on shared branches. Only force push on private branches.

### Mistake 2: Losing Work with Hard Reset

```bash
# Don't do this without checking
git reset --hard HEAD~5  # Lost 5 commits!
```

**Fix**: Check `git log` first. Use `reflog` to recover if needed.

### Mistake 3: Not Testing After Rollback

```bash
# Don't do this
git revert HEAD
git push
# Then realize rollback broke something else
```

**Fix**: Always test after rollback. Rollbacks can have side effects.

## Key Takeaways

1. **Rollbacks are safety nets** - Use them when needed
2. **Revert for shared branches** - It's safe
3. **Reset for private branches** - When you control the branch
4. **Check reflog** - To recover lost commits
5. **Test after rollback** - Make sure it works

## What's Next?

Now that you can rollback, let's learn about emergency fixes. Next: [Emergency Fixes](/docs/git-github/production-scenarios/emergency-fixes).

---

> **Remember**: Rollbacks aren't failures. They're tools. Use them confidently.

