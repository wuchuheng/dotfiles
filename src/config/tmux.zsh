#!/usr/bin/env zsh 

# Lanch tmux.
function lanchTmux() {
  # if then cmd `tmux` exists, and then load the flowing configure.
  local hasTmux=$( whereis tmux )
  hasTmux=${hasTmux#tmux:}
  if [[ -n ${hasTmux} ]]; then
    # Set the default terminal to tmux-256color
    set -g default-terminal "tmux-256color"

    # Define your session name
    SESSION_NAME="default"

    # Check if the tmux session exists
    if tmux has-session -t $SESSION_NAME 2>/dev/null; then
      echo "[Tmux] Session $SESSION_NAME already exists. Attaching..."
      tmux attach-session -t $SESSION_NAME
    else
      echo "[Tmux] Session $SESSION_NAME does not exist. Creating..."
      tmux new-session -s $SESSION_NAME
    fi
  fi
}

if [[ ${TMUX_ENABLE} == ${TRUE} ]]; then
  lanchTmux
fi

# 切换 tmux 模式
function t() {
  lanchTmux
}