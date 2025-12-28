---
sidebar_position: 1
title: Understanding Branches
---

# Understanding Branches: Git's Superpower

**Branches are what make Git powerful. They let you work on multiple things at once. They let you experiment safely. They're essential.**

## 🎯 The Big Picture

Think of branches like this: **If commits are snapshots in time, branches are different timelines you can switch between.**

You can work on a feature in one branch. Fix a bug in another. Experiment in a third. All without affecting each other.

**That's the power of branches.**

## What Is a Branch?

A **branch** is:
- A movable pointer to a commit
- An independent line of development
- A way to work on features without affecting main code
- A timeline you can switch between

```bash
# See current branch
git branch

# Output:
# * main
#   feature/auth
```

The `*` shows your current branch.

## Why Branches Matter

Branches let you:
- **Work on features independently** - Without affecting main code
- **Experiment safely** - Try things without risk
- **Collaborate easily** - Multiple people work on different features
- **Organize work** - Features, fixes, experiments in separate branches

**Branches are the foundation of modern development workflows.**

## Creating Branches

### Create and Switch

```bash
# Create and switch to new branch
git checkout -b feature/new-feature

# Or use newer command
git switch -c feature/new-feature
```

### Create Without Switching

```bash
# Create branch but stay on current
git branch feature/new-feature

# Switch to it later
git checkout feature/new-feature
```

## Switching Branches

```bash
# Switch to existing branch
git checkout branch-name

# Or use newer command
git switch branch-name

# Switch and create if doesn't exist
git checkout -b new-branch
```

**Important**: Git won't let you switch if you have uncommitted changes (unless they don't conflict).

## Branch Best Practices

### Naming Conventions

```bash
# Feature branches
git checkout -b feature/user-authentication

# Bug fix branches
git checkout -b fix/memory-leak

# Hotfix branches
git checkout -b hotfix/security-patch

# Experiment branches
git checkout -b experiment/new-approach
```

### Keep Branches Focused

```bash
# Good: One feature per branch
git checkout -b feature/login
# ... work on login only ...

# Bad: Multiple features in one branch
git checkout -b feature/everything
# ... login, payment, search all in one ...
```

## My Take: Branches Are Freedom

I used to work only on main. I'd be scared to break things. I'd avoid experimenting.

Then I learned branches. Now I create branches for everything:
- New feature? New branch.
- Bug fix? New branch.
- Experiment? New branch.

**Branches give you freedom to try things. Use them.**

## Key Takeaways

1. **Branches are independent timelines** - Switch between them freely
2. **Create branches for features** - Keep work organized
3. **Use naming conventions** - Makes branches easy to understand
4. **Keep branches focused** - One feature per branch
5. **Branches are safety** - Experiment without risk

## Hands-On: Create and Use Branches

Let's create a branch and see it in action:

```bash
# Create a feature branch
git checkout -b feature/new-feature

# Make a change
echo "New feature code" > feature.js
git add feature.js
git commit -m "Add new feature"

# Switch back to main
git checkout main

# Feature file doesn't exist here!
ls -la

# Switch back to feature branch
git checkout feature/new-feature

# Feature file is back
ls -la
```

**What you're seeing**:
- Branches are separate workspaces
- Changes on one branch don't affect others
- You can switch between them freely

**Try it**: 
1. Create a branch using the commands above
2. Make changes on the branch
3. Switch branches and observe how files change
4. Use `git branch` to see all branches

**Create a screenshot**: Capture your terminal showing branch creation, switching, and `git branch` output.

## What's Next?

Now that you understand branches, let's learn about merging. Next: [Merging Branches](/docs/git-github/branching-merging/merging-branches).

---

> **Remember**: Branches are your safety net. Use them liberally.

