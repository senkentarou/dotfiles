## 動作確認環境
- macOS (Venture)

## 導入方法
- 初期セットアップ直後を想定する。
1. Terminal.appを開く
2. xcodeをインストールする。 (取り急ぎ `git` を実行するとインストールを促されるのでそれでもOK)
```
xcode-select --install
```
3. dotfilesを手元に落とす。(git submoduleを利用しているので--recursiveを付ける)
```
git clone --recursive https://github.com/senkentarou/dotfiles.git
```
4. リポジトリルートで `make` コマンドを実行すると以下の要素が順に処理される。(途中でパスワード入力が必要・ユーザ入力が必要な場合がある)
  - 使用するアプリをインストール `make install`
  - アプリをセットアップ `make setup`
  - dotfilesをローカルにリンク `make link`

## bashの設定
- 履歴検索にREADLINE_LINEとREADLINE_POINTを利用しているため古いbashだと正常動作しない可能性がある (Bash 4.0以上が必要)
1. `brew install bash` でbashをインストール
2. `which bash` でインストール先を確認
3. `sudo vim /etc/shells` を開き、bashのインストール先のパスを追加
4. `chpass -s /opt/homebrew/bin/bash` で切り替える

## nvimの設定
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
3. tree-sitterやmasonなどデフォルトでプラグインのインストールが実行されるものがあるので正常終了することを確認する

## aquaSKKの設定
1. [AquaSKK](https://github.com/codefirst/aquaskk)の最新リリースをインストールする
2. リポジトリルートにある`aquaSKK`フォルダを開く
```
open aquaSKK
```
3. 設定ファイルがあるフォルダを開いてコピペする (存在しない場合はフォルダを先に作成する)
参考: https://aquaskk.osdn.jp/folders_and_files.html
```
open ~/Library/Application\ Support/AquaSKK
```
4. macの入力ソースをaaquaSKKquaSKKが提供する「ASCII」と「AquaSKK統合」のみに変更する
5. 入力ソースを選択して「設定ファイルの再読み込み」を実行する

## iTerm2の設定
1. nvimを使用する際、Hack Nerd Fontでないと文字化けするので設定する
```
iTerm2 > Preferences > Profiles > Text > Hack Nerd Font
```
2. AquaSKKを使用する際、日本語切り替えに指定しているショートカットがデフォルトで上手く処理してくれないので設定する
```
iTerm2 > Preferences > Advanced > AquaSKKで検索
```
3. option keyをmeta keyとして認識させるために
```
iTerm2 > Preferences > Profiles > Keys > Left Option KeyをNormalからEsc+に。(Right Option Keyも同様)
```
