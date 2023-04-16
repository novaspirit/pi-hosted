#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directory..."
sudo mkdir -p /portainer/Files/AppData/Config/pgadmin || error "Failed to create pgadmin folder!"
sudo mkdir -p /portainer/Files/AppData/Config/pgadmin || error "Failed to create pgadmin folder!"
sudo chown -R 5050:root /portainer/Files/AppData/Config/pgadmin || error "Failed to create pgadmin folder!"
echo "Setup complete. You can now install the PgAdmin using the App Template."
