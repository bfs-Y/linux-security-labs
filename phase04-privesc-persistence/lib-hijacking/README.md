# /lib Hijacking & Shared Library Attacks

Shared libraries load automatically. That is the feature. It is also the problem.

Before main() runs, the dynamic linker resolves every library the binary depends on. If you control what gets loaded — through environment variables, config files, or the filesystem itself — you control what every binary does. No patching. No recompilation. Just a file in the right place.

## Threat Model

An attacker with root access drops a malicious .so file and registers it in /etc/ld.so.preload. From that point, every dynamically linked binary on the system loads the attacker's code first — ls, ssh, sudo, cron, everything. Survives reboots. Affects services that never touch a shell. Most defenders never check for it.

The same outcome is possible without root if LD_PRELOAD is set in a user's environment, but that is noisier and limited to that user's processes. /etc/ld.so.preload is the persistence mechanism worth knowing.

A quieter version skips the preload file entirely — just replace a legitimate library with a malicious one using the same filename and path. No new files. No preload entries. The system loads it normally because it looks like it belongs there.

## What Was Tested

- Constructor-based payload injection via __attribute__((constructor))
- System-wide preload persistence through /etc/ld.so.preload
- Safe library triage without executing untrusted code
- Detection using strings, stat, dpkg -S, and cat /etc/ld.so.preload
- Removal order — preload file first, library second
- .so replacement attack and checksum-based detection with dpkg -V
- Recovery from a broken package manager caused by replacing a core library

## Break 01: ld.so.preload Persistence

Compiled a shared library with a constructor function — code that runs before main() on every binary that loads it. Registered it system-wide in /etc/ld.so.preload.

Every binary spawns a new process. Every process loads the library. The PID changes each time — that is how you know it is firing on separate executions, not caching.

Verify the attack is active:

    ls
    whoami
    id

Each command should print the payload before doing anything else.

## Break 02: .so Replacement

Replaced /lib/x86_64-linux-gnu/libselinux.so.1 with a malicious version using the same filename. No new files. No preload entry. The checksum changed but the path looked identical.

Result: dpkg, ls, cp all broke because they depend on libselinux. Cascading failure. The package manager could not reinstall the library because dpkg itself was compromised. Recovery required extracting the clean library directly from the cached .deb file without using dpkg.

## Fix: Detection and Removal

Safe triage — no execution of untrusted files:

    cat /etc/ld.so.preload
    stat /lib/suspicious.so
    file /lib/suspicious.so
    strings /lib/suspicious.so | grep -E "(exec|socket|/tmp|bash|wget|curl)"
    dpkg -S /lib/suspicious.so

dpkg -S is the key check. Legitimate libraries are owned by packages. No owner means it was dropped manually — suspicious regardless of filename.

For .so replacement, dpkg -V catches checksum mismatches:

    dpkg -V libselinux1

A 5 flag means MD5 mismatch. The file at that path is not what the package manager installed.

Removal order for ld.so.preload persistence:

    rm /etc/ld.so.preload
    rm /lib/evil.so

Preload file first. Reversing the order causes one more payload execution during cleanup.

## Harden

    # Check if preload file exists — it should not on a clean system
    ls /etc/ld.so.preload 2>/dev/null && echo "ALERT: preload file present"

    # Find unowned libraries
    for lib in /lib/x86_64-linux-gnu/*.so*; do
        dpkg -S "$lib" > /dev/null 2>&1 || echo "[UNOWNED] $lib"
    done

    # Check for checksum mismatches
    dpkg -V 2>/dev/null | grep "^..5"

## Attack Surface

/lib/x86_64-linux-gnu/ contains hundreds of libraries. An attacker who names their payload libaudit.so.2 or libpam.so.1 blends in without much effort. Timestamp checks and dpkg -S are reliable signals — not filenames.

The constructor approach is worse than function hijacking from a detection standpoint. It requires no specific function call to trigger. Every binary, every time, unconditionally.

## Failure Modes

- Running ldd on an untrusted .so — can execute the library
- Removing the library before the preload file — payload fires one more time
- Trusting filenames instead of package ownership
- Skipping dpkg -V — the only reliable way to catch a replaced legitimate-named library
- Assuming dpkg -V works when dpkg itself depends on the compromised library

## Next

- /tmp attacks — staging payloads in world-writable directories
- LD_PRELOAD via /etc/environment for user-scoped persistence
- Integrity monitoring with checksums against known-good package state
