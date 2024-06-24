#!/usr/bin/env zsh

##
# Notyfy the user with a message and a title on the desktop.
# @Usage: some_cmd_stout_message | n
# @Docs: n: Notyfy the user with a message and a title on the desktop. usage: <some_cmd_stout_message> | n
##
function n() {
    # 1. Handling input.
    # 1.1 Get the input from the standard input.
    local body=""
    local title=""
    local help=""

    local args=($@)
    local i=1
    for (( i=1; i<=${#args[@]}; i++ )); do
        local arg=${args[$i]}
        case $arg in
            --title|-t)
                ((i++))
                title=${args[$i]}
                ;;
            --help|-h)
                help="true"
                ;;
            --body|-b)
                ((i++))
                body=${args[$i]}
                ;;
        esac
    done

    # 2. Processing logic.
    # 2.1 If the 'help' is set to 'true', display the help message.
    if [[ ${help} == "true" ]]; then
        echo "Notyfy the user with a message and a title on the desktop."
        echo "";
        echo "Usage:"
        echo "<some_cmd_stout_message> | n"
        echo "Flags:"
        echo "  --title, -t: The title of the notification."
        echo "  --body, -b: The body of the notification, if not provided, the body will be read from the standard input."
        echo "  --help, -h: Display the help message."
        return 0
    fi

    # 2.2 Retrieve the standard input from the pipe.
    # 2.2.1 If the $body is empty, get the input from the standard input by reading the pipe.
    if [[ ${body} == "" ]]; then
        while IFS= read -r line; do
            echo -e "${line}"
            body="${line}\n"
        done
    else 
        echo -e "${body}"
    fi

    local log_file="${G_DOTFILES_ROOT}/src/cache/plugin/notification/nohup.log"
    # 2.2.2 If the directory does not exist, create it
    local dir=${log_file:h}
    [ ! -d $dir ] && mkdir -p $dir

    local desktop_notification_script="${G_DOTFILES_ROOT}/src/plugins/notification/desktop-notification.zsh"

    if [[ -z "${body}" ]]; then
        body="(empty message)"
    fi

    # 3. Display the notification on the desktop.
    $(nohup  ${desktop_notification_script} --body "${body}" --title "${title}" > $log_file 2>&1 &)
}

