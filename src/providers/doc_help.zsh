#!/usr/bin/env zsh

function load() {
    # If the path ${G_DOTFILES_ROOT}/src/bin does not exist in $PATH, add it.
    if [[ ! $PATH =~ "${G_DOTFILES_ROOT}/src/bin" ]]; then
        export PATH="${G_DOTFILES_ROOT}/src/bin:$PATH"
    fi
}
