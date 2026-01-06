#!/usr/bin/env zpm
# zmodload zsh/zprof

# Ensure G_DOTFILES_ROOT is set if not already present, defaulting to the parent directory of this script
if [[ -z "${G_DOTFILES_ROOT}" ]]; then
    export G_DOTFILES_ROOT="${0:a:h:h}"
fi

source ${G_DOTFILES_ROOT}/src/providers/env.zsh
source ${G_DOTFILES_ROOT}/src/providers/theme.zsh
source ${G_DOTFILES_ROOT}/src/providers/config.zsh
source ${G_DOTFILES_ROOT}/src/providers/plugin.zsh
source ${G_DOTFILES_ROOT}/src/providers/lib.zsh
source ${G_DOTFILES_ROOT}/src/providers/custom_plugin.zsh
source ${G_DOTFILES_ROOT}/src/providers/workflow.zsh
source ${G_DOTFILES_ROOT}/src/providers/doc_help.zsh
source ${G_DOTFILES_ROOT}/src/providers/welcome.zsh

function main() {
    env.load
    doc_help.load
    welcome.load
    config.load
    lib.load
    plugins.load
    custom_plugin.load
    workflow.load
    theme.load
    
    if ! type compdef > /dev/null; then
        autoload -Uz compinit
        # Check if .zcompdump exists and is less than 20 hours old
        if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+20) ]]; then
            compinit
        else
            compinit -C
        fi
    fi

    # zprof > /home/wuchuheng/.dotfiles/zprof.log
}

main # <-- Auto load main function.