#!/bin/bash

# Deploy Django Notes App with error handling

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

    # Update and install dependencies
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

    # Ensuring Docker is running
    sudo systemctl start docker
    sudo systemctl enable docker

    # Installing  Nginx
    sudo apt-get install nginx -y
    sudo systemctl enable nginx
}

deploy() {
    echo "Deploying Docker Container..."
    docker build -t notes-app-image .
    docker run -d -p 8000:8000 notes-app-image:latest
}

echo "************** Deployment Started *************"

Code_clone

if ! install_requirements; then
    echo "Requirements installation failed."
    exit 1
fi

deploy

echo "************** Deployment Completed *************"
