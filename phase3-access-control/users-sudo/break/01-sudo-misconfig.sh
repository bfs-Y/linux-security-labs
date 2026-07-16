#!/bin/bash
useradd -m alice 2>/dev/null
useradd -m bob 2>/dev/null
echo "alice:password123" | chpasswd
echo "bob:password123" | chpasswd
usermod -aG sudo bob
echo "alice ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
echo "alice ALL=(ALL:ALL) ALL" >> /etc/sudoers
