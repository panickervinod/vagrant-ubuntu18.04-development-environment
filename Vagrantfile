# -*- mode: ruby -*-
# vi: set ft=ruby :
#Vagrant.require_plugin "vagrant-reload"

# class VagrantPlugins::ProviderVirtualBox::Action::SetName
#   alias_method :original_call, :call
#   def call(env)
#     machine = env[:machine]
#     driver = machine.provider.driver
#     uuid = driver.instance_eval { @uuid }
#     ui = env[:ui]
#
#     # Find out folder of VM
#     vm_folder = ""
#     vm_info = driver.execute("showvminfo", uuid, "--machinereadable")
#     lines = vm_info.split("\n")
#     lines.each do |line|
#       if line.start_with?("CfgFile")
#         vm_folder = line.split("=")[1].gsub('"','')
#         vm_folder = File.expand_path("..", vm_folder)
#         ui.info "VM Folder is: #{vm_folder}"
#       end
#     end
#
#     size = 10240
#     disk_file = vm_folder + "/disk1.vmdk"
#
#     ui.info "Adding disk to VM"
#     if File.exist?(disk_file)
#       ui.info "Disk already exists"
#     else
#       ui.info "Creating new disk"
#       driver.execute("createmedium", "disk", "--filename", disk_file, "--size", "#{size}", "--format", "VMDK")
#       ui.info "Attaching disk to VM"
#       driver.execute('storageattach', uuid, '--storagectl', "SATA Controller", '--port', "1", '--type', 'hdd', '--medium', disk_file)
#     end
#
#     original_call(env)
#   end
# end

file_to_disk = File.realpath( "." ).to_s + "/disk.vdi"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "bento/ubuntu-18.04"
  config.vm.box = "ubuntu/bionic64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "4096"
  	# CPUs
  	vb.cpus = 4
  	# Clipboard
  	vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']
  	# Video configuration
  	vb.customize ["modifyvm", :id, "--vram", "64"]
  	vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    if ARGV[0] == "up" && ! File.exist?(file_to_disk)
      vb.customize [
           'createhd',
           '--filename', file_to_disk,
           '--format', 'VDI',
           '--size', 30 * 1024 # 30 GB
           ]
      vb.customize [
           'storageattach', :id,
           '--storagectl', 'SATAController', # The name may vary
           '--port', 1, '--device', 0,
           '--type', 'hdd', '--medium', file_to_disk
           ]
    end
  end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
	#proxy
	#echo 'Acquire::http::Proxy "http://192.168.1.19:3128";' >> /etc/apt/apt.conf
	#export http_proxy=http://192.168.1.19:3128


	#update repo info
  apt-get update

	#ensure non-interactive updates
	export DEBIAN_FRONTEND=noninteractive

	#update any package from the base distro
	apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade

	#make the distro a "desktop"
	apt-get install -y ubuntu-desktop
	apt-get install `check-language-support -l en`

  #TODO add other required packages here.
  apt-get install -y git unzip

	#HOME
	cd /home/vagrant

  #User configs
  #wget to solve cr/lf when host is not the linux
  #To prevent master.zip.1 getting created
  if [ -f master.zip ]; then
      rm master.zip
  fi
  wget --quiet https://github.com/panickervinod/vagrant-ubuntu18.04-development-environment/archive/master.zip
  unzip master
  cp -vr vagrant-ubuntu18.04-development-environment-master/config/* .
  cp -vr vagrant-ubuntu18.04-development-environment-master/config/.* .

  desktop-file-install vagrant-ubuntu18.04-development-environment-master/config/.gnome/apps/*


	chown -R vagrant.vagrant /home/vagrant
	rm -fR vagrant-ubuntu18.04-development-environment-master

	update-desktop-database

  SHELL

  #reboot
  config.vm.provision :reload

  #config.vm.provision "shell", inline: <<-SHELL
  #	#anything after the reload
  #	setxkbmap us
  #SHELL

end
