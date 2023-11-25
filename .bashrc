#
# Load .bash.d
#
for file in "${HOME}/.bash.d"/*; do
	if [ -f "$file" ]; then
		# shellcheck disable=SC1090
		. "$file"
	fi
done

#
# Load .bashrc.local
#
# shellcheck disable=SC1091
test -r "${HOME}/.bashrc.local" && . "${HOME}/.bashrc.local"

#
# Setup prompt
#
__bash_prompt() {
	# shellcheck disable=SC2016
	local userpart='`export XIT=$? && echo -n "\[\033[0;32m\]\u " && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'
	# shellcheck disable=SC2016
	local gitbranch='`\
        if [ "$(git config --get devcontainers-theme.hide-status 2>/dev/null)" != 1 ] && [ "$(git config --get codespaces-them e.hide-status 2>/dev/null)" != 1 ]; then \
            export BRANCH=$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null); \
            if [ "${BRANCH}" != "" ]; then \
                echo -n "\[\033[0;36m\](\[\033[1;31m\]${BRANCH}" \
                && if [ "$(git config --get devcontainers-theme.show-dirty 2>/dev/null)" = 1 ] && \
                    git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then \
                        echo -n " \[\033[1;33m\]✗"; \
                fi \
                && echo -n "\[\033[0;36m\]) "; \
            fi; \
        fi`'
	local lightblue='\[\033[1;34m\]'
	local removecolor='\[\033[0m\]'
	PS1="${userpart} ${lightblue}\w ${gitbranch}${removecolor}\$ "
	unset -f __bash_prompt
}
__bash_prompt

# tmux automatic attachment
__attach_tmux() {
	# Is exist tmux?
	if ! (type 'tmux' >/dev/null 2>&1); then
		echo 'tmux command not found.'
		return 1
	fi
	# Is tmux mode?
	if [ -n "$TMUX" ]; then
		echo 'Hello, tmux!'
		return 0
	# Is sty mode?
	elif [ -n "$STY" ]; then
		echo 'This is on screen.'
		return 0
	# Is not ssh connection?
	elif [ -n "$PS1" ] && [ -z "$SSH_CONECTION" ]; then
		if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '(.*]|.*\))$'; then
			tmux list-sessions
			echo -n 'tmux: attach? {y(=latest)/N(=new)/<num>}: '
			read -r

			if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
				if tmux attach-session; then
					echo "$(tmux -V) attached session."
					return 0
				fi
			elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then

				if tmux attach -t "$REPLY"; then
					echo "$(tmux -V) attached session"
					return 0
				fi
			fi
		fi

		# Create new session
		tmux new-session && echo "tmux created new session"
	fi
}
__attach_tmux
