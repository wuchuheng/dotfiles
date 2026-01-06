#!/usr/bin/env zsh

function activate_chrome_action() {
    local os=$( uname -s )
    case $os in
        "Darwin")
    osascript -e 'tell application "Google Chrome" to activate'
            ;;
        "Linux")
            # Check if wmctrl is installed
            if command -v wmctrl >/dev/null 2>&1; then
                wmctrl -a "Google Chrome"
            else
                log.warn "wmctrl is not installed. Skipping Chrome activation on Linux."
            fi
            ;;
        *)
            throw --error-message "Not support the os: $os" --exit-code 1
            ;;
    esac
}