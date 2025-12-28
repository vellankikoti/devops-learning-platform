# DevOps Learning Platform

🚀 Comprehensive learning platform for Kubernetes, Docker, AWS, and all DevOps tools.

## Sites

- **devopsengineers.in** - Main hub for all DevOps content
- **learnk8s.in** - Dedicated Kubernetes deep-dive (coming soon)

## Features

- ✅ 100+ hands-on tutorials
- ✅ Real-time tool version tracking
- ✅ Latest DevOps news and updates
- ✅ Production-ready examples
- ✅ Zero to hero learning paths

## Tech Stack

- **Framework**: Docusaurus 3.x
- **Hosting**: GitHub Pages
- **CI/CD**: GitHub Actions
- **Language**: TypeScript/React

## Project Structure

```
devops-learning-platform/
├── sites/
│   ├── devopsengineers/     # Main site (devopsengineers.in)
│   └── learnk8s/            # Kubernetes-only site (learnk8s.in)
├── shared/                  # Shared content and components
│   ├── kubernetes/         # Single source for K8s content
│   └── components/         # Reusable React components
├── .github/workflows/      # CI/CD automation
├── scripts/                # Utility scripts
└── config/                 # Configuration files
```

## Local Development

### Main Site (devopsengineers.in)

```bash
cd sites/devopsengineers
npm install
npm start
```

Visit http://localhost:3000

### Build for Production

```bash
cd sites/devopsengineers
npm run build
```

## Deployment

### Automatic Deployment

Push to `main` branch - GitHub Actions automatically deploys to GitHub Pages.

**Workflow**: `.github/workflows/deploy-main-site.yml`

### Manual Deployment

```bash
cd sites/devopsengineers
npm run build
npm run deploy
```

## GitHub Repository Setup

### 1. Create Repository on GitHub

```bash
# Using GitHub CLI
gh repo create devops-learning-platform --public

# Or create manually on GitHub.com
# Repository name: devops-learning-platform
# Visibility: Public
```

### 2. Push Code

```bash
git init
git add .
git commit -m "Initial commit: DevOps Learning Platform"
git branch -M main
git remote add origin https://github.com/vellankikoti/devops-learning-platform.git
git push -u origin main
```

### 3. Enable GitHub Pages

1. Go to repository **Settings** → **Pages**
2. **Source**: Select **GitHub Actions**
3. Wait for first deployment (2-3 minutes)

### 4. Configure Custom Domain

1. Add DNS records at your domain registrar:
   ```
   Type: A
   Name: @
   Value: 185.199.108.153
   Value: 185.199.109.153
   Value: 185.199.110.153
   Value: 185.199.111.153
   
   Type: CNAME
   Name: www
   Value: vellankikoti.github.io
   ```

2. Create `CNAME` file:
   ```bash
   echo "devopsengineers.in" > sites/devopsengineers/static/CNAME
   git add sites/devopsengineers/static/CNAME
   git commit -m "Add custom domain CNAME"
   git push
   ```

3. In repository Settings → Pages, add your custom domain

## Automation

### Tool Version Tracking

Automatically fetches latest versions of DevOps tools every 6 hours.

**Script**: `scripts/fetch-tool-versions.js`

**Workflow**: `.github/workflows/update-tool-versions.yml`

### Manual Run

```bash
node scripts/fetch-tool-versions.js
```

## Content Creation

### Adding New Tutorial

1. Create directory: `sites/devopsengineers/docs/[tool-name]/`
2. Add content files (Markdown)
3. Update sidebar if needed
4. Commit and push → Auto-deploys

See [Quick_Reference_Guide.md](Quick_Reference_Guide.md) for detailed workflow.

## Configuration

### Update Site Metadata

Edit `sites/devopsengineers/docusaurus.config.ts`:

- Update `organizationName` with your GitHub username
- Update `url` if using different domain
- Add Google Analytics ID (optional)
- Customize navigation and footer

## Documentation

- **PRD**: [PRD_DevOps_Learning_Platform.md](PRD_DevOps_Learning_Platform.md)
- **Technical Guide**: [Technical_Implementation_Guide.md](Technical_Implementation_Guide.md)
- **Quick Reference**: [Quick_Reference_Guide.md](Quick_Reference_Guide.md)
- **Architecture**: [Architecture_Diagrams.md](Architecture_Diagrams.md)

## Contributing

Contributions welcome! Please read our contributing guidelines (coming soon).

## License

MIT License - see [LICENSE](LICENSE) file

## Support

- **Repository**: https://github.com/vellankikoti/devops-learning-platform
- **Live Site**: https://vellankikoti.github.io/devops-learning-platform/ (GitHub Pages)
- **Custom Domain**: https://devopsengineers.in (after DNS setup)
- **Issues**: https://github.com/vellankikoti/devops-learning-platform/issues
- **Discussions**: https://github.com/vellankikoti/devops-learning-platform/discussions

---

**Built with ❤️ using Docusaurus**

