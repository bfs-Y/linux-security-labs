# Drill 03 — UID 0 account audit

Find all accounts with UID 0. Only root should have UID 0.

Command:
awk -F: '($3 == 0)' /etc/passwd

Fix: remove any non-root UID 0 entry:
sed -i '/^backdoor/d' /etc/passwd
sed -i '/^backdoor/d' /etc/shadow
