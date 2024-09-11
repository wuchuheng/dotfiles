#!/usr/bin/env osascript

on run argv
    -- Check if any arguments were provided
    if (count of argv) < 1 then
        my printHelp()
        return
    end if

    -- Get the provided action
    set action to (item 1 of argv) as text
    
    -- Trim whitespace from action string
    set action to my trimWhitespace(action)

    -- Resize the window based on the provided action.
    if action = "left" then
        my resizeWindowToLeftHalf()
    else if action = "right" then
        my resizeWindowToRightHalf()
    else if action = "maximize" then
        my resizeWindowToMaximize()
    else if action = "center" then
        my resizeWindowToCenter()
    else
        my printHelp()
    end if
end run

on resizeWindowToCenter()
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
            set screenWidth to item 3 of screenBounds    -- Total width of the screen
            set screenHeight to item 4 of screenBounds    -- Total height of the screen
            
            -- Define the desired width and height for the centered window
            set windowWidth to 800  -- Example width for the centered window
            set windowHeight to 600  -- Example height for the centered window
            
            -- Calculate new position to center the window
            set leftPosition to (screenWidth - windowWidth) / 2  -- X-coordinate for centering
            set topPosition to (screenHeight - windowHeight) / 2  -- Y-coordinate for centering
            
            -- Attempt to resize and reposition the front window to the center
            try
                -- Set the window position to the calculated center position
                set position of frontWindow to {leftPosition, topPosition}
                -- Resize the window to the specified smaller dimensions
                set size of frontWindow to {windowWidth, windowHeight}
            on error errMsg
                -- Display an error dialog if the resizing operation fails
                display dialog "Error centering window: " & errMsg
            end try
        else
            -- Notify the user if no windows are available in the active application
            display dialog "No windows found for the front application."
        end if
    end tell
end resizeWindowToCenter

on resizeWindowToMaximize()
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
            set topPosition to item 2 of screenBounds  -- Y-coordinate for the top edge
            set leftPosition to item 1 of screenBounds  -- X-coordinate for the left edge
            set screenWidth to item 3 of screenBounds    -- Total width of the screen
            set screenHeight to item 4 of screenBounds    -- Total height of the screen
            
            -- Attempt to resize and reposition the front window to full screen
            try
                -- Set the window position to the top left corner
                set position of frontWindow to {leftPosition, topPosition}
                -- Resize the window to fill the entire screen
                set size of frontWindow to {screenWidth, screenHeight}
            on error errMsg
                -- Display an error dialog if the resizing operation fails
                display dialog "Error maximizing window: " & errMsg
            end try
        else
            -- Notify the user if no windows are available in the active application
            display dialog "No windows found for the front application."
        end if
    end tell
end resizeWindowToMaximize

on resizeWindowToRightHalf()
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
end resizeWindowToRightHalf

on resizeWindowToLeftHalf()
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
        set leftPosition to item 1 of screenBounds  -- X-coordinate for the left edge
        set topPosition to item 2 of screenBounds   -- Y-coordinate for the top edge
        set screenWidth to item 3 of screenBounds    -- Total width of the screen
        set halfWidth to screenWidth / 2             -- Half of the screen width
        set screenHeight to item 4 of screenBounds    -- Total height of the screen
        
        -- Attempt to resize and reposition the front window
        try
            -- Set the window position to the top left corner
            set position of frontWindow to {leftPosition, topPosition}
            -- Resize the window to fill the left half of the screen
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
    
end resizeWindowToLeftHalf

on trimWhitespace(inputString)
    -- Trim leading and trailing whitespace from the string
    return my removeLeadingTrailingSpaces(inputString)
end trimWhitespace

on removeLeadingTrailingSpaces(str)
    -- Remove leading spaces
    repeat while str starts with " "
        set str to text 2 thru -1 of str
    end repeat
    -- Remove trailing spaces
    repeat while str ends with " "
        set str to text 1 thru -2 of str
    end repeat
    return str
end removeLeadingTrailingSpaces

on printHelp()
    -- Display help dialog with usage information
    display dialog "Invalid argument. Usage:\n" & Â
        "   ./resizeWindows.applescript [action]\n\n" & Â
        "Actions:\n" & Â
        "   left     - Resize window to left half of the screen\n" & Â
        "   right    - Resize window to right half of the screen\n" & Â
        "   maximize - Maximize window to full screen\n" & Â
        "   center   - Center window on the screen\n"
end printHelp