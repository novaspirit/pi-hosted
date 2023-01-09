#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directory"
sudo mkdir -p /portainer/Files/AppData/Config/TiddlyWiki/ || error "Failed to set create folder for TiddlyWiki volume!"

echo "Setting permissions"
sudo chown -R 1000:1000 /portainer/Files/AppData/Config/TiddlyWiki/ || error "Failed to set permissions for TiddlyWiki volume!"

echo "Done You are ready to goto install tiddlywiki!"
