# Install and setup instructions for the RPI Docker Monitor

## Introduction

A monitoring solution for Docker hosts and containers with [Prometheus](https://prometheus.io/), [Grafana](http://grafana.org/), [cAdvisor](https://github.com/google/cadvisor), [NodeExporter](https://github.com/prometheus/node_exporter).

## Screenshot

![screencapture-192-168-1-100-1013-d-Ss3q6hSZk-docker-and-os-metrics-2021-10-13-21_35_57](https://user-images.githubusercontent.com/18188407/137201307-a47cf9c3-fe8b-4792-8bd1-3fc02f89893b.png)


# Installation

## Pre-Installation Steps

First SSH into your Pi and there is one thing we need to do before we get cracking. We need to enable `c-groups` so the stack will work out of the box. To do this you need to modify the configuration file `cmdline.txt`:  This is stored in various locations depending on your OS.  Some OS like PI OS Bullseye and Diet PI are setup to use cgroup ver 2 these change break several of the monitors so we need to disable that as well.

### Pi OS & DietPI OS
```
sudo nano /boot/cmdline.txt
```

### Ubuntu OS
```
sudo nano /boot/firmware/cmdline.txt
```

### All c-group version 2 OS's Currently DietPI and PI OS Bullseye add the following options to the begin of the line:

```
systemd.unified_cgroup_hierarchy=0 cgroup_enable=memory cgroup_memory=1
```

### All c-group version 1 OS's add the following options to the begin of the line:

```
cgroup_enable=memory cgroup_memory=1
```

### Now save the file in your editor and reboot:

```
sudo reboot
```

### Confirm that c-groups are enabled

```
cat /proc/cgroups
```

You should see output something like this.

```
#subsys_name    hierarchy       num_cgroups     enabled
cpuset  9       15      1
cpu     7       69      1
cpuacct 7       69      1
blkio   8       69      1
memory  11      158     1
devices 3       69      1
freezer 5       16      1
net_cls 2       15      1
perf_event      6       15      1
net_prio        2       15      1
pids    4       76      1
rdma    10      1       1
```

The numbers aren't really important what is important is that you see memory in the list if you don't confirm you have put it in the correct file.  Don't go on until you get this working.

## Folder Setup Script

First thing we need to do is setup the folder structure and install some files that need to be in place for everything to work correctly.  

Run the following script
```
wget -qO- https://git.io/JPXba | sudo bash
```

Your output should look something like this

```
# wget -qO- https://git.io/JPXba | sudo bash
creating directories
downloading prometheus config files
--2021-10-17 00:56:28--  https://raw.githubusercontent.com/oijkn/Docker-Raspberry-PI-Monitoring/main/prometheus/prometheus.yml
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.110.133, 185.199.109.133, 185.199.111.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.110.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 163 [text/plain]
Saving to: ‘/portainer/Files/AppData/Config/prometheus/config/prometheus.yml’

/portainer/Files/AppData/Config/prometheus/config/promethe 100%[=======================================================================================================================================>]     163  --.-KB/s    in 0s

2021-10-17 00:56:28 (971 KB/s) - ‘/portainer/Files/AppData/Config/prometheus/config/prometheus.yml’ saved [163/163]

setting permissions
Done You are ready to goto next step in the install document
```

### This Step is now complete go to the next step.
<br><br>
## Install the App Template.<br>

![App Templates Lists](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-AppTemplatesList.png)

Goto App Templates and install "Raspberry Pi Docker Monitor"

You can change how long your data should be stored or leave the default **15d**. It can be set with {`ms`,`s`,`m`,`h`,`d`,`w`,`y`} or a combination of it (e.g. `2w3d` for 2 weeks and 3 days).

![Stack Settings](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-DeployStack.png)

The default settings should all be good so **Deploy the Stack**
<br><br>

## Setup Grafana

Navigate to Grafana `http://<host-ip>:3000` and login with user ***admin*** password ***admin***. You can change the credentials in the template file or by supplying the `ADMIN_USER` and `ADMIN_PASSWORD` environment variables inside the container monitoring-prometheus. 

```yaml
GF_SECURITY_ADMIN_USER=admin
GF_SECURITY_ADMIN_PASSWORD=changeme
GF_USERS_ALLOW_SIGN_UP=false
```

### Default Login Inforamtion

User: Admin <br>
Password: Admin

### Setup Prometheus as the default data source.
 
```
Grafana > Configuration > Data Sources > Prometheus
```
**It is important that you set the URL to http://monitoring-prometheus:9090/**<br><br>

![image](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-DataSource.png)

### Setup the Dashboard
Grafana is not preconfigured with dashboard, so you have to import it from the [Arm json](https://github.com/pi-hosted/pi-hosted/blob/master/configs/rpi_dashboard/arm_rpi_dashboard.json) or [PC(AMD) json](https://github.com/pi-hosted/pi-hosted/blob/master/configs/rpi_dashboard/amd_rpi_dashboard.json) file.

```
Grafana > + > Import 
```

![image](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-Dashboard-Menu-Import.png)

Now we open the [Arm json](https://github.com/pi-hosted/pi-hosted/blob/master/configs/rpi_dashboard/arm_rpi_dashboard.json) or [PC(AMD) json](https://github.com/pi-hosted/pi-hosted/blob/master/configs/rpi_dashboard/amd_rpi_dashboard.json) file and Click on the "raw" button to copy the content from the json file.

(!["raw" button](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-Raw.png))


 Once copied into the bigger of the 2 boxes Click Load.

![image](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-Dashboard-Import.png)


Now we can display the dashboard

```
Grafana > Dashboard > Manage
```
![image](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-Menu-Dashboard-Manage.png)

There should be just the one item list.  Select "Docker and OS Metrics" from the list and you should see the dashboard listed below.

![image](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-Dashboard-Manage.png)

![screencapture-192-168-1-100-1013-d-Ss3q6hSZk-docker-and-os-metrics-2021-10-13-21_35_57](https://user-images.githubusercontent.com/18188407/137201307-a47cf9c3-fe8b-4792-8bd1-3fc02f89893b.png)


> Hint: Well the Dashboard is displayed you can select your profile > Preferences and change the default Dashboard to the new Dashboard you just create and it will always display the new Dashboad when you login.

![image](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-Menu-User-Preferences.png)

![image](https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/docs/images/rpi_docker_monitor-Preferences-Dashboard.png)


## Pi Hosted : Raspberry Pi Docker Monitoring Part 7
[![Pi Hosted : Raspberry Pi Docker Monitoring Part 7](https://i.ytimg.com/vi/IoD3vFuep64/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE&rs=AOn4CLDBjV3a9aT7NV28n88mqqogOzLUww)](https://www.youtube.com/watch?v=IoD3vFuep64)

## Acknowledgment
* based on [Docker-Raspberry-PI-Monitoring](https://github.com/oijkn/Docker-Raspberry-PI-Monitoring) by Oijkn
