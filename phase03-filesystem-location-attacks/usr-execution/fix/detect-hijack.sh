#!/bin/bash
# Detect PATH hijacking without executing suspicious binary

echo "[*] Checking command resolution..."

for cmd in ls cat grep ps; do
    echo "
=== $cmd ==="
    type -a $cmd
    hash -t $cmd 2>/dev/null || echo "Not in hash table"
    
    # Check ownership and permissions of first match
    first_match=$(which $cmd 2>/dev/null)
    if [ -n "$first_match" ]; then
        stat -c '%A %U:%G %n' "$first_match"
    fi
done

echo "
[*] Current PATH: $PATH"
echo "[*] Suspicious directories in PATH:"
echo "$PATH" | tr ':' '\n' | while read dir; do
    [ -w "$dir" ] && echo "  [!] Writable: $dir"
done
