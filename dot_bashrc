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

export GOPATH="$HOME/.go"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$PATH:$HOME/.cargo/bin"

export ANDROID_SDK_ROOT="$HOME/Android/Sdk"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/ludihan/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/ludihan/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<
