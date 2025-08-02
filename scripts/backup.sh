#!/usr/bin/env bash

set -euo pipefail

# 色定義
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # 色なし

# 設定
BACKUP_DIR="$HOME/.dotfiles_backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
CURRENT_BACKUP="$BACKUP_DIR/backup_$TIMESTAMP"

# バックアップ対象ファイル
DOTFILES=(
    "$HOME/.zshrc"
    "$HOME/.zprofile"
    "$HOME/.zshenv"
    "$HOME/.config/zsh"
    "$HOME/.gitconfig"
    "$HOME/.gitignore_global"
    "$HOME/.vimrc"
    "$HOME/.vim"
    "$HOME/.tmux.conf"
    "$HOME/.tmux"
    "$HOME/.config/starship.toml"
    "$HOME/.bashrc"
    "$HOME/.bash_profile"
    "$HOME/.profile"
)

# バックアップディレクトリを作成
mkdir -p "$CURRENT_BACKUP"

echo -e "${BLUE}dotfilesのバックアップを開始します...${NC}"
echo "バックアップ先: $CURRENT_BACKUP"
echo

# 各ファイル/ディレクトリをバックアップ
for item in "${DOTFILES[@]}"; do
    if [[ -e "$item" ]]; then
        # ホームディレクトリからの相対パスを取得
        relative_path="${item#$HOME/}"
        target_dir="$CURRENT_BACKUP/$(dirname "$relative_path")"
        
        # ターゲットディレクトリを作成
        mkdir -p "$target_dir"
        
        # ファイル/ディレクトリをコピー
        cp -r "$item" "$target_dir/"
        echo -e "${GREEN}✓${NC} バックアップ完了: $item"
    else
        echo -e "${YELLOW}⚠${NC} スキップ（見つかりません）: $item"
    fi
done

# 圧縮アーカイブを作成
echo
echo -e "${BLUE}圧縮アーカイブを作成中...${NC}"
cd "$BACKUP_DIR"
tar -czf "backup_$TIMESTAMP.tar.gz" "backup_$TIMESTAMP"
rm -rf "backup_$TIMESTAMP"

# 最新5件のバックアップを保持
echo
echo -e "${BLUE}古いバックアップを削除中...${NC}"
ls -t "$BACKUP_DIR"/backup_*.tar.gz 2>/dev/null | tail -n +6 | xargs -r rm

echo
echo -e "${GREEN}バックアップが正常に完了しました！${NC}"
echo "アーカイブ: $BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# バックアップサイズを表示
size=$(du -h "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" | cut -f1)
echo "サイズ: $size"