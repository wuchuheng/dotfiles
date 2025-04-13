#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

##
# @Docs: proxy.set: Set the proxy in the shell. usage: proxy
##
function proxy.set() {
    # 2.1 Proxy for env.
    echo "Env proxy: "
    echo "${SHELL_PROXY_CMD}"
    eval "${SHELL_PROXY_CMD}"

    # 2.2 Git proxy.
    local gitProxyCmd="
    git config --global http.proxy ${PROXY_URL};
    git config --global https.proxy ${PROXY_URL};
"

#    echo "Git proxy:"
#    echo "${gitProxyCmd}"

    call log.info "Set the proxy in the shell." --no-path
}

##
# @Docs: proxy: Set the proxy in the shell. usage: proxy
##
function proxy() {
    proxy.set
}

##
# @Docs: proxy.unset: Unset the proxy in the shell. usage: proxy.unset
##
function proxy.unset() {
    
    # 2.1 Unset env proxy.
    local unsetEnvProxyCmd="
    unset http_proxy;
    unset https_proxy;
    unset ftp_proxy;
    unset no_proxy;
    unset HTTP_PROXY;
    unset HTTPS_PROXY;
    unset FTP_PROXY;
    unset NO_PROXY;
"
    echo "Unset env proxy:"
    echo ${unsetEnvProxyCmd}
    eval "${unsetEnvProxyCmd}"

    # 2.2 Unset git proxy
    local unsetGitProxyCmd='
    git config --global --unset http.proxy;
    git config --global --unset https.proxy;
'
#    eval "${unsetGitProxyCmd}"
#    echo "Unset git proxy:"
#    echo "${unsetGitProxyCmd}"

    # Unset the proxy in the shell.
    call log.success "Unset the proxy in the shell."
}

if [[ ${SHELL_PROXY_ENABLED} == ${TRUE}  ]]; then
    proxy
fi
