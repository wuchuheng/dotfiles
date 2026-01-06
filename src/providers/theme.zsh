#!/usr/bin/env zsh

# import ${ZPM_DIR}/src/utils/bin.zsh --as bin

function theme.load() {
    local cacheFile="${G_DOTFILES_ROOT}/src/cache/theme_load.zsh"
    local zpmPackageJson="${G_DOTFILES_ROOT}/zpm-package.json"

    if [[ -f "${cacheFile}" && "${cacheFile}" -nt "${zpmPackageJson}" ]]; then
        source "${cacheFile}"
        return
    fi

    local jq="${ZPM_DIR}/src/qjs-tools/bin/jq"
    local theme=$( $jq -j "$( cat ${zpmPackageJson} )" -q theme.repository -t get )
    local version=$( $jq -j "$( cat ${zpmPackageJson} )" -q "dependencies.${theme//\./\\.}" -t get )
    local themeName=${theme##*/}
    local themeEntryFile=${ZPM_DIR}/packages/${theme}/${version}/${themeName}.zsh-theme
    
    local cacheContent=""
    if [[ -f $themeEntryFile ]]; then
        cacheContent="source ${themeEntryFile}"
    fi

    # Ensure cache directory exists
    mkdir -p "${cacheFile:h}"
    echo "${cacheContent}" > "${cacheFile}"
    zcompile "${cacheFile}"
    
    source "${cacheFile}"
}