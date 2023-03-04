#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

function check_internet() {
  printf "Checking if you are online..."
  wget -q --spider http://github.com
  if [ $? -eq 0 ]; then
    echo "Online. Continuing."
  else
    error "Offline. Go connect to the internet then run the script again."
  fi
}

# check_internet

echo "Setting permissions..."
sudo chown -R root:root /portainer/Files/AppData/Config/ncdata || error "Failed to set permissions!"
sudo chown -R 33:33 /portainer/Files/AppData/Config/ncdata/nextcloud || error "Failed to set permissions!"
sudo chown -R 33:33 /portainer/Files/AppData/Config/ncdata/ncp || error "Failed to set permissions!"
sudo chown -R 101:102 /portainer/Files/AppData/Config/ncdata/database || error "Failed to set permissions!"
sudo chmod -R 755 /portainer/Files/AppData/Config/ncdata/ || error "Failed to set permissions!"
echo "Permissions are reset to a working config."
