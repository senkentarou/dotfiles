#
# exports
#

# prompt color
export LSCOLORS=gxfxcxdxbxegedabagacad

# history settings
export HISTCONTROL=erasedups
#shellcheck disable=SC2125
export HISTIGNORE=history:exit:?:?? # ignore 1,2 chars commands

export PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"
shopt -u histappend
