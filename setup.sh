#!/bin/bash

# Time
SECONDS=0

# Load util functions
. './scripts/utils.sh'

downlad_my_dotfiles() {
    if [ -d "$MY_DOTFILES_PATH" ]; then
        echo_warning "$MY_DOTFILES_PATH: already exist"
        return 1
    fi

    if ! is_exist_command 'git'; then
        echo_error "git command is not found."
        return 1
    fi

    local dotfiles_repository='https://github.com/senkentarou/dotfiles.git'

    echo_normal 'Downloading my dotfiles..'
    git clone --recursive "$dotfiles_repository" "$MY_DOTFILES_PATH"

    echo_normal 'Downloaded'
    return 0
}

link_my_dotfiles() {
    if [ ! -d "$MY_DOTFILES_PATH" ]; then
        echo_error "$MY_DOTFILES_PATH: not found"
        exit 1
    fi

    echo_normal 'Deploying dotfiles..'
    # link
    # add symbolic links about dotfiles from $HOME to
    # first, find the dotfiles on $MY_DOTFILES_PATH,
    # and next, select the dotdirs yourself.
    dots=$(find $MY_DOTFILES_PATH -type f -maxdepth 1 -name '.??*' | awk -F/ '{print $NF}')
    dots="$dots .zsh.d .vim .config/nvim"

    for dot in $dots; do
      [[ -L $HOME/$dot ]] && unlink $HOME/$dot
      ln -sv $MY_DOTFILES_PATH/$dot $HOME/$dot
    done

    echo_normal 'Deployed'
    return 0
}

set_git_config() {
    if ! is_exist_command 'git'; then
        echo_error "git command is not found."
        return 1
    fi

    git config --global core.editor 'vim -c "set fenc=utf-8"'
    git config --global user.name 'senkentarou'
    git config --global user.email 'masahiro-senda@c-fo.com'
    git config --global merge.ff false
    git config --global pull.ff only
}

#
# Main procedure
#
if [ -z "${MY_DOTFILES_PATH:-}" ]; then
    export MY_DOTFILES_PATH="${HOME}/mywork/dotfiles"
fi

downlad_my_dotfiles
link_my_dotfiles
set_git_config

#
# Finish procedure
#
echo "Installation is done: Time=${SECONDS}(Sec.)"
exit 0
