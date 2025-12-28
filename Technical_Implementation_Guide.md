# Technical Implementation Guide
## DevOps Learning Platform - Step-by-Step Setup

---

## Overview

This guide walks through setting up the exact architecture analyzed from kubernetesmyths.com, adapted for our multi-domain learning platform.

**Technology Stack**:
- **Framework**: Docusaurus 3.x (React-based static site generator)
- **Deployment**: GitHub Pages with GitHub Actions
- **Language**: TypeScript + React + MDX (Markdown with JSX)
- **Styling**: Custom CSS + Infima (Docusaurus default theme)

---

## Architecture Analysis: kubernetes-myths

### What I Found

From analyzing kubernetesmyths.com:

1. **Framework**: Docusaurus (confirmed by file structure)
   - `docusaurus.config.ts` - Main configuration
   - `sidebars.ts` - Sidebar navigation structure
   - `package.json` - Dependencies (React, Docusaurus packages)
   - `tsconfig.json` - TypeScript configuration

2. **Structure**:
   ```
   ├── docs/               # Markdown content
   ├── src/               # Custom React components
   │   ├── components/    # Reusable components
   │   ├── pages/         # Custom pages (homepage)
   │   └── css/           # Custom styles
   ├── static/            # Static assets (images, data files)
   ├── .github/workflows/ # GitHub Actions for deployment
   ```

3. **Features**:
   - Category-based content organization
   - Custom homepage with featured content carousel
   - Social proof statistics (impressions, saves)
   - Clean, minimal design
   - Mobile responsive

4. **Deployment**:
   - GitHub Actions workflow for CI/CD
   - Deploys to GitHub Pages on push to main

---

## Phase 1: Foundation Setup (Week 1)

### Step 1.1: Repository Initialization

```bash
# Create main repository
mkdir devops-learning-platform
cd devops-learning-platform
git init

# Create folder structure
mkdir -p .github/workflows
mkdir -p sites/devopsengineers
mkdir -p sites/learnk8s
mkdir -p shared/kubernetes
mkdir -p shared/components
mkdir -p scripts
mkdir -p config

# Initialize main README
cat > README.md << 'EOF'
# DevOps Learning Platform

Multi-domain learning platform for DevOps, Kubernetes, Docker, and AWS.

## Sites
- **devopsengineers.in** - Main hub for all DevOps content
- **learnk8s.in** - Dedicated Kubernetes learning site

## Tech Stack
- Docusaurus 3.x
- GitHub Pages
- GitHub Actions
- TypeScript/React

## Quick Start
See individual site directories for setup instructions.
EOF

git add .
git commit -m "Initial repository structure"
```

### Step 1.2: Setup Main Site (devopsengineers.in)

```bash
cd sites/devopsengineers

# Initialize Docusaurus with TypeScript
npx create-docusaurus@latest . classic --typescript

# This creates the following structure:
# ├── blog/
# ├── docs/
# ├── src/
# │   ├── components/
# │   ├── css/
# │   └── pages/
# ├── static/
# ├── docusaurus.config.ts
# ├── package.json
# ├── sidebars.ts
# └── tsconfig.json
```

### Step 1.3: Configure docusaurus.config.ts

```typescript
// sites/devopsengineers/docusaurus.config.ts

import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

const config: Config = {
  title: 'DevOps Engineers',
  tagline: 'Master DevOps Tools from Zero to Hero',
  favicon: 'img/favicon.ico',

  // GitHub Pages deployment config
  url: 'https://devopsengineers.in',
  baseUrl: '/',
  organizationName: 'your-github-username', // Your GitHub org/user name
  projectName: 'devops-learning-platform', // Repo name
  deploymentBranch: 'gh-pages',
  trailingSlash: false,

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      {
        docs: {
          sidebarPath: './sidebars.ts',
          editUrl: 'https://github.com/your-username/devops-learning-platform/tree/main/sites/devopsengineers/',
          showLastUpdateTime: true,
          showLastUpdateAuthor: true,
        },
        blog: {
          showReadingTime: true,
          blogTitle: 'Latest Updates',
          blogDescription: 'Stay updated with latest DevOps tool releases and industry news',
          postsPerPage: 10,
          blogSidebarTitle: 'Recent updates',
          blogSidebarCount: 'ALL',
        },
        theme: {
          customCss: './src/css/custom.css',
        },
        gtag: {
          trackingID: 'G-XXXXXXXXXX', // Add your Google Analytics ID
          anonymizeIP: true,
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    image: 'img/devops-social-card.jpg',
    navbar: {
      title: 'DevOps Engineers',
      logo: {
        alt: 'DevOps Engineers Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'kubernetes',
          position: 'left',
          label: 'Kubernetes',
        },
        {
          type: 'docSidebar',
          sidebarId: 'docker',
          position: 'left',
          label: 'Docker',
        },
        {
          type: 'docSidebar',
          sidebarId: 'aws',
          position: 'left',
          label: 'AWS',
        },
        {
          type: 'dropdown',
          label: 'Tools',
          position: 'left',
          items: [
            { label: 'Linux', to: '/docs/linux/intro' },
            { label: 'Git & GitHub', to: '/docs/git-github/intro' },
            { label: 'Jenkins', to: '/docs/jenkins/intro' },
            { label: 'Ansible', to: '/docs/ansible/intro' },
            { label: 'Terraform', to: '/docs/terraform/intro' },
            { label: 'Shell Scripting', to: '/docs/shell-scripting/intro' },
          ],
        },
        {to: '/blog', label: 'Updates', position: 'left'},
        {to: '/updates', label: "What's New", position: 'left'},
        {
          href: 'https://github.com/your-username/devops-learning-platform',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      links: [
        {
          title: 'Learn',
          items: [
            { label: 'Kubernetes', to: '/docs/kubernetes/intro' },
            { label: 'Docker', to: '/docs/docker/intro' },
            { label: 'AWS', to: '/docs/aws/intro' },
            { label: 'All Tools', to: '/docs/intro' },
          ],
        },
        {
          title: 'Community',
          items: [
            { label: 'LinkedIn', href: 'https://linkedin.com/in/your-profile' },
            { label: 'GitHub', href: 'https://github.com/your-username' },
            { label: 'Twitter', href: 'https://twitter.com/your-handle' },
          ],
        },
        {
          title: 'More',
          items: [
            { label: 'Blog', to: '/blog' },
            { label: 'Updates Feed', to: '/updates' },
            { label: 'About', to: '/about' },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} DevOps Engineers. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['bash', 'yaml', 'json', 'docker', 'hcl', 'terraform'],
    },
    algolia: {
      // Algolia DocSearch config (apply after site goes live)
      appId: 'YOUR_APP_ID',
      apiKey: 'YOUR_SEARCH_API_KEY',
      indexName: 'devopsengineers',
      contextualSearch: true,
    },
    colorMode: {
      defaultMode: 'light',
      disableSwitch: false,
      respectPrefersColorScheme: true,
    },
  } satisfies Preset.ThemeConfig,

  plugins: [
    [
      '@docusaurus/plugin-ideal-image',
      {
        quality: 85,
        max: 2000,
        min: 500,
        steps: 4,
        disableInDev: false,
      },
    ],
  ],
};

export default config;
```

### Step 1.4: Setup Sidebar Structure

```typescript
// sites/devopsengineers/sidebars.ts

import type {SidebarsConfig} from '@docusaurus/plugin-content-docs';

const sidebars: SidebarsConfig = {
  // Kubernetes sidebar
  kubernetes: [
    {
      type: 'category',
      label: 'Introduction',
      items: [
        'kubernetes/intro',
        'kubernetes/why-kubernetes',
        'kubernetes/architecture',
      ],
    },
    {
      type: 'category',
      label: 'Getting Started',
      items: [
        'kubernetes/setup-minikube',
        'kubernetes/setup-kind',
        'kubernetes/kubectl-basics',
      ],
    },
    {
      type: 'category',
      label: 'Core Concepts',
      items: [
        'kubernetes/pods',
        'kubernetes/deployments',
        'kubernetes/services',
        'kubernetes/configmaps-secrets',
      ],
    },
    {
      type: 'category',
      label: 'Networking',
      items: [
        'kubernetes/networking-basics',
        'kubernetes/ingress',
        'kubernetes/network-policies',
      ],
    },
    {
      type: 'category',
      label: 'Storage',
      items: [
        'kubernetes/volumes',
        'kubernetes/persistent-volumes',
        'kubernetes/statefulsets',
      ],
    },
    {
      type: 'category',
      label: 'Advanced Topics',
      items: [
        'kubernetes/rbac',
        'kubernetes/custom-resources',
        'kubernetes/operators',
        'kubernetes/service-mesh',
      ],
    },
  ],

  // Docker sidebar
  docker: [
    {
      type: 'category',
      label: 'Fundamentals',
      items: [
        'docker/intro',
        'docker/installation',
        'docker/images-containers',
      ],
    },
    {
      type: 'category',
      label: 'Advanced',
      items: [
        'docker/multi-stage-builds',
        'docker/networking',
        'docker/volumes',
        'docker/compose',
        'docker/hardened-images',
      ],
    },
  ],

  // AWS sidebar
  aws: [
    {
      type: 'category',
      label: 'AWS Fundamentals',
      items: [
        'aws/intro',
        'aws/iam',
        'aws/ec2',
        'aws/s3',
      ],
    },
    {
      type: 'category',
      label: 'AWS for DevOps',
      items: [
        'aws/eks',
        'aws/ecr',
        'aws/codepipeline',
        'aws/cloudformation',
      ],
    },
  ],

  // Other tools (similar pattern)
  linux: [/* ... */],
  jenkins: [/* ... */],
  ansible: [/* ... */],
  terraform: [/* ... */],
};

export default sidebars;
```

### Step 1.5: Create Custom Homepage

```tsx
// sites/devopsengineers/src/pages/index.tsx

import React from 'react';
import clsx from 'clsx';
import Link from '@docusaurus/Link';
import useDocusaurusContext from '@docusaurus/useDocusaurusContext';
import Layout from '@theme/Layout';
import HomepageFeatures from '@site/src/components/HomepageFeatures';
import LatestUpdates from '@site/src/components/LatestUpdates';
import ToolStatusDashboard from '@site/src/components/ToolStatusDashboard';

import styles from './index.module.css';

function HomepageHeader() {
  const {siteConfig} = useDocusaurusContext();
  return (
    <header className={clsx('hero hero--primary', styles.heroBanner)}>
      <div className="container">
        <h1 className="hero__title">{siteConfig.title}</h1>
        <p className="hero__subtitle">{siteConfig.tagline}</p>
        <div className={styles.buttons}>
          <Link
            className="button button--secondary button--lg"
            to="/docs/intro">
            Start Learning →
          </Link>
        </div>
        
        {/* Google-like search bar */}
        <div className={styles.searchContainer}>
          <input 
            type="text" 
            placeholder="Search DevOps tools, tutorials, best practices..." 
            className={styles.searchBar}
          />
        </div>
      </div>
    </header>
  );
}

export default function Home(): JSX.Element {
  const {siteConfig} = useDocusaurusContext();
  return (
    <Layout
      title={`${siteConfig.title} - Learn DevOps from Zero to Hero`}
      description="Comprehensive learning platform for Kubernetes, Docker, AWS, and all DevOps tools">
      <HomepageHeader />
      <main>
        {/* Tool Status Dashboard */}
        <section className={styles.statusSection}>
          <div className="container">
            <h2>🟢 Real-time Tool Status</h2>
            <ToolStatusDashboard />
          </div>
        </section>

        {/* Latest Updates */}
        <section className={styles.updatesSection}>
          <div className="container">
            <h2>📰 What's New in DevOps</h2>
            <LatestUpdates />
          </div>
        </section>

        {/* Learning Paths */}
        <HomepageFeatures />
        
        {/* Quick Stats */}
        <section className={styles.statsSection}>
          <div className="container">
            <h2>Platform Impact</h2>
            <div className={styles.stats}>
              <div className={styles.statCard}>
                <h3>100+</h3>
                <p>Tutorials</p>
              </div>
              <div className={styles.statCard}>
                <h3>10+</h3>
                <p>Tools Covered</p>
              </div>
              <div className={styles.statCard}>
                <h3>Daily</h3>
                <p>Updates</p>
              </div>
              <div className={styles.statCard}>
                <h3>Free</h3>
                <p>Forever</p>
              </div>
            </div>
          </div>
        </section>
      </main>
    </Layout>
  );
}
```

### Step 1.6: Create React Components

**Component 1: Latest Updates Widget**

```tsx
// sites/devopsengineers/src/components/LatestUpdates/index.tsx

import React, { useEffect, useState } from 'react';
import styles from './styles.module.css';

interface Update {
  tool: string;
  title: string;
  date: string;
  link: string;
  type: 'release' | 'security' | 'feature' | 'outage';
}

export default function LatestUpdates(): JSX.Element {
  const [updates, setUpdates] = useState<Update[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Fetch from static JSON (populated by GitHub Actions)
    fetch('/data/latest-updates.json')
      .then(res => res.json())
      .then(data => {
        setUpdates(data.slice(0, 10)); // Show latest 10
        setLoading(false);
      })
      .catch(err => {
        console.error('Failed to load updates:', err);
        setLoading(false);
      });
  }, []);

  const getTypeIcon = (type: string) => {
    switch(type) {
      case 'release': return '🚀';
      case 'security': return '🔒';
      case 'feature': return '✨';
      case 'outage': return '⚠️';
      default: return '📢';
    }
  };

  if (loading) {
    return <div className={styles.loading}>Loading latest updates...</div>;
  }

  return (
    <div className={styles.updatesContainer}>
      {updates.map((update, idx) => (
        <div key={idx} className={styles.updateCard}>
          <span className={styles.typeIcon}>{getTypeIcon(update.type)}</span>
          <div className={styles.updateContent}>
            <strong>{update.tool}</strong>: {update.title}
            <div className={styles.updateMeta}>
              <span className={styles.date}>{update.date}</span>
              <a href={update.link} target="_blank" rel="noopener noreferrer">
                Learn more →
              </a>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
```

**Component 2: Tool Status Dashboard**

```tsx
// sites/devopsengineers/src/components/ToolStatusDashboard/index.tsx

import React, { useEffect, useState } from 'react';
import styles from './styles.module.css';

interface ToolStatus {
  name: string;
  status: 'operational' | 'degraded' | 'outage';
  version: string;
  lastChecked: string;
  statusUrl: string;
}

export default function ToolStatusDashboard(): JSX.Element {
  const [tools, setTools] = useState<ToolStatus[]>([]);

  useEffect(() => {
    fetch('/data/tool-status.json')
      .then(res => res.json())
      .then(setTools)
      .catch(console.error);
  }, []);

  const getStatusColor = (status: string) => {
    switch(status) {
      case 'operational': return '#00c851';
      case 'degraded': return '#ffbb33';
      case 'outage': return '#ff4444';
      default: return '#ccc';
    }
  };

  return (
    <div className={styles.dashboard}>
      {tools.map((tool, idx) => (
        <div key={idx} className={styles.toolCard}>
          <div 
            className={styles.statusIndicator} 
            style={{ backgroundColor: getStatusColor(tool.status) }}
          />
          <div className={styles.toolInfo}>
            <h4>{tool.name}</h4>
            <div className={styles.version}>v{tool.version}</div>
            <div className={styles.status}>
              {tool.status === 'operational' && '✓ Operational'}
              {tool.status === 'degraded' && '⚠ Degraded'}
              {tool.status === 'outage' && '✗ Outage'}
            </div>
          </div>
          <a 
            href={tool.statusUrl} 
            target="_blank" 
            rel="noopener noreferrer"
            className={styles.statusLink}
          >
            Status Page →
          </a>
        </div>
      ))}
    </div>
  );
}
```

### Step 1.7: GitHub Actions Deployment

```yaml
# .github/workflows/deploy-main-site.yml

name: Deploy DevOps Engineers Site

on:
  push:
    branches:
      - main
    paths:
      - 'sites/devopsengineers/**'
      - 'shared/**'
  workflow_dispatch:

jobs:
  deploy:
    name: Deploy to GitHub Pages
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - uses: actions/setup-node@v4
        with:
          node-version: 20
          cache: npm
          cache-dependency-path: sites/devopsengineers/package-lock.json

      - name: Install dependencies
        working-directory: sites/devopsengineers
        run: npm ci

      - name: Build website
        working-directory: sites/devopsengineers
        run: npm run build

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./sites/devopsengineers/build
          cname: devopsengineers.in
          user_name: 'github-actions[bot]'
          user_email: 'github-actions[bot]@users.noreply.github.com'
```

### Step 1.8: Automation - Fetch Tool Versions

```javascript
// scripts/fetch-tool-versions.js

const fs = require('fs');
const https = require('https');

const GITHUB_API = 'https://api.github.com';

const toolSources = {
  kubernetes: {
    repo: 'kubernetes/kubernetes',
    type: 'github-release',
  },
  docker: {
    url: 'https://docs.docker.com/engine/release-notes/',
    type: 'webpage',
  },
  terraform: {
    repo: 'hashicorp/terraform',
    type: 'github-release',
  },
  ansible: {
    repo: 'ansible/ansible',
    type: 'github-release',
  },
  // Add more tools...
};

async function fetchGitHubRelease(repo) {
  return new Promise((resolve, reject) => {
    const options = {
      hostname: 'api.github.com',
      path: `/repos/${repo}/releases/latest`,
      headers: {
        'User-Agent': 'DevOps-Learning-Platform',
        'Accept': 'application/vnd.github.v3+json',
      },
    };

    https.get(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        if (res.statusCode === 200) {
          const release = JSON.parse(data);
          resolve({
            version: release.tag_name,
            date: release.published_at,
            url: release.html_url,
          });
        } else {
          reject(new Error(`HTTP ${res.statusCode}`));
        }
      });
    }).on('error', reject);
  });
}

async function main() {
  const results = {};

  for (const [tool, config] of Object.entries(toolSources)) {
    try {
      if (config.type === 'github-release') {
        results[tool] = await fetchGitHubRelease(config.repo);
        console.log(`✓ Fetched ${tool}: ${results[tool].version}`);
      }
    } catch (error) {
      console.error(`✗ Failed to fetch ${tool}:`, error.message);
    }
  }

  // Write to static data file
  const outputPath = './sites/devopsengineers/static/data/tool-versions.json';
  fs.mkdirSync('./sites/devopsengineers/static/data', { recursive: true });
  fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
  
  console.log(`\n✓ Saved tool versions to ${outputPath}`);
}

main();
```

**GitHub Action to run this script**:

```yaml
# .github/workflows/update-tool-versions.yml

name: Update Tool Versions

on:
  schedule:
    - cron: '0 */6 * * *'  # Every 6 hours
  workflow_dispatch:

jobs:
  update:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - uses: actions/setup-node@v4
        with:
          node-version: 20

      - name: Fetch latest tool versions
        run: node scripts/fetch-tool-versions.js

      - name: Commit changes
        run: |
          git config user.name "GitHub Actions Bot"
          git config user.email "actions@github.com"
          git add sites/devopsengineers/static/data/tool-versions.json
          git diff --quiet && git diff --staged --quiet || \
            (git commit -m "chore: update tool versions [skip ci]" && git push)
```

---

## Phase 2: Content Creation (Weeks 2-6)

### Content Template

```markdown
---
title: Introduction to Kubernetes Pods
description: Learn what Kubernetes Pods are, how they work, and practical examples
keywords: [kubernetes, pods, containers, orchestration]
sidebar_position: 1
---

# Introduction to Kubernetes Pods

## Overview

A Pod is the smallest deployable unit in Kubernetes. Learn how Pods encapsulate containers and provide the foundation for all Kubernetes workloads.

**What you'll learn:**
- What Pods are and why they exist
- How to create and manage Pods
- Multi-container Pod patterns
- Best practices for production

**Prerequisites:**
- Basic understanding of containers
- Kubernetes cluster access (minikube/kind)

---

## What is a Pod?

A Pod represents a single instance of a running process in your cluster. Pods can contain one or more containers that share:
- Network namespace (same IP address)
- Storage volumes
- Configuration

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:1.27
    ports:
    - containerPort: 80
```

---

## Hands-on Exercise

### Step 1: Create Your First Pod

```bash
# Create a simple nginx pod
kubectl run nginx --image=nginx:1.27

# Check pod status
kubectl get pods

# Get detailed information
kubectl describe pod nginx
```

### Step 2: Access the Pod

```bash
# Port forward to access locally
kubectl port-forward pod/nginx 8080:80

# In another terminal
curl http://localhost:8080
```

---

## Real-world Use Case

**Scenario**: Deploying a microservice with sidecar logging

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: app-with-logging
spec:
  containers:
  - name: app
    image: myapp:latest
    volumeMounts:
    - name: logs
      mountPath: /var/log
  
  - name: log-shipper
    image: fluentd:latest
    volumeMounts:
    - name: logs
      mountPath: /var/log
  
  volumes:
  - name: logs
    emptyDir: {}
```

---

## What's New

**Kubernetes 1.30** (May 2024):
- Pod readiness gates now support custom conditions
- Improved pod startup performance for large images
- Enhanced security with user namespaces (beta)

**Best Practices (Updated Dec 2024)**:
- Always set resource requests and limits
- Use liveness and readiness probes
- Implement proper logging strategies
- Consider pod disruption budgets for HA

---

## Common Issues & Troubleshooting

**Problem**: Pod stuck in Pending state

```bash
# Check events
kubectl describe pod <pod-name>

# Common causes:
# - Insufficient resources
# - Image pull errors
# - Node selector not matching
```

---

## Additional Resources

- [Official Kubernetes Pods Documentation](https://kubernetes.io/docs/concepts/workloads/pods/)
- [Pod Lifecycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)
- [Interactive Tutorial](https://kubernetes.io/docs/tutorials/kubernetes-basics/)

---

**Next**: [Understanding Deployments](/docs/kubernetes/deployments)

**Related**:
- [Container Best Practices](/docs/docker/best-practices)
- [Kubernetes Architecture](/docs/kubernetes/architecture)
```

---

## Phase 3: Setup Kubernetes-only Site (learnk8s.in)

### Quick Setup (symlink approach)

```bash
cd sites/learnk8s

# Initialize Docusaurus
npx create-docusaurus@latest . classic --typescript

# Link to shared Kubernetes content
rm -rf docs
ln -s ../../shared/kubernetes docs

# Configure for K8s-only
# Edit docusaurus.config.ts to reflect K8s branding
# Customize homepage to be Kubernetes-focused
```

**Alternative: Deploy same content to both sites**

GitHub Action can build and deploy to multiple targets:

```yaml
- name: Deploy to multiple sites
  run: |
    # Deploy to learnk8s.in
    npm run build
    # ... deploy to learnk8s repo
    
    # Deploy to devopsengineers.in/kubernetes
    # Content already included in main site
```

---

## DNS Configuration

### Setup Custom Domains

**For devopsengineers.in**:

1. Create GitHub Pages in repo settings
2. Add DNS records at your registrar:
   ```
   Type: A
   Name: @
   Value: 185.199.108.153
   Value: 185.199.109.153
   Value: 185.199.110.153
   Value: 185.199.111.153
   
   Type: CNAME
   Name: www
   Value: your-username.github.io
   ```

3. Add `CNAME` file to static folder:
   ```
   sites/devopsengineers/static/CNAME
   ---
   devopsengineers.in
   ```

**For learnk8s.in**: Same process, different CNAME value

---

## Performance Optimization

### Lighthouse CI

```yaml
# .github/workflows/lighthouse.yml

name: Lighthouse CI
on: [pull_request]

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
      - run: npm install && npm run build
      - uses: treosh/lighthouse-ci-action@v10
        with:
          urls: |
            http://localhost:3000
            http://localhost:3000/docs/kubernetes/intro
          uploadArtifacts: true
```

### Image Optimization

Use Docusaurus image plugin + WebP conversion:

```bash
# Install sharp for image processing
npm install @docusaurus/plugin-ideal-image

# Images auto-optimized on build
```

---

## Scaling Pattern: Adding New Tools

**Example: Adding Prometheus**

1. Create directory:
   ```bash
   mkdir -p sites/devopsengineers/docs/prometheus
   ```

2. Add category config:
   ```json
   // docs/prometheus/_category_.json
   {
     "label": "Prometheus",
     "position": 11,
     "link": {
       "type": "generated-index",
       "description": "Learn Prometheus monitoring from basics to advanced"
     }
   }
   ```

3. Add content:
   ```bash
   docs/prometheus/
   ├── intro.md
   ├── installation.md
   ├── querying.md
   └── alerting.md
   ```

4. Update sidebar (auto-generated from folder structure)

5. Push to GitHub → Auto-deploys

**Time to add: < 30 minutes**

---

## Monitoring & Analytics

### Setup Google Analytics

Already configured in `docusaurus.config.ts`:

```typescript
gtag: {
  trackingID: 'G-XXXXXXXXXX',
  anonymizeIP: true,
}
```

### Custom Events

```typescript
// Track tutorial completion
import { useEffect } from 'react';

useEffect(() => {
  window.gtag?.('event', 'tutorial_complete', {
    'tutorial_name': 'kubernetes-pods'
  });
}, []);
```

---

## Next Steps

1. **Review and approve PRD** ✓
2. **Week 1**: Setup repository and deploy basic site
3. **Week 2-3**: Create first 20 content modules
4. **Week 4**: Implement automation scripts
5. **Week 5**: Add custom components (updates, status)
6. **Week 6**: Testing, optimization, launch

**Ready to start?** Let's create the repository and deploy the first version! 🚀
