#!/usr/bin/env zsh

# Set default editor
export EDITOR='vim'
export VISUAL='vim'

# Set language
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Pager
export PAGER='less'
export LESS='-R'

# Terminal
export TERM='xterm-256color'

# Browser
if [[ "$OSTYPE" == linux* ]]; then
  export BROWSER='xdg-open'
elif [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

# WSL specific settings
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  # WSL2 specific settings
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
  export LIBGL_ALWAYS_INDIRECT=1
fi

# Set PATH, MANPATH, etc., for Homebrew if it exists
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi