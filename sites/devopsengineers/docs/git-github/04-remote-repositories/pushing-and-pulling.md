---
sidebar_position: 3
title: Pushing and Pulling
---

# Pushing and Pulling: Syncing with Remote

**Push uploads your work. Pull downloads others' work. Understanding push and pull is understanding how to sync with remote.**

## 🎯 The Big Picture

Push and pull are how you sync with remote. Push sends your commits. Pull gets others' commits. They're the foundation of collaboration.

**Think of it like this: Push is uploading. Pull is downloading. They keep local and remote in sync.**

## Pushing to Remote

### Basic Push

```bash
# Push to remote
git push origin main

# Or just (if upstream set)
git push
```

### Push New Branch

```bash
# Push new branch and set upstream
git push -u origin feature-branch

# -u sets upstream, so later you can just:
git push
```

### Force Push (Be Careful!)

```bash
# Force push (rewrites remote history)
git push --force origin main

# Or safer:
git push --force-with-lease origin main
```

**Warning**: Force push rewrites history. Only use on branches you own.

## Pulling from Remote

### Basic Pull

```bash
# Pull from remote
git pull origin main

# Or just (if upstream set)
git pull
```

### Pull with Rebase

```bash
# Pull and rebase instead of merge
git pull --rebase origin main
```

## Push and Pull Workflow

### Daily Workflow

```bash
# Start of day: Get latest
git pull

# During day: Make changes
git add .
git commit -m "Update"

# End of day: Share changes
git push
```

### Feature Branch Workflow

```bash
# Create feature branch
git checkout -b feature/auth

# Make changes
git add .
git commit -m "Add authentication"

# Push feature branch
git push -u origin feature/auth

# Create PR, merge to main
# Then update local main
git checkout main
git pull
```

## My Take: Push and Pull Are Routine

I used to think push and pull were complicated. I'd avoid them.

Then I learned: **Push and pull are routine. They're how you collaborate.**

Now I push and pull:
- Pull at start of day (get latest)
- Push when done (share work)
- Pull before pushing (avoid conflicts)

**Push and pull are collaboration. Use them routinely.**

## Key Takeaways

1. **Push uploads commits** - Share your work
2. **Pull downloads commits** - Get others' work
3. **Set upstream** - Makes push/pull easier
4. **Pull before push** - Avoid conflicts
5. **Force push carefully** - Only when necessary

## What's Next?

Next: [Remote Management](/docs/git-github/remote-repositories/remote-management).

---

> **Remember**: Push and pull are routine. They're how you collaborate.

