# Drill 05: Timed Incident Response — Library Compromise

**Time limit:** 10 minutes
**Environment:** Full scenario. You get paged. Nothing else.

## Scenario

3am. Alert fires. "Unusual output on all commands across prod server." You SSH in.
No runbook. No hints. You have 10 minutes to confirm or rule out shared library compromise,
identify the persistence mechanism, remove it, and verify clean.

Do it from memory. No notes.

## Tasks

1. Check /etc/ld.so.preload
2. Identify and triage any referenced library
3. Scan for unowned libraries system-wide
4. Remove persistence in correct order
5. Verify clean

## Pass Criteria

- Full triage completed under 10 minutes
- Correct removal order — preload file before library
- Clean binary execution confirmed after removal
- No ldd used on untrusted files
- All findings documented in test-log.md after drill

## Failure Modes

- Any step done from memory incorrectly
- Wrong removal order
- Skipping verification after cleanup
- Timeout

## Solution

[Run the drill first. Fill this in after at least two attempts.]
