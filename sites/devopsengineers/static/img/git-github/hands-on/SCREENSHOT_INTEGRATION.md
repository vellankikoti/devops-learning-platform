# Git Hands-On Screenshot Integration Guide

## Overview

This document guides the integration of screenshots from the reference repository into the Git & GitHub section.

## Reference Repository

**Source**: https://github.com/vellankikoti/15Days-of-DevOps-Interview-Preparation/blob/main/Day-1-Git/Git-Hands-On.md

## Screenshot Requirements

### Directory Structure

All screenshots should be placed in:
```
sites/devopsengineers/static/img/git-github/hands-on/
```

### Screenshot List

The following screenshots are referenced in the content:

#### Basic Operations
1. **git-init-hands-on.png** - `git init` command output
2. **git-status-untracked.png** - Git status showing untracked files
3. **git-status-staged.png** - Git status showing staged files
4. **first-commit-hands-on.png** - First commit output
5. **git-log.png** - Git log output
6. **git-diff.png** - Git diff showing changes
7. **git-diff-staged.png** - Staged changes diff
8. **multiple-files.png** - Multiple files in git status
9. **selective-staging.png** - Selective file staging
10. **git-log-detailed.png** - Detailed git log with stats
11. **git-show.png** - Git show command output
12. **undo-changes.png** - Undoing uncommitted changes
13. **unstage-changes.png** - Unstaging changes

#### .gitignore
14. **gitignore.png** - .gitignore file content
15. **gitignore-working.png** - .gitignore in action (ignored files)

#### Branching
16. **branch-hands-on.png** - Creating and using branches
17. **create-branch.png** - Branch creation output
18. **branch-commit.png** - Commit on feature branch
19. **switch-branches.png** - Switching between branches
20. **merge-branch.png** - Merging branches output

#### Remote Operations
21. **add-remote.png** - Adding remote repository
22. **push-remote.png** - Pushing to remote
23. **clone-repository-hands-on.png** - Cloning repository
24. **clone-repo.png** - Clone command output
25. **pull-push.png** - Pull and push operations

#### Complete Workflows
26. **complete-workflow.png** - Complete Git workflow diagram
27. **conflict-resolution-hands-on.png** - Resolving merge conflicts

## Screenshot Specifications

### Format
- **Type**: PNG (preferred) or JPG
- **Resolution**: Minimum 1920x1080 for clarity
- **File Size**: Optimized (under 500KB per image)

### Content Guidelines
- Show actual terminal output
- Include command prompts
- Show file listings where relevant
- Include Git status/output clearly
- Use readable fonts and colors

### Naming Convention
- Use lowercase with hyphens
- Descriptive names matching content
- Match exactly the filenames in markdown

## Integration Steps

1. **Download screenshots** from reference repo
2. **Rename** to match filenames in markdown
3. **Optimize** images (compress if needed)
4. **Place** in `static/img/git-github/hands-on/` directory
5. **Verify** all images load correctly
6. **Test** on local build

## Files Using Screenshots

### Primary Files
- `hands-on-exercises.md` - Main exercises file (27 screenshots)
- `initializing-repositories.md` - Git init hands-on
- `making-commits.md` - First commit hands-on
- `understanding-branches.md` - Branch hands-on
- `cloning-repositories.md` - Clone hands-on
- `resolving-conflicts.md` - Conflict resolution hands-on

## Verification Checklist

- [ ] All screenshot files exist
- [ ] All images load correctly
- [ ] Image paths match markdown references
- [ ] Images are optimized
- [ ] Alt text is descriptive
- [ ] Build passes without errors

## Notes

- Screenshots should match the actual command outputs
- Use real terminal screenshots, not mockups
- Ensure consistency in terminal styling
- Include error messages if relevant to learning
- Show both success and failure scenarios where appropriate

---

**Last Updated**: January 2025  
**Status**: Ready for screenshot integration

