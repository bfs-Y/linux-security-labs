# Drill 02 — Dotfile audit

Find world-writable dotfiles in home directories.

Command:
find /home -name ".*" -perm -o+w 2>/dev/null

Fix:
chmod 644 /home/username/.bashrc

Risk: world-writable .bashrc allows any user to inject persistent commands.
