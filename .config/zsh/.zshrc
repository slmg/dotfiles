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

# Ensure history is created next to this file (wherever .zshenv decides it is).
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
alias lt="ls -lrth"
alias la="ls -lAh"
alias lat="ls -lArth"

alias gfg="git ls-files --recurse-submodules | xargs grep --color=always -in"
alias glon="git --no-pager lo master.."

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

# Open with the default program in a graphical session, in a web browseer as an example.
command -v xdg-open > /dev/null && {
    alias open=xdg-open
}
