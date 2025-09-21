#!/bin/bash

# Load util functions
. './scripts/utils.sh'

set_git_config() {
	echo_info 'setting git config ...'

	if ! is_exist_command 'git'; then
		echo_error "git command is not found."
		return 1
	fi

	git config --global core.editor 'vim -c "set fenc=utf-8"'
	git config --global user.name 'senkentarou'
	git config --global user.email 'senkentarou@gmail.com'
	git config --global merge.ff false
	git config --global pull.ff only

	if ! is_exist_command 'git-secrets'; then
		echo_error "git-secrets command is not found."
		return 1
	fi

	git secrets --register-aws --global
	git secrets --install ~/.git-templates/git-secrets
	git config --global init.templatedir "${HOME}/.git-templates/git-secrets"

	echo_success 'set git config.'
	return 0
}

#
# Main procedure
#
set_git_config
