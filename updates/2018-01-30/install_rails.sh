gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

curl -sSL https://get.rvm.io | bash -s stable

source ~/.rvm/scripts/rvm

rvm --version
rvm list known
rvm install 2.4.0

# For Installing Qt and compiling capybara webkit (look up the travis.yml to check the correct version required for ruby 2.1.9 and rails 4.2.2, fablabs uses ruby 2.1.9 and rails 4.2.2 , default version was picked up as rails 5)
#sudo apt-get update
#sudo apt-get install qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x
