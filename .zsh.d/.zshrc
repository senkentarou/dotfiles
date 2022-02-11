# Preloads
# color
export LSCOLORS=gxfxcxdxbxegedabagacad
export BAT_THEME='gruvbox-dark'

# pyenv
export PYENV_ROOT="$HOME/.anyenv/envs/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# goenv
export GOENV_ROOT="$HOME/.anyenv/envs/goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
if command -v goenv 1>/dev/null 2>&1; then
  export GO111MODULE=on
  eval "$(goenv init -)"
fi

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
