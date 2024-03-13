#!/bin/sh

set -eux

sudo apt-get update
sudo apt-get install -y curl
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

#minikube start
