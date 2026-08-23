#!/bin/bash
# HARDEN: /dev security controls

echo "[HARDEN] checking /dev/null integrity:"
ls -la /dev/null
stat -c "%F %a %t %T" /dev/null

echo "[HARDEN] verifying /dev/shm mount options:"
mount | grep shm
# Should include noexec,nosuid,nodev

echo "[HARDEN] checking for suspicious files in /dev/shm:"
find /dev/shm -type f | while read f; do
    echo "[SUSPICIOUS] $f"
    ls -la "$f"
done

echo "[HARDEN] making /dev/null immutable:"
chattr +i /dev/null 2>/dev/null && echo "immutable set" || echo "chattr not available"

echo "[HARDEN] monitor /dev/shm for new executables:"
find /dev/shm -type f -newer /proc/1/exe 2>/dev/null && echo "[ALERT] new files in /dev/shm"

echo "[REMINDER] /dev/shm noexec does not stop interpreter bypass"
echo "Monitor process execution from /dev/shm paths with auditd"
