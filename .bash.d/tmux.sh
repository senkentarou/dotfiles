# only attach on tmux
if [ ! -n "$TMUX" ]; then
  return
fi

_tmux_reattach() {
  local remaining_panes
  remaining_panes=$(tmux list-panes 2>/dev/null | wc -l)

  if [[ $remaining_panes -le 1 ]]; then
    local current_session
    current_session=$(tmux display-message -p '#S' 2>/dev/null)

    local current_window
    current_window=$(tmux display-message -p '#I' 2>/dev/null)

    # Check if there are other windows in the same session
    local other_window
    other_window=$(tmux list-windows -t "$current_session" -F "#{window_index}" 2>/dev/null | grep -v "^${current_window}$" | sort -rn | head -1)

    if [[ -n "$other_window" ]]; then
      exec tmux select-window -t "${current_session}:${other_window}"
    else
      # If no other window in current session, switch to another session
      local other_session
      other_session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -v "^${current_session}$" | head -1)

      if [[ -n "$other_session" ]]; then
        exec tmux switch-client -t "$other_session"
      fi
    fi
  fi
}
trap '_tmux_reattach' EXIT
