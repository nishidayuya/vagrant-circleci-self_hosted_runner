#!/bin/sh

set -eux

if test -z "$CIRCLECI_TOKEN" = ""
then
  echo 'need $CIRCLECI_TOKEN'
  exit 1
fi

helm repo add container-agent https://packagecloud.io/circleci/container-agent/helm
helm repo update

if ! kubectl get namespace circleci > /dev/null 2> /dev/null
then
  kubectl create namespace circleci
fi

# TODO: mktemp
f=/tmp/values.yml
cat <<EOF > $f
agent:
  resourceClasses:
    namespace/my-rc:
      token: $CIRCLECI_TOKEN
EOF
helm install container-agent container-agent/container-agent -n circleci -f $f
rm -fv $f
