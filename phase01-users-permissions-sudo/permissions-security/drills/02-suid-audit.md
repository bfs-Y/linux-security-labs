# Drill 02 — SUID audit

Find all SUID binaries. Flag anything outside /usr/bin.

Command:
find / -perm -4000 -not -path "/proc/*" -not -path "/sys/*" 2>/dev/null
