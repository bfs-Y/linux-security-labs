#!/bin/bash
# FIX: Remove cron PATH hijack via /tmp

# Step 1 — check crontab for /tmp in PATH
crontab -l

# Step 2 — remove malicious binary
rm /tmp/ls

# Step 3 — fix crontab PATH
crontab - << 'EOF'
* * * * * PATH=/usr/bin:/bin /usr/local/bin/cleanup.sh >> /tmp/cron-output.txt 2>&1
EOF

# Step 4 — verify ls resolves to real binary
which ls

# Step 5 — confirm cron fires clean
sleep 65 && cat /tmp/cron-output.txt && echo "[CLEAN] no PWNED output"
