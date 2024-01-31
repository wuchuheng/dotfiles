#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/bin.zsh --as bin

function load() {
    local jq=$( call bin.jq )
    local zpmPackageJson=${G_DOTFILES_ROOT}/zpm-package.json
    local theme=$( $jq -j "$( cat ${zpmPackageJson} )" -q theme.repository -t get )
    local version=$( $jq -j "$( cat ${zpmPackageJson} )" -q "dependencies.${theme//\./\\.}" -t get )
    local themeName=${theme##*/}
    local themeEntryFile=${ZPM_DIR}/packages/${theme}/${version}/${themeName}.zsh-theme
    if [[ -f $themeEntryFile ]]; then
        source $themeEntryFile
    fi
}