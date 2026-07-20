# Drill 01: Detect Malicious GRUB Parameters

**Time limit:** 5 minutes
**Environment:** Live system. Suspect someone modified boot parameters.

## Scenario

You are auditing a server before a scheduled reboot. You need to check
whether boot parameters have been tampered with before the system restarts
into a compromised state.

## Tasks

1. Check current GRUB_CMDLINE parameters
2. Scan for known dangerous parameters
3. Verify config file ownership and permissions
4. Check modification timestamp

## Commands in Order

    cat /etc/default/grub
    grep CMDLINE /etc/default/grub
    grep -E "(init=|single|rd.break|systemd.unit=emergency)" /etc/default/grub
    ls -la /etc/default/grub
    stat /etc/default/grub

## Success Criteria

- Dangerous parameters identified before reboot
- File ownership confirmed as root
- Modification timestamp noted
- Clean or compromised state confirmed

## Failure Modes

- Not checking before a scheduled reboot
- Missing rd.break and systemd.unit= as dangerous parameters
- Only checking grub.cfg instead of /etc/default/grub

## Solution

[Run drill first. Fill this in after at least two attempts.]
