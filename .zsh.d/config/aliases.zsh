# aliases
alias k='kubectl'
alias tf='terraform'

alias reload="source ${HOME}/.zsh.d/.zshrc"
alias zshconf="vim ${HOME}/.zsh.d/.zshrc"
alias vimconf="vim ${HOME}/.config/nvim/init.vim"
alias keyconf="vim ${HOME}/.config/nvim/config/key_mappings.vim"

alias less='less -qR'
alias ls='ls -al'

alias gl='git log'
alias glp='git log -p'
alias glno='git log --name-only'
alias glm='git log --merges'

alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gr='git reset'

alias gri='git rebase -i'
alias grc='git rebase --continue'

alias gc='git checkout'
alias gcb='git checkout -b'

alias gsu='git stash -u'
alias gsp='git stash pop'

alias gau='git add -u'
alias gcm='git commit -m'
alias gmc='gitmoji -c'
alias gpo='git push origin'
alias gpu='git push upstream'

alias gskip='git update-index --skip-worktree'
alias gnoskip='git update-index --no-skip-worktree'
alias gls='git ls-files -v | grep "^S"'

# vim
[[ -f $HOME/nvim-osx64/bin/nvim ]] && alias nvim=$HOME/nvim-osx64/bin/nvim
alias vim=nvim

# tmux
[[ -f $HOME/tmuxinator-3.0.1/bin/tmuxinator ]] && alias mux=$HOME/tmuxinator-3.0.1/bin/tmuxinator

# git open in log files
function golf() {
  local target='HEAD^..HEAD'
  if [[ $1 =~ [0-9a-f]{40} ]]; then
    # select files by range
    target="$1^..HEAD"
  fi

  vim $(git log ${target} --name-only --oneline | grep -Ev '.{7} ' | uniq)
}

# git checkout pull request by #PR number
function gcopr() {
  git fetch upstream pull/$1/head:pr/$1
  git checkout pr/$1
}

# git pull pull request on current #PR number branch
function gplpr() {
  git pull upstream pull/$(git branch | grep \* | cut -d ' ' -f2 | sed -e 's/pr\///')/head
}

# git open all file on vim
function goaf() {
  vim $(git status --porcelain | grep -wv D | awk '{print $2}')
}

# git pull upstream and push origin
function gpap() {
  if [[ $# = 0 ]]; then
    echo 'gpap <branch_name>'
    return 1
  fi

  local upstream_conf=$(git config --list | grep 'remote.upstream' | wc -l | tr -d ' ')
  if [[ $upstream_conf -eq 0 ]]; then
    echo 'no upstream config.'
    return 1
  fi
  git pull upstream $1
  git push origin $1
}

alias gpapd='gpap develop'
alias gpapm='gpap master'

# tmuxinator
function mux() {
  if [ $# = 0 ]; then
    tmuxinator default
  else
    tmuxinator $1
  fi
}
