#!/usr/bin/env zsh

# This is the entry point for 
function web-vim() {
    local currentDir=${G_DOTFILES_ROOT}/src/plugins/web-vim
    local XDG_DATA_HOME=${currentDir}/data;
    [[ ! -d ${XDG_DATA_HOME} ]] && mkdir -p ${XDG_DATA_HOME}
    local XDG_CACHE_HOME=${currentDir}/cache
    [[ ! -d ${XDG_CACHE_HOME} ]] && mkdir ${XDG_CACHE_HOME}
    local XDG_STATE_HOME=${currentDir}/state
    [[ ! -d  ${XDG_STATE_HOME} ]] && mkdir -p ${XDG_STATE_HOME}
    local XDG_CONFIG_HOME=${currentDir}/config
    [[ ! -d ${XDG_CONFIG_HOME} ]] && mkdir -p ${XDG_CONFIG_HOME}
    
    # Check if the https://github.com/AstroNvim/AstroNvim was not installed under the path ${XDG_CONFIG_HOME}/nvim,
    # and then try to install it.
    local astroNvimInstalledPath=${XDG_CONFIG_HOME}/nvim
    if [[ ! -d ${astroNvimInstalledPath} ]]; then
        mkdir -p ${astroNvimInstalledPath}
        git clone --depth 1 https://github.com/AstroNvim/AstroNvim ${astroNvimInstalledPath}
    fi

    XDG_CACHE_HOME=${XDG_CACHE_HOME} \
    XDG_DATA_HOME=${XDG_DATA_HOME} \
    XDG_STATE_HOME=${XDG_STATE_HOME} \
    XDG_CONFIG_HOME=${XDG_CONFIG_HOME} \
    nvim $@
}
