# load commands on brew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

#
# stty
#

# bash history: ctrl+r
#   back:    ctrl+r
#   forward: ctrl+s
# updef screen lock (ctrl+s)
stty stop undef
# updef screen unlock (ctrl+q)
stty start undef

#
# bind
#
fzf_history() {
  local l
  l=$(HISTTIMEFORMAT='' history | gsed -e 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | sort -u | fzf --select-1 --reverse --height 30% --query "$READLINE_LINE")
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$l${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#l} ))
}
bind -x '"\C-r": fzf_history'

#
# bindings
#
alias nvim='nvim'
# alias nvim="${HOME}/work/nvim-linux64/bin/nvim"
alias vim='nvim'

#
# git
#
alias gl='git log'
alias glp='git log -p'

alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'

alias gri='git rebase -i'

# alias gc='git checkout'
alias gc='git switch'
# alias gcb='git checkout -b'
alias gcb='git switch -c'

alias gau='git add -u'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'

alias gsu='git stash -u'
alias gsp='git stash pop'

__bash_prompt() {
    local userpart='`export XIT=$? \
        && echo -n "\[\033[0;32m\]\u " \
        && [ "$XIT" -ne "0" ] && echo -n "\[\033[1;31m\]➜" || echo -n "\[\033[0m\]➜"`'
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
	if [ ! -z "$TMUX" ]; then
		echo 'Hello, tmux!'
		return 0
	# Is sty mode?
	elif [ ! -z "$STY" ]; then
		echo 'This is on screen.'
		return 0
	# Is not ssh connection?
	elif [ ! -z "$PS1" ] && [ -z "$SSH_CONECTION" ]; then
		if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '(.*]|.*\))$'; then
			tmux list-sessions
			echo -n 'tmux: attach? {y(=latest)/N(=new)/<num>}: '
			read
			if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
				tmux attach-session
				if [ $? -eq 0 ]; then
					echo "$(tmux -V) attached session."
					return 0
				fi
			elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
				tmux attach -t "$REPLY"
				if [ $? -eq 0 ]; then
					echo "$(tmux -V) attached session"
					return 0
				fi
			fi
		fi
		# mac OS settings (need to install: reattach-to-user-namespace (brew install reattach-to-user-namespace))
    if [[ "$OSTYPE" == "darwin*" ]] && (type 'reattach-to-user-namespace' >/dev/null 2>&1); then
			tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
			tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
		else
			tmux new-session && echo "tmux created new session"
		fi
	fi
}
__attach_tmux # execute
