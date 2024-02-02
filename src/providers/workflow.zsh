#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

function load() {
    local workflow=''
    local workflowPath="${G_DOTFILES_ROOT}/src/workflows"
    if [[ -n "$(ls -A ${workflowPath})" ]]; then
        for workflow in ${workflowPath}/*; do
            local workflowPath=${workflow:A}
            if [[ -f ${workflowPath} ]]; then
                . ${workflowPath}
            elif [[ -d ${workflowPath} ]]; then
                continue
            else
                call log.error "workflow ${name} not found in path ${workflowPath}."
            fi
        done
    fi
}