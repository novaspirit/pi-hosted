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
sudo mkdir -p /portainer/Files/AppData/Config/drupal/database || error "Failed to create database directory!"
sudo mkdir -p /portainer/Files/AppData/Config/drupal/modules || error "Failed to create modules directory!"
sudo mkdir -p /portainer/Files/AppData/Config/drupal/profiles || error "Failed to create profiles directory!"
sudo mkdir -p /portainer/Files/AppData/Config/drupal/themes || error "Failed to create themes directory!"
sudo mkdir -p /portainer/Files/AppData/Config/drupal/sites || error "Failed to create sites directory!"
sudo mkdir -p /portainer/Files/AppData/Config/drupal/sites/default || error "Failed to create sites/default directory!"
echo "Downloading Drupal config files"
sudo wget -O /portainer/Files/AppData/Config/drupal/sites/README.txt https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/drupal/README.txt || error "Failed to download README.txt file!"
sudo wget -O /portainer/Files/AppData/Config/drupal/sites/development.services.yml https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/drupal/development.services.yml || error "Failed to download development.services.yml file!"
sudo wget -O /portainer/Files/AppData/Config/drupal/sites/example.settings.local.php https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/drupal/example.settings.local.php || error "Failed to download example.settings.local.php file!"
sudo wget -O /portainer/Files/AppData/Config/drupal/sites/example.sites.php https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/drupal/example.sites.php || error "Failed to download example.sites.php file!"
sudo wget -O /portainer/Files/AppData/Config/drupal/sites/default/default.services.yml https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/drupal/default/default.services.yml || error "Failed to download default.services.yml file!"
sudo wget -O /portainer/Files/AppData/Config/drupal/sites/default/default.settings.php https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/configs/drupal/default/default.settings.php || error "Failed to download default.settings.php file!"
echo "Setting permissions..."
sudo chown -R 1000:1000 /portainer/Files/AppData/Config/drupal/database || error "Failed to set permissions for database data!"
sudo chown -R 33:33 /portainer/Files/AppData/Config/drupal/modules || error "Failed to set permissions for modules data!"
sudo chown -R 33:33 /portainer/Files/AppData/Config/drupal/profiles || error "Failed to set permissions for profiles data!"
sudo chown -R 33:33 /portainer/Files/AppData/Config/drupal/themes || error "Failed to set permissions for themes data!"
sudo chown -R 33:33 /portainer/Files/AppData/Config/drupal/sites || error "Failed to set permissions for sites data!"
echo "Done You are ready to install the Drupal Template"
