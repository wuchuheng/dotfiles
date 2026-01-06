#!/usr/bin/env zsh

##
# This is a simple plugin to create a new certificates from Let's Encrypt.
# Help documents: https://eff-certbot.readthedocs.io/en/latest/install.html#alternative-1-docker
# @Author: wuchuheng<root@wuchuheng.com>
# @Date: 2024-02-08
##

##
# Create a new certificate by DNS.
# @Docs: certificate.create_by_dns: Create a new certificate by DNS.
##
function certificate.create_by_dns() {
    local certificateDir="$(pwd)/letsencrypt"
    if [[ ! -d $certificateDir ]]; then
        mkdir -p $certificateDir
    fi
    sudo docker run -it --rm --name certbot \
        -v "${certificateDir}:/etc/letsencrypt" \
        -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
        certbot/certbot certonly  --manual --preferred-challenges dns
    if [ $? -eq 0 ]; then
        log.success "The certificate has been created successfully and saved in ${certificateDir}"
    fi
}