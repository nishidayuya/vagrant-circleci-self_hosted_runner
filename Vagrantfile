# -*- mode: ruby -*-
# vi: set ft=ruby :

require "etc"

n_cpus = ENV.fetch("VIRTUALBOX_CPUS", Etc.nprocessors).to_i
memory_mega_bytes = ENV.fetch("VIRTUALBOX_MEMORY", 1024 * 8).to_i

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"

  config.vm.provider(:virtualbox) do |vb|
    vb.cpus = n_cpus
    vb.memory = memory_mega_bytes
  end

  config.vm.provision(:shell, privileged: false, inline: <<~SHELL)
    set -eu
    if ps $$ | grep -q bash
    then
      set -o pipefail
    fi

    export CIRCLECI_TOKEN='#{ENV.fetch("CIRCLECI_TOKEN")}'

    for f in $(ls /vagrant/scripts/*.sh)
    do
      test -x $f || continue
      echo start: $f
      $f
      echo end: $f
    done
  SHELL
end
