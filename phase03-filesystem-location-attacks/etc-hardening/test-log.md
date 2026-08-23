# Test Log — Module 11

## Baseline on clean Ubuntu 22.04 container
- /etc/passwd: 644 — correct
- /etc/shadow: 640, group shadow — correct
- /etc/sudoers: not present in base container
- No UID 0 accounts besides root
- No empty password hashes

## Breaks planted
- chmod 644 /etc/shadow — world-readable
- chmod 666 /etc/passwd — world-writable
- backdoor UID 0 account injected into passwd and shadow
- empty password hash on backdoor account

## What surprised me
A backdoor UID 0 account with empty password hash requires no root password — the system hands over root silently. Easy to miss in a quick audit if you only check permissions and not account contents.

## Edge cases
- harden.sh reports rogue UID 0 accounts but does not remove them
- find/audit must run as root — normal user gets permission denied on /etc/shadow
- malformed passwd entry with missing field may fail login silently
