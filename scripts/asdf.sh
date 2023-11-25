#!/bin/bash

# Time
SECONDS=0

# Load util functions
. './scripts/utils.sh'

ruby_global_version='3.1.2'
gem_libs=('solargraph' 'rubocop' 'rubocop-daemon')

nodejs_global_version='18.16.0'
npm_libs=('eslint_d' 'prettier')

if is_exist_command 'asdf'; then
	if ! is_exist_command 'ruby'; then
		asdf plugin add ruby
		asdf install ruby "${ruby_global_version}"
		asdf global ruby "${ruby_global_version}"
	fi

	if ! is_exist_command 'node'; then
		asdf plugin add nodejs
		asdf install nodejs "${nodejs_global_version}"
		asdf global nodejs "${nodejs_global_version}"
	fi
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

#
# Finish procedure
#
echo "Linking is done: Time=${SECONDS}(Sec.)"
exit 0
