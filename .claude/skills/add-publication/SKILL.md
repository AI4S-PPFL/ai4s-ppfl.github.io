---
name: add-publication
description: Add a publication to the project website's bibliography. Accepts raw BibTeX, an arXiv URL/ID, or a DOI; resolves to BibTeX, generates a unique citation key, validates required fields, deduplicates against `_bibliography/references.bib`, and appends. Use when the user asks to add a paper, publication, citation, or BibTeX entry — for example "add this BibTeX", "add this arXiv paper", or "publish this citation on the website".
---

# add-publication

Add a paper to `_bibliography/references.bib`. The [Publications page](https://ai4s-ppfl.github.io/publications/) renders this file automatically (grouped by year, descending) via jekyll-scholar.

## Input forms accepted

The user supplies one of:

| Form | Example | How to resolve to BibTeX |
|---|---|---|
| Raw BibTeX | a pasted `@inproceedings{…}` block | use as-is |
| arXiv URL or ID | `https://arxiv.org/abs/2505.22916` or `2505.22916` | WebFetch `https://arxiv.org/bibtex/<id>` — returns a BibTeX entry directly |
| DOI or DOI URL | `10.1109/CCGrid.2025.xxxxx` | WebFetch `https://api.crossref.org/works/<doi>/transform/application/x-bibtex` |

If raw BibTeX is provided alongside another form, prefer the raw BibTeX (most authoritative).

## Procedure

1. **Obtain BibTeX** using the table above. If WebFetch fails or returns something that doesn't parse as BibTeX, report to the user and stop — do not fabricate fields.

2. **Parse** the entry: extract entry type (`@inproceedings`, `@article`, `@misc`, …), citation key, and the field map.

3. **Generate or normalize the citation key.** Convention used throughout `references.bib`: `<lastname><year><firstkeyword>` lowercased, no punctuation, no spaces. The first keyword is the first non-stopword token from the title (skip `a`, `an`, `the`, `on`, `of`, `for`, `and`, `to`, `in`, `with`). Examples already in the file:
   - `li2026fedqueue` (Li, 2026, FedQueue)
   - `byeon2026firm` (Byeon, 2026, FIRM)
   - `qiu2025randomized` (Qiu, 2025, Randomized…)

   Replace the upstream key when it's generic (`arxiv:2505.22916`, all-digits, a single-word like `paper1`, or already taken).

4. **Check uniqueness.** Read `_bibliography/references.bib`. If the proposed key already exists, append a disambiguator letter (`li2026fedqueueb`, then `c`, …). If the *exact same paper* (same title + first author) seems already present, stop and ask the user before adding a duplicate.

5. **Validate required fields** by entry type:
   - `@inproceedings`: `title`, `author`, `booktitle`, `year`
   - `@article`: `title`, `author`, `journal`, `year`
   - `@misc` (typical for arXiv): `title`, `author`, `year`; arXiv entries additionally have `eprint`, `archivePrefix={arXiv}`, `primaryClass`, `url`
   
   If a required field is missing, ask the user — never invent one.

6. **Format to match existing style.** Look at recent entries in `references.bib` and mirror their spacing. The common pattern is:

   ```bibtex
   @inproceedings{key,
     title        = {…},
     author       = {Last, First and Other, Author},
     booktitle    = {…},
     pages        = {…},
     year         = {YYYY},
     organization = {…}
   }
   ```

   - Two-space indent
   - Field names padded so `=` aligns (loose — match neighbors, not exact)
   - One blank line between entries

7. **Append** the entry to the end of `_bibliography/references.bib`. Do not reorder — existing entries are append-order; jekyll-scholar sorts at render time by year.

8. **Report** to the user: cite the new key and title, and offer to create a feature branch + PR (`git checkout -b add-pub/<key>`, commit, push, `gh pr create`). Only do this if the user confirms or has already asked.

## Pitfalls to avoid

- `&` in titles must be `\&` (LaTeX). Other LaTeX-special characters: `%`, `_`, `#`, `$`, `{`, `}` — escape with backslash inside titles.
- Acronyms like `FIRM`, `APPFL`, `LLM` lose capitalization in some BibTeX styles. The existing bib does not consistently brace them (`{FIRM}`), so don't introduce braces unless the user asks.
- arXiv BibTeX from `https://arxiv.org/bibtex/<id>` returns `@misc` with `eprint`/`archivePrefix`/`primaryClass`/`url` — preserve all four. Existing arXiv entries in the bib follow this exact shape.
- Never edit `_publications/index.md` — that's the template, not the data.
- Never use `--no-verify` to bypass commit hooks (none are configured here, but the rule stands).
