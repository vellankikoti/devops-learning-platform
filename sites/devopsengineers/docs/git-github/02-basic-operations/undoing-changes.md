---
sidebar_position: 4
title: Undoing Changes
---

# Undoing Changes: Git's Safety Net

**Mistakes happen. Git lets you undo them. Understanding how to undo changes is understanding Git's safety net.**

## 🎯 The Big Picture

Git gives you multiple ways to undo changes. Each method has a purpose. Each method has consequences. Understanding when to use which method is what separates beginners from experts.

**Think of it like this: Git is a time machine. Undoing changes is going back in time. But you need to know which time machine to use.**

## Types of Undo Operations

### 1. Discard Uncommitted Changes

**Situation**: You made changes but haven't committed. You want to discard them.

```bash
# Discard changes in a file
git restore file.txt

# Or (older Git versions)
git checkout -- file.txt

# Discard all uncommitted changes
git restore .

# See what would be discarded
git status
```

**When to use**: You made a mistake, haven't committed, and want to start over.

**Warning**: This is permanent. Make sure you want to lose these changes.

### 2. Unstage Changes

**Situation**: You staged changes but want to unstage them.

```bash
# Unstage a file
git restore --staged file.txt

# Or (older Git versions)
git reset HEAD file.txt

# Unstage all files
git restore --staged .
```

**When to use**: You staged the wrong files or want to stage them differently.

**Note**: Files remain modified, just not staged.

### 3. Undo Last Commit (Keep Changes)

**Situation**: You committed but want to undo the commit, keeping your changes.

```bash
# Undo commit, keep changes staged
git reset --soft HEAD~1

# Undo commit, keep changes unstaged
git reset --mixed HEAD~1
# Or just:
git reset HEAD~1
```

**When to use**: You committed too early or with wrong message.

**Note**: Changes remain in your working directory.

### 4. Undo Last Commit (Discard Changes)

**Situation**: You committed but want to completely undo it.

```bash
# Undo commit and discard changes
git reset --hard HEAD~1

# Warning: This is destructive!
```

**When to use**: You committed something you don't want at all.

**Warning**: This permanently deletes the commit and changes. Use carefully.

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

**When to use**: You've already pushed the commit. Revert is safe for shared branches.

**Why revert instead of reset?** Revert doesn't rewrite history. It creates a new commit.

## Real-World Scenarios

### Scenario 1: Oops, Wrong File

```bash
# You edited the wrong file
vim wrong-file.txt

# Discard the changes
git restore wrong-file.txt

# Now edit the correct file
vim correct-file.txt
```

### Scenario 2: Committed Too Early

```bash
# You committed but forgot a file
git commit -m "Add feature"

# Undo the commit, keep changes
git reset --soft HEAD~1

# Add the forgotten file
git add forgotten-file.txt

# Commit again
git commit -m "Add feature with all files"
```

### Scenario 3: Wrong Commit Message

```bash
# You committed with typo in message
git commit -m "Fix bugg"  # Typo!

# Amend the message
git commit --amend -m "Fix bug"

# If already pushed, you'll need to force push (be careful!)
```

### Scenario 4: Undo Pushed Commit

```bash
# You pushed a bad commit
git push origin main

# Revert it (safe method)
git revert HEAD
git push origin main

# Now there's a new commit that undoes the bad one
```

## Understanding Reset Options

### `--soft`: Keep Changes Staged

```bash
git reset --soft HEAD~1
```

**What happens**:
- Commit is undone
- Changes remain staged
- Ready to commit again

**Use when**: You want to recommit with different message or add more files.

### `--mixed` (default): Keep Changes Unstaged

```bash
git reset --mixed HEAD~1
# Or just:
git reset HEAD~1
```

**What happens**:
- Commit is undone
- Changes remain in working directory (unstaged)
- You can edit before recommitting

**Use when**: You want to modify changes before recommitting.

### `--hard`: Discard Everything

```bash
git reset --hard HEAD~1
```

**What happens**:
- Commit is undone
- Changes are discarded
- Working directory matches previous commit

**Use when**: You want to completely remove the commit and changes.

**Warning**: This is destructive. Make sure you want to lose the changes.

## My Take: Undo with Confidence

I used to be scared of undoing changes. I'd think I'd break something. I'd avoid it.

Then I learned: **Git's undo operations are safe if you understand them.**

Now I undo confidently:
- Wrong changes? Discard them.
- Wrong commit? Reset it.
- Already pushed? Revert it.

**Understanding undo operations gives you confidence to experiment.**

## Memory Tip: The Time Machine Analogy

Think of undo operations like time travel:
- **restore**: Go back in time, discard changes
- **reset --soft**: Go back, keep changes ready
- **reset --mixed**: Go back, keep changes to edit
- **reset --hard**: Go back, forget everything
- **revert**: Create new timeline that undoes changes

Once you see it that way, undo operations make sense.

## Common Mistakes

### Mistake 1: Hard Reset on Shared Branch

```bash
# Don't do this on shared branches
git reset --hard HEAD~1
git push --force  # Others have this commit!
```

**Fix**: Use `revert` on shared branches. Only reset on private branches.

### Mistake 2: Losing Work with Hard Reset

```bash
# Don't do this without checking
git reset --hard HEAD~5  # Lost 5 commits!
```

**Fix**: Check `git log` first. Use `reflog` to recover if needed.

### Mistake 3: Not Understanding the Difference

```bash
# Don't use reset when you mean revert
git reset HEAD~1  # On pushed commit
git push --force  # Rewrites history!
```

**Fix**: Use `revert` for pushed commits. Use `reset` for local commits.

## Key Takeaways

1. **Multiple undo methods** - Each has a purpose
2. **restore for uncommitted** - Discard working directory changes
3. **reset for local commits** - Undo commits that aren't pushed
4. **revert for pushed commits** - Safe method for shared branches
5. **Understand consequences** - Each method has different effects

## What's Next?

Now that you can undo changes, let's learn about working with files. Next: [Working with Files](/docs/git-github/basic-operations/working-with-files).

---

> **Remember**: Undo operations are tools. Use them confidently, but understand what they do.

