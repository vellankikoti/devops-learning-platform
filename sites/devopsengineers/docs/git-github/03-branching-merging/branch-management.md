---
sidebar_position: 6
title: Branch Management
---

# Branch Management: Organizing Your Work

**Good branch management is good project organization. Understanding how to manage branches is understanding how to organize work.**

## 🎯 The Big Picture

Branches are how you organize work. Features, fixes, experiments - each gets its own branch. Managing branches well makes collaboration easier.

**Think of it like this: Branches are workspaces. Good branch management is keeping workspaces organized.**

## Branch Naming Conventions

### Common Conventions

```bash
# Feature branches
feature/user-authentication
feature/payment-integration

# Bug fix branches
fix/memory-leak
fix/login-bug

# Hotfix branches
hotfix/security-patch
hotfix/critical-bug

# Release branches
release/v1.2.0
release/v2.0.0

# Experiment branches
experiment/new-approach
experiment/performance-test
```

### Naming Best Practices

- **Be descriptive**: `feature/auth` not `feature/new`
- **Use prefixes**: `feature/`, `fix/`, `hotfix/`
- **Use hyphens**: `feature/user-auth` not `feature/user_auth`
- **Keep it short**: But descriptive enough

## Creating Branches

### Create and Switch

```bash
# Create and switch to new branch
git checkout -b feature/new-feature

# Or use newer command
git switch -c feature/new-feature
```

### Create from Specific Commit

```bash
# Create branch from commit
git checkout -b feature/branch abc1234

# Create branch from tag
git checkout -b release/v1.2.0 v1.2.0
```

### Create from Remote Branch

```bash
# Create local branch tracking remote
git checkout -b feature/branch origin/feature/branch

# Or just checkout (Git creates local branch)
git checkout feature/branch
```

## Listing Branches

### List Local Branches

```bash
# List all local branches
git branch

# List with last commit
git branch -v

# List merged branches
git branch --merged

# List unmerged branches
git branch --no-merged
```

### List Remote Branches

```bash
# List remote branches
git branch -r

# List all branches (local and remote)
git branch -a
```

## Switching Branches

### Switch to Branch

```bash
# Switch to existing branch
git checkout branch-name

# Or use newer command
git switch branch-name
```

### Switch and Create

```bash
# Switch and create if doesn't exist
git checkout -b new-branch
git switch -c new-branch
```

## Deleting Branches

### Delete Local Branch

```bash
# Delete merged branch
git branch -d feature/branch

# Force delete (even if not merged)
git branch -D feature/branch
```

### Delete Remote Branch

```bash
# Delete remote branch
git push origin --delete feature/branch

# Or
git push origin :feature/branch
```

### Clean Up Merged Branches

```bash
# Delete all merged branches except main
git branch --merged | grep -v "\*\|main" | xargs -n 1 git branch -d
```

## Branch Tracking

### Set Upstream Branch

```bash
# Push and set upstream
git push -u origin feature/branch

# Now you can just:
git push
git pull
```

### Change Upstream Branch

```bash
# Set upstream manually
git branch --set-upstream-to=origin/feature/branch feature/branch
```

## Branch Workflows

### Feature Branch Workflow

```bash
# Create feature branch
git checkout -b feature/auth

# Develop feature
git add .
git commit -m "Add authentication"

# Push to remote
git push -u origin feature/auth

# Create PR, merge to main
# Then delete branch
git branch -d feature/auth
git push origin --delete feature/auth
```

### Hotfix Workflow

```bash
# Create hotfix from main
git checkout -b hotfix/security-patch main

# Fix the issue
git commit -m "Fix security vulnerability"

# Merge to main and develop
git checkout main
git merge hotfix/security-patch
git checkout develop
git merge hotfix/security-patch

# Delete hotfix branch
git branch -d hotfix/security-patch
```

## Branch Protection

### Protect Main Branch

On GitHub/GitLab:
- Require pull requests
- Require reviews
- Require status checks
- Prevent force push

### Local Protection

```bash
# Create alias to prevent accidental commits to main
git config --global alias.main-protect '!git branch --show-current | grep -q "^main$" && echo "Protected branch!" || git commit'
```

## My Take: Branch Management Is Organization

I used to work on main. I'd be scared to create branches. I'd avoid them.

Then I learned: **Branches are organization. Good branch management is good project management.**

Now I:
- Create branches for everything
- Use naming conventions
- Clean up merged branches
- Protect main branch

**Branch management is project organization. Do it well.**

## Memory Tip: The Workspace Analogy

Think of branches like workspaces:
- **Main branch**: Production workspace (clean, organized)
- **Feature branches**: Project workspaces (temporary, focused)
- **Branch management**: Keeping workspaces organized
- **Deleting branches**: Cleaning up finished workspaces

Once you see it that way, branch management makes sense.

## Common Mistakes

### Mistake 1: Not Using Naming Conventions

```bash
# Don't do this
git checkout -b branch1
git checkout -b test
git checkout -b new
```

**Fix**: Use descriptive names with prefixes.

### Mistake 2: Not Cleaning Up

```bash
# Don't do this
# Leave 50 merged branches around
```

**Fix**: Delete merged branches regularly.

### Mistake 3: Working on Main

```bash
# Don't do this
git checkout main
# Make changes directly on main
```

**Fix**: Always create feature branches.

## Key Takeaways

1. **Use naming conventions** - Makes branches easy to understand
2. **Create branches for features** - Keep work organized
3. **Clean up merged branches** - Don't leave clutter
4. **Protect main branch** - Prevent accidental commits
5. **Track remote branches** - Set upstream for easy push/pull

## What's Next?

Now that you can manage branches, you've completed Branching & Merging. Next: [Working with Remotes](/docs/git-github/remote-repositories/working-with-remotes).

---

> **Remember**: Branch management is project organization. Do it well, and collaboration becomes easier.

