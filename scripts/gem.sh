#!/bin/bash

install_by_gem() {
	local gems=('solargraph' 'rubocop' 'rubocop-daemon')

	echo 'Install gems'
	for g in "${gems[@]}"; do
		gem install "$g"
	done

	return 0
}

install_by_gem
