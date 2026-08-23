#!/bin/bash
# BREAK: Cron persistence via /var/spool/cron/crontabs

service cron start

crontab - << 'EOF'
* * * * * echo "[PWNED] persistence firing" >> /tmp/persist.txt
EOF

echo "[BREAK] cron entry planted:"
crontab -l
echo "[BREAK] stored at:"
cat /var/spool/cron/crontabs/root
echo "[BREAK] wait 60 seconds then: cat /tmp/persist.txt"
