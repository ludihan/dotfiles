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

alias comc="gcc -Wall -Wextra -Wpedantic -std=c17 -lm -o main"
alias comcpp="g++ -Wall -Wextra -Wpedantic -std=c++20 -lm -o main"

alias poweroff="loginctl poweroff"
alias reboot="loginctl reboot"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(go env GOPATH)/bin"

export ANDROID_SDK_ROOT="/home/lucca/Android/Sdk"

export GAMEMODERUNEXEC="prime-run"
