#!/bin/sh
#
# install.sh installs things.
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

SCRIPT_NAME=${1:-"install.sh"}

# Send all our -x output to this file for later debugging
LOG_DIR="$HOME/.install.sh.logs"
mkdir -p "${LOG_DIR}"
exec 1>"${LOG_DIR}/stdout"
exec 2>"${LOG_DIR}/stderr"

set -x

echo "${SCRIPT_NAME} start: $(date)"

export DOTFILES_ROOT=$SCRIPTPATH

set -e

echo ''

# find the installers and run them iteratively
echo "👟 Running installers 👟"
for installer in $(find $SCRIPTPATH -name "*install-tool.sh"); do
  sh -c "${installer}"
done

if $CODESPACES
then
  echo "Running Codespaces post start"
  sh $SCRIPTPATH/codespaces-post-start
fi

echo ''
echo '🏁 All installed! 🏁'
