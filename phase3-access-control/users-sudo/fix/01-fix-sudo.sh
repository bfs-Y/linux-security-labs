#!/bin/bash
sed -i '/^alice/d' /etc/sudoers
deluser bob sudo 2>/dev/null
userdel -r alice 2>/dev/null
userdel -r bob 2>/dev/null
