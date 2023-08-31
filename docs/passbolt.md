# Install and setup instructions for Passbolt

- [Introduction](#introduction)
- [Installation](#installation)
- [Setup first admin user](#setup-first-admin-user)
- [Setup Android Mobile App](#setup-android-mobile-app)
- [Acknowledgment / Troubleshoot](#acknowledgment--troubleshoot)


## Introduction

[Passbolt](https://www.passbolt.com) is an open source password manager with [MariaDB](https://mariadb.com) backend. 

## Installation

### Pre-Installation Steps

Create directorys:
```
sudo mkdir /portainer/Files/AppData/Config/passbolt && \
sudo mkdir /portainer/Files/AppData/Config/passbolt/certs
```

Generate a proper Self-signed certificate. Type in the code below and change it to your needs:
```
sudo openssl req -x509 \
    -newkey rsa:4096 \
    -days 120 \
    -subj "/C=LU/ST=Luxembourg/L=Esch-Sur-Alzette/O=Passbolt SA/OU=Passbolt IT Team/CN=passbolt.domain.tld/" \
    -nodes \
    -addext "subjectAltName = DNS:passbolt.domain.tld" \
    -keyout /portainer/Files/AppData/Config/passbolt/certs/key.pem \
    -out /portainer/Files/AppData/Config/passbolt/certs/cert.pem
```

This command will output two files: **key.pem** and **cert.pem**.

Of course, replace -subj values with your own. It is important to set your passbolt FQDN in both CN and subjectAltName.

You can use an IP address instead of a domain name for your self-signed certificate. If you do that, replace DNS with IP in subjectAltName. `Example: IP:127.0.0.1`

### Install the App Template.

Goto App Templates and click on "Passbolt". Change Configuration to your needs:
- **PUID** (Enter your user's PUID here)
- **PGID** (Enter your user's PGID here)
- **TZ** (Enter your time zone here. See examples [here](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones))
- **MYSQL_ROOT_PASSWORD** (Enter your MySql root password here)
- **MYSQL_DATABASE** (Enter your Passbolt database name here)
- **MYSQL_USER** (Enter your Passbolt database user here)
- **MYSQL_PASSWORD** (Enter your Passbolt database password here)
- **PASSBOLT_PORT** (Enter your Passbolt https port here)
- **PASSBOLT_URL** (Enter your full Passbolt https base URL here. Including port if different from 443)
- **EMAIL_FROM_NAME** (Enter your from email name)
- **EMAIL_FROM_ADDRESS** (Enter your from email address)
- **EMAIL_SMTP_SERVER** (Enter your email smtp server here)
- **EMAIL_SMTP_PORT** (Enter your email smtp port here)
- **EMAIL_USERNAME** (Enter your email username here)
- **EMAIL_PASSWORD** (Enter your email password here)
- **EMAIL_TLS** (Enter set TLS here)

## Setup first admin user

Go into Passbolt container console. Type in the code below and change it to your needs:
```
su -s /bin/bash -c "./bin/cake \
    passbolt register_user \
    -u youremail@mail.net \
    -f yourfirstname \
    -l yourlastname \
    -r admin" www-data
```
After that you get something like this:
```
     ____                  __          ____  
    / __ \____  _____ ____/ /_  ____  / / /_ 
   / /_/ / __ `/ ___/ ___/ __ \/ __ \/ / __/ 
  / ____/ /_/ (__  |__  ) /_/ / /_/ / / /    
 /_/    \__,_/____/____/_.___/\____/_/\__/   

 Open source password manager for teams
-------------------------------------------------------------------------------
User saved successfully.
To start registration follow the link provided in your mailbox or here: 
https://passbolt.local/setup/start/9fb7180d-b44b-41bf-bf77-8c5ab23e8cbc/966ce549-18ec-4b12-9171-9a1bb2f1a393
```
Now you should get an email. Open it and click on `get starded`.

If you do not get an email:
- Double check configuration above
- Have a look into your spam folder
- Copy the url above and paste it in browser

You may have to accept self signed certificate and/or install Passbolt browser add-on.

Proceed with `Welcome to Passbolt, please select a passphrase!`.

## Setup Android Mobile App

### Import certificate on mobile application
[How to import SSL certificate on mobile application](https://help.passbolt.com/faq/hosting/how-to-import-ssl-certificate-on-mobile)

### Transfer your account key
In your desktop browser go to log in to Passbolt, navigate to `your user > Mobile Transfer` and follow the steps.


## Acknowledgment / Troubleshoot
- Help: [Docker passbolt installation](https://help.passbolt.com/hosting/install/ce/docker)
- Help: [iOS / Android Mobile FAQ](https://help.passbolt.com/faq/hosting/mobile-faq)
- Help: [How to import SSL certificate on mobile application](https://help.passbolt.com/faq/hosting/how-to-import-ssl-certificate-on-mobile)
- Help: [Troubleshoot SSL](https://help.passbolt.com/faq/hosting/troubleshoot-ssl)
- GitHub: [https://github.com/passbolt/passbolt_docker](https://github.com/passbolt/passbolt_docker)
