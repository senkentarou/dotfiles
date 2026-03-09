#!/bin/bash
# Session selector: pick from predefined + active sessions + current directory.
# If session exists, switch to it. Otherwise, create and switch.
# Usage: session_selector.sh [current_pane_path]

DEFAULTS=("main" "research" "review" "worktree")

pane_path="${1:-}"
dir_name=""
dir_path=""
if [ -n "$pane_path" ]; then
  dir_name=$(basename "$pane_path" | tr '.' '-')
  dir_path="$pane_path"
fi

current_session=$(tmux display-message -p '#{session_name}' 2>/dev/null)

# Collect active sessions not in the default list (and not the dir_name)
active_sessions=()
while IFS= read -r name; do
  for d in "${DEFAULTS[@]}"; do
    [[ "$name" == "$d" ]] && continue 2
  done
  [[ "$name" == "$dir_name" ]] && continue
  active_sessions+=("$name")
done < <(tmux list-sessions -F '#{session_name}' 2>/dev/null)

# Build candidate list: dir_name first, then defaults, then extras (exclude current session)
candidates=()

# Add current directory as first candidate
if [ -n "$dir_name" ] && [ "$dir_name" != "$current_session" ]; then
  if tmux has-session -t "=$dir_name" 2>/dev/null; then
    candidates+=("● $dir_name")
  else
    candidates+=("◆ $dir_name")
  fi
fi

for d in "${DEFAULTS[@]}"; do
  [[ "$d" == "$current_session" ]] && continue
  if tmux has-session -t "=$d" 2>/dev/null; then
    candidates+=("● $d")
  else
    candidates+=("○ $d")
  fi
done

for s in "${active_sessions[@]}"; do
  [[ "$s" == "$current_session" ]] && continue
  candidates+=("● $s")
done

selected=$(
  printf '%s\n' "${candidates[@]}" | fzf \
    --layout=reverse \
    --no-sort \
    --prompt="Session (now: $current_session) > " \
    --pointer='▶' \
    --highlight-line \
    --color='pointer:red,fg+:white,bg+:#333333,prompt:blue,border:grey' \
    --no-info \
    --border=rounded \
    --border-label=' tmux sessions ' \
    --border-label-pos=center \
    --footer=' ● active  ○ preset  ◆ cwd ' \
    --footer-border=none
) || true

# Strip prefix (● ○ ◆ and space)
name=$(echo "$selected" | sed 's/^[●○◆ ]*//')

if [ -n "$name" ]; then
  if tmux has-session -t "=$name" 2>/dev/null; then
    tmux switch-client -t "=$name"
  elif [ "$name" = "$dir_name" ] && [ -n "$dir_path" ]; then
    tmux new-session -d -s "$name" -c "$dir_path" && tmux switch-client -t "=$name"
  else
    tmux new-session -d -s "$name" && tmux switch-client -t "=$name"
  fi
fi
