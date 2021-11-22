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

echo "Downloading throttled.sh script"
sudo wget -O /usr/local/bin/throttled.sh https://gist.githubusercontent.com/aallan/0b03f5dcc65756dde6045c6e96c26459/raw/c0e75e2599d8ed76f834d44bc3ce84e0f5f2f4bc/throttled.sh || error "Failed to download throttled.sh file!"
echo "Setting permissions..."
sudo chmod -R 755 /usr/local/bin/throttled.sh || error "Failed to set permissions for throttled.sh!"
echo "First Run of Throttled.sh..."
sudo /usr/local/bin/throttled.sh