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

# create if not create already
mkdir -p $XDG_DATA_HOME
mkdir -p $XDG_CONFIG_HOME
mkdir -p $XDG_STATE_HOME
mkdir -p $XDG_CACHE_HOME
mkdir -p $XDG_DATA_HOME/applications

# path
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:$GOPATH/bin"

# unclutter
mkdir -p "$XDG_STATE_HOME"/bash
export HISTFILE="$XDG_STATE_HOME"/bash/history
export GOPATH="$XDG_DATA_HOME"/go
# export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONUSERBASE=$XDG_DATA_HOME/python
export PSQL_HISTORY="$XDG_STATE_HOME/psql_history"
export SQLITE_HISTORY=$XDG_STATE_HOME/sqlite_history
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export JULIA_DEPOT_PATH="$XDG_DATA_HOME/julia:$JULIA_DEPOT_PATH"
export JULIAUP_DEPOT_PATH="$XDG_DATA_HOME/julia"
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node_repl_history
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GHCUP_USE_XDG_DIRS=true
export OPAMROOT="$XDG_DATA_HOME/opam"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export OMNISHARPHOME="$XDG_CONFIG_HOME/omnisharp"
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
