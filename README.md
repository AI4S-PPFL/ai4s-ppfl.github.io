# AI4S-PPFL: Privacy-Preserving Federated Learning for Science

**AI4S-PPFL** is a multi-institutional research project focused on developing cutting-edge **privacy-preserving federated learning (PPFL)** algorithms and frameworks to enable the training of large foundation models on distributed, sensitive datasets.

For more information, please visit our [project website](https://ai4s-ppfl.github.io).

## Contributing content

This repo is the source for the project website. Every push to `main` redeploys the site via GitHub Actions (typically live within ~2 minutes of merge). Please contribute via pull request from a feature branch — direct pushes to `main` are discouraged.

### Add a publication

Append a BibTeX entry to [`_bibliography/references.bib`](_bibliography/references.bib). The [Publications page](https://ai4s-ppfl.github.io/publications/) re-renders automatically (grouped by year, descending).

```bibtex
@inproceedings{lastname2026keyword,
  title     = {Paper title},
  author    = {Last, First and Other, Author},
  booktitle = {Conference or journal name},
  year      = {2026}
}
```

Use a unique citation key (`lastname<year><keyword>`). `@article`, `@inproceedings`, and `@misc` (for arXiv) are all supported.

### Add a highlight slide

1. Drop the PDF into `_highlights/` using the filename pattern `YYYYMMDD - ShortTitle.pdf` — the date prefix controls sort order.
2. Append an entry to [`_data/highlights.yml`](_data/highlights.yml):

```yaml
- date: 2026-05-22
  file: "20260522 - YourTopic.pdf"
  title: "Full descriptive title shown on the highlights page"
```

The [Highlights page](https://ai4s-ppfl.github.io/highlights/) sorts entries by filename (descending), so the YYYYMMDD prefix puts the newest at the top.

### Update a team member

Edit the team card markup in [`index.html`](index.html) and drop the photo (lowercase-hyphenated filename, e.g. `firstname-lastname.jpg`) into `assets/photos/`.

### Preview locally (optional)

```bash
bundle install              # one-time setup; requires Ruby 3.3.6
bundle exec jekyll serve    # open http://localhost:4000
```

### Using Claude Code

If you use [Claude Code](https://claude.ai/code), open the repo and use the project skills shipped under `.claude/skills/`:

- **add-publication** — paste a BibTeX entry, an arXiv URL/ID, or a DOI; the skill resolves it, generates a unique citation key, deduplicates against the existing bib, and appends.
- **add-highlight** — give it a PDF path, date, and title; the skill renames and copies the PDF into `_highlights/` and adds the YAML entry to `_data/highlights.yml`.

You can invoke either by name (e.g., "use add-publication to add this paper: …") or just describe what you want — Claude will pick the right skill. Both offer to open a PR for you when finished.

## Acknowledgement

This project is supported by the U.S. Department of Energy, Office of Science, Advanced Scientific Computing Research, under Contract DE-AC02-06CH11357.
