# import github.com/zpm-shell/zpm/src/utils/log.zsh --as log

##
# Create a new plugin.
# @Docs: dot.create.plugin: Create a new plugin.
##
function dot.create.plugin() {
    # 1. Recieve the plugin name by asking the user's input.
    read "name?Enter the plugin name: "

    # 1.1 Trim the name.
    name=$(echo ${name} | xargs)

    # 1.1 Check the name must be in a letter.
    if [[ ! ${name} =~ ^[a-zA-Z0-9]+$ ]]; then
        log.error "Invalid plugin name. The plugin name must be in a letter."
        return 1
    fi

    # 2. Check if the plugin already exists.
    local currentDir=${G_DOTFILES_ROOT}/src/plugins/${name}
    if [ -d ${currentDir} ]; then
        log.error "Plugin already exists."
        return 1
    fi

    # 3. Create the plugin directory and the plugin file.
    mkdir -p ${currentDir}
    # 3.1 Create the plugin file.
    local plugin_file=${currentDir}/${name}.plugin.zsh
    cat <<EOF > ${plugin_file}
##
# This is a sample plugin.
# @Docs: ${name}: This is a sample plugin.
##
function ${name}() {
    echo "Hello, ${name}!"
}

EOF

    # 4. Print the success message for the user.
    cat ${plugin_file}

    local relativeFile=${plugin_file#${G_DOTFILES_ROOT}/}
    log.success "Plugin: ${name} created successfully in ${relativeFile}."
}