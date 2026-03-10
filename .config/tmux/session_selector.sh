#!/bin/bash
# Session selector: pick from predefined + active sessions.
# Ctrl-N to create a new session from current directory.
# Usage: session_selector.sh [current_pane_path]

DEFAULTS=("main" "research" "review" "worktree" "help")

pane_path="${1:-}"
dir_name=""
dir_path=""
if [ -n "$pane_path" ]; then
  dir_name=$(basename "$pane_path" | tr '.' '-')
  dir_path="$pane_path"
fi

current_session=$(tmux display-message -p '#{session_name}' 2>/dev/null)

# Collect active sessions not in the default list (and not the dir_name),
# limited to sessions whose starting directory is a git repo root
active_sessions=()
while IFS=$'\t' read -r name spath; do
  for d in "${DEFAULTS[@]}"; do
    [[ "$name" == "$d" ]] && continue 2
  done
  [[ "$name" == "$dir_name" ]] && continue
  [[ -d "$spath/.git" ]] || continue
  active_sessions+=("$name")
done < <(tmux list-sessions -F '#{session_name}	#{session_path}' 2>/dev/null)

# Build candidate list: active sessions first, then inactive presets (exclude current)
active_candidates=()
inactive_candidates=()

# Add current directory only if it's a git repo root and session already exists
if [ -n "$dir_name" ] && [ "$dir_name" != "$current_session" ] && [ -d "$pane_path/.git" ]; then
  if tmux has-session -t "=$dir_name" 2>/dev/null; then
    active_candidates+=("● $dir_name")
  fi
fi

for d in "${DEFAULTS[@]}"; do
  [[ "$d" == "$current_session" ]] && continue
  if tmux has-session -t "=$d" 2>/dev/null; then
    active_candidates+=("● $d")
  else
    inactive_candidates+=("○ $d")
  fi
done

for s in "${active_sessions[@]}"; do
  [[ "$s" == "$current_session" ]] && continue
  active_candidates+=("● $s")
done

candidates=("${active_candidates[@]}" "${inactive_candidates[@]}")

# Footer hint for ctrl-n
footer_cwd=""
if [ -n "$dir_name" ]; then
  footer_cwd="  C-n: new '$dir_name'"
fi

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
    --footer=" ● active  ○ preset${footer_cwd} " \
    --footer-border=none \
    --bind='alt-q:abort' \
    --bind="ctrl-n:print-query" \
    --expect=ctrl-n
) || true

# Parse fzf output: first line is the key pressed (from --expect), second is the selection
key=$(echo "$selected" | head -1)
choice=$(echo "$selected" | tail -1)

if [ "$key" = "ctrl-n" ]; then
  # Create session from current directory
  if [ -n "$dir_name" ] && [ -n "$dir_path" ]; then
    if tmux has-session -t "=$dir_name" 2>/dev/null; then
      tmux switch-client -t "=$dir_name"
    else
      tmux new-session -d -s "$dir_name" -c "$dir_path" && tmux switch-client -t "=$dir_name"
    fi
  fi
elif [ -n "$choice" ]; then
  # Strip prefix (● ○ and space)
  name=$(echo "$choice" | sed 's/^[●○ ]*//')
  if [ -n "$name" ]; then
    if tmux has-session -t "=$name" 2>/dev/null; then
      tmux switch-client -t "=$name"
    else
      tmux new-session -d -s "$name" && tmux switch-client -t "=$name"
    fi
  fi
fi
