# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "hashicorp/bionic64"
    config.vm.box_version = "1.0.282"

    config.vm.synced_folder "./www", "/var/www/html",
        id: "core",
        :nfs => true,
        :mount_options => ['nolock,vers=3,udp,noatime,actimeo=2']

    #config.vm.synced_folder "./www", "/var/www/html",
    #    id: "vagrant-root",
    #    owner: "vagrant",
    #    group: "www-data",
    #    mount_options: ["dmode=775,fmode=775"]

    config.vm.network "private_network", ip: "192.168.11.2"

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", 2048]
        #vb.customize ["modifyvm", :id, "--cpus", 4]

        vb.customize ["modifyvm", :id, "--uartmode1", "disconnected"]
    end

    config.vm.provision :shell, :path => "bootstrap.sh"
end
