#
# bind
#

fzf_history() {
	local hist
	hist=$(HISTTIMEFORMAT='' history | gsed -e 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | sort -u | fzf --select-1 --reverse --height 30% --query "$READLINE_LINE")
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${hist}${READLINE_LINE:$READLINE_POINT}"
	READLINE_POINT=$((READLINE_POINT + ${#hist}))
}
bind -x '"\C-r": fzf_history'
