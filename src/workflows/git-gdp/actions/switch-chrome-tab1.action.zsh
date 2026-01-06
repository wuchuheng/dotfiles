#!/usr/bin/env zsh 

function switch_chrome_tab1_action() {
    local os=$(uname -s)
    case $os in
        "Darwin")
            osascript -e 'tell application "Google Chrome" to set the active tab index of window 1 to 1'
            ;;
        "Linux")
            # Check if xdotool is installed
            if command -v xdotool >/dev/null 2>&1; then
                # Assuming Chrome is the active window, send Ctrl+1 to switch to the first tab
                xdotool key --clearmodifiers ctrl+1
            else
                log.warn "xdotool is not installed. Skipping Chrome tab switch on Linux."
            fi
            ;;
        *)
            throw --error-message "Not support the os: $os" --exit-code 1
            ;;
    esac
}