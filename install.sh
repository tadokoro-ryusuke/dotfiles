#!/usr/bin/env bash

set -euo pipefail

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 色なし

# ログ出力関数
info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

# このスクリプトのディレクトリを取得
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# バックアップディレクトリを作成
create_backup() {
    info "バックアップディレクトリを作成: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
}

# 既存ファイルのバックアップ
backup_file() {
    local file="$1"
    if [[ -e "$file" ]]; then
        info "既存の$fileをバックアップ中"
        cp -r "$file" "$BACKUP_DIR/"
    fi
}

# シンボリックリンクを作成
create_symlink() {
    local source="$1"
    local target="$2"
    
    # 既存のシンボリックリンクを削除または既存ファイルをバックアップ
    if [[ -L "$target" ]]; then
        rm "$target"
    elif [[ -e "$target" ]]; then
        backup_file "$target"
        rm -rf "$target"
    fi
    
    # 必要に応じてディレクトリを作成
    mkdir -p "$(dirname "$target")"
    
    # シンボリックリンクを作成
    ln -s "$source" "$target"
    success "シンボリックリンクを作成しました: $target -> $source"
}

# パッケージマネージャーのインストール
install_package_managers() {
    info "パッケージマネージャーをインストール中..."
    
    # Homebrewのインストール（macOS/Linux）
    if ! command -v brew &> /dev/null && [[ "$OSTYPE" == "darwin"* ]]; then
        info "Homebrewをインストール中..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        success "Homebrewは既にインストールされているか、macOSではありません"
    fi
    
    # Voltaのインストール（Node.jsバージョン管理）
    if ! command -v volta &> /dev/null; then
        info "Voltaをインストール中..."
        curl https://get.volta.sh | bash
        export VOLTA_HOME="$HOME/.volta"
        export PATH="$VOLTA_HOME/bin:$PATH"
    else
        success "Voltaは既にインストールされています"
    fi
    
    # pyenvのインストール（Pythonバージョン管理）
    if ! command -v pyenv &> /dev/null; then
        info "pyenvをインストール中..."
        git clone https://github.com/pyenv/pyenv.git ~/.pyenv
        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
    else
        success "pyenvは既にインストールされています"
    fi
    
    # tfenvのインストール（Terraformバージョン管理）
    if ! command -v tfenv &> /dev/null; then
        info "tfenvをインストール中..."
        git clone https://github.com/tfutils/tfenv.git ~/.tfenv
        export PATH="$HOME/.tfenv/bin:$PATH"
    else
        success "tfenvは既にインストールされています"
    fi
    
    # phpenvのインストール（PHPバージョン管理）- オプション
    if [[ "${INSTALL_PHPENV:-false}" == "true" ]]; then
        if ! command -v phpenv &> /dev/null; then
            info "phpenvをインストール中..."
            git clone https://github.com/phpenv/phpenv.git ~/.phpenv
            export PHPENV_ROOT="$HOME/.phpenv"
            export PATH="$PHPENV_ROOT/bin:$PATH"
        else
            success "phpenvは既にインストールされています"
        fi
    fi
}

# 必須パッケージのインストール
install_packages() {
    info "必須パッケージをインストール中..."
    
    # OSを検出
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        if command -v apt &> /dev/null; then
            # Debian/Ubuntu
            sudo apt update
            sudo apt install -y \
                curl \
                git \
                vim \
                tmux \
                zsh \
                ripgrep \
                fd-find \
                bat \
                htop \
                jq \
                build-essential \
                direnv \
                ctags \
                wget
        elif command -v dnf &> /dev/null; then
            # Fedora
            sudo dnf install -y \
                curl \
                git \
                vim \
                tmux \
                zsh \
                ripgrep \
                fd-find \
                bat \
                htop \
                jq \
                gcc \
                make
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        brew install \
            git \
            vim \
            tmux \
            zsh \
            ripgrep \
            fd \
            bat \
            htop \
            jq \
            starship
    fi
}

# Zshプラグインのインストール
install_zsh_plugins() {
    info "Zshプラグインをインストール中..."
    
    # Zinitのインストール
    ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
    if [[ ! -d "$ZINIT_HOME" ]]; then
        mkdir -p "$(dirname $ZINIT_HOME)"
        git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
        success "Zinitをインストールしました"
    else
        success "Zinitは既にインストールされています"
    fi
    
    # Powerlevel10kフォントのインストール
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew tap homebrew/cask-fonts
        brew install --cask font-meslo-lg-nerd-font
    fi
}

# tmuxプラグインマネージャーのインストール
install_tmux_plugins() {
    info "tmuxプラグインマネージャーをインストール中..."
    
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
        success "TPMをインストールしました"
    else
        success "TPMは既にインストールされています"
    fi
}

# dotfilesのセットアップ
setup_dotfiles() {
    info "dotfilesをセットアップ中..."
    
    create_backup
    
    # Zsh
    create_symlink "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc"
    create_symlink "$SCRIPT_DIR/zsh/.zprofile" "$HOME/.zprofile"
    create_symlink "$SCRIPT_DIR/zsh/.zshenv" "$HOME/.zshenv"
    mkdir -p "$HOME/.config/zsh"
    create_symlink "$SCRIPT_DIR/zsh/aliases.zsh" "$HOME/.config/zsh/aliases.zsh"
    create_symlink "$SCRIPT_DIR/zsh/functions.zsh" "$HOME/.config/zsh/functions.zsh"
    create_symlink "$SCRIPT_DIR/zsh/completions.zsh" "$HOME/.config/zsh/completions.zsh"
    
    # Git
    create_symlink "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig"
    create_symlink "$SCRIPT_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
    
    # Vim
    create_symlink "$SCRIPT_DIR/vim/.vimrc" "$HOME/.vimrc"
    
    # Tmux
    create_symlink "$SCRIPT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
    create_symlink "$SCRIPT_DIR/tmux/.tmux.session.conf" "$HOME/.tmux.session.conf"
    create_symlink "$SCRIPT_DIR/tmux/.tmux.gcp.conf" "$HOME/.tmux.gcp.conf"
    
    # 設定ファイル
    mkdir -p "$HOME/.config"
    create_symlink "$SCRIPT_DIR/config/starship.toml" "$HOME/.config/starship.toml"
    create_symlink "$SCRIPT_DIR/config/wsl.zsh" "$HOME/.config/wsl.zsh"
    
    # 必要なディレクトリを作成
    mkdir -p "$HOME/.local/bin"
    mkdir -p "${XDG_STATE_HOME:-$HOME/.local/state}/zsh"
    
    # GitHub CLI
    if command -v gh &> /dev/null; then
        mkdir -p "$HOME/.config/gh"
        create_symlink "$SCRIPT_DIR/config/gh/config.yml" "$HOME/.config/gh/config.yml"
    fi
    
    # Claude CLI
    if command -v claude &> /dev/null || [[ -d "$HOME/.claude" ]]; then
        mkdir -p "$HOME/.claude"
        create_symlink "$SCRIPT_DIR/config/claude/settings.json" "$HOME/.claude/settings.json"
    fi
    
    # direnv
    if command -v direnv &> /dev/null; then
        mkdir -p "$HOME/.config/direnv"
        create_symlink "$SCRIPT_DIR/config/direnv/direnvrc" "$HOME/.config/direnv/direnvrc"
    fi
    
    # SSH設定
    mkdir -p "$HOME/.ssh/sockets"
    chmod 700 "$HOME/.ssh"
    info "SSH設定テンプレートの場所: $SCRIPT_DIR/ssh/config.template"
    
    # 検索ツールの無視ファイル
    create_symlink "$SCRIPT_DIR/.rgignore" "$HOME/.rgignore"
    create_symlink "$SCRIPT_DIR/.fdignore" "$HOME/.fdignore"
    
    # その他の設定ファイル
    create_symlink "$SCRIPT_DIR/.editorconfig" "$HOME/.editorconfig"
    create_symlink "$SCRIPT_DIR/.curlrc" "$HOME/.curlrc"
}

# Zshをデフォルトシェルに設定
set_default_shell() {
    info "Zshをデフォルトシェルに設定中..."
    
    if [[ "$SHELL" != "$(which zsh)" ]]; then
        chsh -s "$(which zsh)"
        success "デフォルトシェルをZshに変更しました"
    else
        success "Zshは既にデフォルトシェルです"
    fi
}

# メインインストール
main() {
    echo "======================================"
    echo "       Dotfilesインストール          "
    echo "======================================"
    echo
    
    # dotfilesディレクトリから実行されているか確認
    if [[ ! -f "$SCRIPT_DIR/install.sh" ]]; then
        error "dotfilesディレクトリからこのスクリプトを実行してください"
    fi
    
    # 確認を求める
    read -p "dotfilesをインストールし、既存ファイルを上書きする可能性があります。続行しますか？ (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        warning "インストールをキャンセルしました"
        exit 0
    fi
    
    # すべてをインストール
    install_package_managers
    install_packages
    install_zsh_plugins
    install_tmux_plugins
    setup_dotfiles
    set_default_shell
    
    echo
    success "dotfilesのインストールが完了しました！"
    echo
    info "既存ファイルのバックアップ保存先: $BACKUP_DIR"
    info "ターミナルを再起動するか、次のコマンドを実行してください: source ~/.zshrc"
    echo
    info "インストール後の手順:"
    echo "  1. 'p10k configure' を実行してPowerlevel10kプロンプトを設定"
    echo "  2. tmuxを開いて 'prefix + I' を押してtmuxプラグインをインストール"
    echo "  3. Gitに名前とメールアドレスを設定:"
    echo "     git config --global user.name \"あなたの名前\""
    echo "     git config --global user.email \"あなたのメール@example.com\""
    echo
    
    if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
        info "WSLを検出しました。追加手順:"
        echo "  1. 1Password SSH署名を使用する場合、git configを更新:"
        echo "     - SSH署名キーを設定"
        echo "     - op-ssh-sign-wslのパスを更新"
        echo "  2. より良い体験のためにWindows Terminalをインストール"
    fi
    echo
}

# メイン関数を実行
main "$@"