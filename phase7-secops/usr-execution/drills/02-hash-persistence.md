# Drill 02: Hash Table Persistence

**Time limit:** 3 minutes

## Scenario

Malicious binary cached in hash table. You remove it from PATH. 
Does the compromise persist?

## Setup
```bash
export PATH=/tmp/backdoor:$PATH
hash -r
ps  # Triggers caching
```

## Test
```bash
# Remove malicious directory from PATH
export PATH=/usr/bin:/bin

# Does ps still execute backdoor?
ps
```

## Expected Result

YES - backdoor still executes because hash table still points to `/tmp/backdoor/ps`.

## Correct Fix
```bash
hash -r  # Flush hash table
ps       # Now clean
```

## Lesson

PATH changes don't affect existing hash table entries. 
Always flush hash after PATH modifications during incident response. 
Hash table is per-shell - only affects current session.

## Verification Commands
```bash
hash           # Show cached paths
hash -r        # Clear all cached paths
type -a ps     # Show all PATH matches (doesn't use cache)
which ps       # Show first match (uses cache in some shells)
```
