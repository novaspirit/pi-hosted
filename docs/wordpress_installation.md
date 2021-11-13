# WORDPRESS + SSL SETUP

### WORDPRESS STACK

Remember to choose a port for http not used for another service and a username and password for the mysql server used by wordpress

![Stack_Install](https://github.com/AlbertoHugonin/pi-hosted/blob/9615953a281011cc9369ae7fd62f40ead9f62908/docs/images/WordPress_Portainer_Stack_Installation.PNG)

### Nginx Proxy Manager

[Novaspirit Tech - Nginx Proxy Manager Installation](https://www.youtube.com/watch?v=yl2Laxbqvo8)

We now have to add a host to redirect all the traffic to the correct port

![App Template](https://github.com/AlbertoHugonin/pi-hosted/blob/9615953a281011cc9369ae7fd62f40ead9f62908/docs/images/WordPress_New_Proxy_Host.PNG)

Now you should be able with www.your_domain_here to access your site from the outside (if you have port 80 and 443 open)

### HOW TO ENABLE SSL 

To use the site as a shop you should enable SSL by using Let's Encrypt in the Nginx dashboard

![App Template](https://github.com/AlbertoHugonin/pi-hosted/blob/9615953a281011cc9369ae7fd62f40ead9f62908/docs/images/WordPress_Adding_SSL_Certificate.PNG)

Remember to add the certificate to the proxy host
![App Template](https://github.com/AlbertoHugonin/pi-hosted/blob/9615953a281011cc9369ae7fd62f40ead9f62908/docs/images/WordPress_Enable_SSL_Certificate.PNG)


### OFFLINE SETUP

Just proceed after you deploy the stack to access the site using the correct ip address and port combination
