#!/bin/bash
echo "=== NOPASSWD sudo entries ==="
grep NOPASSWD /etc/sudoers /etc/sudoers.d/* 2>/dev/null

echo "=== All active sudo rules ==="
grep -v "^#" /etc/sudoers | grep -v "^$"

echo "=== Users in sudo group ==="
getent group sudo

echo "=== Users in admin group ==="
getent group admin

echo "=== Accounts with UID 0 ==="
awk -F: '($3 == 0)' /etc/passwd

echo "=== Accounts with empty password ==="
awk -F: '($2 == "")' /etc/shadow

echo "=== All users with shell access ==="
grep -v nologin /etc/passwd | grep -v false
