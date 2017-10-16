# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/jtcressy/.oh-my-zsh
POWERLEVEL9K_MODE='awesome-fontconfig'
# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bureau"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker dnf docker-compose meteor cp colorize man nmap node npm nvm pip python screen sudo vagrant yum tmux encode64 history sprunge zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
	TERM="xterm-256color" # Use xterm 256 color profile for remote connections
#   export EDITOR='vim'
 else
	TERM="screen-256color" # otherwise use screen color profile
#   export EDITOR='mvim'
 fi
export EDITOR='vim'
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOSTART_ONCE=false
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

PATH="$HOME/.local/bin:$PATH"

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh  

export NVM_DIR="/home/jtcressy/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

alias docker-powercli="docker run -it --rm -v "$(pwd)":/projects jtcressy/powercli_docker"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/jtcressy/google-cloud-sdk/path.zsh.inc' ]; then source '/home/jtcressy/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/jtcressy/google-cloud-sdk/completion.zsh.inc' ]; then source '/home/jtcressy/google-cloud-sdk/completion.zsh.inc'; fi

source <(kompose completion zsh)
source ~/.fonts/*.sh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator context dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status load ram_joined battery time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true

konsolex=$(qdbus | grep konsole | cut -f 2 -d\ )
if [ -n "$konsolex" ]; then
		for konsole in `xdotool search --class konsole`; do
				xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $konsole;
		done
fi
if [ `qdbus | grep yakuake` ]; then
		xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id `xdotool search --class yakuake`;
fi
alias powercli="docker run -it --rm jtcressy/powercli_docker"
