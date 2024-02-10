#!/usr/bin/env zsh

##
# Notyfy the user with a message and a title on the desktop.
# @Usage: some_cmd_stout_message | n
##
function n() {
    local message="(empty message)"

    if [ -p /dev/stdin ]; then
        message=$(cat)
    fi

    local log_file="${G_DOTFILES_ROOT}/src/cache/plugin/notification/nohup.log"
    # if the directory does not exist, create it
    local dir=${log_file:h}
    [ ! -d $dir ] && mkdir -p $dir

    local desktop_notification_script="${G_DOTFILES_ROOT}/src/plugins/notification/desktop-notification.zsh"

    $(nohup  ${desktop_notification_script} --message "${message}" > $log_file 2>&1 &)
}

