#!/usr/bin/env zsh 

##
# This is a simple plugin to open the browser with the DNS lookup of the domain.
# @Author: wuchuheng<root@wuchuheng.com>
# @Date: 2024-02-08
##

function dns.a() {
    # Ask the domain from the user in the terminal.
    read "REPLY?Enter the domain: "
    
    local domain=$REPLY
    local url="https://toolbox.googleapps.com/apps/dig/#A/${domain}"
    printf "${url}\n"
    # Open the browser with the URL.
    open $url
}

##
# @Docs: dns: Query the A record of the domain. usage: dns example.com
##
function dns() {
    dns.a
}