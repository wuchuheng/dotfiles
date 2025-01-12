#!/usr/bin/env osascript

tell application "System Events"
    -- Retrieve the currently active application process
    set frontApp to first application process whose frontmost is true

    -- Check if the active application has at least one open window
    if (count of windows of frontApp) > 0 then
        -- Reference the frontmost window of the active application
        set frontWindow to front window of frontApp

        -- Obtain the dimensions of the primary display using Finder
        tell application "Finder"
            set screenBounds to bounds of window of desktop
        end tell
        
        -- Extract position and dimension values from screen bounds
        set rightPosition to (item 3 of screenBounds) - ((item 3 of screenBounds) / 2)  -- X-coordinate for the right edge
        set topPosition to item 2 of screenBounds  -- Y-coordinate for the top edge
        set screenWidth to item 3 of screenBounds    -- Total width of the screen
        set halfWidth to screenWidth / 2             -- Half of the screen width
        set screenHeight to item 4 of screenBounds    -- Total height of the screen
        
        -- Attempt to resize and reposition the front window
        try
            -- Set the window position to the top right corner
            set position of frontWindow to {rightPosition, topPosition}
            -- Resize the window to fill the right half of the screen
            set size of frontWindow to {halfWidth, screenHeight}
        on error errMsg
            -- Display an error dialog if the resizing operation fails
            display dialog "Error resizing window: " & errMsg
        end try
    else
        -- Notify the user if no windows are available in the active application
        display dialog "No windows found for the front application."
    end if
end tell
