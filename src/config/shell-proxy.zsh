#!/usr/bin/env zsh

# Set the proxy in the shell.
SHELL_PROXY_ENABLED=${TRUE}

# Shell proxy cmd.
SHELL_PROXY_CMD="export https_proxy=http://127.0.0.1:2089 http_proxy=http://127.0.0.1:2089 all_proxy=socks5://127.0.0.1:2089"
