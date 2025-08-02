# Make directory and change into it
mkcd() {
  mkdir -p "$@" && cd "$@"
}

# Extract archives
extract() {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find and replace in files
findreplace() {
  if [ $# -lt 3 ]; then
    echo "Usage: findreplace <search> <replace> <path>"
    return 1
  fi
  find "$3" -type f -exec sed -i "s/$1/$2/g" {} +
}

# Create a backup of a file
backup() {
  if [ -f "$1" ]; then
    cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)"
    echo "Backup created: $1.bak.$(date +%Y%m%d_%H%M%S)"
  else
    echo "File not found: $1"
  fi
}

# Show directory tree
tree() {
  if command -v tree &> /dev/null; then
    command tree "$@"
  else
    find ${1:-.} -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
  fi
}

# Quick git commit
gquick() {
  git add -A && git commit -m "${1:-'Quick commit'}" && git push
}

# Docker cleanup
docker-cleanup() {
  echo "Removing stopped containers..."
  docker container prune -f
  echo "Removing unused images..."
  docker image prune -f
  echo "Removing unused volumes..."
  docker volume prune -f
  echo "Removing unused networks..."
  docker network prune -f
}

# Show port usage
port() {
  if [ -z "$1" ]; then
    echo "Usage: port <port_number>"
    return 1
  fi
  sudo lsof -i :$1
}

# Weather
weather() {
  curl -s "wttr.in/${1:-Tokyo}?format=3"
}

# Simple HTTP server
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# URL encode/decode
urlencode() {
  python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$1"
}

urldecode() {
  python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))" "$1"
}

# JSON pretty print
json() {
  if [ -t 0 ]; then
    python3 -m json.tool "$@"
  else
    python3 -m json.tool
  fi
}

# Show colors
colors() {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done
}