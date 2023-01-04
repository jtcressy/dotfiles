#!/bin/sh
#
# install.sh installs things.
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

SCRIPT_NAME=${1:-"install-tool.sh"}

if ! [ -x "$(command -v zsh)" ]
then
  echo "installing zsh"
  if [ "$(uname -s)" == "Darwin" ]
  then
    brew install zsh
  else
    sudo apt install -y zsh
  fi

else
  echo "zsh already installed"
  zsh --version
fi

# Install antigen for vundle-like package management for zsh
curl -L git.io/antigen > "$HOME/antigen.zsh"

ln -sfn ${SCRIPTPATH}/zsh/.zshrc ~
ln -sfn ${SCRIPTPATH}/zsh/.antigenrc ~
ln -sfn ${SCRIPTPATH}/zsh/.zsh-custom-functions ~
ln -sfn ${SCRIPTPATH}/zsh/.p10k.zsh ~
