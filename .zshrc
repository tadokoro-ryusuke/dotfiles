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

alias mitsuridb='cd /Users/poshiri/work/mitsuri-2/;docker-compose exec db psql -U mitsuri'
alias mitsuritestdb='psql -h mitsuri-test-db.c6lnashhzrjc.ap-northeast-1.rds.amazonaws.com -U postgres -p 5432 -d mitsuri'
alias mitsuriproddb='psql -h mitsuri-db.c6lnashhzrjc.ap-northeast-1.rds.amazonaws.com -U mitsuri -p 5432 -d mitsuri'

# mitsuri
alias m_up='~/work/mitsuri-2/;docker-compose up rabbit_mq db dummy_smtp request_project_handler identity_service edit_project_handler scheduler;'
alias m_down='~/work/mitsuri-2/;docker-compose down;'

# db migration
alias dbmig='export PYTHONPATH=.; export FLASK_APP=projects/service/app.py; export CONNECTION_STRING=postgres://mitsuri:BNMXTEQzHbXWgjYSzvTs8NUN3fxxav35@localhost:5432/mitsuri; export OIDC_CLIENT_SECRETS=projects/service/auth-local.json; flask db migrate -m $1'
alias dbup='export PYTHONPATH=.; export FLASK_APP=projects/service/app.py; export CONNECTION_STRING=postgres://mitsuri:BNMXTEQzHbXWgjYSzvTs8NUN3fxxav35@localhost:5432/mitsuri; export OIDC_CLIENT_SECRETS=projects/service/auth-local.json; flask db upgrade'
alias dbdown='export PYTHONPATH=.; export FLASK_APP=projects/service/app.py; export CONNECTION_STRING=postgres://mitsuri:BNMXTEQzHbXWgjYSzvTs8NUN3fxxav35@localhost:5432/mitsuri; export OIDC_CLIENT_SECRETS=projects/service/auth-local.json; flask db downgrade'

# mitsuri-2 start
alias m2start='tmux source-file ~/.tmux.mitsuri-2-start.conf'

# ssh
alias mitsuri-jenkins='sudo ssh -i ~/.ssh/mitsuri-jenkins.pem ec2-user@54.238.93.229'
alias bluem1='ssh -i ~/.ssh/mitsuri-blue-keypair.pem docker@3.113.70.163'
#alias bluem2='ssh -i ~/.ssh/mitsuri-blue-keypair.pem docker@18.179.25.101'
#alias bluem3='ssh -i ~/.ssh/mitsuri-blue-keypair.pem docker@54.250.202.68'

alias bluew1='ssh -i ~/.ssh/mitsuri-blue-keypair.pem docker@54.238.212.149'

alias greenm1='ssh -i ~/.ssh/russell-mitsuri.pem docker@18.176.150.51'
alias greenm2='ssh -i ~/.ssh/russell-mitsuri.pem docker@18.176.181.211'
alias greenm3='ssh -i ~/.ssh/russell-mitsuri.pem docker@3.115.168.121'

alias mitsuri-reverce='ssh -i ~/.ssh/mitsuri-reverse-proxy.pem ubuntu@3.114.215.103'

alias mitsuri1='ssh ubuntu@mitsu-ri.net'

HISTSIZE=5000       	  # 現在使用中のbashが保持する履歴数
HISTFILESIZE=5000   	  # 履歴ファイルに保存される履歴数
# HISTCONTROL=ignoredups  # 同じコマンドが連続する場合は1回だけ記録する
# HISTCONTROL=ignorespace # コマンドの頭にスペースを付けて実行すると記録しない
HISTCONTROL=ignoreboth    # ignoredupsとignorespaceどちらも設定する
HISTIGNORE=history     	  # historyは記録しない

alias tmuxg='tmux new-session \; source-file ~/.tmux.session.conf'
alias tmuxr='tmux new-session \; source-file ~/.tmux.gcp.conf'
alias llt='ls -lt'

alias ctag='ctags -R --languages=Java,Python,typescript,JavaScript,C\#'
alias gcl="git branch | grep -v 'develop' | grep -v '*' | grep -v 'main' | xargs git branch -D"

alias poshiri="ssh poshiri@35.243.96.209 -i ~/.ssh/id_rsa"
alias remote-dev="ssh poshiri@34.85.12.147 -i ~/.ssh/id_rsa"
alias poshiri-dev="ssh poshiri@34.85.12.147 -i ~/.ssh/id_rsa"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/poshiri/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/poshiri/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/poshiri/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/poshiri/tmp/google-cloud-sdk/completion.zsh.inc'; fi

alias catallaxy-start='gcloud compute instances start dev-tdkr'
alias catallaxy-stop='gcloud compute instances stop dev-tdkr'
alias poshiri-start='gcloud compute instances start poshiri-development'
alias poshiri-stop='gcloud compute instances stop poshiri-development'
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

export ANDROID_SDK="/Users/poshiri/Library/Android/sdk"
export PATH="/Users/poshiri/Library/Android/sdk/platform-tools:$PATH"

# pnpm
export PNPM_HOME="/Users/poshiri/.pnpm/store"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
