#!/bin/sh

set -eux

# TODO: APT化https://helm.sh/ja/docs/intro/install/#apt-%E3%81%8B%E3%82%89-debianubuntu
# https://github.com/helm/helm/releases
work_path=$(mktemp -d)
cd $work_path
wget https://get.helm.sh/helm-v3.14.3-linux-amd64.tar.gz
tar xf helm-v3.14.3-linux-amd64.tar.gz
sudo install -v -m 755 linux-amd64/helm /usr/local/bin/
cd
rm -rf $work_path
