# Drill 01 — Home directory permissions

Check all home directories. Should be 700.

Command:
ls -la /home/

Fix:
chmod 700 /home/username

Risk: world-accessible home exposes all user files to other local users.
