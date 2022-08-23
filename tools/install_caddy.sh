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
sudo mkdir -p /portainer/Files/AppData/Config/Caddy || error "Failed to create Caddy folder!"
echo "Downloading caddy config files"
sudo wget -O /portainer/Files/AppData/Config/Caddy/Caddyfile https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/Caddyfile || error "Failed to download Caddyfile file!"
echo "Setup complete. You can now install Caddy using the App Template."

