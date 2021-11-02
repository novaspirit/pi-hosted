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

portainer_pid=`docker ps | grep portainer/agent | awk '{print $1}'`
portainer_name=`docker ps | grep portainer/agent | awk '{print $2}'`

sudo docker stop $portainer_pid || error "Failed to stop portainer!"
sudo docker rm $portainer_pid || error "Failed to remove portainer container!"
sudo docker rmi $portainer_name || error "Failed to remove/untag images from the container!"
sudo docker run -d -p 9001:9001 --name portainer_agent --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest || error "Failed to execute newer version of Portainer Agent!"
