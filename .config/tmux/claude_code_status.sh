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

      # CPU使用率とメモリ使用率を取得（スペース区切りで取得）
      proc_stats=$(ps -p "$claude_pid" -o %cpu= -o %mem= 2>/dev/null)
      if [ -n "$proc_stats" ]; then
        read -r cpu mem <<<"$proc_stats"

        # 情報を整形して追加
        if [ -n "$claude_info" ]; then
          claude_info+=", "
        fi
        claude_info+="${pane_id} cpu${cpu}% mem${mem}%"
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
