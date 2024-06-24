#!/usr/bin/env zsh

# 1. Handleing input.
# 1.1 Get the input from the standard input.
local messageInput=""
local title=""
local args=($@)
local i=1
while [[ $i -le ${#args[@]} ]]; do
    local arg=${args[$i]}
    case $arg in
        --body)
            ((i++))
            messageInput=${args[$i]}
            ;;
        --title)
            ((i++))
            title=${args[$i]}
            ;;
    esac
    ((i++))
done
echo "args: ${args[@]}"

# 1.2 If the title is empty, set the default title.
[[ -z $title ]] && title="Command Line Notification"

# 2. Processing logic.
# 2.1 Get the last command from the history file.that will be displayed in the notification.
local history_file="$HOME/.zsh_history"
local lastCmd=$(tail -n 1 $history_file | cut -d ';' -f 2-)

# 2.1.1 Replace the character `"` with `\"` to avoid the error `unterminated string literal`
lastCmd=$(echo $lastCmd | sed 's/"/\\"/g')
messageInput=$(echo $messageInput | sed 's/"/\\"/g')

# 3. Display the notification on the desktop.
osascript -e "display notification \"${messageInput}\" with title \"${title}\" subtitle \"${lastCmd}\" sound name \"Submarine\""