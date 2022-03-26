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

* Limited testing Operating Systems: Pi OS 64 Beta, DietPI 32 bit

### Pi-Hosted YouTube series

[![Pi-Hosted Playlist](https://i.ytimg.com/vi/cO2-gQ09Jj0/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLAfgdX8HlHas2CddSmgwJzergnTzQ)](https://www.youtube.com/watch?v=cO2-gQ09Jj0&list=PL846hFPMqg3jwkxcScD1xw2bKXrJVvarc)


|   | Episode                                                                                                                                                                       | Additional Information |
|---|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------|
<<<<< YOUTUBE TABLE HERE >>>>>

### Aditional Documentation

You can find more tutorials and useful information in our [GitHub Docs](DocumentList.md) folder.

### Included Scripts

Install, Update, Pre-Install and extra scripts can be found in our [GitHub Tools](../tools) folder.

### Contributors

See the list of [contributors](https://github.com/pi-hosted/pi-hosted/graphs/contributors) who participated in this project.

### Acknowledgment
* template based on [SelfHosted](https://github.com/SelfhostedPro/selfhosted_templates) Portainer App Template
