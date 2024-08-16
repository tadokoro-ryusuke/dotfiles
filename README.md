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
1. tpm
```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

1. 反映させる
```shell
source ~/.tmux.conf
source ~/.tmux.session.conf
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

## volta
1. install
```shell
curl https://get.volta.sh | bash # voltaのインストールコマンド (https://docs.volta.sh/guide/getting-started)
exec $SHELL -l # shellのリロード
volta -v # バージョンが表示されていればインストール成功
echo "export VOLTA_FEATURE_PNPM=1" >> ~/.zshrc
```

1. node install
```shell
volta install node # LTS が入る
```

1. pnpm instal
```shell
volta install pnpm
```

## pyenv
1. install
```shell
sudo apt update
sudo apt install build-essential libffi-dev libssl-dev zlib1g-dev liblzma-dev libbz2-dev \
  libreadline-dev libsqlite3-dev libopencv-dev tk-dev git

git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```

1. .zprofile に追加
```vim
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
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

## docker
1. package
```shell
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```
1. gpg キー追加
```shell
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
```
1. 鍵確認
```shell
sudo apt-key fingerprint 0EBFCD88
```
1. リポジトリ追加
```shell
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
```
1. install
```shell
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

## postgresql
1. install
```shell
sudo apt-get install postgresql-client
```
