#!/bin/bash
# FIX: Remove ld.so.preload persistence
# Detection first, removal second

echo "[DETECT] Checking /etc/ld.so.preload"
cat /etc/ld.so.preload 2>/dev/null || echo "File not present - clean"

echo "[DETECT] Checking library"
stat /lib/evil.so 2>/dev/null
strings /lib/evil.so 2>/dev/null | grep -E "(eval|exec|socket|/tmp|bash|wget|curl)"
dpkg -S /lib/evil.so 2>/dev/null || echo "[IOC] No package owns this library"

echo "[FIX] Removing preload file first"
rm -f /etc/ld.so.preload

echo "[FIX] Removing malicious library"
rm -f /lib/evil.so

echo "[VERIFY] Running ls - should be clean"
ls /tmp
