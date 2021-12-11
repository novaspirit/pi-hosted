#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directories..."
sudo mkdir -p /portainer/Files/AppData/Config/PhotoPrism/storage || error "Failed to create storage and database directories!"
sudo mkdir -p /portainer/Files/AppData/Config/PhotoPrism/database || error "Failed to create storage and database directories!"
sudo mkdir -p /portainer/PhotoPrism || error "Failed to create storage and database directories!"

echo "Setting permissions..."
sudo chown -R 1000.1000 /portainer/Files/AppData/Config/PhotoPrism/storage || error "Failed to set permissions for PhotoPrism data!"
sudo chown -R 1000.1000 /portainer/Files/AppData/Config/PhotoPrism/database || error "Failed to set permissions for PhotoPrism data!"
sudo chown -R 1000.1000 /portainer/PhotoPrism || error "Failed to set permissions for PhotoPrism data!"

echo
echo -e "If you already have a folder for images, make sure the user \\e[32mpi\\e[m has access to it."
echo -e "If required, you can change permissions with:"
echo -e "   \\e[32msudo chown -R 1000.1000 /path/to/folder\\e[m"
echo -e "If not, create it now and give user \\e[32mpi\\e[m permission"
echo -e "When done you can continue to install PhotoPrism Stack"
