# Install and setup instructions for the RPI Unifi Monitor

## Introduction

A monitoring solution for the Unifi Controller with [Grafana](http://grafana.org/), [UnPoller](https://unpoller.com/).

## Screenshot

![USG-UnPoller](https://user-images.githubusercontent.com/42878642/139702071-c481522b-96ad-425e-bdb1-493df7ec735e.PNG)
![UAP-unpoller](https://user-images.githubusercontent.com/42878642/139702089-bb165f84-81c3-4a5f-8aed-282de5ad5bbb.PNG)


# Installation

## Pre-Installation Steps

First SSH into your Pi or use Shell in a Box to get to the command line.  ensure you have pulled the latest from https://github.com/pi-hosted/pi-hosted/ and run unpoller.sh

## Folder Setup Script

First thing we need to do is setup the folder structure and install some files that need to be in place for everything to work correctly.  

Run the following script
```
sudo sh ./tools/unpoller-install.sh
```

Your output should look something like this

```
# sudo ./tools/unpoller-install.sh
creating directories
downloading unpoller config files
--2021-10-17 00:56:28--  https://raw.githubusercontent.com/pi-hosted/pi-hosted/tree/master/pi-hosted_template/configs/unpoller-up.conf
Resolving raw.githubusercontent.com (raw.githubusercontent.com)... 185.199.110.133, 185.199.109.133, 185.199.111.133, ...
Connecting to raw.githubusercontent.com (raw.githubusercontent.com)|185.199.110.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 163 [text/plain]
Saving to: ‘/portainer/Files/AppData/Config/unpoller/up.conf’

/portainer/Files/AppData/Config/unpoller/up.conf 100%[=======================================================================================================================================>]     163  --.-KB/s    in 0s

2021-10-17 00:56:28 (971 KB/s) - ‘/portainer/Files/AppData/Config/unpoller/up.conf’ saved [163/163]

Done You are ready to goto next step in the install document
```

### This Step is now complete go to the next step.
<br><br>
## Install the App Template.<br>

Goto App Templates and install "UnPoller Monitor"

The default settings should all be good so **Deploy the Stack**
<br><br>

## Setup Grafana

Assuming you have already installed the pi monitoring suite we will need to install 2 new plugins for grafana to display the new dashboards correctly.  Navigate to your monitoring-grafana container and click >_Console.
![console](https://user-images.githubusercontent.com/42878642/139703380-7e9804eb-6215-4294-a3c8-62907b5caf34.PNG)

Click connect on this next page
![connect](https://user-images.githubusercontent.com/42878642/139703514-e5665d58-f78b-4c96-adc0-f264a82df678.PNG)

Then type in:
```
grafana-cli plugins install grafana-clock-panel
```
&
```
grafana-cli plugins install grafana-piechart-panel
```

After each line make sure to hit enter and your output should look something like the following:
![plugin-install](https://user-images.githubusercontent.com/42878642/139704132-e14d2607-705b-4c76-9238-9aa638a32120.PNG)

Following this just restart the monitoring-grafana container and the plugins will be ready to use.

### Setup InfluxDB as a data source.
 
```
Grafana > Configuration > Data Sources > Add data source
```
**It is important that you set the URL to http://<Server-IP>:8086/**<br><br>

![datasource](https://user-images.githubusercontent.com/42878642/139704631-aee34f6b-606f-443a-8dff-88c2fb342295.PNG)

### Setup the Dashboard
Grafana is not preconfigured with dashboard, so you have to import it from the Grafana dashboard repo.

```
Grafana > + > Import 
```

Use the table found at [UnPollers](https://unpoller.com/docs/install/grafana) website for the dashboard you need for your hardware.


Type in the number for the appropriate dashboard in the "Import via grafana.com" box and click load
![load dashboard](https://user-images.githubusercontent.com/42878642/139705535-dc2a679e-8f55-4ed1-b993-933519802f97.PNG)

Once loaded ensure you select the InfluxDB datasource at the bottom and click import
![import](https://user-images.githubusercontent.com/42878642/139705998-9f9963c2-552e-42af-84e0-2d54cc053645.PNG)

Now we can display the dashboard

```
Grafana > Dashboard > Manage
```
The dashboard should now be accessible from the dashboards menu where the Raspberry Pi monitoring dashboard is located.

## Acknowledgment
* based on [Docker-Raspberry-PI-Monitoring](https://github.com/oijkn/Docker-Raspberry-PI-Monitoring) by Oijkn
