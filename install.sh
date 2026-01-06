#!/usr/bin/env bash

TRUE=0
FALSE=1
dotfiles_repo="https://github.com/wuchuheng/dotfiles.git"
dotfiles_dir="${HOME}/.dotfiles"
ZPM_INSTALL_URL="https://raw.githubusercontent.com/zpm-shell/zpm/0.1.7/install.sh"

##
# Check if zsh is installed
# @returnm {boolean} true if zsh is installed
##
function check_zsh_exists() {
    local hasZsh=$(command -v zsh)
    if [ -z "${hasZsh}" ]; then
        return ${FALSE}
    fi
    return ${TRUE}
}

##
# Check if zpm is installed
# @returnm {boolean} true if zpm is installed
##
function check_zpm_exists() {
    local hasZpm=$(command -v zpm)
    if [ -z "${hasZpm}" ]; then
        return ${FALSE}
    fi
    return ${TRUE}
}

##
# Check if git is installed
# @returnm {boolean} true if git is installed
##
function check_git_exists() {
    local hasGit=$(command -v git)
    if [ -z "${hasGit}" ]; then
        return ${FALSE}
    fi
    return ${TRUE}
}

##
# Check if curl is installed
# @returnm {boolean} true if curl is installed
##
function check_curl_exists() {
    local hasCurl=$(command -v curl)
    if [ -z "${hasCurl}" ]; then
        return ${FALSE}
    fi
    return ${TRUE}
}

##
# print error message
##
function print_error() {
    echo -e "\033[1;31mERROR: \033[0m$1"
    exit ${FALSE}
}

##
# print success message
##
function print_success() {
    echo -e "\033[1;32mSUCCESS: \033[0m$1"
}
print_success hello

##
# print info message
##
function print_info() {
    echo -e "\033[1;34mINFO: \033[0m$1"
}

ZSHRC_START_SYMBOL="# zpm load zpm-dotfiles"
ZSHRC_END_SYMBOL="# zpm end load zpm-dotfiles"

##
# check if the config to autoload the zpm dotfiles is already in the zshrc or not.
# @return {boolean} true if the config is already in the zshrc
##
function check_zshrc() {
    local hasConf=$(grep "${ZSHRC_START_SYMBOL}" ~/.zshrc)
    if [ -z "${hasConf}" ]; then
        return ${FALSE}
    fi
}

##
# add the config for the zpm dotfiles in the zshrc
# @return {boolean} true if the config is already in the zshrc
##
function add_zshrc() {
    cat >> ~/.zshrc <<EOF
${ZSHRC_START_SYMBOL}
if [[ -d ${dotfiles_dir} ]]; then
    . ${ZPM_DIR}/bin/zpm run -w ${dotfiles_dir} ${dotfiles_dir}/src/main.zsh
fi
${ZSHRC_END_SYMBOL}
EOF
}

##
# check if the zpm dotfiles is already installed
# @return {boolean} true if the zpm dotfiles is already installed
##
function check_zpm_dotfiles() {
    if [ -d "${dotfiles_dir}" ]; then
        return ${TRUE}
    fi
    return ${FALSE}
}

##
# install the zpm dotfiles
# @return {boolean} true if the zpm dotfiles is already installed
##
function install_zpm_dotfiles() {
    git clone  ${dotfiles_repo} ${dotfiles_dir}
    local currentDir=$(pwd)
    cd ${dotfiles_dir}
    zpm install
    cd ${currentDir}
}

##
# remove the config for the zpm dotfiles in the zshrc
##
function remove_zshrc_conf() {
    sed -i '' "/${ZSHRC_START_SYMBOL}/,/${ZSHRC_END_SYMBOL}/d" ~/.zshrc
}

# 1. Check the environment.
# 1.1 check if zsh is installed
check_zsh_exists || print_error "zsh is not installed"
# 1.2 check if curl is installed
check_curl_exists || print_error "curl is not installed"
# 1.3 check if git is installed
check_git_exists || print_error "git is not installed"

# 2. Processing the logic.
# 2.1 Install zpm if it is not installed.
if ! check_zpm_exists; then
    # 2.1.1 Install zpm.
    print_info "zpm is not installed, installing zpm..."
    curl -fsSL -o install.sh ${ZPM_INSTALL_URL} && source install.sh
    if [ $? -ne 0 ]; then
        print_error "install zpm failed"
    else
        print_success "install zpm successfully"
    fi

fi


# 2.2 Throw an error if the zpm dotfiles is already installed.
check_zpm_dotfiles && print_error "zpm dotfiles is already installed"

# 2.3 Install the zpm dotfiles.
install_zpm_dotfiles
 
# 2.4 Remove the config for the zpm dotfiles in the zshrc if it exists.
check_zshrc && remove_zshrc_conf

# 2.5 Add the config for the zpm dotfiles in the zshrc.
add_zshrc

# 2.6 Clean up the installation package.
[ -f install.sh ] && rm -f install.sh

# 2.7 Link the ~/.dotfiles/src/.zshenv to ~/.zshenv
# 2.7.1 remove the ~/.zshenv to ~/.dotfiles/src/cache/backup/.zshenv if it exists
if [ -f ~/.zshenv ]; then
    backupDir="${dotfiles_dir}/src/cache/backup"
    [ ! -d "${backupDir}" ] && mkdir -p "${backupDir}"
    mv ~/.zshenv ${backupDir}/.zshenv 
fi

# 2.8 link the ~/.dotfiles/src/.zshenv to ~/.zshenv
ln -s ${dotfiles_dir}/src/.zshenv ~/.zshenv

# 2.9 Handle ~/.claude
# If ~/.claude exists locally and is not a symlink, move it to the repo
claude_local="${HOME}/.claude"
claude_repo="${dotfiles_dir}/src/config/claude"

if [ -d "${claude_local}" ] && [ ! -L "${claude_local}" ]; then
    print_info "Migrating ${claude_local} to ${claude_repo}..."
    mkdir -p "$(dirname "${claude_repo}")"
    mv "${claude_local}" "${claude_repo}"
fi

# Link ~/.claude to the repo if it exists in the repo
if [ -d "${claude_repo}" ]; then
    if [ -L "${claude_local}" ]; then
        # Check if it points to the correct location, if not, update it
        current_target=$(readlink "${claude_local}")
        if [ "${current_target}" != "${claude_repo}" ]; then
            print_info "Updating ~/.claude symlink..."
            rm "${claude_local}"
            ln -s "${claude_repo}" "${claude_local}"
        fi
    elif [ -e "${claude_local}" ]; then
        # If it exists and is not a symlink (and wasn't moved above), backup and link
        print_info "Backing up existing ${claude_local}..."
        backupDir="${dotfiles_dir}/src/cache/backup"
        [ ! -d "${backupDir}" ] && mkdir -p "${backupDir}"
        mv "${claude_local}" "${backupDir}/claude_backup_$(date +%s)"
        ln -s "${claude_repo}" "${claude_local}"
    else
        # If it doesn't exist, create the link
        print_info "Linking ${claude_repo} to ${claude_local}..."
        ln -s "${claude_repo}" "${claude_local}"
    fi
fi

# 3. Print the success message.
print_success "zpm dotfiles installed successfully, please restart your terminal."