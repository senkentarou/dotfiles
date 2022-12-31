#!/bin/bash

# Time
SECONDS=0

# Load util functions
. './scripts/utils.sh'

set_git_config() {
	if ! is_exist_command 'git'; then
		echo_error "git command is not found."
		return 1
	fi

	if ! is_exist_command 'git-secrets'; then
		echo_error "git-secrets command is not found."
		return 1
	fi

	git config --global core.editor 'vim -c "set fenc=utf-8"'
	git config --global user.name 'senkentarou'
	git config --global user.email 'masahiro-senda@c-fo.com'
	git config --global merge.ff false
	git config --global pull.ff only

	git secrets --register-aws --global
	git secrets --install ~/.git-templates/git-secrets
	git config --global init.templatedir "${HOME}/.git-templates/git-secrets"
	git config --global branch.master.remote 'upstream'
}

#
# Main procedure
#
if [ -z "${MY_DOTFILES_PATH:-}" ]; then
	export MY_DOTFILES_PATH="${HOME}/mywork/dotfiles"
fi

set_git_config

#
# Finish procedure
#
echo "Setupping is done: Time=${SECONDS}(Sec.)"
exit 0
