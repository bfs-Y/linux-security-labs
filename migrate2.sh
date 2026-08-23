#!/usr/bin/env bash
set -euo pipefail

# fix the missed folder from run 1
git mv phase3-access-control/hardening-audit phase01-users-permissions-sudo/hardening-audit
rmdir phase3-access-control

# resume everything that never ran because run 1 died here
git mv phase7-secops/root-hardening phase02-authentication-ssh-pam/root-hardening

git mv phase7-secops/etc-hardening  phase03-filesystem-location-attacks/etc-hardening
git mv phase7-secops/home-security  phase03-filesystem-location-attacks/home-security
git mv phase7-secops/tmp-attacks    phase03-filesystem-location-attacks/tmp-attacks
git mv phase7-secops/dev-attacks    phase03-filesystem-location-attacks/dev-attacks
git mv phase7-secops/usr-execution  phase03-filesystem-location-attacks/usr-execution

git mv phase7-secops/privilege-escalation   phase04-privesc-persistence/privilege-escalation
git mv phase7-secops/lib-hijacking          phase04-privesc-persistence/lib-hijacking
git mv phase7-secops/process-signal-attacks phase04-privesc-persistence/process-signal-attacks

git mv phase1-layer2-attacks/arp phase06-layer2-network-attacks/arp
rmdir phase1-layer2-attacks

git mv phase2-firewalling/firewall phase07-firewalling/firewall
rmdir phase2-firewalling

git mv phase4-appsec/cleartext-capture phase08-appsec-crypto/cleartext-capture
git mv phase4-appsec/tls               phase08-appsec-crypto/tls
rmdir phase4-appsec

git mv phase5-recon-detection/rogue-port phase09-recon-detection/rogue-port
rmdir phase5-recon-detection

git mv phase6-logging-monitoring/var-attacks phase10-logging-monitoring-integrity/var-attacks
rmdir phase6-logging-monitoring

git mv phase7-secops/boot-security phase11-boot-security-disk-encryption/boot-security

rmdir phase7-secops 2>/dev/null || echo "WARNING: phase7-secops not empty — check leftovers"

mkdir -p phase06-layer2-network-attacks/arp/test-log
mkdir -p phase07-firewalling/firewall/test-log
mkdir -p phase07-firewalling/firewall/postmortem
mkdir -p phase04-privesc-persistence/process-signal-attacks/test-log

echo "Resume complete. Run 'git status' to review."
