#!/usr/bin/env zsh

##
# This is the entry point for 
# @Docs: rust-vim: Open the nvim to develope a rust program.
##
function rust-vim() {
    local currentDir=${G_DOTFILES_ROOT}/src/plugins/rust-vim
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
        if [[ $? -ne 0 ]]; then
            log.error "Failed to install AstroNvim"
            return 1
        fi
    fi

    # Check if the customize config was installed under the path ${XDG_CONFIG_HOME}/nvim/lua/user
    # and then try to install it from github.com/wuchuheng/rust-vim
    local userConfigPath=${astroNvimInstalledPath}/lua/user
    if [[ ! -d ${userConfigPath} ]]; then
        git clone --depth 1 https://github.com/wuchuheng/rust-vim ${userConfigPath}
        if [[ $? -ne 0 ]]; then
            log.error "Failed to install AstroNvim"
            return 1
        fi
    fi

    XDG_CACHE_HOME=${XDG_CACHE_HOME} \
    XDG_DATA_HOME=${XDG_DATA_HOME} \
    XDG_STATE_HOME=${XDG_STATE_HOME} \
    XDG_CONFIG_HOME=${XDG_CONFIG_HOME} \
    nvim $@
}
