#curl -sf -L https://static.rust-lang.org/rustup.sh | sudo bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update

# check if docker is installed and if apt-get install will install docker from the right repo
#apt-cache policy docker-ce

sudo apt-get install -y docker-ce
#check if docker is running
#sudo systemctl status docker
