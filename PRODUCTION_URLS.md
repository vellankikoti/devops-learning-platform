# Production URLs - DevOps Learning Platform

## 🌐 Live Site URLs

### Primary URLs
- **GitHub Pages**: https://vellankikoti.github.io/devops-learning-platform/
- **Custom Domain**: https://devopsengineers.in (after DNS setup)

### Repository URLs
- **GitHub Repository**: https://github.com/vellankikoti/devops-learning-platform
- **Actions**: https://github.com/vellankikoti/devops-learning-platform/actions
- **Pages Settings**: https://github.com/vellankikoti/devops-learning-platform/settings/pages
- **Issues**: https://github.com/vellankikoti/devops-learning-platform/issues
- **Discussions**: https://github.com/vellankikoti/devops-learning-platform/discussions

## 📋 Configuration Details

### Docusaurus Configuration
- **Organization**: `vellankikoti`
- **Project Name**: `devops-learning-platform`
- **Base URL**: `/devops-learning-platform/` (for GitHub Pages)
- **Base URL**: `/` (for custom domain - devopsengineers.in)
- **Production URL**: `https://devopsengineers.in`

### GitHub Pages Setup
- **Source**: GitHub Actions
- **Workflow**: `.github/workflows/deploy-main-site.yml`
- **Environment**: `github-pages`
- **Branch**: `main` (auto-deploys on push)

## 🔧 How It Works

### Dual Base URL Support
The site is configured to work with both:
1. **GitHub Pages URL** (`/devops-learning-platform/` baseUrl)
   - Set via `BASE_URL` environment variable in workflow
   - Works immediately after deployment

2. **Custom Domain** (`/` baseUrl)
   - Uses default baseUrl when `BASE_URL` is not set
   - Works after DNS is configured and custom domain is added in GitHub Pages settings

### Build Process
- GitHub Actions workflow sets `BASE_URL=/devops-learning-platform/` during build
- This ensures the site works at the GitHub Pages URL
- When custom domain is configured, GitHub Pages serves it with root baseUrl

## ✅ Current Status

- ✅ Repository: https://github.com/vellankikoti/devops-learning-platform
- ✅ Workflow: Configured and running
- ✅ Base URL: Fixed for GitHub Pages
- ✅ All URLs: Updated with actual values (no placeholders)
- ⏳ GitHub Pages: Enable in Settings → Pages → Source: GitHub Actions
- ⏳ Custom Domain: Configure DNS and add domain in Pages settings

## 🚀 Next Steps

1. **Enable GitHub Pages**:
   - Visit: https://github.com/vellankikoti/devops-learning-platform/settings/pages
   - Select "GitHub Actions" as source
   - Save

2. **Verify GitHub Pages URL**:
   - After deployment: https://vellankikoti.github.io/devops-learning-platform/
   - Should work immediately

3. **Configure Custom Domain** (optional):
   - Add DNS A records pointing to GitHub Pages IPs
   - Add custom domain in Pages settings
   - Site will also work at: https://devopsengineers.in

---

**All URLs are production-ready with no placeholders or test values!** ✅

