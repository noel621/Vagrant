# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

networktype = 'public_network'
vmswitch = 'LAN'

nodes = [
  { :hostname => 'rabbit1', :ip => '192.168.40.41', :box => 'generic/centos7', :ram => '512', :vcpus => '1' },
  { :hostname => 'rabbit2', :ip => '192.168.40.42', :box => 'generic/centos7', :ram => '512', :vcpus => '1' },
  { :hostname => 'rabbit3', :ip => '192.168.40.43', :box => 'generic/centos7', :ram => '512', :vcpus => '1' }
]

puts nodes


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
      nodeconfig.vm.network networktype, bridge: vmswitch, ip: node[:ip]

      # b.vm.synced_folder "../data", "/vagrant_data"

      nodeconfig.vm.provider "hyperv" do |h|
        h.enable_virtualization_extensions = false
        h.linked_clone = true
        h.vmname = node[:hostname]
        h.cpus = node[:vcpus] 
        h.memory = node[:ram]
      end
      #
      # View the documentation for the provider you are using for more
      # information on available options.

      # Enable provisioning with a shell script. Additional provisioners such as
      # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
      # documentation for more information about their specific syntax and use.
      # b.vm.provision "shell", inline: <<-SHELL
      #   apt-get update
      #   apt-get install -y apache2
      # SHELL
    end
  end
end

