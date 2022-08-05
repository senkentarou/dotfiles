#!/bin/bash

# Time
SECONDS=0

# Load util functions
. './scripts/utils.sh'

#
# Main procedure
#
if [ -z $(echo $OSTYPE | grep 'darwin') ]; then
    echo $OSTYPE
    echo_error "Here is not osx."
    exit 1
fi

if ! is_exist_command 'brew'; then
    echo_normal 'Installing brew ..'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" || echo_error 'installing brew was failed'; exit 1
fi

MODULES=('brew' 'npm' 'gem' 'anyenv')
for m in ${MODULES[@]}; do
    if is_exist_command $m; then
        echo_normal "Installing by ${m} .."
        . "./scripts/${m}.sh"
    fi
done

#
# Finish procedure
#
echo "Installation is done: Time=${SECONDS}(Sec.)"
echo "Reboot shell in 5 seconds .."
sleep 5

# Reboot shell or change shell to zsh
if [ "$SHELL" != '/bin/zsh' ]; then
    echo_info "change shell $SHELL to /bin/zsh"
    chsh -s /usr/local/bin/zsh
    exec /usr/local/bin/zsh
else
    exec "${SHELL}" -l
fi
exit 0
