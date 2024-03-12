# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # https://packages.debian.org/search?keywords=openvpn&searchon=names&suite=all&section=all
  # https://packages.ubuntu.com/search?keywords=openvpn&searchon=names&suite=all&section=all
  config.vm.box = "debian/bookworm64" # 2023-06-10 Debian 12 openvpn-2.6.3-1+deb12u1
  # config.vm.box = "ubuntu/jammy64" # 2022-04-21 Ubuntu 22.04 openvpn-2.5.5-1ubuntu3.1
  # config.vm.box = "debian/bullseye64" # 2021-08-14 Debian 11 openvpn-2.5.1-3
  # config.vm.box = "ubuntu/focal64" # 2020-04-23 Ubuntu 20.04 openvpn-2.4.7-1ubuntu2.20.04.4
  # config.vm.box = "debian/buster64" # 2019-06-06 Debian 10 openvpn-2.4.7-1+deb10u1

  # config.vm.provider(:virtualbox) do |vb|
  #   vb.gui = true
  # end

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
end
