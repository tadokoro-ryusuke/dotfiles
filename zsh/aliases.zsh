# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ~='cd ~'
alias -- -='cd -'

# List directory contents
alias ls='ls --color=auto'
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias lt='ls -lt'
alias ltr='ls -ltr'

# File operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# Grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias rg='rg --smart-case'

# System
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias top='htop'
alias ps='ps aux'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'

# Network
alias ip='ip -c'
alias ports='netstat -tulanp'
alias listening='ss -tulpn'

# Package management
if command -v apt &> /dev/null; then
  alias apt-update='sudo apt update'
  alias apt-upgrade='sudo apt upgrade'
  alias apt-install='sudo apt install'
  alias apt-search='apt search'
  alias apt-remove='sudo apt remove'
fi

# Docker
alias d='docker'
alias dc='docker compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dexec='docker exec -it'
alias dlogs='docker logs -f'

# Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git pull'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias gp='git push'
alias gst='git status'
alias gss='git status -s'

# Kubernetes
alias k='kubectl'
alias kg='kubectl get'
alias kd='kubectl describe'
alias kl='kubectl logs'
alias kx='kubectl exec -it'
alias ka='kubectl apply -f'
alias kdel='kubectl delete'

# Terraform
alias tf='terraform'
alias tfi='terraform init'
alias tfp='terraform plan'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tfv='terraform validate'
alias tff='terraform fmt'

# Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'

# Node.js
alias ni='npm install'
alias nid='npm install --save-dev'
alias nig='npm install -g'
alias nr='npm run'
alias ns='npm start'
alias nt='npm test'
alias nb='npm run build'
alias nd='npm run dev'

# Misc
alias h='history'
alias j='jobs -l'
alias which='type -a'
alias path='echo -e ${PATH//:/\\n}'
alias reload='exec $SHELL -l'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias week='date +%V'
alias myip='curl -s ifconfig.me'
alias localip='hostname -I | cut -d" " -f1'

# Custom aliases
alias llt='ls -lt'
alias ctag='ctags -R --languages=Java,Python,typescript,JavaScript,C\#'
alias gcl="git branch | grep -v 'develop' | grep -v '*' | grep -v 'main' | xargs git branch -D"

# tmux
alias tmuxg='tmux new-session \; source-file ~/.tmux.session.conf'
alias tmuxr='tmux new-session \; source-file ~/.tmux.gcp.conf'

# GCP
alias poshiri-start='gcloud compute instances start poshiri-development'
alias poshiri-stop='gcloud compute instances stop poshiri-development'

# Custom tools
alias claude='$HOME/.claude/local/claude'
alias task='$HOME/.local/bin/task'

# Gemini CLI (Web検索用)
alias gemini-search='gemini --prompt "WebSearch: "'
alias gs-tech='gemini --prompt "WebSearch: technical documentation "'
alias gs-error='gemini --prompt "WebSearch: error solution "'