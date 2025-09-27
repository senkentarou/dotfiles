#
# alias
#

# one char commands
# alias a=''
# alias b=''
alias c='code'
alias d='docker'
# alias e=''
# alias f=''
alias g='git'
# alias h=''
# alias i=''
# alias j=''
# alias k=''
alias l='ls'
# alias m=''
# alias n=''
alias o='open'
# alias p=''
alias q='exit'
# alias r=''
# alias s=''
alias t='tmux'
# alias u=''
alias v='vim'
alias w='w'
# alias x=''
# alias y=''
alias z='z'

# settings
alias reload='source ${HOME}/.bashrc'
alias bashrc='vim ${HOME}/.bashrc'
alias bashrc.local='vim ${HOME}/.bashrc.local'
alias tmux.conf='vim ${HOME}/.tmux.conf'

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

# ls
alias ls='ls -G --color=auto'
alias ll='ls -alF'

# cd
# alias cd='z'

# docker
alias dp='docker ps'
alias dil='docker image ls'
alias dcl='docker container ls'
alias dvl='docker volume ls'

# git
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
alias gaa='git add -A'
alias gau='git add -u'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gp='git push'

alias gsu='git stash -u'
alias gsp='git stash pop'

alias gr='git reset'
alias grs='git reset --soft HEAD^'

# git check out pull request
gcopr() {
	git fetch upstream "pull/$1/head:pr/$1"
	git checkout "pr/$1"
}

# tmux
alias tl='tmux ls'

# tmux attach
ta() {
	local session='main'
	if [ -z "$TMUX" ]; then
		if ! tmux attach -t $session >/dev/null 2>&1; then
			tmux new -s $session
		fi
	fi
}
