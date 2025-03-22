#!/use/bin/env zsh
#@Author: wuchuheng<root@wuchuheng.com>
#@Date: 2024-02-01 01:25

import ./actions/activate-chrome.action.zsh --as activate_chrome_action
import ./actions/switch-chrome-tab1.action.zsh --as switch_chrome_tab1_action
import ./git-gdp.workflow.zsh --as self

function prompt() {
    cat <<EOF
Please, show me the standard git commit message for the above changes?
and the git commit message must use the prefix like:
    feat: ... or test: ... or docs: ... etc.
and try to add an option that can be used to add the scope of the changes, like:
    feat(plugin): Add a new plugin ... or docs(conf): add a documents for some config ...
    feat(workflows): ...
EOF
}

# @Description: This workflow is used to generate the standard git commit message by using the AI gdp.
# This is a workflow to do the flowing steps:
# - add all the changes to the stage
# - show the changes
# - add the prompt for the AI gdp to use the standard git commit message to generate the standar commit message
# - copy the changes to the clipboard
# @Docs: git_gdp_workflow: This workflow is used to generate the standard git commit message by using the AI gdp.
function git_gdp_workflow() {
    local diff=$( git add -A && git diff --staged )
    # | pbcopy
    local content=$( cat  <<EOF
    $diff
    
$(call self.prompt)
EOF
)
   print $content | pbcopy 
   call activate_chrome_action.activate_chrome_action
   call switch_chrome_tab1_action.switch_chrome_tab1_action
}

##
# @Description: This workflow is used to generate the standard git commit message by using the AI gdp.
# This is a workflow to do the flowing steps:
# - show the changes
# - add the prompt for the AI gdp to use the standard git commit message to generate the standar commit message
# - copy the changes to the clipboard
# @Docs: git_stage_gdp_workflow: This workflow is used to generate the standard git commit message by using the AI gdp. but only stage the changes.
##
function git_stage_gdp_workflow() {
    local diff=$(git diff --staged )
    # | pbcopy
    local content=$( cat  <<EOF
    $diff


$(call self.prompt)
EOF
)
   print $content | pbcopy
   call activate_chrome_action.activate_chrome_action
   call switch_chrome_tab1_action.switch_chrome_tab1_action
}

##
# @Description: This workflow is used to generate the standard git commit message by using the AI gdp.
# This is a workflow to do the flowing steps:
# - show the changes
# - add the prompt for the AI gdp to use the standard git commit message to generate the standar commit message
# - copy the changes to the clipboard
# @Docs: git_vscode_workflow: This workflow is used to generate the standard git commit message by using the AI gdp. but only stage the changes.
##
function git_vscode_workflow() {
    # 1. Handling input.
    # 2. Processing logic.
    # 2.1 Add all git file.
    git add -A
    # 2.2 Get the git status.
    local gitStatus=$(git status)

    
    # 2.3 Add the prompt to clipboard.
    local content=$( cat  <<EOF
@workspace
    $gitStatus


$(call self.prompt)
like: 

feat(config): Enhance Jest and TypeScript configuration 
  - Update Jest configuration to include testEnvironment and s etupFilesAfterEnv options. 
  - Add jest.setup.js for Jest setup and mocking.
  - ...
EOF
)
   call self.clipboard $content
   
   # 3. Return result.
   echo "Please put the prompt from the clipboard to the copilot in the vscode."
}


function clipboard() {
    # 2. Handling logic.
    # 2.1 Access the output of the command.
    local content=$1

    # 2.2 Copy the content to the clipboard.
    # If OS is Linux, use xclip to copy the content to the clipboard.
    if [[ $(uname) == "Linux" ]]; then
        echo $content | xclip -selection clipboard
    # If OS is Mac, use pbcopy to copy the content to the clipboard.
    else
        echo $content | pbcopy
    fi
}
