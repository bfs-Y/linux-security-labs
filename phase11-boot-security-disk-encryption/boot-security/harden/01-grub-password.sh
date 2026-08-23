#!/bin/bash
# HARDEN: Set GRUB password to prevent boot parameter tampering
# Must be run on real hardware — grub files may not exist in containers

echo "[STEP 1] generate password hash:"
echo "run: grub-mkpasswd-pbkdf2"
echo "copy the full hash starting with grub.pbkdf2.sha512..."

echo ""
echo "[STEP 2] add to /etc/grub.d/40_custom:"
cat << 'EOF'
#!/bin/sh
exec tail -n +3 $0
set superusers="root"
password_pbkdf2 root <paste-hash-here>
EOF

echo ""
echo "[STEP 3] apply changes:"
echo "update-grub"

echo ""
echo "[STEP 4] verify:"
echo "grep -i password /boot/grub/grub.cfg"

echo ""
echo "[STEP 5] protect the config files:"
chmod 600 /etc/default/grub
chmod 700 /etc/grub.d/40_custom
chown root:root /etc/default/grub /etc/grub.d/40_custom
echo "[HARDEN] permissions locked down"

echo ""
echo "[REMINDER] physical security is the final layer"
echo "GRUB password is bypassed if attacker boots from USB"
echo "Enable Secure Boot and BIOS password for full protection"
