#!/usr/bin/env ruby

# Review:
#   - Docker Vargranfile: https://github.com/dotcloud/docker/blob/master/Vagrantfile
#   - Build custom Vagrant-image: https://github.com/fespinoza/checklist_and_guides/wiki/Creating-a-vagrant-base-box-for-ubuntu-12.04-32bit-server

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu-12.04-64'
  # config.vm.box_url = 'http://files.vagrantup.com/precise64.box'
  config.vm.box_url = 'https://oss-binaries.phusionpassenger.com/vagrant/boxes/ubuntu-12.04.3-amd64-vbox.box' # https://github.com/phusion/open-vagrant-boxes

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  #
  config.vm.network :private_network, ip: '192.168.100.100' # OS X Mavericks BUG: http://davidwalsh.name/fixing-vagrant-errors
  # config.vm.network :public_network

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  #
  config.vm.network :forwarded_port, guest: 80, host: 8081

  # Docker
  # (49000..49900).each do |port|
  #   config.vm.network :forwarded_port, guest: port, host: port
  # end

  # Sync project folder to the guest VM.
  # config.vm.synced_folder 'config', '/data/config', disabled: false, nfs: false # , owner: 'nobody', group: 'nobody'

  # SSH
  config.ssh.forward_agent = true
  # config.ssh.private_key_path = '~/.ssh/id_rsa'

  # vagrant plugin install vagrant-cachier
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.auto_detect = true
  end

  # VirtualBox
  config.vm.provider :virtualbox do |provider, override|
    # override.vm.provision :shell, path: 'script/vagrant-provision-guestadditions'

    # override.vm.provision :shell, path: 'script/vagrant-provision-raw'
    # override.vm.provision :shell, path: 'script/vagrant-provision-raw-openresty'

    # override.vm.provision :shell, path: 'script/vagrant-provision-docker-alt'
    override.vm.provision :shell, path: 'script/vagrant-provision-docker'
    override.vm.provision :shell, path: 'script/vagrant-provision-docker-openresty'

    provider.customize ['modifyvm', :id, '--cpus', 2]
    provider.customize ['modifyvm', :id, '--memory', 256]
    provider.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    provider.customize ['modifyvm', :id, '--natdnsproxy1', 'on']

    # vagrant plugin install vagrant-vbguest
    if Vagrant.has_plugin?('vagrant-vbguest')
      override.vbguest.auto_update = true
      override.vbguest.no_remote = false
    end
  end

  # Digital Ocean: https://github.com/smdahlen/vagrant-digitalocean
  # config.vm.provider :digital_ocean do |provider, override|
  #   override.vm.box = 'digitalocean'
  #   override.vm.box_url = 'https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box'
  #
  #   provider.image = 'Ubuntu 12.04 x64'
  #   provider.region = "Amsterdam 1"
  #   provider.ca_path = "conf/security/ssl/ca.crt"
  #
  #   provider.client_id = ENV['DIGITALOCEAN_CLIENT_ID']
  #   provider.api_key = ENV['DIGITALOCEAN_API_KEY']
  # end
end
