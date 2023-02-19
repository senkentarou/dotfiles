#!/bin/bash

install_by_brew() {
	echo 'Update and upgrade brew ..'
	brew update && brew upgrade

	local brew_commands=('wget' 'zsh' 'tmux' 'tmuxinator' 'git' 'git-secrets' 'gh' 'vim' 'neovim' 'bat' 'anyenv' 'direnv' 'node' 'go' 'mysql' 'mycli' 'jq' 'ripgrep' 'fd' 'fzf' 'cmake' 'luarocks' 'docker' 'reattach-to-user-namespace' 'gitmoji' 'rustup')
	local brew_taps=('homebrew/cask-fonts' 'homebrew/cask-drivers')
	local brew_casks=('docker' 'iterm2' 'google-chrome' 'slack' 'font-hack-nerd-font' 'elgato-stream-deck')

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

	echo 'Install brew taps'
	for bt in ${brew_taps[@]}; do
		brew tap "$bt"
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
