#!/bin/bash

# Function to display the menu and handle user's choice
display_menu() {
    echo "Please select an option:"
    echo "1) Build Docker image from Dockerfile"
    echo "2) Deploy with Containerlab"
    echo "3) Execute network tests with Traffic Control"
    echo "4) Destroy with Containerlab"
    echo "5) Restart Docker"
    echo "6) Stop and remove all Docker containers"
    echo "7) Remove all Docker images"
    echo "8) Exit without action"

    # Prompt the user for their choice
    read -p "Enter the number of your choice: " choice

    # Execute the appropriate action based on user's choice
    case $choice in
        1)	
            echo ""
            # Build Docker image from Dockerfile
            echo "Building Docker image from Dockerfile..."
            sudo docker build -f dockerfile -t p2p-topology .
            echo "Docker image build completed."
            ;;
        2)
            # Deploy using Containerlab
            echo "Deploying with Containerlab..."
            echo ""
            sudo containerlab deploy -t containerlab-topology.yml
            echo "Deployment completed."
            ;;
        3)
            # Execute network tests with Traffic Control
            echo "Executing network tests with Traffic Control..."
            ./tcAfterClab.sh > tcAfterClab.txt 2>&1
            echo "Network tests with Traffic Control completed and saved in tcAfterClab.txt."
            ;;
        4)
            # Destroy using Containerlab
            echo "Destroying with Containerlab..."
            sudo containerlab destroy -t containerlab-topology.yml --cleanup
            echo "Destruction completed."
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
            echo "No action taken. Exiting."
            exit 0
            ;;
        *)
            # Invalid choice
            echo "Invalid selection."
            ;;
    esac
}

# Main loop to continuously display the menu until user selects option 8
while true; do
    display_menu

    # Pause for a moment to let the user see the results
    sleep 2

    # Ask the user if they want to continue or exit
    read -p "Do you want to continue? (yes/no): " continue_choice
    if [[ "$continue_choice" == "no" ]]; then
        echo "Exiting."
        exit 0
    fi
done

