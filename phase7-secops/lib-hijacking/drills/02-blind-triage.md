# Drill 02: Blind Library Triage

**Time limit:** 7 minutes
**Environment:** You inherit a system. No alert, no context. Just a box you didn't build.

## Scenario

No one told you anything is wrong. You're doing a routine check on a production system.
Your job is to find out if any library on the system shouldn't be there — without knowing
what to look for in advance.

## Tasks

1. Check /etc/ld.so.preload first — should be empty or missing
2. Find every .so file in /lib/x86_64-linux-gnu/ not owned by a package
3. Run checksum verification across installed packages
4. Flag anything that comes back modified

## Commands in Order

cat /etc/ld.so.preload 2>/dev/null || echo "clean"

for lib in /lib/x86_64-linux-gnu/*.so*; do
    dpkg -S "$lib" > /dev/null 2>&1 || echo "[UNOWNED] $lib"
done

dpkg -V 2>/dev/null | grep "^..5"

## Success Criteria

- /etc/ld.so.preload confirmed absent or empty
- Any unowned library flagged by name
- Any checksum mismatch surfaced with dpkg -V

## Failure Modes

- Skipping the preload check because nothing looks wrong
- Assuming package-named files are legitimate without verifying ownership
- Not running dpkg -V — modified libraries won't announce themselves

## Solution

[Run the drill first. Fill this in after at least two attempts.]
