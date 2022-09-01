#TODO: install k9s agnostically

mkdir -p $HOME/.k9s

ln -sfn ${DOTFILES_ROOT}/k9s/config.yaml $HOME/.k9s/
ln -sfn ${DOTFILES_ROOT}/k9s/skin.yaml $HOME/.k9s/
