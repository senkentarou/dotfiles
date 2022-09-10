### 導入方法
1. 使用するアプリをインストール(パスワード入力が必要・ユーザ入力が必要な場合がある) `make install`
2. アプリをセットアップ `make setup`
3. dotfilesをローカルにリンク `make link`
4. ターミナルを再起動 `make reboot`
(上記全てをまとめて実行する `make all` or `make`)

### nvimの設定

1. 初回起動時にvim-plugの設定が入っていないエラーになる場合は先にダウンロードする
https://github.com/junegunn/vim-plug
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
2. nvimを開けたら、コマンドから`PlugInstall`を実行する
```
:PlugInstall
```

### aquaSKKの設定
0. [aquaSKK](https://github.com/codefirst/aquaskk)をインストールする

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
  * nvimで何かしらのエラーが出ている場合
    * `:checkhealth`でエラー内容を確認する。
