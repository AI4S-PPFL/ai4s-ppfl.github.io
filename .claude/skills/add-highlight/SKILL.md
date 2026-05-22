---
name: add-highlight
description: Add a highlight slide PDF to the project website. Copies/renames the PDF into `_highlights/` with the YYYYMMDD prefix convention and appends an entry to `_data/highlights.yml`. Use when the user wants to add, publish, or upload a highlight, slide deck, research-progress PDF, or quarterly update to the website.
---

# add-highlight

Add a highlight slide to the website. The [Highlights page](https://ai4s-ppfl.github.io/highlights/) is data-driven: it reads `_data/highlights.yml` and links each entry to a PDF in `_highlights/`.

## Required inputs

| Input | Format | Notes |
|---|---|---|
| PDF source | absolute or relative path to a `.pdf` file | URL downloads are out of scope — ask the user to download first if they only give a link |
| Date | `YYYY-MM-DD` | If the user says "today" or omits, use today's date. Convert relative dates ("this Friday") to absolute before saving. |
| Title | one-line descriptive string | The full title shown on the highlights page. Do **not** invent this — ask the user if missing. |
| Short tag | short name for the filename, e.g. `FedQueue`, `APPFL Deployment` | Often the system/method name. If the title is long, ask the user for the short tag rather than guessing. |

## Procedure

1. **Validate the PDF.** Confirm the file exists and is a PDF (`file <path>` should report "PDF document"). Stop and report to the user if not.

2. **Compute the target filename** in the form `<YYYYMMDD> - <ShortTag>.pdf`:
   - `YYYYMMDD` from the date, no dashes (e.g., `2026-05-22` → `20260522`).
   - Single space before and after the hyphen — this is intentional and matches every existing file (`20260522 - FedQueue.pdf`, `20260420 - Auto MIA.pdf`).
   - Short tag may contain spaces (e.g., `Auto MIA`).

3. **Check for collisions.** If `_highlights/<target>` already exists, ask the user whether to overwrite (use a different short tag, or change the date).

4. **Copy** the PDF into `_highlights/<target>`. Use `cp` and preserve the original at its source path — don't move/delete.

5. **Append a YAML entry** to `_data/highlights.yml`:

   ```yaml
   - date: <YYYY-MM-DD>
     file: "<target filename including .pdf>"
     title: "<full title>"
   ```

   Append at the bottom of the file. The page sorts by `file` (descending) at render time, so chronological order inside the YAML is irrelevant.

   **Quote the `file:` and `title:` values** with double quotes — both routinely contain spaces, colons, or punctuation that YAML parses ambiguously.

6. **Report** to the user: show the target filename and the YAML entry you appended. Offer to create a feature branch + PR (`git checkout -b add-highlight/<short-tag>`, commit, push, `gh pr create`) — only if the user confirms or has already asked.

## Pitfalls to avoid

- The `file:` value in YAML must exactly match the PDF filename in `_highlights/`, **including** the `YYYYMMDD - ` prefix and `.pdf` extension. Any mismatch produces a broken download link with no build error.
- Do **not** hand-edit the list rendered in `_highlights/index.md` — that template reads from `_data/highlights.yml`. Adding an `<li>` there will not show up after the next data update and will confuse contributors.
- Date format: YAML wants `2026-05-22` (dashes); filename wants `20260522` (no dashes). Don't conflate them.
- Don't strip the spaces around the hyphen in the filename. The existing convention uses single spaces (`20260522 - FedQueue.pdf`), and the YAML `file:` value mirrors that exactly.
