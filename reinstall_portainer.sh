#!/bin/bash

function error() {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

function warning() {
  echo -e "\\e[91m$1\\e[39m"
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

portainer_pid=`docker ps | grep portainer-ce | awk '{print $1}'`
portainer_name=`docker ps | grep portainer-ce | awk '{print $2}'`

echo Removing the old version of Portainer
sudo docker stop $portainer_pid || warning "Failed to stop portainer!"
sudo docker rm $portainer_pid || warning "Failed to remove portainer container!"
sudo docker rmi $portainer_name || warning "Failed to remove/untag images from the container!"

echo Pruning unused volume.  If asked answer yes.
sudo docker volume prune

echo now doing a fresh install of portainer
sudo docker run -d -p 9000:9000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest --logo "https://pi-hosted.com/pi-hosted-logo.png" || error "Failed to execute newer version of Portainer!"
