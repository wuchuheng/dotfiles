if [[ -d ~/.dotfiles/src/XDG_CONFIG_HOME ]]; then
  export XDG_CONFIG_HOME=~/.dotfiles/src/XDG_CONFIG_HOME
fi

. "$HOME/.cargo/env"