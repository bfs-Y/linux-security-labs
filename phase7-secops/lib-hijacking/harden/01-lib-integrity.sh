#!/bin/bash

echo "[CHECK 1] /etc/ld.so.preload"
if [ -f /etc/ld.so.preload ]; then
    echo "[ALERT] preload file exists"
    cat /etc/ld.so.preload
else
    echo "clean"
fi

echo ""
echo "[CHECK 2] unowned libraries"
for lib in /lib/x86_64-linux-gnu/*.so*; do
    dpkg -S "$lib" > /dev/null 2>&1 || echo "[UNOWNED] $lib"
done

echo ""
echo "[CHECK 3] checksum mismatches"
dpkg -V 2>/dev/null | grep "^..5" || echo "clean"
