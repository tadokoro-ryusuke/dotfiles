#!/usr/bin/env zsh

# Powerlevel10k インスタントプロンプトを有効化
# パスワード入力などの対話的な処理は、このブロックより上に記述する必要があります
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# XDG Base Directory 仕様に準拠したディレクトリ設定
export XDG_CONFIG_HOME="$HOME/.config"      # 設定ファイル
export XDG_CACHE_HOME="$HOME/.cache"        # キャッシュ
export XDG_DATA_HOME="$HOME/.local/share"   # データファイル
export XDG_STATE_HOME="$HOME/.local/state"  # 状態ファイル

# パス設定（重複を自動削除）
typeset -U path PATH
path=(
  $HOME/.local/bin         # ユーザーローカルバイナリ
  $HOME/.claude/local      # Claude CLI
  $HOME/tmp/ecspresso      # ecspresso
  /usr/local/{bin,sbin}    # システムローカル
  /usr/{bin,sbin}          # システム標準
  /{bin,sbin}              # システム基本
  $path
)

# シェルオプション
setopt nonomatch  # ワイルドカードがマッチしない場合もエラーにしない

# Zinit（プラグインマネージャー）のインストール
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  print -P "%F{33}▓▒░ %F{220}Zinitプラグインマネージャーをインストール中…%f"
  command mkdir -p "$(dirname $ZINIT_HOME)"
  command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
    print -P "%F{33}▓▒░ %F{34}インストール成功！%f%b" || \
    print -P "%F{160}▓▒░ インストール失敗。%f%b"
fi

source "${ZINIT_HOME}/zinit.zsh"

# テーマ（Powerlevel10k）
zinit ice depth=1
zinit light romkatv/powerlevel10k

# プラグイン（遅延読み込みで高速化）
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
    zsh-users/zsh-completions \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# 履歴設定
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"  # 履歴ファイルの場所
HISTSIZE=100000      # メモリ上の履歴数
SAVEHIST=100000      # ファイルに保存する履歴数
HISTFILESIZE=100000  # ファイルサイズ上限
setopt EXTENDED_HISTORY          # 履歴に実行時刻を記録
setopt SHARE_HISTORY             # 複数端末間で履歴を共有
setopt HIST_EXPIRE_DUPS_FIRST    # 重複する履歴は古いものから削除
setopt HIST_IGNORE_DUPS          # 直前と同じコマンドは記録しない
setopt HIST_IGNORE_ALL_DUPS      # 既存の履歴と重複したら古い方を削除
setopt HIST_FIND_NO_DUPS         # 履歴検索で重複を表示しない
setopt HIST_SAVE_NO_DUPS         # 重複する履歴は保存しない
setopt HIST_REDUCE_BLANKS        # 余分な空白を削除
setopt HIST_VERIFY               # 履歴展開後、すぐに実行せず編集可能にする
setopt HIST_IGNORE_SPACE         # スペースで始まるコマンドは記録しない

# 履歴ディレクトリがなければ作成
[[ ! -d "${HISTFILE:h}" ]] && mkdir -p "${HISTFILE:h}"

# ディレクトリ移動設定
setopt AUTO_CD              # ディレクトリ名だけで移動
setopt AUTO_PUSHD           # cd時に自動でディレクトリスタックに追加
setopt PUSHD_IGNORE_DUPS    # スタックに重複したディレクトリを追加しない
setopt PUSHD_SILENT         # pushdとpopdの出力を抑制

# 補完設定
zstyle ':completion:*' menu select                            # 補完候補をメニュー形式で表示
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'          # 大文字小文字を区別しない
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}        # 補完候補に色を付ける
zstyle ':completion:*' group-name ''                         # 補完グループを有効化
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'  # グループの説明文の書式

# キーバインド（Emacsスタイル）
bindkey -e
bindkey '^[[A' history-substring-search-up    # 上矢印: 履歴検索（前）
bindkey '^[[B' history-substring-search-down  # 下矢印: 履歴検索（次）
bindkey '^[[C' forward-char                   # 右矢印: カーソル右移動
bindkey '^[[D' backward-char                  # 左矢印: カーソル左移動

# 基本エイリアス
alias ls='ls --color=auto'       # ファイル一覧に色を付ける
alias ll='ls -alF'               # 詳細表示
alias la='ls -A'                 # 隠しファイルも表示
alias l='ls -CF'                 # コンパクト表示
alias grep='grep --color=auto'   # grepの結果に色を付ける
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Gitエイリアス
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gs='git status'

# カスタム関数を読み込み
[[ -f "$HOME/.config/zsh/functions.zsh" ]] && source "$HOME/.config/zsh/functions.zsh"

# カスタムエイリアスを読み込み
[[ -f "$HOME/.config/zsh/aliases.zsh" ]] && source "$HOME/.config/zsh/aliases.zsh"

# WSL固有の設定を読み込み
[[ -f "$HOME/.config/wsl.zsh" ]] && source "$HOME/.config/wsl.zsh"

# ローカル設定を読み込み（このファイルはgitで管理しない）
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# 開発ツール設定
# Volta (Node.js バージョン管理)
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export VOLTA_FEATURE_PNPM=1          # pnpmサポートを有効化

# Python (pyenv)
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv &> /dev/null && eval "$(pyenv init -)"

# PHP (phpenv)
export PHPENV_ROOT="$HOME/.phpenv"
if [ -d "${PHPENV_ROOT}" ]; then
  export PATH="${PHPENV_ROOT}/bin:$PATH"
  command -v phpenv &> /dev/null && eval "$(phpenv init -)"
fi

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Terraform (tfenv)
export PATH="$HOME/.tfenv/bin:$PATH"

# direnv (プロジェクト別環境変数)
command -v direnv &> /dev/null && eval "$(direnv hook zsh)"

# Powerlevel10k設定ファイルを読み込み
# カスタマイズは `p10k configure` を実行
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh