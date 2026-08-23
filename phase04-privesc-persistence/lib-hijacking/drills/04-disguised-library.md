# Drill 04: Identify a Malicious Library by a Legitimate Name

**Time limit:** 8 minutes
**Environment:** Post-compromise system. Attacker named their payload libpam.so.1.

## Scenario

Attacker was careful. The malicious library is named libpam.so.1 and sits in
/lib/x86_64-linux-gnu/ next to the real one. Filename tells you nothing.
You need to prove it's malicious using evidence that doesn't depend on the name.

## Tasks

1. Check timestamps — when was it last modified versus system install date
2. Verify package ownership — does any package claim this exact path
3. Run checksum verification — does dpkg -V flag it as modified
4. Check strings for payload artifacts or anomalous compiler output

## Commands in Order

stat /lib/x86_64-linux-gnu/libpam.so.1
dpkg -S /lib/x86_64-linux-gnu/libpam.so.1
dpkg -V libpam-runtime
strings /lib/x86_64-linux-gnu/libpam.so.1 | grep -E "(exec|socket|/tmp|bash|wget|curl)"

## Success Criteria

- Modification timestamp identified and noted as suspicious
- Package ownership confirmed or denied
- dpkg -V surfaces checksum mismatch if file is modified
- Strings output reviewed for non-standard symbols

## Failure Modes

- Trusting the filename
- Skipping dpkg -V — it's the only command that catches a replaced legitimate-named library
- Running ldd on the file to inspect it

## Solution

[Run the drill first. Fill this in after at least two attempts.]
