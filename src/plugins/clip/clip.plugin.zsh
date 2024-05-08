#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

##
# Access the pipe line and put the input to the clipboard.
# @Docs: clip: Put the input from pipe line to the clipboard.
##
function clip() {
    local input=$(cat)
    echo $input | pbcopy
    call log.info "The input was copied to the clipboard."
}