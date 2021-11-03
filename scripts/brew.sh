#!/bin/bash

install_by_brew() {
    echo 'Update and upgrade brew ..'
    brew update && brew upgrade

    local brew_commands=('zsh' 'tmux' 'tmuxinator' 'git' 'git-secrets' 'vim' 'neovim' 'bat' 'anyenv' 'direnv' 'node' 'mysql' 'mycli' 'jq' 'ripgrep' 'fzf' 'docker' 'reattach-to-user-namespace' 'efm-langserver')
    local brew_casks=('docker' 'iterm2' 'google-chrome' 'slack' 'karabiner-elements')

    echo 'Install brew packages'
    for bc in ${brew_commands[@]}; do
        if ! brew list | grep -wq "$bc"; then
            echo "Installing $bc .."
            brew install "$bc"
            echo "Installed $bc"
        else
            echo "$bc is already installed in brew"
        fi
    done

    for bcs in ${brew_casks[@]}; do
        if ! brew list --cask | grep -wq "$bcs"; then
            echo "Installing $bcs .."
            brew install --cask "$bcs"
            echo "Installed $bcs"
        else
            echo "$bcs is already installed in brew --cask"
        fi
    done

    echo 'Cleaning brew ..'
    brew cleanup

    return 0
}

install_by_brew
