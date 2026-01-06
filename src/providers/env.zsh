#!/usr/bin/env zsh

# Load the env file.
function env.load() {
    
    # 1. Handle the input.
    # 2. Processing logic.
    
    local envFile="${G_DOTFILES_ROOT}/.env"
    
    # 2.1 Load the env file.
    # 2.1.1 Check if the file exists.
    if [[ -f ${envFile} ]]; then
        # 2.1.2 Load the file.
        source ${envFile}
    fi
    # 3. Return the result.
}
