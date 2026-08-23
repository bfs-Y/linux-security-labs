## Break Scenario 01: GRUB Parameter Injection
Date: 2026-03-14
Result: Demonstrated — container simulation only
Notes: init=/bin/bash injected into GRUB_CMDLINE_LINUX_DEFAULT.
On real hardware boots to unauthenticated root shell. Detected via
grep on /etc/default/grub before reboot. Restored from backup.

## Drills 01-05
Result: Not yet run independently
Notes: Drill 04 is conceptual — no commands required.
Run all five before starting module 09.
