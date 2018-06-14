# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["LC_ALL"] = "en_US.UTF-8"

envList = ["STAG", "PROD"]

frontendAmt = 1
backendAmt = 2
dbAmt = 2

hostPort = 8080

ansible_groups = {}
envList.each do |env|
    ansible_groups["#{env}:children"] = ["#{env}_frontend", "#{env}_backend", "#{env}_db"]
    ansible_groups["#{env}_frontend"] = ["#{env}-frontend-[1:#{frontendAmt}]"]
    ansible_groups["#{env}_backend"] = ["#{env}-backend-[1:#{backendAmt}]"]
    ansible_groups["#{env}_db"] = ["#{env}-db-[1:#{dbAmt}]"]
end
# puts (ansible_groups)

Vagrant.configure(2) do |config|
    envList.each do |env|

        (1..frontendAmt).each do |id|
            config.vm.define "#{env}-frontend-#{id}" do |frontend|
                frontend.vm.box = "centos/7"
                frontend.vm.network "forwarded_port", guest: 80, host: "#{hostPort += 1}"
                frontend.vm.network "private_network", type: "dhcp"

                frontend.vm.provider "virtualbox" do |virtualbox|
                    virtualbox.name = "#{env}-frontend-#{id}"
                    # virtualbox.memory = 1024
                    # virtualbox.cpus = 2
                end

                frontend.vm.hostname = "#{env}-frontend-#{id}"
            end
        end

        (1..backendAmt).each do |id|
            config.vm.define "#{env}-backend-#{id}" do |backend|
                backend.vm.box = "centos/7"
                backend.vm.network "private_network", type: "dhcp"

                backend.vm.provider "virtualbox" do |virtualbox|
                    virtualbox.name = "#{env}-backend-#{id}"
                    # virtualbox.memory = 1024
                    # virtualbox.cpus = 2
                end

                backend.vm.hostname = "#{env}-backend-#{id}"
            end
        end

        (1..dbAmt).each do |id|
            config.vm.define "#{env}-db-#{id}" do |db|
                db.vm.box = "centos/7"
                db.vm.network "private_network", type: "dhcp"

                db.vm.provider "virtualbox" do |virtualbox|
                    virtualbox.name = "#{env}-db-#{id}"
                    # virtualbox.memory = 1024
                    # virtualbox.cpus = 2
                end

                db.vm.hostname = "#{env}-db-#{id}"
            end
        end
    end

    config.vm.define "workaround" do |workaround|
        workaround.vm.box = "hashicorp/precise64"
        workaround.vm.provider "virtualbox" do |virtualbox|
            virtualbox.name = "workaround"
        end
        workaround.vm.provision "ansible" do |ansible|
            ansible.limit = "all:!workaround"
            ansible.playbook = "site.yml"
            ansible.host_key_checking = false
            ansible.verbose = false
            ansible.groups = ansible_groups
            # ansible.tags = "common, mysql, apache, php, nginx"
            # ansible.tags = "nginx"
        end
    end
    
end