# Drill 01 — World-writable audit

Run from a clean container. Find all world-writable files without sticky bit.

Command:
find / -perm -o+w -not -perm -1000 -not -path "/proc/*" -not -path "/sys/*" -not -path "/dev/*" 2>/dev/null
