# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias d='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

PS1='\[\e[92m\]\u\[\e[0m\]@\[\e[92m\]\h\[\e[0m\]:\[\e[92m\]\w\[\e[0m\]> '

export HISTFILE="$XDG_STATE_HOME"/bash/history

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
. "$HOME/.cargo/env"
