#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

function proxy.set() {
    eval "${SHELL_PROXY_CMD}"
    call log.info "Set the proxy in the shell." --no-path
}

function proxy() {
    proxy.set
}

function proxy.unset() {
    unset http_proxy
    unset https_proxy
    unset ftp_proxy
    unset no_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset FTP_PROXY
    unset NO_PROXY
    # Unset the proxy in git.
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    # Unset the proxy in the shell.
    call log.success "Unset the proxy in the shell."
}

if [[ ${SHELL_PROXY_ENABLED} == ${TRUE}  ]]; then
    proxy
fi
