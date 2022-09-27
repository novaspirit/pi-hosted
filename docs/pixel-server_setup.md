# Run the preInstallScript

Before deploying go to [Post Installation](#post-installation) section and run the preInstallScript for the pixel-server container.

Or you can run these commands (just do this once!)

```bash
echo "Enabling spi and i2c communication"
sudo raspi-config nonint do_spi 0
sudo raspi-config nonint do_i2c 0
echo "Creating directory..."
sudo mkdir /portainer/Files/AppData/Config/pixel-server/
echo "Downloading config files and configuring partly"
sudo touch /portainer/Files/AppData/Config/pixel-server/users.cfg 
sudo sh -c "echo 'network_allow_auth = 0.0.0.0' > /portainer/Files/AppData/Config/pixel-server/auth.cfg"
sudo wget https://raw.githubusercontent.com/penguintutor/pixel-server/main/defaults.cfg -O /portainer/Files/AppData/Config/pixel-server/pixelserver.cfg
echo "Done You are ready to goto next step in the install document"
```

Now you can deploy the pixel-server container, but do return back to this document to configure a user so you can login into the dashboard on port 85.

To configure a user run the following in your terminal:

```bash
docker exec -it pixel-server sh -c 'python3 createadmin.py <username> <password> >> users.cfg'
docker restart pixel-server
```

Replace `<username>` and `<password>` with the account you wish to use. You can now login into the container using the IP of the host on port 85.

## Configuring

While you're technically set, you do need to configure the pixel-server how to communicate with your RGB device. You can do this by clicking on the Settings button.

You should set:

- the Number of LEDS.
- GPIO Pin No (use <https://pinout.xyz/> you want to input the number next to GPIO on the right (not the left)).
- Brightness (default should be good, but take small steps when setting this value, requires restart of the container!).
- LED Strip (Very important that you choose the right type, otherwise you're RGB device will show the wrong colors).

## Automation

You can use cron inside the container aswell. You can enable Cheerlights by doing:

```bash
docker exec -it pixel-server crontab -e
```

And add: `*/5     *       *       *       *       wget -q -O /opt/pixel-server/customlight.cfg http://api.thingspeak.com/channels/1417/field/2/last.txt`

Save and exit out of the file and container.
