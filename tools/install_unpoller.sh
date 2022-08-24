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

check_internet

echo "Creating directories..."
sudo mkdir -p /portainer/Files/AppData/Config/unpoller || error "Failed to create config directory!"
echo "Downloading Unpoller config files"
sudo wget -O /portainer/Files/AppData/Config/unpoller/up.conf https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/unpoller-up.conf || error "Failed to download up.conf file!"
echo "Done You are ready to goto next step in the install document"
