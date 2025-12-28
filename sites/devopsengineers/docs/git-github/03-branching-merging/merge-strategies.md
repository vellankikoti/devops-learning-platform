---
sidebar_position: 3
title: Merge Strategies
---

# Merge Strategies: How Git Combines Branches

**Git has different ways to merge branches. Understanding merge strategies is understanding how to control your history.**

## 🎯 The Big Picture

Not all merges are the same. Sometimes you want a merge commit. Sometimes you want linear history. Sometimes you want to squash everything. Git gives you options.

**Think of it like this: Merge strategies are different recipes. Same ingredients (branches), different results (history).**

## Default Strategy: Recursive

Git's default merge strategy. Handles most cases automatically.

```bash
# Git automatically uses recursive strategy
git merge feature-branch

# Output: Merge made by the 'recursive' strategy.
```

**When to use**: Most common case. Let Git handle it.

**Result**: Creates merge commit with two parents.

## Fast-Forward Only

Only merges if it can fast-forward. Fails otherwise.

```bash
# Only fast-forward, no merge commit
git merge --ff-only feature-branch

# If fast-forward isn't possible:
# fatal: Not possible to fast-forward, aborting.
```

**When to use**: You want linear history. No merge commits.

**Result**: Linear history, no merge commit.

## No Fast-Forward

Always creates a merge commit, even if fast-forward is possible.

```bash
# Always create merge commit
git merge --no-ff feature-branch

# Creates merge commit even if fast-forward possible
```

**When to use**: You want to preserve branch history in main.

**Result**: Merge commit always created.

## Squash Merge

Combines all commits from feature branch into one commit.

```bash
# Squash all commits
git merge --squash feature-branch

# All commits combined, but not committed yet
# You need to commit:
git commit -m "Add feature"
```

**When to use**: You want clean history. All feature work becomes one commit.

**Result**: One commit with all changes.

## Strategy Comparison

### Fast-Forward

```
Before:
main:     A---B
                \
feature:         C---D

After:
main:     A---B---C---D
```

**Pros**: Clean, linear history  
**Cons**: Loses branch context

### No Fast-Forward

```
Before:
main:     A---B
                \
feature:         C---D

After:
main:     A---B-------M (merge commit)
                \     /
feature:         C---D
```

**Pros**: Preserves branch history  
**Cons**: More merge commits

### Squash

```
Before:
main:     A---B
                \
feature:         C---D---E

After:
main:     A---B---S (squashed commit)
```

**Pros**: Very clean history  
**Cons**: Loses individual commit history

## Real-World Strategy Selection

### Scenario 1: Feature Development

```bash
# Feature branch with multiple commits
git checkout -b feature/auth
git commit -m "Add login form"
git commit -m "Add validation"
git commit -m "Add JWT tokens"

# Merge with no-ff to preserve context
git checkout main
git merge --no-ff feature/auth
```

**Why**: Preserves that this was a feature branch with multiple commits.

### Scenario 2: Hotfix

```bash
# Hotfix with one commit
git checkout -b hotfix/security-patch
git commit -m "Fix security vulnerability"

# Fast-forward is fine
git checkout main
git merge hotfix/security-patch
```

**Why**: Simple fix, linear history is fine.

### Scenario 3: Experimental Feature

```bash
# Experimental branch with many commits
git checkout -b experiment/new-approach
# ... 20 commits of experimentation ...

# Squash into one commit
git checkout main
git merge --squash experiment/new-approach
git commit -m "Add experimental feature"
```

**Why**: Experimental work becomes one clean commit.

## Choosing the Right Strategy

### Use Fast-Forward When:
- Simple feature
- Linear history preferred
- No need to preserve branch context

### Use No Fast-Forward When:
- Feature branch with meaningful commits
- Want to preserve branch history
- Team wants to see feature development

### Use Squash When:
- Many small commits
- Want very clean history
- Feature work should be one unit

## My Take: Strategy Matters

I used to just merge. I'd let Git decide. I didn't think about strategy.

Then I learned: **Strategy affects history. History affects understanding.**

Now I choose strategies thoughtfully:
- Feature branches? No-ff to preserve context.
- Hotfixes? Fast-forward for simplicity.
- Experiments? Squash for cleanliness.

**Strategy is about communication. Choose what tells the best story.**

## Memory Tip: The Story Analogy

Think of merge strategies like storytelling:
- **Fast-forward**: Simple story, straight timeline
- **No fast-forward**: Story with chapters (branches)
- **Squash**: Summary of the story, one chapter

Choose the strategy that tells the story you want.

## Common Mistakes

### Mistake 1: Always Using Default

```bash
# Don't do this
git merge feature-branch  # Always default
# Sometimes you want different strategy
```

**Fix**: Think about what history you want, choose strategy.

### Mistake 2: Squashing Everything

```bash
# Don't do this
git merge --squash feature-branch  # Always squash
# Loses valuable commit history
```

**Fix**: Use squash selectively, not always.

### Mistake 3: Not Understanding Result

```bash
# Don't do this
git merge --squash feature-branch
# Forget to commit!
```

**Fix**: Squash requires manual commit. Don't forget.

## Key Takeaways

1. **Multiple merge strategies** - Each has a purpose
2. **Fast-forward**: Linear history
3. **No fast-forward**: Preserves branch history
4. **Squash**: Clean, single commit
5. **Choose based on history needs** - What story do you want?

## What's Next?

Now that you understand merge strategies, let's learn about rebase. Next: [Rebase vs Merge](/docs/git-github/branching-merging/rebase).

---

> **Remember**: Merge strategy is about history. Choose what tells the best story.

