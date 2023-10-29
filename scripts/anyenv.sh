#!/bin/bash

install_by_anyenv() {
	local envs=('direnv' 'rbenv' 'nodenv' 'pyenv' 'goenv' 'tfenv' 'luaenv')

	echo 'Install anyenv init'
	anyenv install --init

	echo 'Install anyenv packages'
	for e in "${envs[@]}"; do
		echo "Installing $e .."
		anyenv install -f "$e"
	done

	return 0
}

install_by_anyenv
