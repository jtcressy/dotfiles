source $HOME/antigen.zsh
antigen init $HOME/.antigenrc

#GPG setup (todo: make this a dedicated gpg setup plugin for antigen on github)
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Aliases
alias home='git --work-tree=$HOME --git-dir=$HOME/.home'
alias kx=kubectl-ctx
alias kn=kubectl-ns
alias tf=terraform
alias k9r="k9s --readonly"
if [ -f $HOME/.zsh-custom-functions ];
then
  source $HOME/.zsh-custom-functions
fi

# Make VSCode the default editor for the terminal ONLY if the environment
# is codespaces, because we can rely on vscode being always available
if $CODESPACES
then
  export EDITOR="code --wait"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="${PATH}:${HOME}/.krew/bin"
export PATH="${PATH}:${HOME}/go/bin"
export PATH=/usr/local/sbin:$PATH

[ $(command -v thefuck) ] && eval $(thefuck --alias)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
