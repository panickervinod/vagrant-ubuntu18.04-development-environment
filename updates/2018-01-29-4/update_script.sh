#!/bin/bash

#### Sample update_script #####
#SCRIPT=`realpath $0`
#SCRIPTPATH=`dirname $SCRIPT`

#sudo bash $SCRIPTPATH/some_script.sh

#####

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

sudo bash $SCRIPTPATH/install_atom.sh
cp $SCRIPTPATH/atom.desktop /home/vagrant/.config/apps
cp $SCRIPTPATH/atom.desktop /home/vagrant/.local/share/applications

sudo bash $SCRIPTPATH/install_pycharm.sh
cp $SCRIPTPATH/pycharm.desktop /home/vagrant/.config/apps
cp $SCRIPTPATH/pycharm.desktop /home/vagrant/.local/share/applications

exit $?
