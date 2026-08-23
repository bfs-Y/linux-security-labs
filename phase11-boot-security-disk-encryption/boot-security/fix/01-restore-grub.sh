#!/bin/bash
# FIX: Detect and remove malicious GRUB boot parameters

echo "[DETECT] current boot parameters:"
grep CMDLINE /etc/default/grub

echo "[DETECT] checking for dangerous parameters:"
grep -E "(init=|single|rd.break|systemd.unit=emergency)" /etc/default/grub && \
    echo "[ALERT] dangerous boot parameter found" || \
    echo "clean"

echo "[FIX] restoring from backup:"
if [ -f /etc/default/grub.bak ]; then
    cp /etc/default/grub.bak /etc/default/grub
    echo "[FIX] restored from backup"
else
    sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"/' /etc/default/grub
    echo "[FIX] reset to default parameters"
fi

echo "[VERIFY] parameters after fix:"
grep CMDLINE /etc/default/grub
echo "[ACTION] run update-grub to apply on real system"
