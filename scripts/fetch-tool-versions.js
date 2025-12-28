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
  jenkins: {
    repo: 'jenkinsci/jenkins',
    type: 'github-release',
  },
};

function fetchGitHubRelease(repo) {
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
          try {
            const release = JSON.parse(data);
            resolve({
              version: release.tag_name,
              date: release.published_at,
              url: release.html_url,
            });
          } catch (e) {
            reject(new Error('Failed to parse JSON'));
          }
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
      } else {
        // For non-GitHub sources, we'll add them later
        console.log(`⚠ Skipping ${tool} (${config.type} not implemented yet)`);
      }
    } catch (error) {
      console.error(`✗ Failed to fetch ${tool}:`, error.message);
      // Keep previous version if fetch fails
    }
  }

  // Write to static data file
  const outputPath = './sites/devopsengineers/static/data/tool-versions.json';
  fs.mkdirSync('./sites/devopsengineers/static/data', { recursive: true });
  fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
  
  console.log(`\n✓ Saved tool versions to ${outputPath}`);
}

main().catch(console.error);

