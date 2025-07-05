##
# Copy the content to the clipboard.
# @Docs: clipboard: Copy the content to the clipboard.
##
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