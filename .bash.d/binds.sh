#
# bind
#

bh_select_history() {
	local selected
	selected="$(bh </dev/tty 2>/dev/tty)"
	if [ -n "$selected" ]; then
		READLINE_LINE="$selected"
		READLINE_POINT=${#selected}
	fi
}
bind -x '"\C-r": bh_select_history'
