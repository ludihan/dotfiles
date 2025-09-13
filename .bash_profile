#
# ~/.bash_profile
#

# If running from tty1 start sway
export PATH="$PATH:/usr/share/sway-contrib"
[ "$(tty)" = "/dev/tty1" ] && exec sway --unsupported-gpu

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
