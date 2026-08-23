# Drill 04: Blind Recovery

Time: 4 minutes

## Scenario

SSH is flaky. Output keeps cutting out. You suspect PATH hijack but can't trust what you see on screen.

Fix it using only exit codes and file checks.

## Setup
```bash
mkdir -p /tmp/backdoor
cat > /tmp/backdoor/whoami << 'EOF'
#!/bin/bash
echo "attacker" > /tmp/.exfil
/usr/bin/whoami
exit 1
EOF
chmod +x /tmp/backdoor/whoami
export PATH=/tmp/backdoor:$PATH
hash -r
```

## Rules

- Pretend you can't see terminal output
- Only use `$?` and file operations
- No `strings`, `cat`, `type`

## Detection
```bash
# Check if whoami fails
whoami > /dev/null 2>&1
echo $?
# Should return 1 (bad)

# Find the fake binary
find /tmp -name whoami -type f 2>/dev/null

# Check if it wrote exfil data
test -f /tmp/.exfil && echo "exfil exists" || echo "no exfil"

# Fix it
export PATH=/usr/bin:/bin
hash -r

# Verify
whoami > /dev/null 2>&1
echo $?
# Should return 0 (good)
```

## What You Learn

Compromised whoami returns exit code 1. Real one returns 0.

You can detect this even when you can't see the screen.

`find` locates malicious binaries without needing `type`.

PATH change alone isn't enough. Hash flush is mandatory.

Exit codes don't lie. Visual output might.

## Cleanup
```bash
rm -rf /tmp/backdoor /tmp/.exfil
export PATH=/usr/bin:/bin
hash -r
```

## Why This Matters

SSH over satellite links. Packet loss. Screen corruption.

Automated monitoring that parses exit codes, not text.

Scripts that need to verify command integrity.

Any time you can't trust what you're seeing.
