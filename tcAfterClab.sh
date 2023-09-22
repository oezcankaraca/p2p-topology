#!/bin/bash

# Variable definition
PEERS=("clab-containerlab-topology-peer1" "clab-containerlab-topology-peer2")

# Network simulation for each peer
for PEER in "${PEERS[@]}"; do
    echo "Simulating network conditions for $PEER:"
    
    # Display the tc configuration
    echo ""
    echo "Initial tc configurations for eth1 of $PEER:"
    sudo docker exec -it $PEER tc qdisc show dev eth1

    # Check and delete existing tc rules, if present
    if sudo docker exec -it $PEER tc qdisc show dev eth1 | grep -q "handle 1:"; then
        sudo docker exec -it $PEER tc qdisc del dev eth1 root
    fi

    # Add Token Bucket Filter (TBF) qdisc on eth1
    echo ""
    echo "Setting up Token Bucket Filter (TBF) on eth1 of $PEER to limit rate to 1Mbit, with a buffer of 32Kb and latency of 400ms..."
    sudo docker exec -it $PEER tc qdisc add dev eth1 root handle 1: tbf rate 1mbit burst 32kbit latency 400ms

    # Add Network Emulator (netem) qdisc to introduce a delay of 100ms
    echo ""
    echo "Introducing a delay of 100ms using Network Emulator (netem) on eth1 of $PEER..."
    sudo docker exec -it $PEER tc qdisc add dev eth1 parent 1: handle 10: netem delay 100ms

    # Add another netem qdisc to simulate 10% packet loss
    echo ""
    echo "Simulating 10% packet loss using Network Emulator (netem) on eth1 of $PEER..."
    sudo docker exec -it $PEER tc qdisc add dev eth1 parent 10: handle 20: netem loss 10%

    # Display the tc configuration
    echo ""
    echo "Current tc configurations for eth1 of $PEER:"
    sudo docker exec -it $PEER tc qdisc show dev eth1
    echo ""
    echo "------------------------------------------------------------------------------------------------------------------------------------------------"

    # Short pause to ensure all processes are complete
    sleep 2
done

