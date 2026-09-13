# Job/Internship Market Tracker

Scrapes PK tech job/internship postings, tracks skill/volume trends, sends Telegram alerts.

See `spec.md` for full project spec and `schema.sql` for the DB schema.

## Structure
- `scraper/` — standalone scraper module (run via GitHub Actions daily). Writes directly to DB.
- `api/` — FastAPI app. Reads from DB only, never scrapes.
- `common/` — shared pydantic schemas + skills dictionary used by both scraper and api.
- `frontend/` — React app (built last, once API is stable).

## Setup
1. Copy `.env.example` to `.env` and fill in your Neon DB connection string + Telegram bot token.
2. `pip install -r requirements.txt`
3. Run schema.sql against your Neon DB.
