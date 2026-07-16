# Drill 03 — World-writable files in /etc

Find:
find /etc -perm -o+w 2>/dev/null

Fix:
find /etc -type f -perm -002 -exec chmod 644 {} \;

Caveat: symlinks in /etc persist after chmod — chmod hits the target not the link.
