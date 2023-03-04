#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directories..."
sudo mkdir -p /portainer/Files/AppData/Config/Whoogle || error "Failed to create Whoogle config directory!"
echo "Setting permissions..."
sudo chown -R 927:927 /portainer/Files/AppData/Config/Whoogle || error "Failed to set permissions!"
echo "Done You are ready to install the Whoogle Template"
