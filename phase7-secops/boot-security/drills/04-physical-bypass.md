# Drill 04: Understand Physical Access Bypass

**Time limit:** 5 minutes
**Environment:** Conceptual — no commands required.

## Scenario

You have set a GRUB password. A colleague claims the system is now fully
protected against physical attack. Explain why they are wrong and what
additional controls are needed.

## Tasks

1. Explain how GRUB password is bypassed with a USB drive
2. Name the three layers needed for full boot protection
3. Explain what Secure Boot protects against
4. Explain what a BIOS/UEFI password adds

## Answers

1. Attacker boots from USB live OS — GRUB on the hard drive never loads
2. GRUB password + BIOS/UEFI password + Secure Boot
3. Secure Boot verifies bootloader signature — prevents loading unsigned OS
4. BIOS password prevents changing boot order to USB

## Success Criteria

- Can explain the USB bypass without notes
- Can name all three protection layers
- Understand what each layer protects against

## Solution

[Review and recite from memory after two attempts.]
