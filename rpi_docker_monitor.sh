#!/bin/sh
echo "creating directories"
sudo mkdir -p /portainer/Files/AppData/Config/prometheus/config
sudo mkdir -p /portainer/Files/AppData/Config/prometheus/data
sudo mkdir -p /portainer/Files/AppData/Config/grafana/data
echo "downloading prometheus config files"
sudo wget -O /portainer/Files/AppData/Config/prometheus/config/prometheus.yml https://raw.githubusercontent.com/oijkn/Docker-Raspberry-PI-Monitoring/main/prometheus/prometheus.yml
sudo touch /portainer/Files/AppData/Config/grafana/grafana.ini
echo "setting permissions"
sudo chown -R 472:472 /portainer/Files/AppData/Config/grafana/data
echo "done"