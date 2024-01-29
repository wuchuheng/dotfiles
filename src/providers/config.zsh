#!/usr/bin/env zsh

function load() {
    local conf=''
    for conf in ${G_DOTFILES_ROOT}/src/config/*.zsh; do
        source ${conf}
    done
}