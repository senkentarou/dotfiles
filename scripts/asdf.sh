#!/bin/bash

# Time
SECONDS=0

# Load util functions
. './scripts/utils.sh'

GEM_LIBS=('solargraph' 'rubocop' 'rubocop-daemon')
NPM_LIBS=('eslint_d' 'prettier')
GO_LIBS=('github.com/mattn/memo@latest')

PLUGINS=('ruby' 'nodejs' 'golang')

if is_exist_command 'asdf'; then
	for p in "${PLUGINS[@]}"; do
		asdf plugin add "${p}"
		asdf install "${p}" latest
		asdf global "${p}" latest
	done
fi

if is_exist_command 'gem'; then
	for gl in "${GEM_LIBS[@]}"; do
		if ! is_exist_command "${gl}"; then
			gem install "${gl}"
		fi
	done
fi

if is_exist_command 'npm'; then
	for nl in "${NPM_LIBS[@]}"; do
		if ! is_exist_command "${nl}"; then
			npm install -g "${nl}"
		fi
	done
fi

if is_exist_command 'go'; then
	for gl in "${GO_LIBS[@]}"; do
		if ! is_exist_command "${gl}"; then
			go install "${gl}"
		fi
	done
fi

#
# Finish procedure
#
echo "Linking is done: Time=${SECONDS}(Sec.)"
exit 0
