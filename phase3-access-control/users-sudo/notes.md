# Module 14 - Users, Groups, and Sudo

## Scripts
- break.sh: Plants sudo misconfigs — grants a user full root access with no password via /etc/sudoers and adds another user to the sudo group
- find.sh: Audits /etc/sudoers for NOPASSWD entries, lists users in sudo and admin groups, finds accounts with shell access
- fix.sh: Removes unauthorized sudoers entries, removes users from sudo group, deletes accounts and home directories
- harden.sh: Enforces sudo hygiene — checks for NOPASSWD entries, audits privileged groups, finds UID 0 accounts and empty password hashes

## What surprised me
One line in /etc/sudoers grants full root access with no password — NOPASSWD:ALL is the most dangerous misconfiguration possible and takes seconds to plant. usermod -aG without -a silently strips all existing groups. useradd without -m creates accounts with no home directory causing silent login failures.

## Edge cases / gaps
- Removing sudo rules does not remove the account — account without sudo is still an attack surface
- userdel without -r leaves home directory on disk with sensitive files
- Duplicate sudoers entries stack silently — always audit the full file not just grep for one pattern
