#!/bin/bash

function error {
    echo -e "\\e[91m$1\\e[39m"
    exit 1
}

echo "Creating directory..."
sudo mkdir -p /portainer/Files/AppData/Config/flatnotes || error "Failed to create folder!"
sudo mkdir -p /portainer/Files/AppData/Config/flatnotes/data || error "Failed to create folder!"
sudo chown -R 1000.1000 /portainer/Files/AppData/Config/flatnotes || error "Failed to create folder!"
echo "Setup complete. You can now install Flatnotes using the App Template."
