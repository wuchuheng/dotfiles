#!/usr/bin/env zsh 

function switch_chrome_tab1_action() {
    local os=$(uname -s)
    case $os in
        "Darwin")
            osascript -e 'tell application "Google Chrome" to set the active tab index of window 1 to 1'
            ;;
        "Linux")
            throw --error-message "Not support the os: $os" --exit-code 1
            ;;
        *)
            throw --error-message "Not support the os: $os" --exit-code 1
            ;;
    esac
}