# 環境セットアップ

## 最初にインストール
```
> sudo apt install git
```

## zsh
1. インストール
```shell
> sudo apt update
> sudo apt install zsh
```
1. 設定
```shell
> chsh -s $(which zsh)
```

## prezroインストール
1. clone
```shell
> git clone --recursive https://github.com/sorin-ionescu/prezto.git ${ZDOTDIR:-$HOME}/.zprezto
```
1. zshのEXTENDED_GLOBオプションを設定
```shell
> setopt EXTENDED_GLOB
```
1. 設定ファイルを作成
```shell
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```
