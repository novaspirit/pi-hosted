# Pi-Hosted Portainer Template V2

[![Discord](https://img.shields.io/discord/316245914987528193?logo=discord)](https://discord.com/invite/v8dAnFV) [![Youtube](https://img.shields.io/badge/YouTube-FF0000?style=flat-square&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw) [![Twitter URL](https://img.shields.io/twitter/follow/novaspirittech?style=flat-square&logo=twitter)](https://twitter.com/novaspirittech) [![hacktoberfest](https://img.shields.io/badge/hacktoberfest-friendly-orange)](https://hacktoberfest.digitalocean.com)

This repository is a collection of tutorials for hosting a variety of server applications using Docker and [Portainer](https://github.com/portainer/portainer).

### App Template for Portainer
![alt text](https://github.com/novaspirit/pi-hosted/blob/master/apptemplate.png?raw=true)

### Installation
Run `install-docker.sh`, to install docker, and add the current user to the docker usergroup.
```
wget -qO- https://git.io/JwUkc | bash
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
wget -qO- https://git.io/JwUnf | bash
# to update portainer, run this command
wget -qO- https://git.io/JwUlY | bash
```
Click Settings, in the bottom-left corner, and paste the Portainer v2 json file link from below into the "App Templates" box.

You're done! Now just click App Templates and deploy applications!

#### Versions
| Application  | Supported OS's | URL |
| ------------- | ------------- | ------------- |
| Portainer v2 Arm32 | Pi OS | https://raw.githubusercontent.com/novaspirit/pi-hosted/master/template/portainer-v2-arm32.json |
| Portainer v2 Arm64 | Ubunutu 64, DietPI 64 | https://raw.githubusercontent.com/novaspirit/pi-hosted/master/template/portainer-v2-arm64.json |

* Limited testing Operating Systems: Pi OS 64 Beta, DietPI 32 bit

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

=======

| Additional Documentation |
|------------------------|
|[Install and setup instructions for the RPI Unifi (UnPoller) Monitor](../docs/UnPoller-Monitor.md)|
|[Install and setup instructions for Nginx Proxy Manager (NPM)](../docs/nginx_proxy_manager.md)|
|[Install and setup instructions for the RPI Docker Monitor](../docs/rpi_docker_monitor.md)|
|[Install and setup instructions for the WireGuard VPN Server](../docs/wireguard-install.md)|
|[WORDPRESS + SSL SETUP](../docs/wordpress_installation.md)|
|[Install and Setup Instructions for the Throttled Script](../docs/throttled.md)|
|[Install and Setup Pi-Hole for Network-Wide Ad Block](../docs/pi-hole.md)|
|[Attach a container directly to local network (macvlan)](../docs/macvlan_setup.md)|

=======

| Additional Tools | Description | wget install |
|----------------|--------------|--------------|
|[install_caddy.sh](../tools/install_caddy.sh)|Preinstall Setup for Caddy|wget -qO- https://git.io/JMsEe \| bash|
|[install_drupal.sh](../tools/install_drupal.sh)|Preinstall Setup for Drupal|wget -qO- https://git.io/JMsEj \| bash|
|[install_portainer_agent.sh](../tools/install_portainer_agent.sh)|Install Portainer Agent<br>Portainer agent is used for remote management of the host you install it on.||
|[update_portainer_agent.sh](../tools/update_portainer_agent.sh)|Upgrade Portainer Agent||
|[install_throttled.sh](../tools/install_throttled.sh)|Preinstall Setup for the Throttled Script<br>[Installation Document](../docs/throttled.md)|wget -qO- https://git.io/JXzw0 \| bash|
|[install_vikunja.sh](../tools/install_vikunja.sh)|Preinstall Setup for Vikunja|wget -qO- https://git.io/JMsuZ \| bash|
|[nginx-proxy-manager.sh](../tools/nginx-proxy-manager.sh)|Preinstall Setup for NPM<br>[Installation Document](../docs/nginx_proxy_manager.md)|wget -qO- https://git.io/JPXF5 \| bash|
|[reset_premissions_nextcloud.sh](../tools/reset_premissions_nextcloud.sh)|Basic Script to reset the premissions of NextcloudPi|wget -qO- https://git.io/JDklN \| bash|
|[rpi_docker_monitor.sh](../tools/rpi_docker_monitor.sh)|Preinstall Setup for Docker Monitor<br>[Installation Document](../docs/rpi_docker_monitor.md)|wget -qO- https://git.io/JPXba \| bash|
|[traefik.sh](../tools/traefik.sh)|Preinstall Setup for Traefik|wget -qO- https://git.io/JMsuA \| bash|
|[unpoller-install.sh](../tools/unpoller-install.sh)|Preinstall Setup for UnPoller<br>[Installation Document](../docs/UnPoller-Monitor.md)|wget -qO- https://git.io/JMszE \| bash|
|[install_photoprism.sh](../tools/install_photoprism.sh)|Install Photo Prism|wget -qO- https://git.io/JM5Tr \| bash|
|[update_libseccomp2.sh](../tools/update_libseccomp2.sh)|PI OS 32 libseccomp2 Repair utility|wget -qO- https://git.io/JPXdj \| bash|


### Contributors

See the list of [contributors](https://github.com/novaspirit/pi-hosted/graphs/contributors) who participated in this project.

### Acknowledgment
* template based on [SelfHosted](https://github.com/SelfhostedPro/selfhosted_templates) Portainer App Template
