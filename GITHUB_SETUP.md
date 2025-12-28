# GitHub Repository Setup Guide

This guide will help you set up the DevOps Learning Platform repository on GitHub.

## Prerequisites

- GitHub account
- Git installed on your machine
- GitHub CLI (`gh`) installed (optional, but recommended)

## Step 1: Create GitHub Repository

### Option A: Using GitHub CLI (Recommended)

```bash
# Login to GitHub (if not already)
gh auth login

# Create the repository
gh repo create devops-learning-platform \
  --public \
  --description "Comprehensive learning platform for Kubernetes, Docker, AWS, and all DevOps tools" \
  --clone=false
```

### Option B: Using GitHub Web Interface

1. Go to https://github.com/new
2. Repository name: `devops-learning-platform`
3. Description: "Comprehensive learning platform for Kubernetes, Docker, AWS, and all DevOps tools"
4. Visibility: **Public** (required for free GitHub Pages)
5. **DO NOT** initialize with README, .gitignore, or license (we already have these)
6. Click **Create repository**

## Step 2: Update Configuration

Before pushing, update the following files with your GitHub username:

### 1. Update Docusaurus Config

Edit `sites/devopsengineers/docusaurus.config.ts`:

```typescript
// Replace 'your-github-username' with your actual GitHub username
organizationName: 'your-github-username',
```

Also update all GitHub URLs in:
- `editUrl` fields
- `navbar.items` GitHub link
- `footer.links` GitHub link

### 2. Update README.md

Edit `README.md` and replace:
- `YOUR_USERNAME` with your GitHub username
- Update repository URLs

## Step 3: Initialize and Push to GitHub

```bash
# Navigate to project directory
cd /Users/koti/Downloads/devops-site

# Initialize git (if not already done)
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: DevOps Learning Platform setup

- Docusaurus 3.x main site (devopsengineers.in)
- GitHub Actions workflows for deployment
- Automation scripts for tool version tracking
- Initial content structure (Kubernetes, Docker, AWS)
- Documentation and setup guides"

# Add remote repository
git remote add origin https://github.com/YOUR_USERNAME/devops-learning-platform.git

# Push to GitHub
git branch -M main
git push -u origin main
```

## Step 4: Enable GitHub Pages

1. Go to your repository on GitHub
2. Click **Settings** → **Pages**
3. Under **Source**, select **GitHub Actions**
4. Save the settings

The first deployment will start automatically (check the **Actions** tab).

## Step 5: Configure Custom Domain

### DNS Configuration

At your domain registrar (where you bought devopsengineers.in), add these DNS records:

**A Records** (for root domain):
```
Type: A
Name: @
Value: 185.199.108.153
Value: 185.199.109.153
Value: 185.199.110.153
Value: 185.199.111.153
```

**CNAME Record** (for www subdomain):
```
Type: CNAME
Name: www
Value: YOUR_USERNAME.github.io
```

### GitHub Configuration

1. In repository **Settings** → **Pages**
2. Under **Custom domain**, enter: `devopsengineers.in`
3. Check **Enforce HTTPS** (after DNS propagates)

The `CNAME` file is already created at `sites/devopsengineers/static/CNAME`.

### Verify DNS Propagation

```bash
# Check if DNS is configured correctly
dig devopsengineers.in +short
# Should return: 185.199.108.153 (or similar GitHub Pages IPs)
```

DNS propagation can take 24-48 hours.

## Step 6: Verify Deployment

1. Check GitHub Actions: Go to **Actions** tab in your repository
2. Wait for workflow to complete (2-3 minutes)
3. Visit your site:
   - GitHub Pages URL: `https://YOUR_USERNAME.github.io/devops-learning-platform/`
   - Custom domain (after DNS): `https://devopsengineers.in`

## Step 7: Test Local Development

```bash
cd sites/devopsengineers
npm install
npm start
```

Visit http://localhost:3000 to see your site locally.

## Next Steps

1. **Add more content**: Start writing tutorials in `docs/` directories
2. **Customize homepage**: Edit `src/pages/index.tsx`
3. **Add Google Analytics**: Update `docusaurus.config.ts` with your GA tracking ID
4. **Setup Algolia Search**: After site goes live, apply for free DocSearch
5. **Create learnk8s.in**: Follow similar process for second domain

## Troubleshooting

### Deployment Fails

- Check GitHub Actions logs for errors
- Verify `docusaurus.config.ts` has correct settings
- Ensure `organizationName` matches your GitHub username

### Custom Domain Not Working

- Wait 24-48 hours for DNS propagation
- Verify DNS records are correct using `dig` or online DNS checker
- Check GitHub Pages settings show your custom domain

### Build Errors

- Run `npm install` in `sites/devopsengineers/`
- Check for TypeScript errors: `npm run typecheck`
- Verify all dependencies are installed

## Repository Structure

```
devops-learning-platform/
├── .github/
│   └── workflows/
│       ├── deploy-main-site.yml      # Main site deployment
│       └── update-tool-versions.yml  # Automated version updates
├── sites/
│   ├── devopsengineers/             # Main site
│   │   ├── docs/                    # Content
│   │   ├── src/                     # React components
│   │   ├── static/                  # Static assets
│   │   └── docusaurus.config.ts     # Site configuration
│   └── learnk8s/                    # K8s-only site (future)
├── shared/                           # Shared content
├── scripts/                          # Automation scripts
├── config/                           # Configuration files
└── README.md                         # This file
```

## Support

- **Documentation**: See `PRD_DevOps_Learning_Platform.md` for full project details
- **Issues**: Create GitHub issues for bugs or questions
- **Docusaurus Docs**: https://docusaurus.io/docs

---

**Ready to deploy? Follow the steps above and your site will be live in minutes! 🚀**

