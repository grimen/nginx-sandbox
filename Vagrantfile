#!/usr/bin/env ruby

Vagrant.require_plugin 'vocker' # https://github.com/fgrehm/vocker

Vagrant.configure("2") do |config|
  config.vm.box = "base64"
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  #
  config.vm.network :private_network, ip: '192.168.100.100' # OS X Mavericks BUG: http://davidwalsh.name/fixing-vagrant-errors

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  #
  config.vm.network :forwarded_port, guest: 80, host: 8000

  # Sync project folder to the guest VM.
  config.vm.synced_folder 'config', '/data/config', disabled: false, nfs: false # , owner: 'nobody', group: 'nobody'

  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.auto_detect = true
  end

  config.vm.provider :virtualbox do |vb, override|
    vb.customize ['modifyvm', :id, '--memory', 256, '--cpus', 2]
  end

  # Install docker on the machine (powered by Vocker).
  config.vm.provision :docker

  # Install Vagrant.
  config.vm.provision :shell, inline: %[
    if $(which vagrant > /dev/null 2>/dev/null); then
      exit 0
    fi
    wget http://files.vagrantup.com/packages/a40522f5fabccb9ddabad03d836e120ff5d14093/vagrant_1.3.5_x86_64.deb -O /tmp/vagrant.deb
    dpkg -i /tmp/vagrant.deb
  ]

  # Install `docker-provider`.
  config.vm.provision :shell, privileged: false, inline: %[
    if $(vagrant plugin list | grep -q 'docker-provider'); then
      exit 0
    fi
    vagrant plugin install docker-provider
  ]
end