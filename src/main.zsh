#!/usr/bin/env zpm

import ./providers/theme.zsh --as theme
import ./providers/config.zsh --as conf
import ./providers/plugin.zsh --as plugins
import ./providers/lib.zsh --as libs
import ./providers/custom_plugin.zsh --as custom_plugin
import ./providers/workflow.zsh --as workflow

G_DOTFILES_ROOT=${ZPM_WORKSPACE}

function init() {
    call main # <-- Auto load main function after init.
}

function main() {
    call conf.load
    call libs.load
    call plugins.load
    call custom_plugin.load
    call workflow.load
    call theme.load
}