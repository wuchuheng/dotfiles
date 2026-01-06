#!/usr/bin/env zsh

# import github.com/zpm-shell/zpm/src/utils/color.zsh --as color

##
# Disable the press and hold feature of the keyboard.
# @Docs: mac: Disable the press and hold feature of the keyboard. usage: mac
##
function mac() {

    # If the OS is not macOS, then return.
    if [[ $(uname) != "Darwin" ]]; then
        log.error "This script is only supported on macOS."
        return 1
    fi

    # Disable the press and hold feature of the keyboard.
     defaults write -g ApplePressAndHoldEnabled -bool false
}

# Automatically run the mac function when the script is sourced.
if [[ $(uname) == "Darwin" ]]; then
    mac
fi
