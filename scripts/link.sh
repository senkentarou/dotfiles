#!/bin/bash

# Load util functions
. './scripts/utils.sh'

link_my_dotfiles() {
	if [ ! -d "$MY_DOTFILES_PATH" ]; then
		echo_error "$MY_DOTFILES_PATH: not found"
		exit 1
	fi

	echo_info 'Deploying dotfiles ...'
	# link
	# add symbolic links about dotfiles from $HOME to
	# first, find the dotfiles on $MY_DOTFILES_PATH,
	# and next, select the dotdirs yourself.
	dots=$(find "$MY_DOTFILES_PATH" -type f -maxdepth 1 -name '.??*' | awk -F/ '{print $NF}')
	dots="$dots .bash.d .vim .config/nvim .config/git"

	for dot in $dots; do
		[[ -L $HOME/$dot ]] && unlink "$HOME/$dot"
		ln -sv "$MY_DOTFILES_PATH/$dot" "$HOME/$dot"
	done

	echo_success 'Deployed dotfiles.'
	return 0
}

#
# Main procedure
#
if [ -z "${MY_DOTFILES_PATH:-}" ]; then
	export MY_DOTFILES_PATH="${HOME}/work/dotfiles"
fi

link_my_dotfiles
