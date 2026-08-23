# Drill 01 — Shadow file audit

Check /etc/shadow permissions. Should be 640, readable only by root and shadow group.

Command:
ls -la /etc/shadow

Fix if wrong:
chmod 640 /etc/shadow

Risk: world-readable shadow exposes password hashes to offline cracking.
