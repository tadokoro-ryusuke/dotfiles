#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
setopt nonomatch

HISTSIZE=5000       	  # 現在使用中のbashが保持する履歴数
HISTFILESIZE=5000   	  # 履歴ファイルに保存される履歴数
HISTCONTROL=ignoredups  # 同じコマンドが連続する場合は1回だけ記録する
# HISTCONTROL=ignorespace # コマンドの頭にスペースを付けて実行すると記録しない
HISTCONTROL=ignoreboth    # ignoredupsとignorespaceどちらも設定する
HISTIGNORE=history     	  # historyは記録しない

alias tmuxg='tmux new-session \; source-file ~/.tmux.session.conf'
alias tmuxr='tmux new-session \; source-file ~/.tmux.gcp.conf'
alias llt='ls -lt'

alias ctag='ctags -R --languages=Java,Python,typescript,JavaScript,C\#'
alias gcl="git branch | grep -v 'develop' | grep -v '*' | grep -v 'main' | xargs git branch -D"

# gcp
alias poshiri-start='gcloud compute instances start poshiri-development'
alias poshiri-stop='gcloud compute instances stop poshiri-development'

# 1password ssh alias for windows
alias ssh='ssh.exe'
alias ssh-add='ssh-add.exe'
