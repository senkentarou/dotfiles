#
# exports for tmux
# ref.: https://qiita.com/ono_matope/items/feebac51afb346d9db0e
#
export LSCOLORS=gxfxcxdxbxegedabagacad
# load brew go
export PATH="$HOME/go/bin:$PATH"

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
	local hist
	hist=$(HISTTIMEFORMAT='' history | gsed -e 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | sort -u | fzf --select-1 --reverse --height 30% --query "$READLINE_LINE")
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${hist}${READLINE_LINE:$READLINE_POINT}"
	READLINE_POINT=$((READLINE_POINT + ${#hist}))
}
bind -x '"\C-r": fzf_history'

#
# alias
#

# one char commands
# alias a=''
# alias b='bundle ex'
alias c='code'
# alias d='docker'
# alias e=''
# alias f=''
# alias g='git remote -v'
# alias h=''
# alias i=''
# alias j=''
# alias k='kubectl'
alias l='ls'
# alias m=''
# alias n=''
alias o='open'
# alias p=''
alias q='exit'
alias r='source ${HOME}/.bashrc'
# alias s='supervisorctl'
# alias t=''
# alias u=''
# alias v='vim'
# alias w='w'
# alias x=''
# alias y=''
# alias z=''

# vim
# for downloading nightly build
# download command:
#   for linux: mkdir -p ~/work && cd ~/work && curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz > neovim.tar.gz && tar -zxvf neovim.tar.gz
#   for macos: mkdir -p ~/work && cd ~/work && curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-macos.tar.gz > neovim.tar.gz && tar -zxvf neovim.tar.gz
if [ -e "${HOME}/work/nvim-macos/bin/nvim" ]; then
	alias nvim='${HOME}/work/nvim-macos/bin/nvim'
elif [ -e "${HOME}/work/nvim-linux64/bin/nvim" ]; then
	alias nvim='${HOME}/work/nvim-linux64/bin/nvim'
else
	alias nvim='nvim'
fi
alias vi='nvim'
alias vim='nvim'
alias emacs='nvim'
alias atom='nvim'
alias subl='nvim'
# alias code='nvim'

# ls
alias ls='ls -G --color=auto'
alias ll='ls -alF'

# docker
alias d='docker'
alias dp='docker ps'

# rails
alias b='bundle ex'
alias bspec='bundle ex rspec'
alias bim='bundle install && bundle ex rails db:migrate'

# git
alias g='git remote -v'

alias gl='git log'
alias glp='git log -p'

alias gs='git status -u'
alias gd='git diff'
alias gdc='git diff --cached'

alias gri='git rebase -i'

alias gc='git switch'
alias gco='git checkout'
alias gcb='git switch -c'

alias ga='git add'
alias gau='git add -u'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'

alias gsu='git stash -u'
alias gsp='git stash pop'

# git check out pull request
gcopr() {
	git fetch upstream "pull/$1/head:pr/$1"
	git checkout "pr/$1"
}

# git pull upstream and push origin
gpap() {
	if [[ $# = 0 ]]; then
		echo 'gpap <branch_name>'
		return 1
	fi

	if [[ $(git config --list | grep -c 'remote.upstream' | tr -d ' ') -eq 0 ]]; then
		echo 'no upstream config.'
		return 1
	fi
	git pull upstream "$1"
	git push origin "$1"
}

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

# Check .bashrc.local
test -r "${HOME}/.bashrc.local" && . "${HOME}/.bashrc.local"
