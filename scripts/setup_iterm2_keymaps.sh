#!/bin/bash
# iTerm2 に Cmd+1..9 → tmux ウィンドウ切替用のエスケープシーケンスを一括登録する
# 使い方: iTerm2 を終了してから実行し、再度 iTerm2 を起動する

set -euo pipefail

PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
PB=/usr/libexec/PlistBuddy
PROFILE_IDX=0
KM="New Bookmarks:${PROFILE_IDX}:Keyboard Map"

if pgrep -q iTerm2; then
  echo "⚠  iTerm2 が起動中です。終了してから再実行してください。"
  exit 1
fi

# ── Navigation Shortcuts を無効化 (No Shortcut = 9) ──
# Cmd+N がキーバインドと競合するため、すべて無効にする
defaults write com.googlecode.iterm2 SwitchWindowModifier -int 9
defaults write com.googlecode.iterm2 SwitchTabModifier -int 9
defaults write com.googlecode.iterm2 SwitchPaneModifier -int 9
echo "🚫 Navigation Shortcuts を無効化しました"

# ── タブが1つの時はタブバーを非表示 (tmux でウィンドウ管理するため) ──
defaults write com.googlecode.iterm2 HideTab -bool true
# ── タブ番号を非表示 ──
defaults write com.googlecode.iterm2 HideTabNumber -bool true
echo "🚫 タブバー設定を適用しました（単一タブ非表示・タブ番号非表示）"

# Cmd+1 (0x31) .. Cmd+9 (0x39), Command modifier = 0x100000
# Action 10 = Send Escape Sequence
for i in $(seq 1 9); do
  hex=$(printf "0x%x" $((0x30 + i)))
  key="${hex}-0x100000"
  seq="[9${i}~"

  # エントリが既にあれば削除して再作成
  $PB -c "Delete ':${KM}:${key}'" "$PLIST" 2>/dev/null || true
  $PB -c "Add ':${KM}:${key}' dict" "$PLIST"
  $PB -c "Add ':${KM}:${key}:Action' integer 10" "$PLIST"
  $PB -c "Add ':${KM}:${key}:Text' string '${seq}'" "$PLIST"

  echo "  Cmd+${i} → ESC ${seq}"
done

echo "✅ 完了。iTerm2 を起動してください。"
