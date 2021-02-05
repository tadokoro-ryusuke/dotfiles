# 環境セットアップ

## 最初にインストール
```
sudo apt install git automake make gcc wget
```

## zsh
1. インストール
```shell
sudo apt update
sudo apt install zsh
```
1. 設定
```shell
chsh -s $(which zsh)
```

## prezroインストール
1. clone
```shell
git clone --recursive https://github.com/sorin-ionescu/prezto.git ${ZDOTDIR:-$HOME}/.zprezto
```
1. zshのEXTENDED_GLOBオプションを設定
```shell
setopt EXTENDED_GLOB
```
1. 設定ファイルを作成
```shell
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
```
1. `.zpreztorc` ファイルをコピー
```shell
cp .zpreztorc ~/
```
1. カスタムした `pure.zsh` をコピー
```shell
> cp .pure.zsh ~/.zprezto/modules/prompt/external/pure/
```

## tmux インストール
1. install
```shell
sudo apt install tmux
```
1. 設定ファイルのコピー
```shell
cp .tmux* ~/
```

## vim
1. dein install
```shell
mkdir -p ~/.cache/dein
cd ~/.cache/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
```
1. vimrc とかコピー
```shell
cp .vimrc ~/
cp -a .vim/ ~/
```

## nodenv
1. install
```shell
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src
```
1. path 通す
```shell
echo 'export PATH="$HOME/.nodenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(nodenv init -)"' >> ~/.zshrc
```
1. plugin 入れる
```shell
mkdir -p "$(nodenv root)"/plugins
```
1. build
```shell
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)"/plugins/nodenv-update
git clone https://github.com/pine/nodenv-yarn-install.git "$(nodenv root)/plugins/nodenv-yarn-install"
```

## pyenv
1. install
```shell
sudo apt-get install zlib1g-dev libssl-dev libsqlite3-dev libbz2-dev libncurses5-dev libgdbm-dev liblzma-dev libssl-dev tcl-dev tk-dev libreadline-dev
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
```

## rbenv
1. install
```shell
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```

## go
1. install
```shell
sudo tar -C /usr/local -xzf go1.11.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.11.5.linux-amd64.tar.gz
```
1. path 通す
```shell
export PATH=$PATH:/usr/local/go/bin
```

## the_platinum_searcher
1. install
```shell
go get -u github.com/monochromegane/the_platinum_searcher/...
```
