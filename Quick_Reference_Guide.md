# Quick Reference Guide
## DevOps Learning Platform - Commands & Workflows

---

## 🚀 Initial Setup (One-time)

### Prerequisites Check
```bash
# Verify Node.js (18+)
node --version

# Verify npm
npm --version

# Verify git
git --version
```

### Quick Start
```bash
# Run automated setup script
bash setup.sh

# This creates complete project structure with:
# - Docusaurus sites (devopsengineers + learnk8s)
# - GitHub Actions workflows
# - Sample content
# - Configuration files
```

---

## 📁 Project Structure

```
devops-learning-platform/
├── sites/
│   ├── devopsengineers/           # Main site (devopsengineers.in)
│   │   ├── docs/                  # Content (Markdown/MDX)
│   │   │   ├── kubernetes/
│   │   │   ├── docker/
│   │   │   ├── aws/
│   │   │   └── [other-tools]/
│   │   ├── src/
│   │   │   ├── components/        # React components
│   │   │   └── pages/             # Custom pages
│   │   ├── static/                # Images, data files
│   │   ├── docusaurus.config.ts   # Configuration
│   │   └── sidebars.ts            # Navigation
│   │
│   └── learnk8s/                  # K8s-only site (learnk8s.in)
│
├── shared/                        # Shared content/components
│   ├── kubernetes/                # Single source for K8s content
│   └── components/                # Reusable React components
│
├── .github/workflows/             # CI/CD automation
├── scripts/                       # Utility scripts
└── config/                        # Configuration files
```

---

## 💻 Local Development

### Start Development Server

```bash
cd sites/devopsengineers
npm start

# Opens browser at http://localhost:3000
# Hot reload enabled - changes appear instantly
```

### Build Production Version

```bash
npm run build

# Output in: build/
# Test production build:
npm run serve
```

### Check for Issues

```bash
# Check for broken links
npm run build 2>&1 | grep -i "broken"

# Run TypeScript checks
npm run typecheck

# Format code
npm run format
```

---

## ✍️ Content Creation Workflow

### Adding New Content Module

**Example: Adding Prometheus monitoring tutorial**

#### Step 1: Create Directory
```bash
cd sites/devopsengineers/docs
mkdir -p prometheus
```

#### Step 2: Create Category Config
```json
// docs/prometheus/_category_.json
{
  "label": "Prometheus",
  "position": 11,
  "link": {
    "type": "generated-index",
    "description": "Learn Prometheus monitoring from basics to production"
  }
}
```

#### Step 3: Add Content Files
```bash
cd prometheus

# Create intro
cat > intro.md << 'EOF'
---
sidebar_position: 1
title: Introduction to Prometheus
---

# Prometheus Monitoring

Learn Prometheus from zero to hero...
EOF

# Add more modules
touch installation.md
touch querying.md
touch alerting.md
```

#### Step 4: Preview Changes
```bash
npm start  # Auto-reloads with new content
```

#### Step 5: Commit & Deploy
```bash
git add .
git commit -m "docs: add Prometheus monitoring module"
git push origin main

# GitHub Actions automatically deploys to production
```

**⏱️ Total time: ~10 minutes**

---

## 🔄 Content Update Workflow

### Update Existing Content

```bash
# Edit file
vim docs/kubernetes/pods.md

# Preview locally
npm start

# Commit changes
git add docs/kubernetes/pods.md
git commit -m "docs(k8s): update pods tutorial with v1.30 features"
git push

# Live in ~2 minutes via GitHub Actions
```

### Add Code Examples

```markdown
# In your .md file

## Example: Creating a Pod

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.27
    ports:
    - containerPort: 80
```

```bash
# Apply the configuration
kubectl apply -f pod.yaml

# Verify
kubectl get pods
```
```

### Add Interactive Components

```mdx
---
# Use .mdx extension for interactive content
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';

# Multi-Cloud Deployment

<Tabs>
  <TabItem value="aws" label="AWS EKS" default>
    ```bash
    eksctl create cluster --name my-cluster
    ```
  </TabItem>
  <TabItem value="gcp" label="GCP GKE">
    ```bash
    gcloud container clusters create my-cluster
    ```
  </TabItem>
  <TabItem value="azure" label="Azure AKS">
    ```bash
    az aks create --name my-cluster
    ```
  </TabItem>
</Tabs>
```

---

## 🤖 Automation Scripts

### Fetch Latest Tool Versions

```bash
# Manual run
node scripts/fetch-tool-versions.js

# Output: sites/devopsengineers/static/data/tool-versions.json
```

**Automatic Schedule**: Runs every 6 hours via GitHub Actions

### Fetch Latest DevOps News

```bash
# Fetch from RSS feeds
node scripts/generate-updates-feed.js

# Output: sites/devopsengineers/static/data/latest-updates.json
```

**Automatic Schedule**: Runs daily via GitHub Actions

---

## 🌐 Deployment

### Manual Deployment

```bash
# Build site
cd sites/devopsengineers
npm run build

# Deploy to GitHub Pages (manual)
npm run deploy
```

### Automatic Deployment (Recommended)

**Trigger**: Push to `main` branch

**Workflow**: `.github/workflows/deploy.yml`

**Steps**:
1. Checkout code
2. Install dependencies
3. Build site
4. Deploy to GitHub Pages

**Time**: ~2-3 minutes

**View logs**: GitHub → Actions tab

---

## 🔧 Configuration

### Update Site Metadata

```typescript
// sites/devopsengineers/docusaurus.config.ts

const config: Config = {
  title: 'DevOps Engineers',
  tagline: 'Master DevOps Tools from Zero to Hero',
  url: 'https://devopsengineers.in',
  
  // Update these:
  organizationName: 'your-github-username',
  projectName: 'devops-learning-platform',
  
  // ... more config
};
```

### Customize Navigation

```typescript
// sites/devopsengineers/docusaurus.config.ts

navbar: {
  items: [
    {
      type: 'docSidebar',
      sidebarId: 'kubernetes',
      label: 'Kubernetes',
    },
    // Add more navigation items
  ],
}
```

### Update Theme Colors

```css
/* sites/devopsengineers/src/css/custom.css */

:root {
  --ifm-color-primary: #0066cc;
  --ifm-color-primary-dark: #0052a3;
  --ifm-color-primary-darker: #004d99;
  /* ... more colors */
}
```

---

## 🎨 Custom Components

### Create New Component

```bash
# Create component directory
mkdir -p sites/devopsengineers/src/components/MyComponent

# Create component file
cat > sites/devopsengineers/src/components/MyComponent/index.tsx << 'EOF'
import React from 'react';
import styles from './styles.module.css';

export default function MyComponent(): JSX.Element {
  return (
    <div className={styles.container}>
      <h2>My Custom Component</h2>
    </div>
  );
}
EOF

# Create styles
cat > sites/devopsengineers/src/components/MyComponent/styles.module.css << 'EOF'
.container {
  padding: 2rem;
  background: #f5f5f5;
  border-radius: 8px;
}
EOF
```

### Use Component in Content

```mdx
---
# In your .mdx file
---

import MyComponent from '@site/src/components/MyComponent';

# My Tutorial

<MyComponent />

More content here...
```

---

## 📊 Analytics & Monitoring

### Google Analytics Setup

```typescript
// docusaurus.config.ts

gtag: {
  trackingID: 'G-XXXXXXXXXX',  // Replace with your ID
  anonymizeIP: true,
},
```

### Track Custom Events

```typescript
// In any React component
import { useEffect } from 'react';

useEffect(() => {
  if (typeof window !== 'undefined' && window.gtag) {
    window.gtag('event', 'tutorial_complete', {
      tutorial_name: 'kubernetes-pods',
      completion_time: Date.now(),
    });
  }
}, []);
```

### View Metrics

- **Google Analytics**: analytics.google.com
- **GitHub Insights**: Repository → Insights → Traffic
- **Uptime**: uptimerobot.com (optional)

---

## 🔍 SEO Optimization

### Page-level SEO

```markdown
---
title: Kubernetes Pods Tutorial
description: Learn Kubernetes Pods with hands-on examples and best practices
keywords: [kubernetes, pods, containers, tutorial, devops]
image: /img/kubernetes-pods-social.jpg
---

# Content here...
```

### Generate Sitemap

```bash
# Automatically generated on build
npm run build

# Output: build/sitemap.xml
```

### Submit to Google

```bash
# After deployment, submit sitemap:
# https://devopsengineers.in/sitemap.xml
# 
# Via: Google Search Console
```

---

## 🐛 Troubleshooting

### Build Fails

```bash
# Clear cache
npm run clear

# Reinstall dependencies
rm -rf node_modules package-lock.json
npm install

# Try build again
npm run build
```

### Port Already in Use

```bash
# Kill process on port 3000
lsof -ti:3000 | xargs kill -9

# Or use different port
npm start -- --port 3001
```

### Broken Links

```bash
# Build will show broken links
npm run build 2>&1 | grep "Broken link"

# Fix the reported links
```

### Images Not Loading

```bash
# Check image path (must be in static/)
static/img/my-image.png → /img/my-image.png

# In markdown:
![Alt text](/img/my-image.png)
```

---

## 📦 Adding Dependencies

### Add npm Package

```bash
cd sites/devopsengineers

# Add package
npm install package-name

# Add dev dependency
npm install --save-dev package-name

# Example: Add code formatter
npm install --save-dev prettier
```

### Add Docusaurus Plugin

```bash
# Example: Add sitemap plugin
npm install @docusaurus/plugin-sitemap
```

```typescript
// docusaurus.config.ts
plugins: [
  '@docusaurus/plugin-sitemap',
  // ... other plugins
],
```

---

## 🔄 Git Workflow

### Feature Branch Workflow

```bash
# Create feature branch
git checkout -b feature/add-grafana-module

# Make changes
vim docs/grafana/intro.md

# Commit
git add .
git commit -m "docs: add Grafana monitoring module"

# Push
git push origin feature/add-grafana-module

# Create PR on GitHub
# After review, merge to main → auto-deploys
```

### Quick Fix

```bash
# On main branch
git checkout main
git pull

# Make quick fix
vim docs/kubernetes/typo-fix.md

# Commit and push
git add .
git commit -m "fix(docs): correct typo in k8s pods tutorial"
git push origin main

# Live in 2-3 minutes
```

---

## 🚀 Advanced Workflows

### Multi-site Deployment

**Deploy to both devopsengineers.in and learnk8s.in**

```yaml
# .github/workflows/deploy-multi-site.yml

jobs:
  deploy-main:
    # Deploy devopsengineers.in
    
  deploy-k8s:
    # Deploy learnk8s.in with same K8s content
```

### Content Sync Between Sites

```bash
# Kubernetes content lives in: shared/kubernetes/
# Symlinked to both sites:
# - sites/devopsengineers/docs/kubernetes → shared/kubernetes
# - sites/learnk8s/docs → shared/kubernetes

# Update once, deploys to both
```

### A/B Testing Pages

```typescript
// Custom component for A/B testing
import { useEffect, useState } from 'react';

export default function ABTest({ variantA, variantB }) {
  const [variant, setVariant] = useState('A');
  
  useEffect(() => {
    // 50/50 split
    setVariant(Math.random() > 0.5 ? 'A' : 'B');
  }, []);
  
  return variant === 'A' ? variantA : variantB;
}
```

---

## 📝 Content Guidelines

### Standard Template

Every tutorial should have:

1. **Frontmatter** (metadata)
2. **Overview** (what you'll learn)
3. **Prerequisites**
4. **Hands-on Exercise**
5. **Real-world Use Case**
6. **What's New** (latest updates)
7. **Troubleshooting**
8. **Additional Resources**

### Code Examples Best Practices

- ✅ Always include comments
- ✅ Show both command and expected output
- ✅ Provide complete, runnable examples
- ✅ Include error handling
- ✅ Reference official documentation

### Writing Style

- **Tone**: Professional but approachable
- **Voice**: Second person ("you will learn")
- **Length**: 1000-2000 words per tutorial
- **Format**: Short paragraphs (3-4 lines max)
- **Headings**: Descriptive, keyword-rich

---

## 🎯 Quick Commands Cheatsheet

```bash
# Development
npm start                    # Start dev server
npm run build               # Build production
npm run serve               # Preview production build
npm run clear               # Clear cache

# Content
npm run write-translations  # Extract translatable strings
npm run write-heading-ids   # Add IDs to headings

# Deployment
git push origin main        # Auto-deploy via GitHub Actions

# Utilities
npm run typecheck           # TypeScript validation
npm run format              # Format code with Prettier
npm run lint                # Lint code
```

---

## 🆘 Getting Help

### Documentation
- **Docusaurus**: https://docusaurus.io/docs
- **React**: https://react.dev/learn
- **MDX**: https://mdxjs.com/docs/

### Common Issues
- **Docs**: See `Technical_Implementation_Guide.md`
- **PRD**: See `PRD_DevOps_Learning_Platform.md`

### Community
- **GitHub Issues**: Report bugs, request features
- **Discussions**: Q&A, ideas, showcase

---

## 📈 Performance Checklist

Before each major release:

- [ ] Run Lighthouse audit (score >90)
- [ ] Check all links (no 404s)
- [ ] Optimize images (<200KB each)
- [ ] Test on mobile devices
- [ ] Verify search functionality
- [ ] Check page load times (<3s)
- [ ] Review SEO metadata
- [ ] Test in different browsers

---

## 🎉 Launch Checklist

- [ ] All planned modules completed
- [ ] Custom domain configured
- [ ] SSL certificate active
- [ ] Google Analytics setup
- [ ] Sitemap submitted to Google
- [ ] Social media cards configured
- [ ] README updated
- [ ] Contributing guide added
- [ ] License file added
- [ ] GitHub repository description set

---

**Ready to build? Start with:** `bash setup.sh`

**Questions?** Refer to the PRD and Technical Implementation Guide.

Happy learning! 🚀
