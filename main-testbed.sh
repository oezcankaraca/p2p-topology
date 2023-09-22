#!/bin/bash

echo "Please select an option:"
echo "1) Deploy with Containerlab"
echo "2) Destroy with Containerlab"
echo "3) Build Docker image from Dockerfile"
echo "4) Execute network tests with Traffic Control"
echo "5) Restart Docker"
echo "6) Stop and remove all Docker containers"
echo "7) Remove all Docker images"
echo "8) Exit without action"

read -p "Enter the number of your choice: " choice

case $choice in
    1)
        # Deploy using Containerlab
        echo "Deploying with Containerlab..."
        sudo containerlab deploy -t containerlab-topology.yml
        echo "Deployment completed."
        ;;
    2)
        # Destroy using Containerlab
        echo "Destroying with Containerlab..."
        sudo containerlab destroy -t containerlab-topology.yml --cleanup
        echo "Destruction completed."
        ;;
    3)
        # Build Docker image from Dockerfile
        echo "Building Docker image from Dockerfile..."
        sudo docker build -f dockerfile -t p2p-image .
        echo "Docker image build completed."
        ;;
    4)
        # Execute network tests with Traffic Control
        echo "Executing network tests with Traffic Control..."
        ./tcAfterClab.sh > tcAfterClab.txt 2>&1
        echo "Network tests with Traffic Control completed and saved in tcAfterClab.txt."
        ;;
    5)
        # Restart Docker
        echo "Restarting Docker..."
        sudo systemctl restart docker
        echo "Docker has been restarted."
        ;;
    6)
        # Stop and remove all Docker containers
        echo "Stopping all running Docker containers..."
        sudo docker stop $(sudo docker ps -aq)
        echo "Removing all Docker containers..."
        sudo docker rm $(sudo docker ps -aq)
        echo "All Docker containers have been stopped and removed."
        ;;
    7)
        # Remove all Docker images
        echo "Removing all Docker images..."
        sudo docker rmi -f $(sudo docker images -q)
        echo "All Docker images have been removed."
        ;;
    8)
        # Exit without action
        echo "No action taken."
        ;;
    *)
        # Invalid choice
        echo "Invalid choice."
        ;;
esac

