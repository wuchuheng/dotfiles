#!/usr/bin/env zsh

# import ${ZPM_DIR}/src/utils/log.zsh --as log

function custom_plugin.load() {
    local plugin=''
    local savedPluginPath="${G_DOTFILES_ROOT}/src/plugins"
    if [[ -n "$(ls -A ${savedPluginPath})" ]]; then
        for plugin in ${savedPluginPath}/*; do
            local name=${plugin:t}
            local pluginPath=${plugin}/${name}.plugin.zsh
            if [[ -f ${pluginPath} ]]; then
                . ${pluginPath}
            else
                echo -e "\033[1;31mERROR:\033[0m Plugin ${name} not found."
            fi
        done
    fi
}