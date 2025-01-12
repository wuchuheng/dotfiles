#!/bin/bash


function copyToClipboard() {
    # 1. Handle input
    # 1.1 Check if text is provided
    local text="6"
    printf "%s" "$text" | pbcopy

    # 3. Return result
    return 0
}

copyToClipboard
