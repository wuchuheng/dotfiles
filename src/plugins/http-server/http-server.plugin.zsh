#!/usr/bin/env zsh

##
# Launch a http server.
# @Docs: http.start: Launch a http server with nginx.
##
function http.start() {
    local currentDir="${G_DOTFILES_ROOT}/src/plugins/http-server"
    docker run -it --rm --name http-server \
        -p '80:80' \
        -p '443:443' \
        -v "$(pwd):/www/default" \
        -v "${currentDir}/www/local.wuchuheng.com:/www/local.wuchuheng.com" \
        -v ${currentDir}/nginx/:/etc/nginx/ \
        --name http-server \
        nginx:latest

      # - ./certs:/etc/nginx/certs
}
