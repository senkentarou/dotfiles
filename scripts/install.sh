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
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || echo_error 'installing brew was failed'
	exit 1
fi

MODULES=('brew' 'npm' 'gem' 'anyenv')
for m in "${MODULES[@]}"; do
	if is_exist_command "$m"; then
		echo_normal "Installing by ${m} .."

		#shellcheck disable=SC1090
		. "./scripts/${m}.sh"
	fi
done

echo "execute below:"
echo "  edit /etc/shells and append '/opt/homebrew/bin/bash'"
echo "  chsh -s /opt/homebrew/bin/bash"

#
# Finish procedure
#
echo "Installation is done: Time=${SECONDS}(Sec.)"
exit 0
