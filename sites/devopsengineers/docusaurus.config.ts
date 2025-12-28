import {themes as prismThemes} from 'prism-react-renderer';
import type {Config} from '@docusaurus/types';
import type * as Preset from '@docusaurus/preset-classic';

// This runs in Node.js - Don't use client-side code here (browser APIs, JSX...)

const config: Config = {
  title: 'DevOps Engineers',
  tagline: 'Master DevOps Tools from Zero to Hero',
  favicon: 'img/favicon.ico',

  // Future flags, see https://docusaurus.io/docs/api/docusaurus-config#future
  future: {
    v4: true, // Improve compatibility with the upcoming Docusaurus v4
  },

  // Production URL - primary custom domain
  url: 'https://devopsengineers.in',
  // Base URL: '/' for custom domain, '/devops-learning-platform/' for GitHub Pages
  // This works for both custom domain and GitHub Pages fallback URL
  baseUrl: process.env.BASE_URL || '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'vellankikoti', // GitHub username
  projectName: 'devops-learning-platform', // Repository name
  deploymentBranch: 'gh-pages',
  trailingSlash: false,

  onBrokenLinks: 'throw',

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
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
          editUrl: 'https://github.com/vellankikoti/devops-learning-platform/tree/main/sites/devopsengineers/',
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
          feedOptions: {
            type: ['rss', 'atom'],
            xslt: true,
          },
          editUrl: 'https://github.com/vellankikoti/devops-learning-platform/tree/main/sites/devopsengineers/',
          onInlineTags: 'warn',
          onInlineAuthors: 'warn',
          onUntruncatedBlogPosts: 'warn',
        },
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    // Replace with your project's social card
    image: 'img/docusaurus-social-card.jpg',
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: 'DevOps Engineers',
      logo: {
        alt: 'DevOps Engineers Logo',
        src: 'img/logo.svg',
      },
      items: [
        {
          type: 'docSidebar',
          sidebarId: 'tutorialSidebar',
          position: 'left',
          label: 'Docs',
        },
        {to: '/blog', label: 'Updates', position: 'left'},
        {
          href: 'https://github.com/vellankikoti/devops-learning-platform',
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
            {
              label: 'Kubernetes',
              to: '/docs/kubernetes/intro',
            },
            {
              label: 'Docker',
              to: '/docs/docker/intro',
            },
            {
              label: 'AWS',
              to: '/docs/aws/intro',
            },
            {
              label: 'All Tools',
              to: '/docs/intro',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'GitHub',
              href: 'https://github.com/vellankikoti/devops-learning-platform',
            },
            {
              label: 'Repository',
              href: 'https://github.com/vellankikoti/devops-learning-platform',
            },
          ],
        },
        {
          title: 'More',
          items: [
            {
              label: 'Blog',
              to: '/blog',
            },
            {
              label: 'GitHub Repository',
              href: 'https://github.com/vellankikoti/devops-learning-platform',
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} DevOps Engineers. Built with Docusaurus.`,
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
      additionalLanguages: ['bash', 'yaml', 'json', 'hcl'],
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
