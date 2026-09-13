"""
Entry point run by GitHub Actions daily cron.
1. Call fetch_postings() for each source
2. Extract skills for each posting
3. Upsert into DB
4. Mark stale postings inactive
5. (later) trigger subscription matching / Telegram alerts
"""

def run():
    raise NotImplementedError

if __name__ == "__main__":
    run()
