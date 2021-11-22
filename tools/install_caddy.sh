#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directories..."
sudo mkdir -p /portainer/Files/AppData/Config/Caddy || error "Failed to create Caddy folder!"
echo "Creating a blank caddy config files"
sudo touch /portainer/Files/AppData/Config/Caddy/caddyfile || error "Failed to touch caddyfile file!"
echo "Setup complete. You can now install Caddy using the App Template."

