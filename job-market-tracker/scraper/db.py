"""
DB write logic for the scraper.
- upsert_posting(): insert or update on (source, source_url) conflict
- mark_stale(): flip is_active=false for postings not seen in latest run
"""
