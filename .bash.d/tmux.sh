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

		local other_session
		other_session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | grep -v "^${current_session}$" | head -1)

		if [[ -n "$other_session" ]]; then
			exec tmux switch-client -t "$other_session"
		fi
	fi
}
trap '_tmux_reattach' EXIT
