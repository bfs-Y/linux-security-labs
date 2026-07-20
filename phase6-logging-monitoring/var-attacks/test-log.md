## Break Scenario 01: Log Tampering
Date: 2026-03-14
Result: Demonstrated — not drilled independently yet
Notes: Three methods tested — surgical deletion, truncation, fake entries.
IOC: sudo entry with no preceding SSH login means log was edited.

## Break Scenario 02: Cron Persistence
Date: 2026-03-14
Result: Pass
Notes: Persistence planted via crontab, fired every minute, removed with
crontab -r, verified by line count staying static after removal.

## Drills 01-05
Result: Not yet run independently
Notes: Run before starting module 08.
