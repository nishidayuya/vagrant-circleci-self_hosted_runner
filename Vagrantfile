# -*- mode: ruby -*-
# vi: set ft=ruby :

require "etc"

n_cpus = ENV.fetch("VIRTUALBOX_CPUS", Etc.nprocessors).to_i
memory_mega_bytes = ENV.fetch("VIRTUALBOX_MEMORY", 1024).to_i

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.provider(:virtualbox) do |vb|
    vb.cpus = n_cpus
    vb.memory = memory_mega_bytes
  end

=begin
  config.vm.provision(:shell, privileged: false, inline: <<~SHELL)
    set -eux
    if ps $$ | grep -q bash
    then
      set -o pipefail
    fi

    os=$(lsb_release -si | tr '[:upper:]' '[:lower:]')-$(lsb_release -sr)
    sudo apt-get update --allow-releaseinfo-change
    sudo apt-get install -y \
      ca-certificates \
      openvpn \
      rsync
    sudo rsync -avH --chown root:root --exclude='*.for_*' /vagrant/data/ /
    find /vagrant/data -name "*.for_$os" -print0 |
      xargs -n1 -0 sh -c '
        sudo install -v -o root $0 $(echo $0 | sed -e "s|^/vagrant/data/|/|" -e "s/\.for_.*//")
      '
    sudo update-ca-certificates
    sudo systemctl restart openvpn@raichu.service
    if test -x /vagrant/run_after_provision
    then
      /vagrant/run_after_provision
    fi
  SHELL
=end
end
