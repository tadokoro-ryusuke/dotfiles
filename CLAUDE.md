# Dotfiles Project

このプロジェクトは個人の開発環境設定（dotfiles）を管理するリポジトリです。

## 主な特徴

- **モダンなツールへの移行**: Prezto → Zinit、Pure → Powerlevel10k
- **WSL対応**: Windows Subsystem for Linux での使用を想定
- **1Password統合**: Git SSH署名のサポート
- **自動セットアップ**: `./install.sh` で環境構築を自動化

## ディレクトリ構成

- `zsh/`: Zshシェル設定
- `git/`: Git設定（1Password SSH署名対応）
- `vim/`: Vim設定
- `tmux/`: tmux設定（カスタムセッション含む）
- `config/`: その他の設定（Starship、WSL）
- `scripts/`: ユーティリティスクリプト
- `install.sh`: 自動インストールスクリプト

## 使用方法

```bash
./install.sh
```

インストール後、必要に応じて個人設定を調整してください。