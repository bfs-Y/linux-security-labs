# Module 13 — File Permissions & Directory Security

## What this covers
- World-writable files and directories
- Sticky bit enforcement on shared directories
- SUID/SGID binary auditing
- World-writable files in /etc
- Files owned by nobody/nogroup

## Attack paths
- World-writable /tmp without sticky bit: file replacement, symlink attacks
- Rogue SUID binary: instant privilege escalation
- World-writable /etc files: config tampering, credential theft

## Scripts
- break/01-permission-misconfig.sh: plants four misconfigs
- fix/01-fix-permissions.sh: reverses all four breaks
- harden/01-audit.sh: finds all four vulnerability categories
- harden/02-harden-permissions.sh: enforces secure baseline
