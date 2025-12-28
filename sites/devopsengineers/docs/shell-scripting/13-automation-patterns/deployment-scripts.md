---
sidebar_position: 2
title: "Deployment Scripts: Automate Deployment"
---

# Deployment Scripts: Deploy Applications

Deployment scripts automate deployment. Build. Deploy. Common pattern.

**Here's the thing: Deployment scripts automate deployment. Learn patterns. Use them.**

## Basic Deployment

```bash
#!/bin/bash
set -euo pipefail

# Build
npm run build

# Deploy
rsync -av dist/ user@server:/var/www/app/
```

**My take**: Deployment scripts automate. Use them.

## Common Patterns

### Full Deployment

```bash
build
test
deploy
verify
```

## What's Next?

Now that you understand deployment, let's talk about [Monitoring Scripts](/docs/shell-scripting/automation-patterns/monitoring-scripts).

---

> **Personal note**: Deployment scripts seemed complex at first. Then I learned patterns. Now I use them constantly. They're useful. Learn them.

