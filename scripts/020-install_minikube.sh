#!/bin/sh

set -eux

# Debian package installation on
# https://minikube.sigs.k8s.io/docs/start/#what-youll-need
sudo apt-get update
sudo apt-get install -y curl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb
rm minikube_latest_amd64.deb

minikube start
#minikube dashboard

# https://minikube.sigs.k8s.io/docs/handbook/kubectl/
sudo ln -sfv $(which minikube) /usr/local/bin/kubectl

# show current status
kubectl get po -A
kubectl get nodes

# https://github.com/helm/helm/releases
work_path=$(mktemp -d)
cd $work_path
wget https://get.helm.sh/helm-v3.14.3-linux-amd64.tar.gz
tar xf helm-v3.14.3-linux-amd64.tar.gz
sudo install -v -m 755 linux-amd64/helm /usr/local/bin/
rm -rf $work_path
cd
