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

git config --global core.editor "vim -c 'set number' -c 'syntax on' "

# Make the git show the chinese characters
git config --global core.quotepath false


import github.com/zpm-shell/zpm/src/utils/log.zsh --as log



##
# Check github connection via SSH.
# @Docs: git.check: Check github connection via SSH.
##
function git.check() {
    call log.info "Check github connection via SSH"
    ssh -T git@github.com
}

##
# @Docs: git.sshProxyConfigDemo: Print SSH proxy configuration for git proxy via ssh.
##
function git.sshProxyConfigDemo() {
    call log.info "Print SSH proxy configuration for git proxy via ssh"
    echo "
Host github.com
HostName github.com
User git
Port 22
ProxyCommand connect -H 192.168.0.102:7897 %h %p
"
}

