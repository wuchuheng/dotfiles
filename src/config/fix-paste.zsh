# Fix for Zsh Vi-Mode Pasting Issues
# 
# Issue: Pasting text results in "hellO" (last char toggled case) and/or slow typing effect.
# Cause: 
#   1. "hellO": In vi-mode, the paste end sequence ^[[201~ ends with '~', which toggles case.
#   2. Slow paste: 'bracketed-paste-magic' (often used by Oh My Zsh) processes text slowly.
#
# Solution: Force use of the native, fast 'bracketed-paste' widget and bind it correctly.

# Ensure we are using the native widget, not the "magic" wrapper
if [[ $(zle -l bracketed-paste) == *"widgets/bracketed-paste-magic"* ]]; then
    # If it's using magic, unbind it so we can use the native one
    zle -D bracketed-paste
fi

# Explicitly bind the paste start sequence to the native bracketed-paste widget
if [[ ${ZSH_VERSION} > 5.1 ]]; then
    # Vi Insert Mode
    bindkey -M viins '^[[200~' bracketed-paste
    
    # Vi Command Mode
    bindkey -M vicmd '^[[200~' bracketed-paste
    
    # Standard Emacs mode (just in case)
    bindkey -M emacs '^[[200~' bracketed-paste
fi

# Disable the variable that triggers OMZ's automatic magic handling
unset zle_bracketed_paste
