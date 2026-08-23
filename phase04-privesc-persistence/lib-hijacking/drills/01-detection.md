# Drill 01: Detect Malicious Library Persistence

**Time limit:** 5 minutes
**Environment:** Live system. Something is loading on every binary execution and you don't know what.

## Scenario

User says every command is printing garbage they didn't expect. `ls` fires it. `whoami` fires it. Doesn't matter what they run. You suspect shared library persistence — something registered in `/etc/ld.so.preload` that the dynamic linker is injecting into every process before `main()` runs.

Your job is to confirm it, identify what's there, and prove it doesn't belong.

## Tasks

1. Check whether `/etc/ld.so.preload` exists and what it's pointing at
2. Pull metadata on the library — when was it created, who owns it, what size
3. Run strings on it and look for anything that shouldn't be in a system library
4. Verify package ownership — if nothing owns it, that's your confirmation

## Commands in Order

cat /etc/ld.so.preload
stat /lib/<library>.so
strings /lib/<library>.so | grep -E "(exec|socket|/tmp|bash|wget|curl)"
dpkg -S /lib/<library>.so

## Success Criteria

- Preload file found, contents identified
- Library creation timestamp noted
- Payload string or compiler artifact visible in strings output
- dpkg -S returns nothing — not owned by any package regardless of filename

## Failure Modes

- Running ldd on the suspicious library — can execute it
- Deleting the library before the preload file — payload fires one more time
- Trusting the filename — libpam.so.1 can be malicious
- Skipping dpkg -S — strings alone don't confirm anything

## Solution

[Run the drill first. Fill this in after at least two attempts.]
