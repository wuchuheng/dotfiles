#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

function proxy.set() {
    eval "${SHELL_PROXY_CMD}"
    call log.info "Set the proxy in the shell."
}

function proxy() {
    proxy.set
}

if [[ ${SHELL_PROXY_ENABLED} == ${TRUE}  ]]; then
    proxy
fi
