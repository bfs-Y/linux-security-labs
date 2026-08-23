#!/bin/bash
# FIX: Detect and restore tampered /dev/null

echo "[DETECT] checking /dev/null:"
ls -la /dev/null

# Check if it's a character device
if [ "$(stat -c %F /dev/null)" != "character special file" ]; then
    echo "[ALERT] /dev/null is not a character device — tampered"
    echo "[ALERT] contents:"
    cat /dev/null
    echo "[FIX] restoring /dev/null"
    rm /dev/null
    mknod -m 666 /dev/null c 1 3
    echo "[VERIFY] restored:"
    ls -la /dev/null
    echo "test" > /dev/null
    cat /dev/null && echo "FAIL" || echo "[CLEAN] /dev/null discarding data"
else
    echo "[CLEAN] /dev/null is legitimate character device"
fi
