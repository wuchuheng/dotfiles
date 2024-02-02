#!/usr/bin/env zsh

function activate_chrome_action() {
    local os=$( uname -s )
    case $os in
        "Darwin")
    osascript -e 'tell application "Google Chrome" to activate'
            ;;
        "Linux")
            throw --error-message "Not support the os: $os" --exit-code 1
            ;;
        *)
            throw --error-message "Not support the os: $os" --exit-code 1
            ;;
    esac
}