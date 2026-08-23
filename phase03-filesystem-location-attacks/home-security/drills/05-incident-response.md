# Drill 05 — Incident response scenario

Suspect a user account is backdoored. Run in order:

1. ls -la /home/
2. find /home -name ".*" -perm -o+w 2>/dev/null
3. grep -r "dev/tcp\|nc -e\|python.*socket" /home/*/\.bashrc 2>/dev/null
4. find /home -name "authorized_keys" -exec cat {} \; 2>/dev/null
5. find /home -name ".ssh" -exec ls -la {} \; 2>/dev/null

Target: identify all backdoors in under 3 minutes.
