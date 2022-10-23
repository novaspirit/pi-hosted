#!/bin/bash

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

echo "Enabling spi and i2c communication"
sudo raspi-config nonint do_spi 0
sudo raspi-config nonint do_i2c 0
echo "Creating directory..."
sudo mkdir /portainer/Files/AppData/Config/pixel-server/
echo "Downloading config files and configuring partly"
sudo touch /portainer/Files/AppData/Config/pixel-server/users.cfg 
sudo sh -c "echo 'network_allow_auth = 0.0.0.0' > /portainer/Files/AppData/Config/pixel-server/auth.cfg"
sudo wget https://raw.githubusercontent.com/penguintutor/pixel-server/main/defaults.cfg -O /portainer/Files/AppData/Config/pixel-server/pixelserver.cfg
echo "Done You are ready to goto next step in the install document"