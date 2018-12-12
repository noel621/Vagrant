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
