# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

networktype = 'public_network'
#vmswitch = 'Bridged Adapter'
vmswitch = 'Default Switch'
basesubnet = '192.168.69.'
gateway = '1'
boxtype = 'centos/8'

nodes = [
  { :hostname => 'cadmin', :ip => basesubnet+'61', :box => boxtype, :ram => '2048', :vcpus => '2', :gw => basesubnet+gateway },
  { :hostname => 'cnode1', :ip => basesubnet+'62', :box => boxtype, :ram => '2048', :vcpus => '2', :gw => basesubnet+gateway },
  { :hostname => 'cnode2', :ip => basesubnet+'63', :box => boxtype, :ram => '2048', :vcpus => '2', :gw => basesubnet+gateway },
  { :hostname => 'cnode3', :ip => basesubnet+'64', :box => boxtype, :ram => '2048', :vcpus => '2', :gw => basesubnet+gateway }
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      # The most common configuration options are documented and commented below.
      # For a complete reference, please see the online documentation at
      # https://docs.vagrantup.com.

      # Every Vagrant development environment requires a box. You can search for
      # boxes at https://vagrantcloud.com/search.
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname]

      # b.vm.network "forwarded_port", guest: 80, host: 8080
      # b.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
      # b.vm.network "private_network", ip: "192.168.33.10"
      #b.vm.network "public_network", bridge: 'LAN'
      #nodeconfig.vm.network networktype, bridge: vmswitch, ip: node[:ip], dev: 'enp0s25'
      #nodeconfig.vm.network :public_network, bridge: 'br0', ip: node[:ip], dev: 'br0', gateway: '192.168.69.1'
      nodeconfig.vm.network :public_network, ip: node[:ip], dev: 'br0', gateway: node[:gw]
      # b.vm.synced_folder "../data", "/vagrant_data"

      #load File.expand_path('./configs/Vagrantfile.rancher')

      nodeconfig.vm.provider "hyperv" do |h|
        h.enable_virtualization_extensions = false
        h.linked_clone = true
        h.vmname = 'Vagrant-' + node[:hostname]
        h.cpus = node[:vcpus] 
        h.memory = node[:ram]
      end

      nodeconfig.vm.provider "virtualbox" do |v|
        v.gui = false
        v.linked_clone = true
        v.name = 'Vagrant-' + node[:hostname]
        v.cpus = node[:vcpus] 
        v.memory = node[:ram]
      end

      nodeconfig.vm.provider "libvirt" do |dom|
        dom.disk_bus = 'sata'
        dom.cpus = node[:vcpus] 
        dom.memory = node[:ram]
        dom.cpu_mode = 'custom'
        dom.cpu_model = 'kvm64'
      end


      #
      # View the documentation for the provider you are using for more
      # information on available options.

      # Enable provisioning with a shell script. Additional provisioners such as
      # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
      # documentation for more information about their specific syntax and use.
      if boxtype.include? "centos"
        nodeconfig.vm.provision "shell", inline: <<-SHELL
          yum -y update
        #   yum install -y yum-utils device-mapper-persistent-data lvm2
        #   yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        #   yum install -y docker-ce
        #   systemctl enable docker
        #   systemctl start docker
        SHELL

        #reboot
        nodeconfig.vm.provision :reload
      end

      # if boxtype.include? "ubuntu"
      #   nodeconfig.vm.provision "shell", inline: <<-SHELL
      #     rm -f /etc/resolv.conf
      #     echo nameserver 8.8.8.8 > /etc/resolv.conf
      #     echo nameserver 8.8.4.4 >> /etc/resolv.conf
      #     apt-get update
      #     apt-get  install apt-transport-https ca-certificates curl software-properties-common -y
      #     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
          
      #     add-apt-repository \
      #     "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      #     $(lsb_release -cs) \
      #     test"

      #     apt-get update
      #     apt-get install docker-ce -y

      #     systemctl enable docker
      #     #systemctl start docker
      #   SHELL

      #   #reboot
      #   nodeconfig.vm.provision :reload

      # end
    end
  end
end

