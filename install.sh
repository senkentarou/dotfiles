#!/bin/bash

# Time
SECONDS=0

# Load util functions
. './scripts/utils.sh'

install_by_brew() {
    if ! is_exist_command 'brew'; then
        echo_error "brew command is not found."
        return 1
    fi

    echo_normal 'Update and upgrade brew ..'
    brew update && brew upgrade

    local brew_commands=('zsh' 'tmux' 'tmuxinator' 'git' 'vim' 'neovim' 'bat' 'anyenv' 'direnv' 'node' 'mysql' 'mycli' 'jq' 'ripgrep' 'fzf' 'docker' 'reattach-to-user-namespace')
    local brew_casks=('docker' 'iterm2' 'google-chrome' 'slack')

    echo_normal 'Install brew packages'
    for bc in ${brew_commands[@]}; do
        if ! brew list | grep -wq "$bc"; then
            echo_normal "Installing $bc .."
            brew install "$bc"
            echo_info "Installed $bc"
        else
            echo_warning "$bc is already installed in brew"
        fi
    done

    for bcs in ${brew_casks[@]}; do
        if ! brew list --cask | grep -wq "$bcs"; then
            echo_normal "Installing $bcs .."
            brew install --cask "$bcs"
            echo_info "Installed $bcs"
        else
            echo_warning "$bcs is already installed in brew --cask"
        fi
    done

    echo_normal 'Cleaning brew ..'
    brew cleanup

    echo_success "$0"
    return 0
}

install_by_npm() {
    if ! is_exist_command 'npm'; then
        echo_error "npm command is not found."
        return 1
    fi

    local npm_commands=('typescript' 'javascript-typescript-langserver')

    echo_normal 'Install npm packages'
    for nc in ${npm_commands[@]}; do
        npm install -g $nc
    done

    echo_success $0
    return 0
}


#
# Main procedure
#
if [ -z $(echo $OSTYPE | grep 'darwin') ]; then
    echo $OSTYPE
    echo_error "Here is not osx."
    exit 1
fi

if ! is_exist_command 'brew'; then
    echo_normal 'Installing brew ..'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || echo_error 'installing brew was failed'; exit 1
fi

install_by_brew
install_by_npm

#
# Finish procedure
#
echo "Installation is done: Time=${SECONDS}(Sec.)"
echo "Reboot shell in 5 seconds .."
sleep 5

# Reboot shell or change shell to zsh
if [ "$SHELL" != '/bin/zsh' ]; then
    echo_info "change shell $SHELL to /bin/zsh"
    chsh -s /usr/local/bin/zsh
    exec /usr/local/bin/zsh
else
    exec "${SHELL}" -l
fi
exit 0
