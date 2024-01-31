#!/use/bin/env zsh
#@Author: wuchuheng<root@wuchuheng.com>
#@Date: 2024-02-01 01:25

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
    

please, show the me the standar git commit message for the above changes?
and the git commit message must be used the prefix like: 
    feat: ... or test: ... or docs: ... etc.
and try to add a option that can be used to add the scope of the changes,like:
    feat(plugin): Add a new plugin ... or docs(conf): add a documents for some config ... 
    feat(workflows): ...
EOF
)
   print $content | pbcopy 

}