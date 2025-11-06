#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/log.zsh --as log
import ../../lib/helper.zsh --as helper

##
# Access the pipe line and put the input to the clipboard.
# @Docs: clip: Put the input from pipe line to the clipboard.
##
function clip() {
    local input="$(cat)"
    if call helper.clipboard "$input"; then
        call log.info "The input was copied to the clipboard."
    else
        call log.error "Failed to copy the input to the clipboard."
        return 1
    fi
}
