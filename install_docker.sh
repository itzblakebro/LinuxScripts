#!/bin/bash

echo "Setting up requirements"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

echo "Done"

sleep 2

echo "Importing keyring"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Done"

sleep 2

echo "Installing docker"

sudo apt update
sudo apt install -y docker-ce

echo "Done"

sleep 1

echo "Adding user to docker group"

sudo usermod -aG docker ${USER}

echo "Done. Install complete"