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
wget -qO- https://git.io/JS96e | bash
# need to reboot/logout for changes to take effect
```

### Pi OS Buster  
On Oct 30, 2021 Pi OS bullseye was released and this is no longer needed.  Older Pi OS buster releases run an old version of libseccomp that is causing problems with many containers that are preventing them from running.  To fix this we need to manually install a newer version of libseccomp.  However we first need to check and see if you are running an older version.  To check please run sudo dpkg-query -W libseccomp.
```
sudo dpkg-query -W libseccomp2
```
If you are running a version less that 2.5 you will need to run the *upgrade script.

```
wget -qO- https://git.io/JPXdj | bash
```
* The upgrade script is for Pi OS 32bit.  Pi OS 64 beta is untested and the upgrade script wont work with it.

### Reboot for changes to take effect

```
sudo reboot
```

After a reboot, run `install-portainer.sh`, to install Portainer.io
```
wget -qO- https://git.io/JS96L | bash
# to update portainer, run this command
wget -qO- https://git.io/JS96Y | bash
```
Click Settings, in the bottom-left corner, and paste the Portainer v2 json file link from below into the "App Templates" box.

You're done! Now just click App Templates and deploy applications!

#### Versions
| Application  | Supported OS's | URL |
| ------------- | ------------- | ------------- |
| Portainer v2 Arm32 | Pi OS | https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-arm32.json |
| Portainer v2 Arm64 | Ubuntu 64, DietPI 64 | https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-arm64.json |
| Portainer v2 Amd64 | Ubuntu, Debian | https://raw.githubusercontent.com/pi-hosted/pi-hosted/master/template/portainer-v2-amd64.json |

* Limited testing Operating Systems: Pi OS 64 Beta, DietPI 32 bit
* Amd64 should work on all distros with **scripts written for Debian based distros**

### Pi-Hosted YouTube series

[![Pi-Hosted Playlist](https://i.ytimg.com/vi/cO2-gQ09Jj0/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLAfgdX8HlHas2CddSmgwJzergnTzQ)](https://www.youtube.com/watch?v=cO2-gQ09Jj0&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc)


|   | Episode                                                                                                                                                                       | Additional Information |
|---|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------|
|1|[Raspberry Pi 4 Server Setup, Docker Install, Portainer Install, Shell In A Box](https://www.youtube.com/watch?v=cO2-gQ09Jj0&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=1)||
|2|[Installing and Configuring Homer Dashboard](https://www.youtube.com/watch?v=_d3J88ootYo&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=2)||
|3|[Manually Installing Guacamole on Portainer](https://www.youtube.com/watch?v=cKAhnf8X1lo&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=3)||
|4|[Installing JDownloader and File Browser On The Pi Docker Server](https://www.youtube.com/watch?v=30MYRgCObu8&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=4)||
|5|[Torrent with Docker and OPENVPN with Transmission and PIA](https://www.youtube.com/watch?v=tGLVEq913_4&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=5)||
|Extra1|[Portainer.io App Template for Raspberry Pi arm/arm64 I Need Your Help!](https://www.youtube.com/watch?v=Zn-VELlaIN4&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=6)||
|6|[Upgrading Portainer and Updating Containers](https://www.youtube.com/watch?v=q3wKqk8qVS8&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=7)||
|7|[Raspberry Pi Docker Monitoring](https://www.youtube.com/watch?v=IoD3vFuep64&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=8)|[Install Doc](../docs/rpi_docker_monitor.md)|
|8|[Installing Nextcloud on Raspberry Pi Docker](https://www.youtube.com/watch?v=E6IrT3g5Gqc&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=9)||
|9|[Installing Nginx Proxy Manager on Docker](https://www.youtube.com/watch?v=yl2Laxbqvo8&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=10)|[Install Doc](../docs/nginx_proxy_manager.md)|
|10|[Setting up Raspberry Pi Samba Server For File Sharing on Docker](https://www.youtube.com/watch?v=2zZ3_1GRWrM&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=11)||
|11|[How to Install Whoogle to replace using Google and repo notes](https://www.youtube.com/watch?v=j3ZGxo3ibUs&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=12)||
|12|[Checking out Windows 2000 Docker](https://www.youtube.com/watch?v=57Gnp0424Qc&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc&index=13)||
|Extra2|[3 Huge Announcements!! Discord Giveaway! Pi-Hosted!! & SBC Garage Sale!](https://www.youtube.com/watch?v=Ppv1cUomwn0)||
|13|[Beginners Guide to WireGuard Docker and Installing Pi-OS 64bit](https://www.youtube.com/watch?v=yB_jAumIxOg)|[Install Doc](../docs/wireguard-install.md)|
|14|[My Most used container! Snippet Box](https://www.youtube.com/watch?v=v-jUyB3fvAo)||
|15|[Rust Desk Open Source Remote Desktop](https://www.youtube.com/watch?v=PDnqFnnbVHg)||
|16|[Route Docker Traffic Through VPN Container](https://www.youtube.com/watch?v=IWj1-j2QWvo)||
|17|[Building NAS with Container](https://www.youtube.com/watch?v=9ln6UFH4z8o)||
|18|[Reviewing Stats on 25+ containers on my Raspberry Pi](https://www.youtube.com/watch?v=_tVj0FX5wYg)||
|Extra3|[Biggest Update to Pi-Hosted Portainer.io Template!](https://www.youtube.com/watch?v=7R7l6c3wswQ)||

### Aditional Documentation

You can find more tutorials and useful information in our [GitHub Docs](DocumentList.md) folder.

### Included Scripts

Install, Update, Pre-Install and extra scripts can be found in our [GitHub Tools](../tools) folder.

### Contributors

See the list of [contributors](https://github.com/pi-hosted/pi-hosted/graphs/contributors) who participated in this project.

### Acknowledgment
* template based on [SelfHosted](https://github.com/SelfhostedPro/selfhosted_templates) Portainer App Template branch on 2021/10/05
