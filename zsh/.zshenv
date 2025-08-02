#!/usr/bin/env zsh

# Ensure path arrays do not contain duplicates
typeset -gU path fpath

# Set the list of directories that Zsh searches for programs
path=(
  $HOME/.local/bin
  $HOME/bin
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
  $path
)

# Skip global configuration files
setopt no_global_rcs