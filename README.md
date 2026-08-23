# linux-security-labs

A hands-on Linux security training repo. Every topic here is learned by building it correctly, breaking it, exploiting the break like an adversary would, fixing it with evidence, hardening it so the same break is harder to repeat, and proving that hardening holds — not by reading about it.

This is not a tutorial collection. It's a lab log.

## Methodology

Every lab topic follows the same cycle:

1. **Build** — configure it correctly first, manually.
2. **Automate** — where it makes sense, turn the correct config into something enforced automatically rather than relying on memory.
3. **Break** — deliberately misconfigure it.
4. **Attack** — exploit the weakness the way an adversary would, scoped to this lab environment only.
5. **Fix** — repair using evidence (logs, audit trail, kernel state), not guesswork.
6. **Harden** — go past "fixed" to structurally harder to break the same way again.
7. **Test/Log** — repeat the attack against the hardened state and prove it fails now, and confirm it would show up in logs.
8. **Postmortem** — written record of what happened, the real root cause, the evidence, and the safeguard now in place.

Every topic folder follows the same subfolder pattern: `break/ drill/ fix/ harden/ test-log/ postmortem/`.

## `/lab-notes`

Session-level notes and postmortems that don't belong to a single topic — cross-cutting incidents, migration/reorg history, and anything that needs documenting but doesn't fit inside one phase folder.

## Structure

| Phase | Topic | Status |
|---|---|---|
| `phase00-threat-modeling` | Asset inventory, trust boundaries, attacker profiles | **Empty — not started** |
| `phase01-users-permissions-sudo` | UID/GID, permissions, sudoers, /sbin admin tooling | Built out |
| `phase02-authentication-ssh-pam` | Root/SSH hardening; PAM and SSH-specific stubs | root-hardening built; ssh-hardening/pam-hardening are stubs |
| `phase03-filesystem-location-attacks` | /etc, /home, /tmp, /dev, /usr — attacks that plant something at a known path | Built out |
| `phase04-privesc-persistence` | SUID/capabilities, LD_PRELOAD/.so hijacking, process/signal attacks | Built out |
| `phase05-mandatory-access-control` | SELinux, AppArmor | **Stubs only — not started** |
| `phase06-layer2-network-attacks` | ARP poisoning, static bindings, monitoring | Built out |
| `phase07-firewalling` | nftables/iptables misconfig and restriction | Built out (postmortem still owed) |
| `phase08-appsec-crypto` | Cleartext capture, TLS/fake cert inspection | Built out |
| `phase09-recon-detection` | Rogue port detection | Built out |
| `phase10-logging-monitoring-integrity` | /var log tampering, cron persistence; file integrity monitoring stub | var-attacks built; file-integrity-aide is a stub |
| `phase11-boot-security-disk-encryption` | GRUB hardening; disk encryption stub | boot-security built; disk-encryption-luks is a stub |
| `phase12-patch-management-compliance` | Patch tracking, compliance benchmarking | **Stubs only — not started** |
| `phase13-incident-response-forensics` | Volatile data collection, timeline reconstruction, full compromise simulation | **Empty — not started** |
| `phase14-capstone` | Combined multi-fault incident | **Empty — not started** |

Status is stated honestly here on purpose. A folder existing is not the same as the topic being learned.

## Known gaps as of last review

- Threat modeling (phase00) has to happen before phase02 and phase05 get real content — everything downstream should be justifiable against a written threat model that doesn't exist yet.
- `arp` and `firewall` were the earliest labs built and are the least rigorously closed out — firewall is still missing its postmortem.
- Everything marked "stub" has folder structure but no actual scripts.

## Migration history

This repo was restructured from an earlier flat phase-numbering scheme into the current layout. See `/lab-notes` for the reorg postmortem, including what broke during the migration and why.
