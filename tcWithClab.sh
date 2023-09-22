#!/bin/sh

# Adding tc (Traffic Control) commands below:

# Adding a Token Bucket Filter (TBF) qdisc on eth1.
echo ""
echo "Setting up Token Bucket Filter (TBF) on eth1 to limit rate to 1Mbit, with a buffer of 32Kb and latency of 400ms..."
tc qdisc add dev eth1 root handle 1: tbf rate 1mbit burst 32kbit latency 400ms

# Adding a Network Emulator (netem) qdisc to introduce a delay of 100ms.
echo ""
echo "Introducing a delay of 100ms using Network Emulator (netem) on eth1..."
tc qdisc add dev eth1 parent 1: handle 10: netem delay 100ms

# Adding another netem qdisc to simulate 10% packet loss.
echo ""
echo "Simulating 10% packet loss using Network Emulator (netem) on eth1..."
tc qdisc add dev eth1 parent 10: handle 20: netem loss 10%

# Showing the tc configuration
echo ""
echo "After tc-configurations for eth1:"
tc qdisc show dev eth1
echo ""

