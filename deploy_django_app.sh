#!/bin/bash

# Deploy Django Notes App with error handling using Docker Compose

Code_clone() {
    echo "Cloning the Repo"
    if [ -d "django-notes-app" ]; then
        echo "The Code directory already exists"
        cd django-notes-app || exit
    else
        git clone https://github.com/LondheShubham153/django-notes-app.git
        cd django-notes-app || exit
    fi
}

install_requirements() {
    echo "Installing Dependencies"

    sudo apt-get update -y

    # Install Docker 
    if ! command -v docker &> /dev/null; then
        echo "Docker not found. Installing..."
        curl -fsSL https://get.docker.com | sh
        sudo usermod -aG docker $USER
        newgrp docker
    else
        echo "Docker already installed"
    fi

    # Ensure Docker is running
    sudo systemctl start docker
    sudo systemctl enable docker

    # Install Docker Compose plugin
    if ! command -v docker compose &> /dev/null; then
        echo "Docker Compose not found. Installing..."
        sudo apt-get install docker-compose-plugin -y
    else
        echo "Docker Compose already installed"
    fi

}

deploy() {
    docker build -t notes-app .
    echo "Deploying with Docker Compose..."
    docker compose up --build -d
}


# Main Script
echo "************** Deployment Started *************"

Code_clone

if ! install_requirements; then
    echo "Requirements installation failed."
    exit 1
fi

deploy

echo "************** Deployment Completed *************"
