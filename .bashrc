#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='\[\e[92m\][\u@\h \W]\$\[\e[0m\] '

# editor
export EDITOR='nvim'
export VISUAL='nvim'

# XDG
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# unclutter
export GOPATH="$XDG_DATA_HOME"/go
export HISTFILE="$XDG_STATE_HOME"/bash/history
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export PYTHON_HISTORY="$XDG_DATA_HOME"/python/history
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js   
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm                             
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"

# path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$CARGO_HOME/bin"
