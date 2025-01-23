#!/bin/bash

# Load util functions
. './scripts/utils.sh'

install_by_brew() {
	echo_info 'Installing by brew ...'

	echo_normal 'Updating brew ...'
	brew update && brew upgrade

	local brew_commands=('wget' 'bash' 'tmux' 'tmuxinator' 'git' 'git-secrets' 'gh' 'vim' 'neovim' 'bat' 'asdf' 'direnv' 'node' 'ruby' 'go' 'terraform' 'mysql' 'mycli' 'jq' 'ripgrep' 'fd' 'fzf' 'cmake' 'luarocks' 'docker' 'gnu-sed')
	local brew_taps=('homebrew/cask-fonts')
	local brew_casks=('iterm2' 'google-chrome' 'slack' 'font-hack-nerd-font' 'elgato-stream-deck')

	for bc in "${brew_commands[@]}"; do
		if ! brew list | (
			grep -wq "$bc"
			ret=$?
			cat >/dev/null
			exit $ret
		); then
			brew install "$bc"
			echo_normal "Installed $bc"
		else
			echo_normal "$bc is already installed in brew"
		fi
	done

	echo_normal 'Tapping brew ...'
	for bt in "${brew_taps[@]}"; do
		brew tap "$bt"
	done

	for bcs in "${brew_casks[@]}"; do
		if ! brew list --cask | (
			grep -q "$bcs"
			ret=$?
			cat >/dev/null
			exit $ret
		); then
			brew install --cask "$bcs"
			echo_normal "Installed $bcs"
		else
			echo_normal "$bcs is already installed in brew --cask"
		fi
	done

	echo_normal 'Cleaning brew ...'
	brew cleanup

	echo_success 'Installed by brew.'
	return 0
}

#
# Main procedure
#
install_by_brew
