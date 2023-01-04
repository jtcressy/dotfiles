#!/bin/sh
#
# install.sh installs things.
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

SCRIPT_NAME=${1:-"install.sh"}

#TODO: install k9s agnostically

mkdir -p $HOME/.k9s

ln -sfn ${SCRIPTPATH}/k9s/config.yaml $HOME/.k9s/
ln -sfn ${SCRIPTPATH}/k9s/skin.yaml $HOME/.k9s/
