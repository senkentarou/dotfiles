#!/bin/bash

# Load util functions
. './scripts/utils.sh'

set_git_config() {
  echo_info 'setting git config ...'

  if ! is_exist_command 'git'; then
    echo_error "git command is not found."
    return 1
  fi

  if [ -z "$(git config --get user.email)" ]; then
    git config --global user.email 'senkentarou@gmail.com'
  fi
  if [ -z "$(git config --get user.name)" ]; then
    git config --global user.name 'senkentarou'
  fi

  git config --global core.editor 'vim -c "set fenc=utf-8"'
  git config --global url."git@github.com:".insteadOf "https://github.com/"
  git config --global merge.ff false
  git config --global pull.ff only

  if ! is_exist_command 'git-secrets'; then
    echo_error "git-secrets command is not found."
    return 1
  fi

  git secrets --register-aws --global
  git secrets --install ~/.git-templates/git-secrets
  git config --global init.templatedir "${HOME}/.git-templates/git-secrets"

  echo_success 'set git config.'
  return 0
}

setup_iterm2() {
  echo_info 'setting up iTerm2 keymaps ...'

  if [ "$(uname)" != "Darwin" ]; then
    echo_info "skipped (not macOS)."
    return 0
  fi

  if pgrep -q iTerm2; then
    echo_error "iTerm2 が起動中です。終了してから再実行してください。"
    return 1
  fi

  bash './scripts/setup_iterm2_keymaps.sh'

  echo_success 'set iTerm2 keymaps.'
  return 0
}

#
# Main procedure
#
set_git_config
setup_iterm2
