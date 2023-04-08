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

echo "Libseccomp2 upgrade needed if you run rpi 32bit. Check version with 'dpkg-query -W libseccomp'. if the version is 2.3 or below, this script is necessary."
wget  http://ftp.us.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.4-1+b3_armhf.deb || error "Failed to download libseccomp2.deb"
sudo dpkg -i libseccomp2_2.5.4-1+b1_armhf.deb || error "Failed to install libseccomp2.deb"
rm -f libseccomp2_2.5.4-1+b1_armhf.deb
echo "Updating the libseccomp2 file is complete."
