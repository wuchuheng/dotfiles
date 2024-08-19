#!/usr/bin/env zsh

export KEYTIMEOUT=1
bindkey -v
# Bind Ctrl+e to the end-of-line widget
bindkey -v '^E' end-of-line
# Bind Ctrl+w to forward one word.
bindkey -v '^W' forward-word
# Bind Ctrl+p to the up-line-or-history widget
bindkey -v '^P' up-line-or-history
# Bind Ctrl+n to the down-line-or-history widget
bindkey -v '^N' down-line-or-history
# increase then number under the cursor in normal mode.
autoload -Uz incarg
zle -N incarg
bindkey -M vicmd '^a' incarg
# remove the word backword in insert mode by Ctrl+w.
bindkey -v '^W' backward-kill-word

cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursor shapes
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}

cursor_mode

# There is declared the edit-command-line for the keybind "v".
autoload -Uz edit-command-line
zle -N edit-command-line

edit-command-line() {
    # Save the command line content to a temporary file
    local tempfile=$(mktemp)
    print -r -- "$LBUFFER$RBUFFER" > $tempfile
    
    # Open the command line in Vim with the 'set number' option
    vim -c "set number" + $tempfile
    
    # After editing, read the content back
    if [[ -f $tempfile ]]; then
        LBUFFER=$(< $tempfile)
        CURSOR=${#LBUFFER}
        rm -f $tempfile
    fi
    zle reset-prompt
}

# Adding Text Objects on zsh interactive mode when using vi mode.
autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed
for km in viopp visual; do
  bindkey -M $km -- '-' vi-up-line-or-history
  for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}; do
    bindkey -M $km $c select-quoted
  done
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $km $c select-bracketed
  done
done

# Edit command line in Vim mode after tap 'v' key in normal mode
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
