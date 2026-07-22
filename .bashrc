PS1='\[\e[92m\]\u\[\e[0m\]@\[\e[92m\]\h\[\e[0m\]:\[\e[92m\]\w\[\e[0m\]> '

export HISTFILE="$XDG_STATE_HOME"/bash/history

export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
# export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc 

export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

export GOPATH="$XDG_DATA_HOME"/go

export PATH="$CARGO_HOME/bin:$PATH"
export PATH="$GOPATH/bin:$PATH"
export PATH="$XDG_DATA_HOME/npm-global/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
