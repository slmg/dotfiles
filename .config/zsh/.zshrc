# Add ~/.local/bin to PATH if it is not already present.
if [[ ! ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load.
ZSH_THEME="custom"

# Use another custom folder than $ZSH/custom.
ZSH_CUSTOM="$ZDOTDIR/omz_custom"

# Ensure history is created in ZDOTDIR (set in ~/.zshenv).
HISTFILE="$ZDOTDIR/.zsh_history"

# History display preference.
HIST_STAMPS="yyyy-mm-dd"

HISTORY_IGNORE="(
    |history|pwd|fg|echo|tree|alias|ag *|eg *|cd|cd ..|..|...|....|1|2|3|4|5|
    |l|l *|la|la *|lt|lt *|lat|lat *|ls|ls *|d|dirs|dirs -v|pipx list|
    |which *|man *|* --help|git help *|* --version|* version|
    |docker * ls|docker * ls -a|docker ps| docker ps -a|docker diff *|
    |code|vim|gst|gd|gdca|glo|glog|glon|glol|gl|glo *|gstl|
    |dotfiles s|dotfiles d|dotfiles dc|dotfiles lo|dotfiles l|
    |apt search *|snap search *|apt-cache search *|pip search *|pip3 search *|
)"

# Plugins to load from ~/.oh-my-zsh/plugins/* or ~/.oh-my-zsh/custom/plugins/.
plugins=(
    ansible
    aws
    conda-env
    docker
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

alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME'

alias l="ls -lh"
alias la="ls -lAh"
alias lt="ls -lrth --time-style=long-iso"
alias lat="ls -lArth --time-style=long-iso"

alias lz="du -sh * | sort -h"

alias gfg="git ls-files --recurse-submodules | xargs grep --color=always -in"
alias gl5="git --no-pager log --oneline --decorate -n 5"
alias glon='git --no-pager log --oneline --decorate --graph  $(git_main_branch)..'
alias gstak="git stash push --keep-index"

alias ag="alias | grep -i"
alias eg="env | grep -i"
alias hg="history | grep -i"

command -v terraform > /dev/null && {
    alias tf=terraform
    export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
}

command -v terraform-docs > /dev/null && {
    alias tfd=terraform-docs
}

command -v terraform-docs-replace > /dev/null && {
    alias tfdr=terraform-docs-replace
}

# Enable completion for pipx.
command -v pipx > /dev/null && {
    # Un-comment the below if experiencing any issues.
    # autoload -U bashcompinit && bashcompinit
    eval "$(register-python-argcomplete pipx)"
}

# Enable completion for micromamba.
command -v micromamba > /dev/null && {
    export MAMBA_ROOT_PREFIX="$HOME/micromamba"
    eval "$(micromamba shell hook --shell zsh)"
    alias mamba=micromamba
}
