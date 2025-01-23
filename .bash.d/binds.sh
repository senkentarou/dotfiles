#
# bind
#

fzf_select_file() {
	local file
	file=$(fzf --select-1 --reverse --height 30% | xargs -I{} echo vim {})
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${file}${READLINE_LINE:$READLINE_POINT}"
	READLINE_POINT=$((READLINE_POINT + ${#file}))
}
bind -x '"\C-f": fzf_select_file'

fzf_select_history() {
	local sed
	if [ -n "$(command -v gsed 2>/dev/null)" ]; then
		sed='gsed'
	else
		sed='sed'
	fi

	local hist
	hist=$(HISTTIMEFORMAT='' history | $sed -e 's/^[[:space:]]*[0-9]\+[[:space:]]*//' | sort -u | fzf --select-1 --reverse --height 30% --query "$READLINE_LINE")
	READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}${hist}${READLINE_LINE:$READLINE_POINT}"
	READLINE_POINT=$((READLINE_POINT + ${#hist}))
}
bind -x '"\C-r": fzf_select_history'
