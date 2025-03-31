#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

##
# This is the entry point for 
# @Docs: lvim: Lazy vim
##
function lvim() {
    local currentDir=${G_DOTFILES_ROOT}/src/plugins/lvim
    local XDG_DATA_HOME=${currentDir}/data;
    [[ ! -d ${XDG_DATA_HOME} ]] && mkdir -p ${XDG_DATA_HOME}
    local XDG_CACHE_HOME=${currentDir}/cache
    [[ ! -d ${XDG_CACHE_HOME} ]] && mkdir ${XDG_CACHE_HOME}
    local XDG_STATE_HOME=${currentDir}/state
    [[ ! -d  ${XDG_STATE_HOME} ]] && mkdir -p ${XDG_STATE_HOME}
    local XDG_CONFIG_HOME=${currentDir}/config
    [[ ! -d ${XDG_CONFIG_HOME} ]] && mkdir -p ${XDG_CONFIG_HOME}

    # 1 Check if the Neovim version is less than 0.5.0, if it is, then return 1.
    # version information like: 
    # NVIM v0.11.0-dev-634+g169f37b94
    local nvimVersion=$(nvim --version | head -n 1 | awk '{print $2}' | awk -F'v' '{print $2}' | awk -F'-' '{print $1}')
    local mainVersion=$(echo ${nvimVersion} | awk -F'.' '{print $1}')
    local secondVersion=$(echo ${nvimVersion} | awk -F'.' '{print $2}')
    local thirdVersion=$(echo ${nvimVersion} | awk -F'.' '{print $3}')
    if [[ ${mainVersion} -lt 0 ]] || [[ ${mainVersion} -eq 0 && ${secondVersion} -lt 5 ]]; then
        call log.error "The current Neovim version is ${nvimVersion}, it must be greater than 0.5.0"
        return 1
    fi
    
    # 2. Check if the lazyvim was not installed under the path ${XDG_CONFIG_HOME}/nvim,
    # and then try to install it.
    local astroNvimInstalledPath=${XDG_CONFIG_HOME}/nvim
    [[ ! -d ${astroNvimInstalledPath} ]] && mkdir -p ${astroNvimInstalledPath}
    # 3. If the directory was empty and then clone the AstroNvim.
    if [[ -z "$(ls -A "${astroNvimInstalledPath}")" ]]; then
        # 3.1 Clone the AstroNvim
	git clone https://github.com/LazyVim/starter ${astroNvimInstalledPath}

        # 3.1.1 If the clone was failed, then return 1.
        if [[ $? -ne 0 ]]; then
            call log.error "Failed to install AstroNvim"
            return 1
        fi

    fi



    OPENAI_API_KEY=${OPENAP_PRIVATE_KEY} \
    XDG_CACHE_HOME=${XDG_CACHE_HOME} \
    XDG_DATA_HOME=${XDG_DATA_HOME} \
    XDG_STATE_HOME=${XDG_STATE_HOME} \
    XDG_CONFIG_HOME=${XDG_CONFIG_HOME} \
    nvim $@
}
