# aliases
alias mux='tmuxinator'
alias k='kubectl'

alias reload="source ${HOME}/.zsh.d/.zshrc"
alias zshconf="vim ${HOME}/.zsh.d/.zshrc"
alias vimconf="vim ${HOME}/.config/nvim/init.vim"
alias keyconf="vim ${HOME}/.config/nvim/config/key_mappings.vim"

alias less='less -qR'
alias ls='ls -al'

alias gs='git status'
alias gd='git diff'

# vim
[[ -f $HOME/nvim-osx64/bin/nvim ]] && alias nvim=$HOME/nvim-osx64/bin/nvim
alias vim=nvim

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
function gpapd() {
  UPSTREAM_CONFIG=$(git config --list | grep 'remote.upstream' | wc -l | tr -d " ")
  if [[ $UPSTREAM_CONFIG -eq 0 ]]; then
    echo 'no upstream config.'
    return 1
  fi
  git pull upstream develop
  git push origin develop
}
