#!/usr/bin/env zsh

##
# Print info message
# @Usage: log.info <message>
##
function log.info() {
    local time=$(date "+%H:%M:%S")
    echo -e "${time} \033[1;34m[INFO]\033[0m $1"
}

##
# Print success message
# @Usage: log.success <message>
##
function log.success() {
    local time=$(date "+%H:%M:%S")
    echo -e "${time} \033[1;32m[SUCCESS]\033[0m $1"
}

##
# Print warning message
# @Usage: log.warn <message>
##
function log.warn() {
    local time=$(date "+%H:%M:%S")
    echo -e "${time} \033[1;33m[WARN]\033[0m $1"
}

##
# Print error message
# @Usage: log.error <message>
##
function log.error() {
    local time=$(date "+%H:%M:%S")
    echo -e "${time} \033[1;31m[ERROR]\033[0m $1" >&2
}
