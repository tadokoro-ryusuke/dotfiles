# Modern Dotfiles

現在の開発環境設定をベースに、よりモダンなツールへ移行した dotfiles セットアップです。

## 特徴

- 🚀 **モダンなツール**: Prezto → Zinit、Pure → Powerlevel10k への移行
- 📦 **整理された構造**: 設定ファイルがカテゴリ別に整理
- 🔧 **自動セットアップ**: ワンコマンドでインストール可能
- 💾 **バックアップ機能**: 既存の設定を自動バックアップ
- 🎨 **カスタマイズ可能**: 簡単に設定を追加・変更可能
- 🪟 **WSL 対応**: Windows Subsystem for Linux 固有の設定を含む
- 🔐 **1Password 統合**: Git SSH 署名のサポート

## ディレクトリ構造

```
dotfiles/
├── install.sh          # 自動セットアップスクリプト
├── zsh/               # Zsh関連設定
│   ├── .zshrc         # メイン設定（Zinit + Powerlevel10k）
│   ├── .zprofile
│   ├── .zshenv
│   ├── aliases.zsh    # カスタムエイリアス
│   ├── functions.zsh
│   └── completions.zsh
├── git/               # Git関連設定
│   ├── .gitconfig     # 1Password SSH署名対応
│   └── .gitignore_global
├── vim/               # Vim関連設定
│   └── .vimrc
├── tmux/              # tmux関連設定
│   ├── .tmux.conf
│   ├── .tmux.session.conf  # tmuxg用
│   └── .tmux.gcp.conf      # tmuxr用
├── config/            # アプリケーション設定
│   ├── starship.toml
│   ├── wsl.zsh        # WSL固有設定
│   ├── gh/            # GitHub CLI設定
│   │   └── config.yml
│   ├── claude/        # Claude CLI設定
│   │   └── settings.json
│   └── direnv/        # direnv設定
│       └── direnvrc
├── ssh/               # SSH設定
│   └── config.template
├── scripts/           # ユーティリティスクリプト
│   └── backup.sh
├── .editorconfig      # エディタ共通設定
├── .rgignore          # ripgrep無視設定
├── .fdignore          # fd無視設定
└── .curlrc            # cURLデフォルト設定
```

## クイックスタート

```bash
# リポジトリをクローン
git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles

# インストールスクリプトを実行
./install.sh
```

## インストール内容

自動インストールスクリプトは以下を実行します：

1. **バージョン管理ツールのインストール**

   - Volta (Node.js)
   - pyenv (Python)
   - tfenv (Terraform)
   - phpenv (PHP - オプション)

2. **必須パッケージのインストール**

   - Git, Vim, tmux, Zsh
   - ripgrep, fd, bat, htop, jq
   - direnv, ctags, wget
   - ビルドツール

3. **プラグインマネージャーのインストール**

   - Zinit (Zsh プラグイン管理)
   - TPM (tmux プラグイン管理)

4. **設定ファイルのシンボリックリンク作成**

5. **デフォルトシェルの変更** (Zsh に設定)

## インストール後の設定

### 1. Git 設定

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 2. Powerlevel10k 設定

```bash
p10k configure
```

### 3. tmux プラグインインストール

tmux を起動して `Ctrl+a` → `I` を押す

## バックアップ

既存の設定をバックアップ：

```bash
./scripts/backup.sh
```

バックアップは `~/.dotfiles_backups/` に保存されます。

## カスタマイズ

### ローカル設定

以下のファイルでローカル固有の設定を追加できます：

- `~/.zshrc.local` - Zsh のローカル設定

### エイリアスの追加

`zsh/aliases.zsh` にカスタムエイリアスを追加

### 関数の追加

`zsh/functions.zsh` にカスタム関数を追加

## トラブルシューティング

### フォントが正しく表示されない

Nerd Fonts をインストール：

```bash
# macOS
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

# Linux
# https://www.nerdfonts.com/ からダウンロード
```

### tmux のプレフィックスキー

デフォルトは `Ctrl+a` に設定されています。
`Ctrl+b` に戻す場合は `tmux/.tmux.conf` を編集してください。

## 含まれるツールと設定

### シェル環境

- **Zsh**: Zinit + Powerlevel10k（Prezto から移行）
- **履歴管理**: 拡張履歴設定（100,000 件保存）
- **補完**: 高度な補完設定

### 開発ツール

- **Node.js**: Volta（高速なバージョン管理）
- **Python**: pyenv
- **PHP**: phpenv（オプション）
- **Terraform**: tfenv
- **direnv**: プロジェクト別環境変数

### エディタ・ターミナル

- **Git**: 1Password SSH 署名対応、GitHub CLI 統合
- **Vim**: 基本設定 + ファイルタイプ別設定
- **tmux**: カスタムセッション設定（tmuxg, tmuxr）

### カスタムエイリアス

- `llt`: タイムスタンプ付き ls
- `gcl`: 開発ブランチ以外を一括削除
- `claude`, `task`: カスタムツール
- GCP 関連: `poshiri-start`, `poshiri-stop`
- Gemini 検索: `gemini-search`, `gs-tech`, `gs-error`

### WSL 固有機能

- Windows SSH 統合（1Password）
- X11 フォワーディング設定
- Windows/WSL 間のクリップボード連携

### 開発サポートツール

- **Claude CLI**: AI 開発アシスタント設定
- **direnv**: プロジェクト別環境変数管理
- **EditorConfig**: エディタ設定の統一
- **ripgrep/fd**: 高速検索ツール用 ignore 設定
- **cURL**: HTTP クライアントのデフォルト設定
- **SSH**: テンプレート設定（1Password 対応）
