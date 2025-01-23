#!/bin/bash

# Load util functions
. './scripts/utils.sh'

install() {
	local modules=('brew' 'asdf')
	for m in "${modules[@]}"; do
		if is_exist_command "$m"; then
			#shellcheck disable=SC1090
			. "./scripts/${m}.sh"
		fi
	done

	# change shell
	local target_shell='/opt/homebrew/bin/bash'
	if [ "$SHELL" != "$target_shell" ] && [ -e "$target_shell" ]; then
		echo_warning 'Changing shell ... (required su password)'
		echo $target_shell | sudo tee -a /etc/shells && chsh -s $target_shell
	fi

	return 0
}

#
# Main procedure
#
if [ "$(uname)" != 'Darwin' ]; then
	echo_error "Here is not osx."
	exit 1
fi

if ! is_exist_command 'brew'; then
	# see https://brew.sh/
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || echo_error 'installing brew was failed'
	echo_warning 'Installed brew. Setup brew and rerun make install.'
	exit 1
fi

install
