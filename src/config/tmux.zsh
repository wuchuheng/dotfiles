#!/usr/bin/env zsh 

# Launches a tmux session with predefined configuration.
# This function checks if tmux is installed, sets the default terminal to tmux-256color,
# and either attaches to an existing session named "default" or creates a new one.
#
# The function performs the following steps:
# 1. Checks for the presence of tmux using 'whereis'.
# 2. If tmux is found, sets the default terminal environment variable.
# 3. Defines a session name ("default").
# 4. Checks if a tmux session with that name already exists.
# 5. If it exists, attaches to it; otherwise, creates a new session.
#
# Note: The function name has a typo ("lanchTmux" instead of "launchTmux").
# It assumes tmux is available in the PATH and handles session management gracefully.
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
      log.info "[Tmux] Session $SESSION_NAME already exists. Attaching..."
      tmux attach-session -t $SESSION_NAME
    else
      log.info "[Tmux] Session $SESSION_NAME does not exist. Creating..."
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