#!/usr/bin/env zsh

function load() {
    local allPlugins=()
    for plugin in ${ZPM_WORKSPACE}/src/custom/plugins/*; do
        if [[ -d $plugin ]]; then
            local pluginName=${plugin##*/}
            local entryFile=$plugin/${pluginName}.plugin.zsh
            if [[ -f $entryFile ]]; then
                allPlugins+=($entryFile)
            fi
        fi
    done

    # load all plugins
    for plugin in ${allPlugins[@]}; do
        source $plugin
    done
}