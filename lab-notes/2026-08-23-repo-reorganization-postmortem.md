# Postmortem: Repo Structural Reorganization

## What changed
Reorganized linux-security-labs from flat, inconsistently numbered phase directories (phase1, phase2, phase3...) into a consistent phaseNN- naming scheme. Split phase7-secops — a ten-topic junk drawer covering boot security, /dev, /etc, /home, lib hijacking, privilege escalation, process/signal attacks, root hardening, /tmp, and /usr — into three meaningful phases (auth/SSH, filesystem-location attacks, privesc/persistence). Added eight new stub topics for gaps that didn't exist before: SSH hardening, PAM hardening, SELinux, AppArmor, file integrity monitoring, disk encryption, patch tracking, and compliance benchmarks. Backfilled missing test-log directories on arp, firewall, and process-signal-attacks, and a missing postmortem directory on firewall.

## What stayed the same
None of the actual lab content changed. Every break/drill/fix/harden script that existed before the reorg still exists, untouched, just relocated to a new path.

## Timeline of failures, in order
1. Pasted the first migration script directly into the terminal with `set -e` active. A failed command killed the shell itself and closed the terminal window, because the pasted script ran in my current interactive shell, not a subprocess.
2. Fixed that by saving the script to a file and running it with `bash`, so a failure inside the script would only kill the subprocess.
3. Script died at `rmdir phase3-access-control` — a fourth subdirectory, `hardening-audit`, existed in the real filesystem but wasn't accounted for in the migration plan.
4. Resumed with a second script. That one died at `rmdir phase6-logging-monitoring` — a hidden `.gitkeep` file was present that plain `ls` didn't show.
5. Found it with `ls -la`, removed it, resumed with a third script that completed cleanly.
6. On review, found a stale duplicate `phase0-threat-modeling` directory still sitting alongside the new `phase00-threat-modeling` — never cleaned up. It also had a hidden `.gitkeep`, discovered the same way, requiring `git rm` instead of plain `rm` since it was tracked.
7. The script that removed it also died right after (same `rmdir`-on-a-dir-that-git-rm-already-emptied issue), so the scaffolding loop for the eight new stub topics silently never ran — twice, across two script attempts — before I finally split scaffolding into its own isolated script and confirmed it actually completed.
8. After committing, discovered the six break/drill/fix/harden/test-log/postmortem subfolders under the new stub topics weren't tracked by git at all, because git doesn't track empty directories — only the README.md files inside them made it into the commit. Fixed with a second pass adding `.gitkeep` to each empty subfolder.

## Root cause analysis
Not "I made typos." The actual pattern across all eight failures was **trusting stale or incomplete evidence instead of checking current, complete state**:
- Trusted an old `tree` output as still-accurate instead of the live filesystem.
- Trusted plain `ls` (which hides dotfiles) as a complete directory listing three separate times.
- Trusted a script producing no fatal-looking output as proof the whole job finished, when `set -e` had actually killed it partway through more than once.
- Trusted a successful `git commit` as proof the full structure was captured, without checking that git doesn't track empty directories at all.

## What's now automated/hardened against this recurring
- Default to `ls -la`, never plain `ls`, before deleting or assuming a directory is empty.
- Never paste a `set -e` script directly into an interactive shell — always save to a file and run with `bash file.sh` so a failure can't take down the terminal.
- After any migration/reorg script, verify with a fresh `tree` and an explicit file/directory count comparison against the pre-migration baseline — don't infer success from a lack of errors.
- Any directory meant to be empty scaffolding gets a `.gitkeep` committed at creation time, not discovered missing after the fact.

## What I'd tell a teammate
Before you delete or reorganize anything: `ls -la`, not `ls`. Save scripts to a file before running them, never paste directly with `set -e` on. And a clean exit code is not evidence — check the actual resulting state before you trust it.
