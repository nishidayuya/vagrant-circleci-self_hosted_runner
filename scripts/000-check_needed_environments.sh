#!/bin/sh

set -e

if test -z "$CIRCLECI_TOKEN"
then
  echo '$CIRCLECI_TOKEN is needed' 1>&2
  exit 1
fi
