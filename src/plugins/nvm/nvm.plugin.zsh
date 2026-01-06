function load_nvm_config() {
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")";
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

# load_nvm_config

# Lazy load nvm
function nvm node npm pnpm yarn {
    unfunction nvm node npm pnpm yarn
    load_nvm_config
    "$0" "$@"
}

##
# Install the nvm command.
# @Docs: nvm.install: Install the nvm command.
##
function nvm.install() {
    # 1. Check if the nvm command was not found.
    if ! command -v nvm &> /dev/null; then
        # 2. If the nvm command was not found, then try to install it.
        ## 2.1 If the command curl not found, then break the installation.
        if ! command -v curl &> /dev/null; then
            log.error "The curl command was not found. Please install it first."
            return 1
        fi
        
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
        
        # 2.2 Load the nvm command.
        load_nvm_config

    fi

    # 3. Load the nvm command.
    if command -v nvm &> /dev/null; then
        load_nvm_config
    else
        log.error "The nvm command was not found. Please install it first."
        return 1
    fi
}