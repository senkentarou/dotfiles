#!/bin/bash

install_by_npm() {
	local npms=('typescript' 'eslint_d' 'prettier')

	echo 'Install npm packages'
	for n in "${npms[@]}"; do
		npm install -g "$n"
	done

	return 0
}

install_by_npm
