ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure(2) do |config|

    frontendAmt = 1
    backendAmt = 1
    dbAmt = 2

    (1..frontendAmt).each do |id|
        config.vm.define "frontend#{id}" do |frontend|
            frontend.vm.box = "centos/7"
            # frontend.vm.network "forwarded_port", guest: 80, host: 1080
            # frontend.vm.network "forwarded_port", guest: 8080, host: 8080
            frontend.vm.network "private_network", type: "dhcp"

            frontend.vm.provider "virtualbox" do |virtualbox|
                virtualbox.name = "frontend#{id}"
                # virtualbox.memory = 1024
                # virtualbox.cpus = 2
            end

            frontend.vm.hostname = "frontend#{id}"
        end
    end

    (1..backendAmt).each do |id|
        config.vm.define "backend#{id}" do |backend|
            backend.vm.box = "centos/7"
            backend.vm.network "private_network", type: "dhcp"

            backend.vm.provider "virtualbox" do |virtualbox|
                virtualbox.name = "backend#{id}"
                # virtualbox.memory = 1024
                # virtualbox.cpus = 2
            end

            backend.vm.hostname = "backend#{id}"
        end
    end

    (1..dbAmt).each do |id|
        config.vm.define "db#{id}" do |db|
            db.vm.box = "centos/7"
            db.vm.network "private_network", type: "dhcp"

            db.vm.provider "virtualbox" do |virtualbox|
                virtualbox.name = "db#{id}"
                # virtualbox.memory = 1024
                # virtualbox.cpus = 2
            end

            db.vm.hostname = "db#{id}"
        end
    end

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "site.yml"
        ansible.host_key_checking = false
        ansible.groups = {
            "frontend" => ["frontend"],
            "backend" => ["backend"],
            "db" => ["db[1:#{dbAmt}]"]
        }
        # ansible.tags = "mysql, apache, php, nginx"
        # ansible.tags = "nginx-packages, nginx-service"
        # ansible.tags = "bootstrap-users"
    end

end