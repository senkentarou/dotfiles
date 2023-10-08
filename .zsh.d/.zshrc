# Preloads
# color
export LSCOLORS=gxfxcxdxbxegedabagacad
export BAT_THEME='gruvbox-dark'

# anyenv
eval "$(anyenv init -)"

# Load Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Load .zsh submodules
ZSHHOME="${HOME}/.zsh.d"
ZSHCONFIG="${ZSHHOME}/config"

if [ -d $ZSHHOME -a -r $ZSHHOME -a -x $ZSHHOME ]; then
  for i in $ZSHCONFIG/*; do
    [[ ${i##*/} = *.zsh ]] &&
      [ \( -f $i -o -h $i \) -a -r $i ] && . $i
  done
fi

# Load .zshrc.local file
[[ -f "${ZSHHOME}/.zshrc.local" ]] && . $ZSHHOME/.zshrc.local

# Open tmux with tmuxinator default setting
mux
