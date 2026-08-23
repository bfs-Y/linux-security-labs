#!/bin/bash
# BREAK: Replace /dev/null with capture file
# Sensitive data meant to be discarded gets captured instead

echo "[BEFORE] legitimate /dev/null:"
ls -la /dev/null

# Replace with regular file
rm /dev/null
touch /dev/null
chmod 666 /dev/null

echo "[AFTER] replaced /dev/null:"
ls -la /dev/null

# Capture sensitive data
echo "password=supersecret123" > /dev/null
echo "api_key=abc123def456" > /dev/null

echo "[CAPTURED] data that should have been discarded:"
cat /dev/null

echo "[BREAK] IOC: ls -la /dev/null shows - instead of c"
