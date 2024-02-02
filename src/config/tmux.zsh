#!/usr/bin/env zsh 

# if then cmd `tmux` exists, and then load the flowing configure.
local hasTmux=$( whereis tmux )
hasTmux=${hasTmux#tmux:}
if [[ -n ${hasTmux} ]]; then
  # Set the default terminal to tmux-256color
  set -g default-terminal "tmux-256color"
fi