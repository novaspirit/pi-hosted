# Install and setup instructions for the throttled Sript

## Introduction

A simple script that displays a warning if voltage or temperature were throttling or had been trottled since last reboot.
## Screenshot
![Throttled Screenshoot](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/throttled-screenshoot.png)
# Installation

Installation is pretty straight forward run the script and it will install the script to /usr/local/bin/.

Run the following script
```
wget -qO- https://git.io/JXzw0 | bash
```

Your output should look something like this

```
# wget -qO- https://git.io/JXzw0 | bash
Checking if you are online...Online. Continuing.
Downloading throttled.sh script
--2021-11-09 00:28:48--  https://gist.githubusercontent.com/aallan/0b03f5dcc65756dde6045c6e96c26459/raw/c0e75e2599d8ed76f834d44bc3ce84e0f5f2f4bc/throttled.sh
Resolving gist.githubusercontent.com (gist.githubusercontent.com)... 185.199.111.133, 185.199.109.133, 185.199.108.133, ...
Connecting to gist.githubusercontent.com (gist.githubusercontent.com)|185.199.111.133|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1096 (1.1K) [text/plain]
Saving to: ‘/usr/local/bin/throttled.sh’

/usr/local/bin/throttled.sh                100%[========================================================================================>]   1.07K  --.-KB/s    in 0s

2021-11-09 00:28:48 (4.55 MB/s) - ‘/usr/local/bin/throttled.sh’ saved [1096/1096]

Setting permissions...
First Run of Throttled.sh...
Status: 0x0
Undervolted:
   Now: NO
   Run: NO
Throttled:
   Now: NO
   Run: NO
Frequency Capped:
   Now: NO
   Run: NO

```

# How to use

Check the current status.

```
sudo throttled.sh
```
![Throttled All Green Screenshoot](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/throttled-screenshoot.png)

# Errors

When you see an error that means something is up with the hardware and most likely needs some kind of adjustment.  If the error happens under Now: It means the state is set right now wereas Run: means the errors has happen sense last reboot.  

![Throttled Error Power Problems](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/throttled-red-power-problem.png)

1) Undervolted means you aren't providing enough power.  This can happen because you have a device like are hard drive that is pulling to much power or you have a power supply not producing enough power to run everything.
* If you are running something that is pulling too much power than you can use an active power hub to provide more power and get around the issue.
* If you have nothing plugged into the USB port and are still getting undervolted messages it likely means you power supply doesn't provide enough power and you need to replace it with a new one.

2) Throttled or Frequency Capped will likely happen because of tempture.  Make sure you have good airflow around the pi and a decent heat sync to pretect the CPU.










