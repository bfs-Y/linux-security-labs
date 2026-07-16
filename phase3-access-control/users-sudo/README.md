# Module 14 - Users, Groups, and Sudo

## What this covers
- User and group management
- sudo misconfiguration detection
- NOPASSWD privilege escalation
- Account hygiene and cleanup

## Attack paths
- NOPASSWD:ALL in sudoers: full root access with no password required
- User added to sudo group: can run any command as root with password
- Leftover accounts: attack surface even without sudo access

## Scripts
- break/01-sudo-misconfig.sh: plants sudo misconfigs
- fix/01-fix-sudo.sh: removes misconfigs and deletes accounts
- harden/01-audit-sudo.sh: full sudo and account audit
- harden/02-harden-sudo.sh: enforces sudo hygiene
