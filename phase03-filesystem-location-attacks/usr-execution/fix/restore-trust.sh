#!/bin/bash
# Restore command execution trust

echo "[*] Flushing hash table..."
hash -r

echo "[*] Resetting PATH to known-good..."
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

echo "[*] Verifying critical commands..."
for cmd in ls cat grep bash; do
    actual=$(hash -t $cmd 2>/dev/null || which $cmd)
    expected="/usr/bin/$cmd"

    if [ "$actual" = "$expected" ]; then
        echo "  [✓] $cmd: $actual"
    else
        echo "  [✗] $cmd: $actual (expected $expected)"
    fi
done

echo "[*] Trust restoration complete"
