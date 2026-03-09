#
# exports
#

# prompt color
export LSCOLORS=gxfxcxdxbxegedabagacad

# history settings
export HISTCONTROL=erasedups
export HISTIGNORE='history:exit:?:??' # ignore 1,2 chars commands

shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r;${PROMPT_COMMAND}"
