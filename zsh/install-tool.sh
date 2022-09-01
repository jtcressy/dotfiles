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

ln -sfn zsh/.zshrc ~
ln -sfn zsh/.antigenrc ~
ln -sfn zsh/.zsh-custom-functions ~
ln -sfn zsh/.p10k.zsh ~
