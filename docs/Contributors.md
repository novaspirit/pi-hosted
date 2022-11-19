# How to contribute?

To contribute to the Pi-Hosted project, it all starts with having a Docker container or a Docker-Compose file.

## What this instruction won't explain

This instruction won't explain how to setup a Docker container, how to setup a Docker-Compose file or how to create a Docker container in the first place.

## What you need to start

Validate json and yaml (use vscode or another IDE or an online tool).

You also need to have a working instance of portainer on your host to test your work before making a pull request.

For a Docker Container you should have a command which setup's the container fully so it can be used. For example:

```bash
docker run --name some-nginx -p 8080:80 -v /some/content:/usr/share/nginx/html:ro -d nginx
```

Source: <https://hub.docker.com/_/nginx>

Or a Docker-Compose example if multiple containers need to interract with eachother like:

```bash
version: "3"
services:
  mariadb:
    hostname: mariadb
    image: linuxserver/mariadb:latest
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${DATABASE_NAME}
      MYSQL_USER: ${DATABASE_USER}
      MYSQL_PASSWORD: ${DATABASE_PASSWORD}
      PUID: ${PGID}
      PGID: ${PGID}
      TZ: ${TZ}
    networks:
      - drupal_network
    restart: unless-stopped
    volumes:
      - /portainer/Files/AppData/Config/drupal/database:/config
  phpmyadmin:
    image: phpmyadmin:latest
    environment:
      PMA_HOST: mariadb
      PMA_PORT: 3306
      PMA_ARBITRARY: 1
    ports:
      - 4081:80
    networks:
      - drupal_network
    restart: unless-stopped
      
  druapl:
    container_name: drupal
    hostname: drupal
    image: drupal:latest
    networks:
      - drupal_network
    ports:
      - 4080:80
    restart: unless-stopped
    volumes:
      - /portainer/Files/AppData/Config/drupal/modules:/var/www/html/modules
      - /portainer/Files/AppData/Config/drupal/profiles:/var/www/html/profiles
      - /portainer/Files/AppData/Config/drupal/themes:/var/www/html/themes
      - /portainer/Files/AppData/Config/drupal/sites:/var/www/html/sites
    depends_on:
      - mariadb

networks:
  drupal_network:
```

Source: <https://github.com/pi-hosted/pi-hosted/blob/master/stack/drupal.yml>

## How to contribute a single container to Pi-Hosted?

After you created a fork of the project, create a new branch from master to keep a clean branch on your fork.

Go into: `template/apps` and create a new json file named after the container/project you wish to contribute.

As example we'll use [dashy.json](https://github.com/pi-hosted/pi-hosted/blob/master/template/apps/dashy.json) as it's short but still has most of the parts you need.

A good practise if you seem to not get it configured right, is to look at other simalair containers that are contributed in the same folder. Or read the official documentation [here](https://docs.portainer.io/advanced/app-templates/format).

### What do i edit in the json file?

Before starting, always make sure GitHub Actions are activated on your fork! Go to Actions in your fork and make sure it's enabled.

You want to edit the Categories part to include some tags that identifies the container.

Edit the description to reflect what the container/project does. The official documentation normally has a description you can re-use.

The env part is important as this allows users to input variables or pre-fill them in.

default refers to what will be filled in already, remove this to make the input box empty.

label refers to what the variable will be named when the user fills in the box.

name refers to the actual name of the variable that will be used in the container.

The image_arch's refer should only be filled in if the registery you're pulling from offers it. Look into the tags section to see waht OS/ARCH are available.

linux/amd64     >   image_amd64
linux/arm/v7    >   image_arm32
linux/arm64     >   image_arm64

Next, get a logo to make it easy for the user to find the container they are looking for.

The name refers to what the name o the container will be. Do not use capatical letters.

officialDoc is adviced to include. The user can always refer to this if something has to be configured after deploying.

piHostedDoc is adviced if more steps are required (before or after deploying). To add specific documentation go into `docs`. The images subfolder can be used to be sure images are always accessable.

preInstallScript is meant if some configuration has to be done beforehand on the host. For example, some rootless containers need specific permissions set on the volume that's mounted on the host. Or create (empty) folders and files. to create a script go into `tools/` and create a .sh script. Test the script manually beforehand (the wget won't work as this is tied to the pi-hosted/pi-hosted repo).

Ports should always be written in the following format `9100:80/tcp`. Or it won't bind correctly.

The restart_policy should always be unless-stopped as this enables the container to start with the system and only stops when the user wants it to.

Title refers to the name displayed in the template list of portainer. Capatical letters is adviced.

The volume consists of two parts:
bind, refers to the file or folder on the host. This is optional if you don't wish to mount the volume to the host.
container, refers to the file or folder in the container.

Do note that all bind's start with: `/portainer/Files/AppData/Config/`. Always add a new subfolder (preferablly named to the container). Optionally followed by more subfolders or files.

Don't do:
`/portainer/Files/AppData/Config/`
but do:
`/portainer/Files/AppData/Config/pixel-server/`
or
`/portainer/Files/AppData/Config/pixel-server/configs/`

privileged should only be used when needed! This basically gives the container as much access to the host as possible and is considered bad practise. However it's required in certain usecases like the Pixel-Server.

webpage refers to the official webpage of the project, this should always be added to give proper credit.

After you saved the json file the automation will make the needed changes to the template jsons's. After it's completed you can test your changes by going to `template/`, open the right template file and click on Raw. Copy the url into the App Templates of your portainer instance.

Lookup your own container and see if it installs and works. After that you can submit a PR.

## How to contribute a stack to Pi-Hosted?

A stack is almost the same as making a container. When creating the json file in `template/apps/` don't use the images_arch's but use the following format to include the right yaml file (we'll create these later):

```json
 "repository": {
  "stackfile_arm32": "stack/drupal.yml",
  "stackfile_arm64": "stack/drupal.yml",
  "stackfile_amd64": "stack/drupal.yml",
  "url": "https://github.com/pi-hosted/pi-hosted/"
 },
```

Replace the url temporarly with the url of your fork (for testing, revert this after testing is succesfull).

### What do i edit in the yaml file?

In the `stack` folder, create a new yml file.

You can copy and paste the Docker-Compose into the yml file and make sure to use the correct volume path's on the host (portainer/Files/AppData/Config/). For the environement specify the env var name, followed by the variable that's going to be filled in by the .json file we created earlier.

So the env vars work like this:

`template/apps/drupal.json`

```json
"env": [
  {
   "default": "1000",
   "label": "PUID",
   "name": "PUID"
  }
```

Retrieves the input from the user

`stack/drupal.yml`

```yml
environment:
  CONTAINER_VAR_PUID: ${PUID}
```

From the drupal.json, the `${PUID}` is filled. The content of `${PUID}` will be retrieved with the name: `CONTAINER_VAR_PUID` in the container.

### Final words

If you  are stuck with making your changes, you can always join the Discord Server or create an issue. We're always happy to help!
