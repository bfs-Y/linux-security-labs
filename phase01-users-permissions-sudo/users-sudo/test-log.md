# Test Log - Module 14

## Baseline on clean Ubuntu 22.04 container
- /etc/sudoers: only root and sudo group have access
- No regular users by default
- sudo group is empty

## Breaks planted
- NOPASSWD:ALL granted to user via /etc/sudoers
- User added to sudo group via usermod -aG sudo
- Duplicate sudoers entries added

## What surprised me
One line in /etc/sudoers gives full passwordless root — fastest privilege escalation possible. Takes seconds to plant, easy to miss in a large sudoers file.

## Edge cases
- userdel without -r leaves home directory behind
- usermod -G without -a strips all existing groups silently
- useradd without -m creates user with no home directory
