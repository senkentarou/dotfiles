### 導入方法
1. TODO

### nvimの設定

1. 初回起動時にvim-plugの設定が入っていない場合はダウンロードしてくる必要がある。
https://github.com/junegunn/vim-plug
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
2. nvimを開けたら、コマンドから`PlugInstall`を実行する
```
:PlugInstall
```
3. Defxを使用する場合は`python3`がnvim上で使える必要がある。
  * nvim上で:echo has('python3')をして1が返るとOK
```
pip3 install pynvim
```

### aquaSKKの設定
1. `aquaSKK`フォルダを開く
```
open aquaSKK
```
2. 設定ファイルがあるフォルダを開いてコピペする
https://aquaskk.osdn.jp/folders_and_files.html
```
open ~/Library/Application\ Support/AquaSKK
```
3. iTerm2を使用している場合は日本語切り替えに指定しているショートカットがデフォルトで反応しないので設定する
```
iTerm2 > Preferences > Advanced > aquaSKKで検索
```

### トラブルシューティング
  * nvimで何かしらのエラーが出ている。
    * `:checkhealth`でエラー内容を確認する。
