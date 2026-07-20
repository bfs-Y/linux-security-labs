# Drill 01: Detect PATH Hijack Without Execution

**Time limit:** 5 minutes 
**Environment:** Compromised shell with poisoned hash table

## Scenario

User reports `ls` acting strange. You suspect PATH hijack. 
You have active shell session. Cannot restart it.

## Tasks

1. Confirm which binary is actually executing
2. Identify the malicious binary location
3. Verify legitimate binary still exists
4. Do NOT execute the suspicious binary

## Success Criteria

- Correct malicious path identified
- Proof shown without execution
- Legitimate binary verified intact
- Completed in under 5 minutes

## Failure Modes

- Executing the malicious binary
- Restarting the shell (defeats drill purpose)
- Wrong binary identified
- Timeout

## Solution

[Run drill first. Fill this after multiple attempts.]
