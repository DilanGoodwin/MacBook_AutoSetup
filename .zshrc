# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

ZSH_CUSTOM=~/.config/zsh

# Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"
alias ls="ls -alrt"
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
