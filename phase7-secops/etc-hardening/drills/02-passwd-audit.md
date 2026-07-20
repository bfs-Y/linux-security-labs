# Drill 02 — Passwd file audit

Check /etc/passwd permissions. Should be 644 — world-readable but never world-writable.

Command:
ls -la /etc/passwd

Fix if wrong:
chmod 644 /etc/passwd

Risk: world-writable passwd lets any user add a root account.
