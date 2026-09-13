# Job/Internship Market Tracker — Project Spec

## 1. Goal
Scrape and aggregate tech job/internship postings targeted at Pakistan, track trends over time (skills in demand, salary ranges, posting volume), and alert users when new postings match their interests.

## 2. Data Sources (scraper targets)
- Rozee.pk — largest PK job board, scrapable
- Internee.pk — internship-focused, PK
- Mustakbil.com — PK jobs
- (Explicitly avoiding LinkedIn/Indeed direct scraping — against their ToS; can revisit with an official API later if needed)

## 3. Data Fields (per posting)
- `id` (internal)
- `source` (rozee / internee / mustakbil)
- `source_url`
- `title`
- `company`
- `location`
- `type` (job / internship)
- `category` (e.g. Data Science, Web Dev, Networking — derived from title/description keyword matching)
- `skills_extracted` (list, via keyword matching against a skills dictionary)
- `salary_range` (nullable — most PK postings omit this)
- `posted_date`
- `scraped_at`
- `is_active` (flips false when no longer seen on source)

## 4. Pipeline
1. **Scraper** (standalone module, run daily via GitHub Actions) — pulls new postings from each source, extracts fields, writes to Postgres (Neon). Dedup on `source` + `source_url`.
2. **Skill extraction** — simple keyword-matching against a maintained skills list (Python, SQL, React, AWS, etc.) run at ingestion time — no ML needed for v1.
3. **Staleness check** — postings not seen in the latest scrape for >X days get `is_active = false`.

## 5. API (FastAPI, reads from DB only — never scrapes directly)
- `GET /postings` — filter by category, type, location, skill, date range
- `GET /postings/{id}`
- `GET /trends/skills` — skill demand over time (for charts)
- `GET /trends/volume` — posting volume over time by category
- `POST /subscriptions` — user registers keyword/skill/location filter + Telegram chat ID
- `DELETE /subscriptions/{id}`

## 6. Alerts
- Telegram bot: user starts a chat, sends `/subscribe <keywords>`, gets pinged when a new matching posting appears (checked after each daily scrape run)

## 7. Frontend (React, built last — step 7 of our plan)
- Browse/filter postings (table + search)
- Trend charts (skills over time, volume over time) — reuse chart patterns from the cricket dashboard
- Subscription management page (view/edit/delete your Telegram alert filters)

## 8. Explicit non-goals for v1
- No user accounts/login for browsing (public read-only data)
- No ML-based skill extraction (keyword matching is enough for v1 — can revisit later)
- No LinkedIn/Indeed scraping

## 9. Stack (chosen to avoid trial-hosting trap)
- DB: Neon (Postgres, free tier, no card, no trial expiry)
- Backend: FastAPI on Render free web service
- Scraper: GitHub Actions (daily cron), same pattern as cricket dashboard
- Frontend: Vercel (same as Quran Companion)
- Alerts: Telegram Bot API (free)
