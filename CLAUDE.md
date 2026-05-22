# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

The Jekyll source for the AI4S-PPFL project website (https://ai4s-ppfl.github.io) — a static marketing/landing site for a multi-institutional DOE-funded research project on privacy-preserving federated learning. No application code; content + a single layout.

## Common commands

```bash
bundle install                                  # first-time setup; uses Ruby 3.3.6
bundle exec jekyll serve                        # local dev server with live reload at http://localhost:4000
bundle exec jekyll build                        # build to ./_site
bundle exec jekyll build --baseurl "/some-path" # mirrors what CI does (configure-pages sets base_path)
```

Ruby version is pinned to **3.3.6** in `Gemfile` and `.github/workflows/build.yml`. Keep these two in sync if you bump it.

## Deployment

GitHub Pages via `.github/workflows/build.yml`. The workflow is intentional but non-obvious:

- `build` job runs on every push **except** `master` (the project lives on `main`).
- `deploy` job runs only when ref is `main` or `master`.
- The custom workflow exists because the site needs the `jekyll-scholar` plugin, which the default GitHub Pages build environment does **not** allow. Don't switch this site to the default Pages build — publications won't render.

## Architecture

- `_layouts/default.html` is the only layout. **All CSS is embedded inline** in its `<style>` block — there is no separate stylesheet (the `assets/css/` directory exists but is empty). Edit styles there.
- `index.html` (home) is hand-written HTML, including hard-coded team cards. To add/remove a team member, edit `index.html` directly and drop their photo into `assets/photos/`.
- `_highlights/` is a Jekyll collection (`output: true` in `_config.yml`). PDFs live alongside `_highlights/index.md`, which links to them with relative paths — the collection output puts them under `/highlights/`.
- `_publications/index.md` renders `_bibliography/references.bib` via `{% bibliography %}` (jekyll-scholar). **To add a publication, append a BibTeX entry to `references.bib`** — do not edit the publications page itself.
- `_posts/` exists but is unused.

## Editing content

| Change | Where |
|---|---|
| Add publication | append BibTeX entry to `_bibliography/references.bib` |
| Add highlight | drop PDF in `_highlights/`, add `<li>` link in `_highlights/index.md` |
| Add/edit team member | edit `index.html` team card markup + add photo to `assets/photos/` |
| Update nav links | `_layouts/default.html` `<nav>` block |
| Site title, URL, plugins | `_config.yml` (Jekyll does NOT auto-reload this — restart `jekyll serve` after edits) |

## Notes

- `{{ site.baseurl }}` is used throughout for asset/link URLs so the site works under both the root and a subpath (e.g., when CI builds with `--baseurl`). Preserve this when adding links.
- Recent style refactor (commit `b84a1be`) introduced semantic class names (e.g., `.section-surface`, `.body-text`, `.text-link-emphasis`) and focus-visible outlines for accessibility. Prefer reusing these classes over inline styles.
