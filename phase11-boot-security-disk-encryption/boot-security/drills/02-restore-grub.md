# Drill 02: Restore Tampered GRUB Config

**Time limit:** 5 minutes
**Environment:** /etc/default/grub has been modified with init=/bin/bash.

## Scenario

You caught the modification before reboot. Restore the config to a clean
state and verify it before applying.

## Tasks

1. Confirm the malicious parameter
2. Restore from backup or manually fix
3. Verify the fix
4. Note what update-grub would do on real hardware

## Commands in Order

    grep CMDLINE /etc/default/grub
    cp /etc/default/grub.bak /etc/default/grub
    grep CMDLINE /etc/default/grub
    # on real hardware: update-grub

## Success Criteria

- Malicious parameter confirmed before fix
- Config restored cleanly
- Parameters verified after restore
- update-grub step noted even if not run in container

## Failure Modes

- Fixing grub.cfg directly instead of /etc/default/grub
- Not verifying after fix
- Forgetting update-grub on real hardware

## Solution

[Run drill first. Fill this in after at least two attempts.]
