ENV["LC_ALL"] = "en_US.UTF-8"

envList = ["STAG", "PROD"]
# env = "STAG"
# env = "PROD"

frontendAmt = 1
backendAmt = 2
dbAmt = 2

hostPort = 8080

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

                if id == dbAmt
                    db.vm.provision "ansible" do |ansible|
                        ansible.limit = "all"
                        ansible.playbook = "site.yml"
                        ansible.host_key_checking = false
                        ansible.groups = {
                            "#{env}:children" => ["#{env}_frontend", "#{env}_backend", "#{env}_db"],

                            "#{env}_frontend" => ["#{env}-frontend-[1:#{frontendAmt}]"],
                            "#{env}_backend" => ["#{env}-backend-[1:#{backendAmt}]"],
                            "#{env}_db" => ["#{env}-db-[1:#{dbAmt}]"]
                        }
                        # ansible.tags = "common, mysql, apache, php, nginx"
                        # ansible.tags = "mysql"
                    end
                end
            end
        end
    end
end