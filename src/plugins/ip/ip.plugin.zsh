#!/usr/bin/env zsh


function ip.public() {
    echo "Your public IPV4 address is: $(curl -s https://api.ipify.org)"
    echo "Your public IPV6 address is: $(curl -s https://api6.ipify.org)"
    echo "Your network is IPv4 or IPv6 access prioritized: $(curl -s https://api64.ipify.org)"

    echo "Your public IPV4 address in cn is: $(curl -s 4.ipw.cn)"
    echo "Your public IPV6 address in cn is: $(curl -s 6.ipw.cn)"
    echo "Your network is IPv4 or IPv6 access prioritized in cn: $(curl -s test.ipw.cn)"
}

function ip() {
    ip.public
}