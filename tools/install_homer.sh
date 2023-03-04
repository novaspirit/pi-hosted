#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directory..."
sudo mkdir -p /portainer/Files/AppData/Config/Homer || error "Failed to create Homer folder!"
sudo mkdir -p /portainer/Files/AppData/Config/Homer/assets || error "Failed to create Homer folder!"
sudo chown -R 1000:1000 /portainer/Files/AppData/Config/Homer || error "Failed to create Homer folder!"
echo "Setup complete. You can now install the Homer using the App Template."
