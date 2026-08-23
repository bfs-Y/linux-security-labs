# Drill 05 — Incident response scenario

You suspect /etc has been tampered with. Run in order:

1. ls -la /etc/passwd /etc/shadow /etc/group /etc/gshadow
2. awk -F: '($3 == 0)' /etc/passwd
3. awk -F: '($2 == "")' /etc/shadow
4. grep -v nologin /etc/passwd | grep -v false

Target: identify all anomalies in under 3 minutes.
