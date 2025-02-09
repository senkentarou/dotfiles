#!/bin/bash

# Load util functions
. './scripts/utils.sh'

install_by_asdf() {
	echo_info 'Installing by asdf ...'

	local plugins=('ruby' 'nodejs')

	local gem_libs=('ruby-lsp')
	local npm_libs=('eslint' 'prettier')

	if is_exist_command 'asdf'; then
		for p in "${plugins[@]}"; do
			asdf plugin add "${p}"
			asdf install "${p}" latest
			asdf global "${p}" latest
		done
	fi

	if is_exist_command 'gem'; then
		for gl in "${gem_libs[@]}"; do
			if ! is_exist_command "${gl}"; then
				gem install "${gl}"
			fi
		done
	fi

	if is_exist_command 'npm'; then
		for nl in "${npm_libs[@]}"; do
			if ! is_exist_command "${nl}"; then
				npm install -g "${nl}"
			fi
		done
	fi

	echo_success 'Installed by asdf.'
	return 0
}

#
# Main procedure
#
install_by_asdf
