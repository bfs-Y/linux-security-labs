# /boot Security & GRUB Hardening

The boot process runs before any security control on the system loads. No PAM,
no SELinux, no auditd, no sudo restrictions. Whatever runs at boot runs as the
kernel itself. That is why physical access to a machine without a GRUB password
is effectively full compromise in under a minute.

GRUB is the first software that runs after the BIOS hands off control. It loads
the kernel and passes boot parameters to it. If an attacker can edit those
parameters, they control what the kernel does before the OS ever starts.

## Threat Model

Physical access plus no GRUB password equals root shell. The attacker walks up,
presses e at the GRUB menu, adds init=/bin/bash or single to the kernel line,
boots, and has an unauthenticated root shell. Takes 30 seconds. Works on every
unprotected Linux system.

Remote attackers with root access can do the same thing by editing
/etc/default/grub directly and running update-grub. Next reboot the system
comes up compromised.

## What Was Tested

- Boot parameter injection via /etc/default/grub
- Dangerous parameters: init=/bin/bash and single
- Detection of malicious parameters before reboot
- GRUB password setup using grub-mkpasswd-pbkdf2
- Permission hardening on GRUB config files

## Break: Boot Parameter Injection

Modified GRUB_CMDLINE_LINUX_DEFAULT to include init=/bin/bash. On real
hardware this boots directly to a root bash shell, bypassing systemd, PAM,
and all authentication.

Detect before reboot:

    grep CMDLINE /etc/default/grub
    grep -E "(init=|single|rd.break)" /etc/default/grub

Any of those parameters in the kernel command line is an IOC.

## Fix

    cp /etc/default/grub.bak /etc/default/grub
    grep CMDLINE /etc/default/grub
    update-grub

Always keep a backup of /etc/default/grub. If no backup exists, manually
reset GRUB_CMDLINE_LINUX_DEFAULT to "quiet splash" and run update-grub.

## Harden

    # Generate password hash
    grub-mkpasswd-pbkdf2

    # Add to /etc/grub.d/40_custom
    set superusers="root"
    password_pbkdf2 root <hash>

    # Apply
    update-grub

    # Lock down config files
    chmod 600 /etc/default/grub
    chmod 700 /etc/grub.d/40_custom

    # Verify password is in generated config
    grep -i password /boot/grub/grub.cfg

GRUB password alone is not enough. An attacker with a USB drive can boot
a live OS and bypass GRUB entirely. Full protection requires GRUB password
plus BIOS/UEFI password plus Secure Boot.

## Failure Modes

- No GRUB password — 30 second physical compromise
- GRUB password without BIOS password — bypassed by booting from USB
- Forgetting to run update-grub after changes — config not applied
- Not backing up /etc/default/grub before changes
- Assuming boot security is only a physical threat — root can modify grub remotely

## Next

- /root hardening — SSH keys, history files, privilege abuse
- initrd tampering — injecting code into the initial RAM disk
