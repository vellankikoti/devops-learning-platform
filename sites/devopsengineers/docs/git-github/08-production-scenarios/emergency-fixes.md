---
sidebar_position: 3
title: Emergency Fixes
---

# Emergency Fixes: When Production Breaks

**Production breaks. You need to fix it now. Understanding emergency fixes is understanding how to respond quickly and safely.**

## 🎯 The Big Picture

Emergency fixes are different from regular fixes. They're urgent. They need to go to production immediately. Git helps you fix quickly and safely.

**Think of it like this: Emergency fixes are like medical emergencies. You need to act fast, but you also need to be careful.**

## Emergency Fix Workflow

### Step 1: Create Hotfix Branch

```bash
# Create hotfix from main (production)
git checkout -b hotfix/critical-bug main

# Or from specific tag
git checkout -b hotfix/critical-bug v1.2.3
```

### Step 2: Fix the Issue

```bash
# Fix the bug
vim broken-file.js
git add broken-file.js
git commit -m "Fix critical bug: [description]"
```

### Step 3: Test Quickly

```bash
# Quick test (as much as possible)
npm test
# Or manual testing
```

### Step 4: Merge to Main

```bash
# Merge to main immediately
git checkout main
git merge hotfix/critical-bug

# Tag the fix
git tag -a v1.2.4 -m "Hotfix: Critical bug fix"
```

### Step 5: Deploy

```bash
# Push and deploy
git push origin main
git push origin v1.2.4

# Deploy to production
```

### Step 6: Merge to Develop

```bash
# Also merge to develop
git checkout develop
git merge hotfix/critical-bug
git push origin develop
```

## My Take: Emergency Fixes Need Speed

Emergency fixes need speed. But don't skip safety. Test what you can. Document what you did.

## Key Takeaways

1. **Create hotfix branch** - From main or production tag
2. **Fix quickly** - But carefully
3. **Test what you can** - Don't skip all testing
4. **Merge to main** - Deploy immediately
5. **Merge to develop** - Keep develop updated

## What's Next?

Next: [Recovering Lost Commits](/docs/git-github/production-scenarios/recovering-lost-commits).

---

> **Remember**: Emergency fixes need speed, but don't skip safety.

