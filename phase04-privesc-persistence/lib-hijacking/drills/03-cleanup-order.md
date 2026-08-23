# Drill 03: Remove Persistence Without Triggering Payload

**Time limit:** 5 minutes
**Environment:** Active compromise. /etc/ld.so.preload is confirmed populated.

## Scenario

You've confirmed the attack. /etc/ld.so.preload points to /lib/evil.so and every binary
is loading it. You need to remove the persistence cleanly without firing the payload
an extra time during cleanup.

Order matters here. Get it wrong and the library executes one more time.

## Tasks

1. Remove the preload file first
2. Verify it's gone before touching the library
3. Remove the library
4. Confirm clean execution on any binary

## Commands in Order

rm /etc/ld.so.preload
cat /etc/ld.so.preload 2>/dev/null || echo "preload gone"
rm /lib/evil.so
ls && whoami

## Success Criteria

- No payload output after ls and whoami
- Preload file confirmed absent before library removal
- Both files gone from filesystem

## Failure Modes

- Removing the library first — preload file still exists, next binary execution fires payload
- Not verifying preload is gone before removing the library
- Assuming it's clean without running a binary to confirm

## Solution

[Run the drill first. Fill this in after at least two attempts.]
