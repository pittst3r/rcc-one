# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'hashicorp/precise32'
  config.vm.network 'forwarded_port', guest: 3000, host: 8080
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  config.vm.provision :shell, path: "vagrant/bootstrap.sh" do |s|
    s.path = 'vagrant/bootstrap.sh'
    s.args = "'#{`git config user.name`.chomp}' #{`git config user.email`.chomp}"
  end
end
