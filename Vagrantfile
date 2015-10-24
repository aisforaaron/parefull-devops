# -*- mode: ruby -*-
# vi: set ft=ruby :

# Project Variables
project_name = "pfl-webapp"
ip_address   = "192.168.33.58"

if ENV['ENV'] == 'dev'
  hostname     = "parefull.aarond.com"
else
  hostname     = "local." + project_name
end

Vagrant.configure(2) do |config|

  config.vm.box = "hashicorp/precise64"
  config.vm.network "private_network", ip: ip_address

  #config.ssh.forward_agent = true

  config.vm.synced_folder "../parefull-heroku", "/home/vagrant/parefull-heroku", type: "nfs", mount_options: ['actimeo=1']

  config.vm.define project_name do |node|
    node.vm.hostname = hostname
    node.vm.network :private_network, ip: ip_address
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = "parefull"
    #vb.memory = "1024"
  end

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = 'v'
    ansible.playbook = "pfl-webapp.yml"
    ansible.extra_vars = {
      "hostname"  => hostname
    }
  end

end