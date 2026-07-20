# Drill 03 — .bashrc backdoor detection

Check for reverse shells or suspicious commands in shell startup files.

Command:
grep -r "dev/tcp\|/bin/bash.*>&\|nc -e\|python.*socket" /home/*/\.bashrc 2>/dev/null

Fix:
sed -i '/dev\/tcp/d' /home/username/.bashrc

Risk: reverse shell in .bashrc executes on every login silently.
