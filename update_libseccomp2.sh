#!/bin/bash
echo "Libseccomp2 upgrade needed if you run rpi 32bit. Check version dpkg-query -W libseccomp, if the version 2.3 or blow, please run this script."
cd ~
wget http://ftp.us.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.2-2_armhf.deb
sudo dpkg -i libseccomp2_2.5.2-2_armhf.deb
rm -f libseccomp2_2.5.2-2_armhf.deb
echo "Updating the libseccomp2 file is complete."
