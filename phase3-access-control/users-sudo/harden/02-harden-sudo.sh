#!/bin/bash
echo "=== Removing NOPASSWD entries ==="
sed -i '/NOPASSWD/d' /etc/sudoers

echo "=== Enforcing sudo group audit ==="
getent group sudo

echo "=== Done ==="
