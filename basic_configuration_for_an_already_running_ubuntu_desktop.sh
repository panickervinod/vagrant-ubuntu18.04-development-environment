#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

apt-get update

#ensure non-interactive updates
export DEBIAN_FRONTEND=noninteractive

#update any package from the base distro
apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

#TODO add other required packages
apt-get install -y git unzip

#HOME
cd /home/vagrant

#User configs
#To prevent master.zip.1 getting created
if [ -f master.zip ]; then
    rm master.zip
fi
#wget to solve cr/lf when host is not the linux
wget --quiet https://github.com/panickervinod/vagrant-ubuntu18.04-development-environment/archive/master.zip
unzip master
cp -vr vagrant-ubuntu18.04-development-environment-master/config/* .
cp -vr vagrant-ubuntu18.04-development-environment-master/config/.* .

desktop-file-install vagrant-ubuntu18.04-development-environment-master/config/.gnome/apps/*

chown -R vagrant.vagrant /home/vagrant
rm -fR vagrant-ubuntu18.04-development-environment-master

update-desktop-database
