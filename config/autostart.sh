#!/bin/bash

setxkbmap us

if [ $DISPLAY == ":0" ] ; then
	#run only in X session
	vibase=$HOME/vagrant-image-update

	#check update structure
	if [ ! -d "$vibase" ] ; then
		mkdir "$vibase"
	fi

	#download updates repos
	if [ ! -d "$vibase/vagrant-ubuntu18.04-development-environment" ] ; then
		cd $vibase
		git clone https://github.com/panickervinod/vagrant-ubuntu18.04-development-environment.git
	else
		repo="$vibase/vagrant-ubuntu18.04-development-environment"
		if [ $(stat -c %Y $repo) -lt $(date +%s --date="120 min ago") ] ; then
			echo update repo, more than 120 mins
			cd $repo
			git pull
			touch $repo
		fi
	fi

	if [ -f "$vibase/vagrant-ubuntu18.04-development-environment/imageupdate.sh" ] ; then
		bash $vibase/vagrant-ubuntu18.04-development-environment/imageupdate.sh
	fi

	#download local updates repos
	#if [ ! -d "$vibase/localrepo" ] ; then
	#	cd $vibase
	#	git clone localrepo
	#else
	#	repo="$vibase/localrepo"
	#	if [ $(stat -c %Y $repo) -lt $(date +%s --date="15 min ago") ] ; then
	#		echo update repo, more than 15 minute
	#		cd $repo
	#		git pull
	#		touch $repo
	#	fi 	fi
	#
	#if [ -f "$vibase/vagrant-ubuntu18.04-development-environment/imageupdate.sh" ] ; then
	#	bash $vibase/vagrant-ubuntu18.04-development-environment/imageupdate.sh
	#fi

fi
