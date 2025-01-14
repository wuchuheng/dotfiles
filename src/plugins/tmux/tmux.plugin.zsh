#!/usr/bin/env zsh

import github.com/zpm-shell/zpm/src/utils/color.zsh --as color

##
# Print the tmux default keybindings
# @Docs: tmux_doc: Print the tmux default keybindings. usage: tmux_doc
##
function tmux_doc() {
    # Reset colors and apply formatting for section headers
    call color.reset
    call color.light_green
    call color.shape_bold

    # Define section headers with color and formatting
    local ResizePanes="$(call color.print 'Resize Panes:')"
    local SelectWindow="$(call color.print 'Select Window:')"
    local SplitWindow="$(call color.print 'Split Window:')"
    local Navigation="$(call color.print 'Navigation:')"
    local SessionManagement="$(call color.print 'Session Management:')"
    local WindowPaneManagement="$(call color.print 'Window & Pane Management:')"
    local CopyPaste="$(call color.print 'Copy & Paste:')"
    local Miscellaneous="$(call color.print 'Miscellaneous:')"

    # Print the reformatted documentation
    cat <<EOF
Prefix key: <Ctrl+b>

${SplitWindow}
Split your current window into panes.
    %       - Split window vertically into left and right panes.
    "       - Split window horizontally into top and bottom panes.

${SelectWindow}
Switch between windows in your tmux session.
    0-9     - Select windows 0 through 9.
    w       - List all windows to select from.
    l       - Move to the previously selected window.
    n       - Move to the next window in order.
    p       - Move to the previous window in order.
    M-n     - Move to the next window with an alert.
    M-p     - Move to the previous window with an alert.

${ResizePanes}
Adjust the size of the current pane.
    M-Up, M-Down, M-Left, M-Right  - Resize pane in the direction by 5 lines/columns.
    C-Up, C-Down, C-Left, C-Right  - Resize pane in the direction by 1 line/column.

${Navigation}
Navigate through panes and windows.
    Up, Down, Left, Right - Select pane in direction.
    M-o     - Rotate window positions down.
    C-o     - Rotate window positions up.
    ;       - Select the last active pane.
    o       - Cycle through panes in the current window.
    q       - Briefly display pane indexes.
    {       - Swap the current pane with the previous pane.
    }       - Swap the current pane with the next pane.

${SessionManagement}
Manage tmux sessions and detach clients.
    d       - Detach from the current tmux session.
    D       - Choose a client to detach.
    L       - Switch to the last client.
    (       - Switch to the previous client.
    )       - Switch to the next client.
    $       - Rename the current session.
    s       - Display an interactive tree of sessions, windows, and panes.

${WindowPaneManagement}
Create, kill, and manage windows and panes.
    c       - Create a new window.
    &       - Kill the current window (with confirmation).
    x       - Kill the current pane (with confirmation).
    !       - Break the current pane out of the window.
    z       - Toggle zoom state of the current pane.
    ,       - Rename the current window.
    .       - Move the current window to another index.
    f       - Prompt to search for text in open windows.

${CopyPaste}
Handle copying and pasting within tmux.
    [       - Enter copy mode to scroll back and copy text.
    ]       - Paste the most recently copied buffer of text.
    -       - Delete the current buffer.
    =       - Choose a buffer to paste from.

${Miscellaneous}
Other useful commands.
    Space   - Switch to the next layout.
    t       - Show the time in the current pane.
    i       - Display information about the current window.
    r       - Force redraw of the tmux client.
    #       - List paste buffers.
    :       - Enter command mode.
    ?       - List all key bindings.
    ~       - Show previous messages from tmux.
    M-1 to M-5 - Select preset layouts.

EOF
}
