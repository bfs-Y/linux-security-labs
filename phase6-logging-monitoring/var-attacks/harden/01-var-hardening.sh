#!/bin/bash
# HARDEN: /var protections

# Step 1 — make auth.log append-only
chattr +a /var/log/auth.log
echo "[HARDEN] auth.log set to append-only"

# Step 2 — audit crontabs
echo "[AUDIT] crontab entries:"
crontab -l 2>/dev/null || echo "no crontab"

echo "[AUDIT] /var/spool/cron/crontabs contents:"
ls -la /var/spool/cron/crontabs/ 2>/dev/null || echo "no crontab files"
