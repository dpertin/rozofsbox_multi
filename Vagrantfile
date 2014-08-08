# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  
  config.vm.box = "denaitre/rozofsbox"


  ### Mojette Projection Storage Server VMs 
  
  (1..3).each do |i|
    config.vm.define "mpss#{i}" do |mpss|
        mpss.vm.hostname = "mpss#{i}"
        mpss.vm.network :private_network, ip: "192.168.100.1#{i}"
        mpss.vm.provision "shell", inline: "rozo agent start"
    end
  end


  ### Meta Data Server VM

  config.vm.define "mds" do |mds|
    mds.vm.hostname = "mds"
    mds.vm.network :private_network, ip: "192.168.100.10"
    mds.vm.provision "shell", inline: "rozo agent start"
    mds.vm.provision "shell", inline: "rozo volume expand 192.168.100.10 192.168.100.11 192.168.100.12 192.168.100.13 -E 192.168.100.10"
    mds.vm.provision "shell", inline: "sleep 10"
    mds.vm.provision "shell", inline: "rozo node start -r exportd -n 192.168.100.10 -E 192.168.100.10"
    mds.vm.provision "shell", inline: "sleep 5"
    mds.vm.provision "shell", inline: "rozo export create -E 192.168.100.10 1"
    mds.vm.provision "shell", inline: "sleep 5"
    mds.vm.provision "shell", inline: "rozo export mount -E 192.168.100.10"
  end

end
