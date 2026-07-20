# Drill 04 — SSH authorized_keys audit

Check .ssh directory permissions and authorized_keys contents.

Commands:
find /home -name ".ssh" -exec ls -la {} \; 2>/dev/null
find /home -name "authorized_keys" -exec cat {} \; 2>/dev/null

Fix:
chmod 700 /home/username/.ssh
chmod 600 /home/username/.ssh/authorized_keys
> /home/username/.ssh/authorized_keys

Risk: attacker key survives password changes and gives permanent SSH access.
