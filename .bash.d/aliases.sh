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
