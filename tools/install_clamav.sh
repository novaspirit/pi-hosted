#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directories..."
sudo mkdir -p /portainer/Files/AppData/Config/clamav/config || error "Failed to create clamav config folder!"
sudo mkdir -p /portainer/Files/AppData/Config/clamav/virus_definitions || error "Failed to create clamav virus_definitions folder!"

echo "Creating pre-filled clamav config files"
sudo wget -O /portainer/Files/AppData/Config/clamav/config/clamd.conf https://github.com/Cisco-Talos/clamav/files/10096744/clamd.conf.txt || error "Failed to get clamd config file!"
sudo wget -O /portainer/Files/AppData/Config/clamav/config/freshclam.conf https://github.com/Cisco-Talos/clamav/files/10096745/freshclam.conf.txt || error "Failed to get freshclam config file"

echo "Setting the right permissions"
sudo chown -R 100:101 /portainer/Files/AppData/Config/clamav/ || error "Unable to set the right permissions for clamav!"

echo "Setup complete. You can now install clamav using the App Template."
