# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.provision "shell", inline: "echo Welcome to ELK stack VM find help under: "
  config.vm.provision :shell, :inline => "sudo apt-get update && sudo apt-get install puppet -y"    #fix augeas issue
 # config.vm.provision :shell, :inline => "mkdir /es-data"
   
  #vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/vagrant-root", "1"]
  #vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
	
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 80, host: 8888
  config.vm.network "forwarded_port", guest: 9200, host: 9200

  config.vm.network "private_network", ip: "10.0.0.111"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  #config.vm.synced_folder "etc/elasticsearch", "/etc/elasticsearch"

  # config.vm.synced_folder "./etc/elasticsearch", "/etc/elasticsearch", id: "elasticsearch_config", create: true,
   # owner: "elasticsearch",
   # group: "elasticsearch",
   # mount_options: ["dmode=775,fmode=664"]
   
  # config.vm.synced_folder "./etc/logstash", "/etc/logstash", id: "logstash_config", create: true,
   # owner: "root",
   # group: "root",
   # mount_options: ["dmode=775,fmode=664"]

   #config.vm.synced_folder "./es-index", "/vagrant/es-index", id: "elasticsearch_index", create: true,
   #owner: "elasticsearch",
   #group: "elasticsearch",
   #mount_options: ["dmode=775,fmode=664"]

   
  config.vm.provider "virtualbox" do |vb|
     # Don't boot with headless mode
  	#   vb.gui = true

     vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file default.pp in the manifests_path directory.


  config.vm.provision "puppet" do |puppet|
     puppet.manifests_path = "manifests"
     puppet.module_path = "modules"
#    puppet.manifest_file  = "site.pp"
  end

end
