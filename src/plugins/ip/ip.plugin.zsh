#!/usr/bin/env zsh


function ip.public() {
    log.info "Your public IPV4 address is: $(curl -s https://api.ipify.org)"
    log.info "Your public IPV6 address is: $(curl -s https://api6.ipify.org)"
    log.info "Your network is IPv4 or IPv6 access prioritized: $(curl -s https://api64.ipify.org)"

    log.info "Your public IPV4 address in cn is: $(curl -s 4.ipw.cn)"
    log.info "Your public IPV6 address in cn is: $(curl -s 6.ipw.cn)"
    log.info "Your network is IPv4 or IPv6 access prioritized in cn: $(curl -s test.ipw.cn)"
}

# @Docs: ip: Get the public IP address.
function ipInfo() {
    ip.public
}
