#!/usr/bin/env bash
set -euo pipefail

git mv phase7-secops/boot-security phase11-boot-security-disk-encryption/boot-security

rmdir phase7-secops 2>/dev/null || echo "WARNING: phase7-secops not empty — check leftovers"

mkdir -p phase06-layer2-network-attacks/arp/test-log
mkdir -p phase07-firewalling/firewall/test-log
mkdir -p phase07-firewalling/firewall/postmortem
mkdir -p phase04-privesc-persistence/process-signal-attacks/test-log

echo "Resume complete. Run 'git status' to review."
