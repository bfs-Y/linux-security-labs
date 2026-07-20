# Drill 04 — Empty password hash audit

Find accounts with no password set. Empty hash means passwordless login.

Command:
awk -F: '($2 == "")' /etc/shadow

Fix: lock the account:
passwd -l <username>
