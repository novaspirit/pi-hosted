# Pi-Hosted Portainer Template V2

[![Discord](https://img.shields.io/discord/316245914987528193?logo=discord)](https://discord.com/invite/v8dAnFV) [![Youtube](https://img.shields.io/badge/YouTube-FF0000?style=flat-square&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCrjKdwxaQMSV_NDywgKXVmw) [![Twitter URL](https://img.shields.io/twitter/follow/novaspirittech?style=flat-square&logo=twitter)](https://twitter.com/novaspirittech) [![hacktoberfest](https://img.shields.io/badge/hacktoberfest-friendly-orange)](https://hacktoberfest.digitalocean.com)

This repository is a collection of tutorials for hosting a variety of server applications using Docker and [Portainer](https://github.com/portainer/portainer).

### App Template for Portainer
![alt text](https://github.com/novaspirit/pi-hosted/blob/master/apptemplate.png?raw=true)

### Installation
Run `install-docker.sh`, to install docker, and add the user pi to the docker usergroup.
```
wget -qO- https://git.io/JwUkc | bash
# need to reboot/logout for changes to take effect
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
| Application  | URL |
| ------------- | ------------- |
| Portainer v2 | https://raw.githubusercontent.com/novaspirit/pi-hosted/master/pi-hosted_template/template/portainer-v2.json |

### Pi-Hosted YouTube series

[![Pi-Hosted Playlist](https://i.ytimg.com/vi/cO2-gQ09Jj0/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLAfgdX8HlHas2CddSmgwJzergnTzQ)](https://www.youtube.com/watch?v=cO2-gQ09Jj0&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc)

### Contributors

See the list of [contributors](https://github.com/novaspirit/pi-hosted/graphs/contributors) who participated in this project.

### Acknowledgment
* based template on [SelfHosted](https://github.com/SelfhostedPro/selfhosted_templates) Portainer App Template

