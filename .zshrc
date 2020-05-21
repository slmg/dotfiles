# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="custom"

# Plugins to load from ~/.oh-my-zsh/plugins/* or ~/.oh-my-zsh/custom/plugins/.
plugins=(
    docker-compose
    git
    pip
    terraform
    vi-mode
    virtualenv
)

source $ZSH/oh-my-zsh.sh

# Preferred editor.
export EDITOR='vim'

# Below are personal aliases, possibly overriding those provided by oh-my-zsh.

alias l="ls -lrth"
alias ll="ls -lArth"

alias gfg="git ls-files | xargs grep --color=always -in"
alias glo="git --no-pager lo"

alias ag="alias | grep -i"
alias eg="env | grep -i"
alias hg="history | grep -i"

alias tf=terraform
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"

alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME'
