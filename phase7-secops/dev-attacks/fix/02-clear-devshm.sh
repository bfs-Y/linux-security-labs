#!/bin/bash
# FIX: Detect and remove payloads from /dev/shm

echo "[DETECT] /dev/shm contents including hidden files:"
ls -la /dev/shm/

echo "[DETECT] executable files in /dev/shm:"
find /dev/shm -type f -executable

echo "[DETECT] hidden files in /dev/shm:"
find /dev/shm -name ".*"

echo "[FIX] removing all non-standard files from /dev/shm:"
find /dev/shm -type f -delete

echo "[VERIFY] /dev/shm after cleanup:"
ls -la /dev/shm/
