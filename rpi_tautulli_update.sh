#!/bin/bash

cd ~
wget http://ftp.us.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.2-2_armhf.deb
sudo dpkg -i libseccomp2_2.5.2-2_armhf.deb
rm -f libseccomp2_2.5.2-2_armhf.deb
echo "Updating the libseccomp file is complete, you may now install Tautulli without issue."
