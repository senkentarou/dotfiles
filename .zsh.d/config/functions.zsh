# fzf
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}

function fzf_search_history() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 |
    FZF_DEFAULT_OPTS="--prompt='Command History > ' --layout='reverse' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle -N fzf_search_history
bindkey -M viins '^R' fzf_search_history

# Search a file with fzf inside a Tmux pane and then open it in an editor
function fzf_open_file_by_name() {
  local file=$(rg --files --hidden --glob '!.git' | FZF_DEFAULT_OPTS="--prompt='File Search > ' --layout='reverse' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd))

  zle reset-prompt

  if [ -n "$file" ]; then
    BUFFER="${EDITOR:-vim} $file"
  fi

  return 0
}
zle -N fzf_open_file_by_name
bindkey -M viins '^F' fzf_open_file_by_name

function fzf_open_file_by_chars() {
  read -r file line <<< "$(rg --glob '!.git' --line-number --invert-match '^\s*$' | FZF_DEFAULT_OPTS="--prompt='String Search > ' --layout='reverse' --height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS" $(__fzfcmd) --select-1 --exit-0 | awk -F: '{print $1, $2}')"

  zle reset-prompt

  if [ -n "$file" ] && [ -n "$line" ]; then
    BUFFER="${EDITOR:-vim} $file"
  fi

  return 0
}
zle -N fzf_open_file_by_chars
bindkey -M viins '^V' fzf_open_file_by_chars
