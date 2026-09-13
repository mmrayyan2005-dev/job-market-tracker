# Scraper module

Standalone — run this locally/via GitHub Actions, independent of the API.

- `sources/` — one file per site (rozee.py, internee.py, mustakbil.py), each returns a list of raw posting dicts
- `skills_extractor.py` — keyword-matches posting text against common/skills_list.py
- `db.py` — DB write/upsert logic (dedup on source + source_url)
- `main.py` — orchestrates: run all sources -> extract skills -> upsert to DB -> mark stale postings inactive
