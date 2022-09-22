# Pi-Hosted Portainer Template V2

[![Discord](https://img.shields.io/discord/316245914987528193?logo=discord)](https://discord.com/invite/v8dAnFV) [![Youtube](https://img.shields.io/badge/YouTube-FF0000?style=flat-square&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw) [![Twitter URL](https://img.shields.io/twitter/follow/novaspirittech?style=flat-square&logo=twitter)](https://twitter.com/novaspirittech)

This repository is a collection of tutorials for hosting a variety of server applications using [Docker](https://www.docker.com/) and [Portainer](https://github.com/portainer/portainer).

### App Template for Portainer
![alt text](https://github.com/pi-hosted/pi-hosted/blob/master/apptemplate.png?raw=true)

### Apps List

See the list of apps included in this template [here](AppList.md).

### Installation
Run `install-docker.sh`, to install docker, and add the current user to the docker usergroup.

```
wget -qO- https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/install_docker.sh | bash
```
You need to reboot/logout for changes to take effect

### Pi OS Buster  
On Oct 30, 2021 Pi OS bullseye was released and this is no longer needed.  Older Pi OS buster releases run an old version of libseccomp that is causing problems with many containers that are preventing them from running.  To fix this we need to manually install a newer version of libseccomp.  However we first need to check and see if you are running an older version.  To check please run sudo dpkg-query -W libseccomp.

```
sudo dpkg-query -W libseccomp2
```

If you are running a version less that 2.5 you will need to run the *upgrade script*.
```
wget -qO- https://raw.githubusercontent.com/novaspirit/pi-hosted/master/tools/update_libseccomp2.sh | bash
```

* The upgrade script is for Pi OS 32bit.  Pi OS 64 beta is untested and the upgrade script wont work with it.

### Reboot for changes to take effect

```
sudo reboot
```

After a reboot, run `install-portainer.sh`, to install Portainer.io

```
wget -qO- https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/install_portainer.sh | bash
# to update portainer, run this command instead
wget -qO- https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/update_portainer.sh | bash
```

### Login to Portainer to update the App Template.

Goto pi-ip:9000 and than login

Click Settings, in the bottom-left corner, and paste the Portainer v2 json file link from below into the "App Templates" box.

You're done! Now just click App Templates and deploy applications!

#### Portainer Architecture

| Architecture | Tested OS's | URL |
| ------------ | ----------- | --- |
| Arm32 | Pi OS, DietPi | https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-arm32.json |
| Arm64 | Pi OS, Ubuntu, DietPi | https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-arm64.json |
| Amd64 | Ubuntu, Debian | https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-amd64.json |

* Amd64 should work on all distros with **scripts written for Debian based distros**

### Pi-Hosted YouTube series

[![Pi-Hosted Playlist](https://i.ytimg.com/vi/cO2-gQ09Jj0/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLAfgdX8HlHas2CddSmgwJzergnTzQ)](https://www.youtube.com/watch?v=cO2-gQ09Jj0&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc)


|     | Channel | Episode | Additional Information |
|:---:|:-------:|---------|------------------------|
|N.01|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Raspberry Pi 4 Server Setup, Docker Install, Portainer Install, Shell In A Box](https://www.youtube.com/watch?v=cO2-gQ09Jj0&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=1)||
|N.02|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Installing and Configuring Homer Dashboard](https://www.youtube.com/watch?v=_d3J88ootYo&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=2)||
|N.03|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Manually Installing Guacamole on Portainer](https://www.youtube.com/watch?v=cKAhnf8X1lo&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=3)||
|N.04|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Installing JDownloader and File Browser On The Pi Docker Server](https://www.youtube.com/watch?v=30MYRgCObu8&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=4)||
|N.05|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Torrent with Docker and OPENVPN with Transmission and PIA](https://www.youtube.com/watch?v=tGLVEq913_4&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=5)||
|N.Extra1|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Portainer.io App Template for Raspberry Pi arm/arm64 I Need Your Help!](https://www.youtube.com/watch?v=Zn-VELlaIN4&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=6)||
|N.06|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Upgrading Portainer and Updating Containers](https://www.youtube.com/watch?v=q3wKqk8qVS8&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=7)||
|N.07|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Raspberry Pi Docker Monitoring](https://www.youtube.com/watch?v=IoD3vFuep64&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=8)|[Install Doc](../docs/rpi_docker_monitor.md)|
|N.08|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Installing Nextcloud on Raspberry Pi Docker](https://www.youtube.com/watch?v=E6IrT3g5Gqc&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=9)||
|N.09|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Installing Nginx Proxy Manager on Docker](https://www.youtube.com/watch?v=yl2Laxbqvo8&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=10)|[Install Doc](../docs/nginx_proxy_manager.md)|
|N.10|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Setting up Raspberry Pi Samba Server For File Sharing on Docker](https://www.youtube.com/watch?v=2zZ3_1GRWrM&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=11)||
|N.11|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[How to Install Whoogle to replace using Google and repo notes](https://www.youtube.com/watch?v=j3ZGxo3ibUs&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=12)||
|N.12|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Checking out Windows 2000 Docker](https://www.youtube.com/watch?v=57Gnp0424Qc&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=13)||
|N.Extra2|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[3 Huge Announcements!! Discord Giveaway! Pi-Hosted!! & SBC Garage Sale!](https://www.youtube.com/watch?v=Ppv1cUomwn0)||
|N.13|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Beginners Guide to WireGuard Docker and Installing Pi-OS 64bit](https://www.youtube.com/watch?v=yB_jAumIxOg)|[Install Doc](../docs/wireguard-install.md)|
|N.14|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[My Most used container! Snippet Box](https://www.youtube.com/watch?v=v-jUyB3fvAo)||
|N.15|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Rust Desk Open Source Remote Desktop](https://www.youtube.com/watch?v=PDnqFnnbVHg)||
|N.16|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Route Docker Traffic Through VPN Container](https://www.youtube.com/watch?v=IWj1-j2QWvo)||
|N.17|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Building NAS with Container](https://www.youtube.com/watch?v=9ln6UFH4z8o)||
|N.18|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Reviewing Stats on 25+ containers on my Raspberry Pi](https://www.youtube.com/watch?v=_tVj0FX5wYg)||
|N.Extra3|[![Novaspirit Tech](../build/images/novaspirit-logo.png "Novaspirit Tech")](https://youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw)|[Biggest Update to Pi-Hosted Portainer.io Template!](https://www.youtube.com/watch?v=7R7l6c3wswQ)||

### Aditional Documentation

You can find more tutorials and useful information in our [GitHub Docs](DocumentList.md) folder.

### Included Scripts

Install, Update, Pre-Install and extra scripts can be found in our [GitHub Tools](../tools) folder.

### Contributors

See the list of [contributors](https://github.com/pi-hosted/pi-hosted/graphs/contributors) who participated in this project.

### Acknowledgment

* template based on [SelfHosted](https://github.com/SelfhostedPro/selfhosted_templates) Portainer App Template branch on 2021/10/05
