# how to setup this repo:
# git clone --bare https://github.com/ludihan/dotfiles $HOME/.dotfiles
# alias d='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# d config --local status.showUntrackedFiles no

# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\[\e[92m\]\u\[\e[0m\]@\[\e[92m\]\h\[\e[0m\]:\[\e[92m\]\w\[\e[0m\]> '

alias d='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias docker-nuke='docker stop $(docker ps -aq) 2>/dev/null; docker system prune -a --volumes -f'
alias server='ssh 192.168.2.174'

export EDITOR="nvim"
export VISUAL="nvim"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/share/odin:$PATH"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
