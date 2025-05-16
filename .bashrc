#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\[\e[92m\][\u@\h \W]\$\[\e[0m\] '

export EDITOR='nvim'
export VISUAL='nvim'

alias l='ls -alh'
alias ll='ls -lh'
alias lt='du -sh * | sort -h'
alias s='du -sh'
alias p='pacman'
alias mirror='wl-mirror eDP-1'
alias diff='diff --color=auto'
alias lg='lazygit'
alias v=$EDITOR
alias g='git'
alias sp='sudo pacman'
alias dotenv='export $(grep -v "^#" .env | xargs)'

export PATH="$PATH:$HOME/.local/bin"

export GOPATH="$HOME/.go"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

#export GAMEMODERUNEXEC="prime-run"




[ -f "/home/ludihan/.ghcup/env" ] && . "/home/ludihan/.ghcup/env" # ghcup-env