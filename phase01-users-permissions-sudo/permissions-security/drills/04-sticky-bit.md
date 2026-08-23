# Drill 04 — Sticky bit enforcement

Break: chmod o-t /tmp
Verify: ls -la / | grep tmp  → drwxrwxrwx = dangerous
Fix: chmod 1777 /tmp
Verify: ls -la / | grep tmp  → drwxrwxrwt = safe
