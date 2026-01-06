#!/usr/bin/env zsh

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${G_DOTFILES_ROOT}/src/cache/.zcompcache"
zstyle ':completion:*' menu select # search
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' file-list all
zstyle ':completion:*' complete-options true
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# +---------+
# | Bindkey |
# +---------+
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^xi' vi-insert
bindkey -M menuselect '^xc' clear-screen

# +---------+
# | Options |
# +---------+
setopt MENU_COMPLETE
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.


# autoload -Uz compinit && compinit 
