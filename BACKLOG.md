
## Attack surface — unused/forgotten network interfaces
Found: training-vm has a second NIC (enp7s0) on an isolated network with no
IP configured, physically up but doing nothing, discovered by accident
during Phase 0 investigation. Real production parallel: unmonitored
interfaces are a forgotten attack surface. Lab idea: script that audits a
host for interfaces that are UP but have no meaningful traffic/monitoring,
flags them for review.
