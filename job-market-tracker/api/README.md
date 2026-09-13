# API module

FastAPI app. Reads from DB only -- never calls the scraper directly.

- `main.py` -- FastAPI app instance, includes routers
- `models.py` -- SQLAlchemy models mirroring schema.sql
- `routes/postings.py` -- GET /postings, GET /postings/{id}
- `routes/trends.py` -- GET /trends/skills, GET /trends/volume
- `routes/subscriptions.py` -- POST/DELETE /subscriptions
- `db.py` -- DB session/connection setup
