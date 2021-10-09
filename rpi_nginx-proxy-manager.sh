#!/bin/sh
echo "creating directories"
sudo mkdir -p /portainer/Files/AppData/Config/nginx-proxy-manager/data
sudo mkdir -p /portainer/Files/AppData/Config/nginx-proxy-manager/letsencrypt
sudo mkdir -p /portainer/Files/AppData/Config/nginx-proxy-manager/database
echo "Creating a blank nginx-proxy-manager config files"
sudo touch /portainer/Files/AppData/Config/nginx-proxy-manager/config.json
echo "done you can now install the stack"
