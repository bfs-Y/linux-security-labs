# Drill 06 — Authentication control

Lock, expire, and unlock accounts. First response to a compromised account.

Commands:
passwd -l username    # lock — blocks login immediately
passwd -u username    # unlock — restores access
passwd -e username    # expire — forces password change on next login
passwd -S username    # status — L=locked, P=password set, NP=no password

Key insight:
Root bypasses account locks — su from root always works.
Locks block external logins — SSH, console, su from non-root users.

Incident response:
1. Detect suspicious activity
2. passwd -l username  ← lock immediately
3. Investigate
4. passwd -u username  ← unlock if clean
5. userdel -r username ← delete if compromised

Never skip step 2 while investigating.
