#
# eval
#
if command -v fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd)"
fi

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"

  # Override zoxide's __zoxide_cd to integrate with fnm
  __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@"
    __fnm_use_if_file_found
  }
fi

if [ -z "$SSH_AUTH_SOCK" ]; then
  eval "$(ssh-agent -s)"
fi
