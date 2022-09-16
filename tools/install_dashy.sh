#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directory..."
sudo mkdir -p /portainer/Files/AppData/Config/Dashy/ || error "Failed to create Dashy folder!"
echo "Creating a blank Dashy config files"
if [ -d /portainer/Files/AppData/Config/Dashy/local-conf.yml ];
then
    sudo rm -rf /portainer/Files/AppData/Config/Dashy/local-conf.yml || error "Failed to remove the folder /portainer/Files/AppData/Config/Dashy/local-conf.yml!"
fi
sudo touch /portainer/Files/AppData/Config/Dashy/local-conf.yml || error "Failed to touch local-conf.yml file!"
echo "Setup complete. You can now install the Dashy using the App Template."
