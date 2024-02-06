#!/use/bin/env zsh
#@Author: wuchuheng<root@wuchuheng.com>
#@Date: 2024-02-01 01:25

import ./actions/activate-chrome.action.zsh --as activate_chrome_action
import ./actions/switch-chrome-tab1.action.zsh --as switch_chrome_tab1_action
import ./git-gdp.workflow.zsh --as self

function prompt() {
    cat <<EOF
please, show the me the standar git commit message for the above changes?
and the git commit message must be used the prefix like:
    feat: ... or test: ... or docs: ... etc.
and try to add a option that can be used to add the scope of the changes,like:
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