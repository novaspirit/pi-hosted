#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directories..."
sudo mkdir -p /portainer/Files/AppData/Config/nginx-proxy-manager/data || error "Failed to create data folder!"
sudo mkdir -p /portainer/Files/AppData/Config/nginx-proxy-manager/letsencrypt || error "Failed to create letsencrypt folder!"
sudo mkdir -p /portainer/Files/AppData/Config/nginx-proxy-manager/database || error "Failed to create database folder!"
echo "Creating a blank nginx-proxy-manager config files"
sudo touch /portainer/Files/AppData/Config/nginx-proxy-manager/config.json || error "Failed to touch config.json file!"
echo "Setup complete. You can now install the stack using the App Template."

