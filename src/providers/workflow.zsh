#!/usr/bin/env zsh

# import ${ZPM_DIR}/src/utils/log.zsh --as log

function workflow.load() {
    local cacheFile="${G_DOTFILES_ROOT}/src/cache/workflow_load.zsh"
    local workflowPath="${G_DOTFILES_ROOT}/src/workflows"
    
    # Check if cache exists and is newer than the workflow directory
    if [[ -f "${cacheFile}" && "${cacheFile}" -nt "${workflowPath}" ]]; then
        source "${cacheFile}"
        return
    fi

    local cacheContent=""
    local workflow=''
    if [[ -n "$(ls -A ${workflowPath})" ]]; then
        for workflow in ${workflowPath}/*; do
            local name=${workflow:t}
            local entry="${workflow}/${name}.workflow.zsh"
            if [[ -f ${entry} ]]; then
                # . ${entry}
                cacheContent="${cacheContent}source ${entry}\n"
            else
                # We can't log to stderr easily in cache generation, but we can include the error print in the cache
                # echo -e "\033[1;31mERROR:\033[0m workflow ${name} not found in path ${workflowPath}."
                # Skipping for now to keep cache clean, or use log.error if available
                :
            fi
        done
    fi

    mkdir -p "${cacheFile:h}"
    echo "${cacheContent}" > "${cacheFile}"
    zcompile "${cacheFile}"

    source "${cacheFile}"
}