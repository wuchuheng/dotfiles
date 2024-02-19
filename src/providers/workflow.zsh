#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

function load() {
    local workflow=''
    local workflowPath="${G_DOTFILES_ROOT}/src/workflows"
    if [[ -n "$(ls -A ${workflowPath})" ]]; then
        for workflow in ${workflowPath}/*; do
            local name=${workflow:t}
            local entry="${workflow}/${name}.workflow.zsh"
            if [[ -f ${entry} ]]; then
                . ${entry}
            else
                call log.error "workflow ${name} not found in path ${workflowPath}."
            fi
        done
    fi
}