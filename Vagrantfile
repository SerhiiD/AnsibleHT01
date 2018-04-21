# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
    config.vm.box = "centos/7"
    config.vm.network "forwarded_port", guest: 80, host: 80
    config.vm.network "forwarded_port", guest: 8080, host: 8080
    # config.vm.network "private_network", type: "dhcp"
    config.vm.provider "virtualbox" do |virtualbox|
        virtualbox.name = "lamp01"
    end
    config.vm.hostname = "lamp01"

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "lamp.yml"
    end
end