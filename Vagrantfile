#Vagrant.configure('2') do |config|
#    config.ssh.max_tries = 40
#    config.ssh.timeout   = 120
#    config.vm.box = 'precise64'
#    config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
#  end



vagrantfiles = %w[./configs/rancher.rb  ./configs/kubnodes.rb ./configs/ceph.rb ]


#vagrantfiles = Dir.glob("./configs/*")
#puts vagrantfiles

 vagrantfiles.each do |vagrantfile|
   puts "Loading " + vagrantfile
   load File.expand_path(vagrantfile) if File.exists?(vagrantfile)
 end
