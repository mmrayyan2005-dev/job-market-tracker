-- Job/Internship Market Tracker — DB Schema (Postgres / Neon)

CREATE TABLE companies (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE postings (
    id SERIAL PRIMARY KEY,
    source TEXT NOT NULL,               -- 'rozee' | 'internee' | 'mustakbil'
    source_url TEXT NOT NULL,
    title TEXT NOT NULL,
    company_id INTEGER REFERENCES companies(id),
    location TEXT,
    type TEXT NOT NULL,                 -- 'job' | 'internship'
    category TEXT,                      -- e.g. 'Data Science', 'Web Dev'
    salary_range TEXT,                  -- nullable, most PK postings omit this
    posted_date DATE,
    scraped_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    last_seen_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    is_active BOOLEAN NOT NULL DEFAULT true,
    UNIQUE (source, source_url)         -- dedup key
);

CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE           -- e.g. 'Python', 'SQL', 'React'
);

CREATE TABLE posting_skills (
    posting_id INTEGER REFERENCES postings(id) ON DELETE CASCADE,
    skill_id INTEGER REFERENCES skills(id) ON DELETE CASCADE,
    PRIMARY KEY (posting_id, skill_id)
);

CREATE TABLE subscriptions (
    id SERIAL PRIMARY KEY,
    telegram_chat_id TEXT NOT NULL,
    keywords TEXT,                      -- free-text keyword filter, nullable
    category TEXT,                      -- nullable
    location TEXT,                      -- nullable
    skill_id INTEGER REFERENCES skills(id),  -- nullable
    created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Indexes for common filter/query patterns
CREATE INDEX idx_postings_category ON postings(category);
CREATE INDEX idx_postings_type ON postings(type);
CREATE INDEX idx_postings_is_active ON postings(is_active);
CREATE INDEX idx_postings_posted_date ON postings(posted_date);
CREATE INDEX idx_posting_skills_skill_id ON posting_skills(skill_id);
