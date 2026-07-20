# Drill 03: Set GRUB Password

**Time limit:** 8 minutes
**Environment:** Unprotected system. Apply GRUB password hardening.

## Scenario

New server before deployment. No GRUB password set. Apply full GRUB
password protection and verify it would be enforced at boot.

## Tasks

1. Generate a PBKDF2 password hash
2. Add superusers and password to /etc/grub.d/40_custom
3. Lock down config file permissions
4. Verify hash appears in grub.cfg after update-grub

## Commands in Order

    grub-mkpasswd-pbkdf2
    nano /etc/grub.d/40_custom
    chmod 600 /etc/default/grub
    chmod 700 /etc/grub.d/40_custom
    update-grub
    grep -i password /boot/grub/grub.cfg

## Success Criteria

- Hash generated successfully
- 40_custom contains set superusers and password_pbkdf2 lines
- File permissions locked to root only
- Hash visible in generated grub.cfg

## Failure Modes

- Storing plaintext password instead of hash
- Forgetting set superusers line
- Not running update-grub
- Not verifying hash appears in grub.cfg

## Solution

[Run drill first. Fill this in after at least two attempts.]
