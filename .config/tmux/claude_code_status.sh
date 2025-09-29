#!/bin/bash

# claudeプロセスのPIDを取得
claude_pids=$(pgrep -f "claude")

if [ -z "$claude_pids" ]; then
	# claudeプロセスが存在しない場合
	echo "claude: ○ offline"
else
	# tmux pane情報を取得して配列に格納
	declare -A pane_info
	while IFS=' ' read -r tty pid session window pane; do
		# /dev/ttysXXX から ttysXXX を抽出
		tty_name=$(basename "$tty")
		pane_info["$pid"]="$session$window$pane:$tty_name"
	done < <(tmux list-panes -a -F '#{pane_tty} #{pane_pid} #{session_name} #{window_id} #{pane_id}' 2>/dev/null)

	# claudeプロセスの詳細情報を収集
	claude_info=""

	for claude_pid in $claude_pids; do
		# claudeプロセスの親PIDを取得
		ppid=$(ps -p "$claude_pid" -o ppid= 2>/dev/null | tr -d ' ')

		if [ -n "$ppid" ] && [ -n "${pane_info[$ppid]}" ]; then
			# pane情報を分解
			IFS=':' read -r pane_id tty_name <<<"${pane_info[$ppid]}"

			# CPU使用率を取得
			cpu=$(ps -p "$claude_pid" -o %cpu= 2>/dev/null | tr -d ' ')
			if [ -n "$cpu" ]; then
				# 情報を整形して追加
				if [ -n "$claude_info" ]; then
					claude_info+=", "
				fi

				# CPU使用率に基づいて色とステータスを決定
				cpu_float=$(echo "$cpu" | bc -l 2>/dev/null || echo "$cpu")
				if (($(echo "$cpu_float == 0" | bc -l 2>/dev/null || [ "$cpu" = "0.0" ]))); then
					status_color="#[fg=blue]○"
				elif (($(echo "$cpu_float <= 7" | bc -l 2>/dev/null || [ "${cpu%.*}" -le 7 ]))); then
					status_color="#[fg=green]◇"
				elif (($(echo "$cpu_float <= 100" | bc -l 2>/dev/null || [ "${cpu%.*}" -le 100 ]))); then
					status_color="#[fg=yellow]●"
				else
					status_color="#[fg=red,bold]◆"
				fi
				claude_info+="${pane_id} ${status_color} ${cpu}%#[default]"
			fi
		fi
	done

	# 結果を出力
	if [ -n "$claude_info" ]; then
		echo "claude: ● ($claude_info)"
	else
		# プロセスは存在するがtmux paneで実行されていない場合
		echo "claude: ● (not in tmux panes)"
	fi
fi
