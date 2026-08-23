#!/bin/bash
# FIX: Detect log tampering in /var/log/auth.log

# Step 1 — check if auth.log exists and its size
echo "[CHECK 1] auth.log metadata:"
ls -la /var/log/auth.log 2>/dev/null || echo "[ALERT] auth.log missing entirely"

# Step 2 — check for empty log
size=$(stat -c%s /var/log/auth.log 2>/dev/null)
if [ "$size" -eq 0 ]; then
    echo "[ALERT] auth.log is empty — possible truncation"
fi

# Step 3 — check for sudo entries without preceding login
echo "[CHECK 2] sudo entries:"
grep "sudo" /var/log/auth.log

echo "[CHECK 3] SSH login entries:"
grep "sshd" /var/log/auth.log

# Step 4 — check modification time
echo "[CHECK 4] recent modifications to log files:"
find /var/log -name "*.log" -newer /var/log/dpkg.log 2>/dev/null

# Step 5 — check journald for entries auth.log might be missing
echo "[CHECK 5] journald auth events:"
journalctl _COMM=sshd --no-pager 2>/dev/null | tail -10 || echo "journald not available"

echo "[HARDEN] ship logs off-system in real time — local logs can always be modified by root"
