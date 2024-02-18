#!/usr/bin/env zsh

##
# Lanch a http server.
# @Docs: http.start: Lanch a http server with nginx.
##
function http.start() {
    local currentDir="${G_DOTFILES_ROOT}/src/plugins/http-server"
    docker run -it --rm --name http-server \
        -p '80:80' \
        -p '443:443' \
        -v "${currentDir}/www/:/www" \
        -v ${currentDir}/nginx/:/etc/nginx/ \
        --name http-server \
        nginx:latest

      # - ./certs:/etc/nginx/certs
}