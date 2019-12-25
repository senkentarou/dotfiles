#
# .bashrc Settings
#
# tmux automatic attachment
function attach_tmux() {
    # Is exist tmux?
    if [ ! type 'tmux' >/dev/null 2>&1 ]; then
        echo 'tmux command not found.'
        return 1
    fi
    # Is tmux mode?
    if [ ! -z "$TMUX" ]; then
        echo 'Hello, tmux!'
        return 0
    # Is sty mode?
    elif [ ! -z "$STY" ]; then
        echo 'This is on screen.'
        return 0
    # Is not ssh connection?
    elif [ ! -z "$PS1" ] && [ -z "$SSH_CONECTION" ]; then
        #
        if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '(.*]|.*\))$'; then
            tmux list-sessions
            echo -n 'tmux: attach? {y(=latest)/N(=new)/<num>}: '
            read
            if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                tmux attach-session
                if [ $? -eq 0 ]; then
                    echo "$(tmux -V) attached session."
                    return 0
                fi
            elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                tmux attach -t "$REPLY"
                if [ $? -eq 0 ]; then
                    echo "$(tmux -V) attached session"
                    return 0
                fi
            fi
        fi
        # mac OS settings (need to install: reattach-to-user-namespace (brew install reattach-to-user-namespace))
        if [[ "$OSTYPE" == "darwin*" ]] && [ type 'reattach-to-user-namespace' >/dev/null 2>&1 ]; then
            tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
            tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
        else
            tmux new-session && echo "tmux created new session"
        fi
    fi
}
attach_tmux  # execute
