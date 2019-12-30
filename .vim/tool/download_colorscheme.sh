#!/bin/sh

#
COLOR_DIR="$HOME/.vim/colors"

if [[ ! -d $COLOR_DIR ]]; then
    mkdir -p $COLOR_DIR
fi

# color scheme: hybrid
GITHUB_URL='https://raw.githubusercontent.com'
USER='w0ng'
REPOSITRY='vim-hybrid'
VIMFILE='hybrid.vim'

curl "$GITHUB_URL/$USER/$REPOSITRY/master/colors/$VIMFILE" -o "$COLOR_DIR/$VIMFILE"

