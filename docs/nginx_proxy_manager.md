# Install and setup instructions for Nginx Proxy Manager (NPM)

## Introduction

Nginx Proxy Manager (NPM) is an easy way to accomplish reverse proxying hosts with SSL termination and as the author puts it "It has to be so easy that a monkey could do it". 

## Screenshot

![NPM Screenshot](https://nginxproxymanager.com/screenshots/proxy-hosts.png)

# Installation

## Pre-Installation Steps

### Folder Setup Script

First thing we need to do is setup the folder structure and install some files that need to be in place for everything to work correctly.  

Run the following script
```
sudo ./nginx-proxy-manager.sh
```

Your output should look something like this

```
# sudo ./nginx-proxy-manager.sh
Creating directories...
Creating a blank nginx-proxy-manager config files
Setup complete. You can now install the stack using the App Template.
```

<br><br>
## Install the App Template.<br>

![App Template](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/rpi_docker_monitor-AppTemplatesList.png)

Goto App Templates and install "Proxy Nginx Manager"

![App Template](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-AppTemplates-Deploy.png)

You need to enter in both a Database Password and Mysql Root Password.  These will be needed if you ever have to access the database but not needed in the day to day operations of the system.

> If you fail to enter password for both the Database Password and Mysql Root Password your install will fail and you will get an error Bad Gateway which means that NPM can't talk to your mysql server.

This should all be good now so **Deploy the Stack**

**This will take several minutes to Deploy.**
<br><br>

## Stack Info
When Complete we should see a list of all our deployed stacks sample list below.<br>
![Stack List](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Stack-List.png)

We want to select nginx-proxy-manager from the list.  This will display lots of information regarding your stack but the section we are looking for is labelled Containers

![Stack Container Details](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Stack-Details.png)

You will notice 3 ports listed.  Port 80, 443, and port 81.  Ports 80 and 443 are for managing your services and really shouldn't be changed.  Port 81 is for managing your lists of hosts.  It can be changed but for the reminder of this install we are going to assume it to be port 81.

> It is important before you go to the next step that you get you public IP forward though your firewall for port 80 and 443 to your NPM install.  You also need to have your DNS pointing at the IP address.  There are many ways to do this and outside the scope of this install document.  If you are not sure where to start feel free to login to the Discord chat and ask someone will help point you at different options for your setup.

## Post Install Setup

### Login to the site<br>

Now that it is installed lets setup our first proxy host.  First thing we need to do is login to the site.  Click on port 81 in the list and you will see the login screen below.

![Login](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Login.png)

The Default Email Address is: admin@example.com
The Default Password is: changeme

Please login and we will then change those to our own settings.

> If you get a Bad Gateway error you likely forgot to run the script on the host to setup the folders / files first although it can also happen if you leave one of the database password blank as well.  Delete the Stack and start back from the beginning.

![First Login](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-First-Login.png)

### Update Your Email address and Password

First we need to select the User menu and select Edit Details

![User Menu](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-User-Menu.png)

Fix your user information and save the changes.


![User Menu](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-User-Edit-Details.png)

Now it is time to change your password.  Select the User menu again and select Change Password <br>
![User Menu](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-User-Menu.png)

Set the password to something you like and save the changes.

![User Menu](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-User-Change-Password.png)

## Update Default Screen

When going to the proxy with a new domain or in some cases where you used *wildcard DNS and someone goes using a DNS you don't haven't setup yet they will see the default screen.  By default this is the Congratulations Screen as shown below.  It is useful for confirming you are setup correctly but in production I prefer a 404 page or a custom page of some kind so we will go though how to set that up.

* Wildcard DNS can have security issues make sure you reach these before using them.

![Congratulations Screen](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Congratulations-Screen.png)

We start by going to the Settings Tab

![Settings Screen](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Menu-Settings.png)

Click on the 3 dots and select Edit from the list.

![3 Dots Screen](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Menu-Settings-Edit.png)

You will now be shown the different options you can select for your default screen.  You can have it display a 404 page, a Custom Page, or do simply redirect depending on your preference.  This is entirely up to you.  I prefer to use a 404 screen so I am going to set that now.

![Setting Edit Screen](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Menu-Settings-Edit-Screen.png)

There we are with the default being a 404 page.

![Settings Screen with 404](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Menu-Settings-404-selected.png)

So now when someone goes to a site that isn't setup yet they will see a 404 page.

![404 Page](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-404-page.png)

Great Nginx Proxy Manager is now all setup.  In the next sections we are going to walk though setting up your first proxy host.

## First Proxy Host Setup

We are now back to the first login screen.
![First Login](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-First-Login.png)

### Select Hosts > Proxy Hosts

![Proxy Hosts](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Proxy-Host.png)

Select Add Proxy Hosts

![Proxy Hosts](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-Menu-Add-Proxy-Host.png)

We need to enter the proxy information.  In this example we are going to use the following information.

Secure External connections to the service using https.<br>
Domain Name: homer.example.com<br>
Scheme: http<br>
Forward Hostname/IP address: 192.168.1.23<br>
Port: 8902<br>
Cache Assets: Disabled<br>
Block Common Exploits: Disabled<br>
Websockets Support: Disabled<br>
Accesss List: Publicly Accessible<br>

> Most of these options should be self explanatory if you aren't sure what they do it is likely best to leave them disabled.

The most import options.<br>  
Domain Name is the public Domain name that will point at your host.<br>
Forward Hostname/IP is the server running the resource.<br>
Port is the port the service is running on that server.<br>

Two options you might want to enable are Cache Assets and Block Common Exploits they will help protect and reduce the load on your sites but they can cause problems for some sites so be aware of this before enabling.

Some applications will use Websockets if the app uses this you will need to enable it but very few applications do so.  To put it simply if you don't know what it is, than leave it disabled.


![Proxy Hosts](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-New-Proxy-Host.png)

> Hint: Generating Certificates can be complicated I will be outlining one of the simplest ways to generate one.  There are other ways not outlined here.

Now we need to setup our secure https connection to the server.  Select the SSL tab.  Under SSL Certificates we are going to select Request a new SSL Certificate

I am also going to select Force SSL this will prevent non-secure connections from being used.  

I will agree to the terms after reading them you should at least review them once so you understand the terms of service.

It should have your correct email address listed if it doesn't please fix as this is where you will get alerts if there is an issue with the Certificate.

![Proxy Hosts](https://raw.githubusercontent.com/novaspirit/pi-hosted/master/docs/images/nginx-proxy-manager-New-Proxy-Host-SSL.png)

Once you click Save it will generate a new certificate this can take a few minutes to do.

Assuming there are no errors your new host has been created and you will be returned to the proxy host screen.  Below is an example of what the screen will look like with several hosts added.

![NPM Screenshot](https://nginxproxymanager.com/screenshots/proxy-hosts.png)



## Pi Hosted : Nginx Proxy Manager Part TBD
TBD

# Additional documentation

Additional documentation can be found at https://nginxproxymanager.com/guide/ .
