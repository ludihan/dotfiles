# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

PS1='\[\e[92m\][\u@\h \W]\$\[\e[0m\] '

export TERM='alacritty'
export BROWSER='firefox'
export EDITOR='nvim'
export VISUAL='nvim'

alias l='ls -alh'
alias ll='ls -lh'

alias reboot="sudo reboot"
alias poweroff="sudo poweroff"

export GOPATH="$HOME/.go"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

export GAMEMODERUNEXEC="prime-run"
