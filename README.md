
# Vagrant automated VM for Open Source Salad Experiments

This image is an Ubuntu Desktop 18.04 LTS plus:
  -  git
  -  autoupdate system

Context:
  -  Base image is *vagrant init bento/ubuntu-16.04*
  -  Image is optimized for Virtual Box, but not restricted to
  -  Make sure ssh and VBox are in path
  -  Default configuration for VM is 4G RAM, 4 core, bidirectional clipboard, active GUI

If you want to generate a new image based on this one:
  -  clone this repo
  -  vagrant plugin install vagrant-reload
  -  vagrant up
=======
