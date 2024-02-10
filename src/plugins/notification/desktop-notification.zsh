#!/usr/bin/env zsh

local messageInput=""
local args=($@)
local i=1
while [[ $i -le ${#args[@]} ]]; do
    local arg=${args[$i]}
    case $arg in
        --message)
            local messageInput=${args[$((i+1))]}
            ;;
    esac
    i=$((i+1))
done

local history_file="$HOME/.zsh_history"
# Get the last command
local cmd=$(tail -n 1 $history_file | cut -d ';' -f 2-)

# Replace the character `"` with `\"` to avoid the error `unterminated string literal`
cmd=$(echo $cmd | sed 's/"/\\"/g')
messageInput=$(echo $messageInput | sed 's/"/\\"/g')
local title="Command Line Notification"

# Display the notification on the desktop.
osascript -e "display notification \"${messageInput}\" with title \"${title}\" subtitle \"${cmd}\" sound name \"Submarine\""




