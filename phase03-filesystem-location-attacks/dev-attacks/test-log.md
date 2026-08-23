## Break Scenario 01: /dev/null Replacement
Date: 2026-03-15
Result: Pass
Notes: Replaced character device with regular file. Captured password and
API key data meant to be discarded. Detection: ls -la shows - instead of c.
Restoration: rm /dev/null && mknod -m 666 /dev/null c 1 3. Verify by
echo test > /dev/null && cat /dev/null returns nothing.

## Break Scenario 02: /dev/shm Payload
Date: 2026-03-15
Result: Pass
Notes: Staged hidden payload in /dev/shm. Direct execution blocked by
noexec. Bypassed with bash interpreter. Detection: find /dev/shm -name ".*"
finds hidden files. ls without -la misses them entirely.

## Drills 01-05
Result: Not yet run independently
Notes: Run all five before consolidation testing.
