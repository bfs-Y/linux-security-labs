#!/bin/bash
# FIX: Detect and remove cron persistence via /var/spool/cron

echo "[DETECT] current crontab:"
crontab -l 2>/dev/null || echo "crontab empty"

echo "[DETECT] raw file:"
cat /var/spool/cron/crontabs/root 2>/dev/null || echo "no crontab file"

echo "[FIX] removing crontab"
crontab -r

echo "[VERIFY] crontab after removal:"
crontab -l 2>/dev/null || echo "crontab empty — clean"
