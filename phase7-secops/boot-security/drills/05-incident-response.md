# Drill 05: Timed Incident Response — Boot Security

**Time limit:** 10 minutes
**Environment:** Full scenario. No hints.

## Scenario

You are called in before an emergency reboot. Someone with root access
may have modified GRUB. You have 10 minutes to check, fix if needed,
and harden before the reboot happens.

## Tasks

1. Check /etc/default/grub for dangerous parameters
2. Check /etc/grub.d/40_custom for unexpected entries
3. Verify grub.cfg modification timestamp
4. Fix any malicious parameters
5. Apply GRUB password if not already set
6. Lock down file permissions

## Pass Criteria

- All GRUB config locations checked
- Dangerous parameters detected and removed
- GRUB password applied
- File permissions set to root only
- Completed under 10 minutes

## Failure Modes

- Missing /etc/grub.d/40_custom check
- Not verifying grub.cfg after fix
- Forgetting update-grub
- Timeout

## Solution

[Run drill first. Fill this in after at least two attempts.]
