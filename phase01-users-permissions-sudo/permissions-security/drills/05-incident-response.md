# Drill 05 — Incident response scenario

You have 5 minutes on an unknown box. Run in order:

1. find / -perm -4000 -not -path "/proc/*" 2>/dev/null
2. find / -perm -o+w -not -perm -1000 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null
3. find /etc -perm -o+w 2>/dev/null
4. ls -la /tmp /dev/shm /opt
5. find / -nouser -o -nogroup 2>/dev/null

Target: all five reviewed in under 5 minutes.
