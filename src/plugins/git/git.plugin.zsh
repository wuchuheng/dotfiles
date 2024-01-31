#!/usr/bin/env zsh

alias gs='git'
alias g='git'
alias gs='git status'
alias ga='git add -A'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

# the workflow to add all files, show the diff in the stage area and output the diff to the clipboard, 
# and the diff in the clipboard is used to create a standard git commit message by AI.
function gdsc_gdp_workflow() {
    local diff=$( git add -A && git diff --staged )
    # pbcopy
    printf "%s\n\nshow the me the standar git commit message for the above changes?and the git commit message must be used the prefix like: feat: ... or test: ... or docs: ... etc.and try to add a option like: feat(plugin): Add a new plugin ... or docs(conf): add a documents for some config ..." "$diff" | pbcopy
}