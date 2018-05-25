#!/bin/bash

#### Sample update_script #####
#SCRIPT=`realpath $0`
#SCRIPTPATH=`dirname $SCRIPT`

#sudo bash $SCRIPTPATH/some_script.sh

#####

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

sudo bash $SCRIPTPATH/install_node.sh
sudo bash $SCRIPTPATH/install_rust.sh

exit $?
