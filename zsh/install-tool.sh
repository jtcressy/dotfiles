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

ln -sfn ${DOTFILES_ROOT}/zsh/.zshrc ~
ln -sfn ${DOTFILES_ROOT}/zsh/.antigenrc ~
ln -sfn ${DOTFILES_ROOT}/zsh/.zsh-custom-functions ~
ln -sfn ${DOTFILES_ROOT}/zsh/.p10k.zsh ~
