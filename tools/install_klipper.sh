#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Creating directories..."
sudo mkdir -p /portainer/Files/AppData/Config/klipper/klipper/ || error "Failed to create data directory for klipper / klipper!"
sudo mkdir -p /portainer/Files/AppData/Config/klipper/klipper/logs || error "Failed to create data directory for klipper / klipper!"
sudo mkdir -p /portainer/Files/AppData/Config/klipper/moonraker/ || error "Failed to create data directory for klipper / moonraker!"
sudo mkdir -p /portainer/Files/AppData/Config/klipper/moonraker/logs || error "Failed to create data directory for klipper / moonraker!"
sudo mkdir -p /portainer/Files/AppData/Config/klipper/run/ || error "Failed to create data directory for klipper / run!"
sudo mkdir -p /portainer/Files/AppData/Config/klipper/gcodes/ || error "Failed to create data directory for klipper / gcodes!"

echo "Checking config file setup..."
if [ -d /portainer/Files/AppData/Config/klipper/klipper/printer.cfg ];
then
    echo "/portainer/Files/AppData/Config/klipper/klipper/printer.cfg is a directory removing"
    rm -rf '/portainer/Files/AppData/Config/klipper/klipper/printer.cfg'
fi
sudo touch /portainer/Files/AppData/Config/klipper/klipper/printer.cfg || error "Failed to touch printer.cfg file!"

if [ -d /portainer/Files/AppData/Config/klipper/moonraker/moonraker.conf ];
then
    echo "/portainer/Files/AppData/Config/klipper/moonraker/moonraker.conf is a directory removing"
    rm -rf '/portainer/Files/AppData/Config/klipper/moonraker/moonraker.conf'
fi
sudo touch /portainer/Files/AppData/Config/klipper/moonraker/moonraker.conf || error "Failed to touch moonraker.conf file!"

echo "Setting permissions..."
sudo chown -R 1000:1000  /portainer/Files/AppData/Config/klipper/ || error "Failed to set permissions for klipper data!"
echo "Done You are ready to goto next step."
