#!/bin/bash

# Time
SECONDS=0

# Load util functions
. './scripts/utils.sh'

#
# Main procedure
#
if [ "$(uname)" != 'Darwin' ]; then
	echo_error "Here is not osx."
	exit 1
fi

if ! is_exist_command 'brew'; then
	echo_normal 'Installing brew ..'
	# see https://brew.sh/
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || echo_error 'installing brew was failed'
	exit 1
fi

MODULES=('brew' 'asdf')
for m in "${MODULES[@]}"; do
	if is_exist_command "$m"; then
		echo_normal "Installing by ${m} .."

		#shellcheck disable=SC1090
		. "./scripts/${m}.sh"
	fi
done

# change shell
echo_normal 'Change shell ..'
TARGET_SHELL='/opt/homebrew/bin/bash'
if [ "$SHELL" != "$TARGET_SHELL" ] && [ -e "$TARGET_SHELL" ]; then
	echo $TARGET_SHELL | sudo tee -a /etc/shells && chsh -s $TARGET_SHELL
fi

#
# Finish procedure
#
echo "Installation is done: Time=${SECONDS}(Sec.)"
exit 0
