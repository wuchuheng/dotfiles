if [[ -d ~/.dotfiles/src/XDG_CONFIG_HOME ]]; then
  export XDG_CONFIG_HOME=~/.dotfiles/src/XDG_CONFIG_HOME
  export XDG_CACHE_HOME=~/.dotfiles/src/XDG_CACHE_HOME
fi


# If cargo env file is exist, load it
local cargoEnv="$HOME/.cargo/env"
if [[ -f "$cargoEnv" ]]; then
  . "$HOME/.cargo/env"
fi