# How to Add Screenshots to Git Hands-On Exercises

## Quick Start

1. **Download screenshots** from the reference repo
2. **Rename** them to match the filenames below
3. **Place** them in this directory: `sites/devopsengineers/static/img/git-github/hands-on/`
4. **Verify** the build works

## Reference Source

**Repository**: https://github.com/vellankikoti/15Days-of-DevOps-Interview-Preparation  
**File**: `Day-1-Git/Git-Hands-On.md`

## Screenshot Mapping

Map the screenshots from the reference repo to these filenames:

### From Reference Repo → To Our Files

1. **git clone output** → `git-init-output.png` or `git-init-hands-on.png`
2. **git pull output** → `pull-push.png`
3. **git status (untracked)** → `git-status-untracked.png`
4. **git add . output** → `git-status-staged.png`
5. **git commit output** → `first-commit-hands-on.png`
6. **git push output** → `push-remote.png`
7. **git branch output** → `create-branch.png` or `branch-hands-on.png`
8. **git checkout branch** → `switch-branches.png`
9. **git push origin branch** → `push-remote.png`
10. **git push --set-upstream** → `add-remote.png`
11. **git cherry-pick output** → (create from cherry-pick section)
12. **Merge conflict markers** → `conflict-resolution-hands-on.png`
13. **git rebase output** → (create from rebase section)
14. **Git Flow diagram** → `complete-workflow.png`

## Quick Download Script

You can manually download screenshots from the GitHub repo:

```bash
# Navigate to screenshot directory
cd sites/devopsengineers/static/img/git-github/hands-on/

# Download screenshots from GitHub (if they're in the repo)
# Or manually save them from the reference markdown file
```

## Verification

After adding screenshots:

```bash
# Build the site
cd sites/devopsengineers
npm run build

# Should build without image errors
# Images should appear in the hands-on exercises
```

## Current Status

✅ **Configuration**: Set to warn on missing images (build passes)  
⏳ **Screenshots**: Need to be added from reference repo  
📝 **Placeholders**: All image references are in place  

## Notes

- Images are referenced with `/img/git-github/hands-on/filename.png`
- Docusaurus serves images from `static/img/` directory
- All image paths are relative to the static directory
- Build currently warns on missing images but doesn't fail

---

**Last Updated**: January 2025  
**Status**: Ready for screenshot integration

