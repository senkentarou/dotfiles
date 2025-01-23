#
# exports (for tmux)
# ref.: https://qiita.com/ono_matope/items/feebac51afb346d9db0e
#

# prompt color
export LSCOLORS=gxfxcxdxbxegedabagacad

# history settings
export HISTCONTROL=erasedups
export HISTIGNORE=history:exit:?:?? # ignore 1,2 chars commands

export PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"
shopt -u histappend
