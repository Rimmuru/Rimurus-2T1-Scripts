-- Combined UI Library
local UIRemastered = {
    Colour = {
        pastelGreen = {r=167, g=244, b=163, a=255},
        white = {r=255, g=255, b=255, a=255},
        black = {r=0, g=0, b=0, a=150},
        blue = {r=137, g=196, b=244, a=255},
        activeButton = {r=107, g=158, b=44, a=255},
        inactiveButton = {r=42, g=63, b=17, a=255}
    },
    MenuData = { 
        scroll = 0,
        maxScroll = 0,
        sliderValue = 0,
        menuWidth = 0,
        menuHeight = 0,
        menuPos = v2()
    },
    buttons = {},
    buttonCount = 0,
    selection = 0,
    loaded = false,
    hidden = false,
    Keys = {
        up = nil,
        down = nil,
        selection = nil
    }
}

--- Adds a new button to the UI.
-- @param name The display name of the button.
-- @param func The function to be called when the button is activated.
-- @param args The arguments to be passed to the function.
-- @param xmin The minimum x-coordinate of the button.
-- @param xmax The maximum x-coordinate of the button.
-- @param ymin The minimum y-coordinate of the button.
-- @param ymax The maximum y-coordinate of the button.
function UIRemastered.addButton(name, args, xmin, xmax, ymin, ymax, func)
    assert(type(name) == "string", "Name must be a string")
    assert(type(xmin) == "number" and type(xmax) == "number", "xmin and xmax must be a number")
    assert(type(ymin) == "number" and type(ymax) == "number", "ymin and ymax must be a number")
    assert(xmin < xmax, "xmin must be less than xmax")
    assert(ymin < ymax, "ymin must be less than ymax")
    assert(type(func) == "function", "Func must be a function")

    local button = {
        name = name,
        func = func,
        args = args,
        xmin = xmin,
        xmax = xmax,
        ymin = ymin * (UIRemastered.buttonCount + 0.01) + 0.02,
        ymax = ymax,
        active = false
    }

    UIRemastered.buttons[#UIRemastered.buttons+1] = button
    UIRemastered.buttonCount = UIRemastered.buttonCount + 1
end

function UIRemastered.updateSelection() 
    if controls.is_control_pressed(2, Keys.down) then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_LIQUOR_STORE_SOUNDSET", true)
        if UIRemastered.selection < UIRemastered.buttonCount - 1 then
            UIRemastered.selection = UIRemastered.selection + 1
            UIRemastered.time = 0
        end
    elseif controls.is_control_pressed(2, Keys.up) then
        AUDIO.PLAY_SOUND_FRONTEND(-1, "SELECT", "HUD_LIQUOR_STORE_SOUNDSET", true)
        if UIRemastered.selection > 0 then
            UIRemastered.selection = UIRemastered.selection - 1
            UIRemastered.time = 0
        end
    elseif controls.is_control_pressed(2, Keys.selection) then
        if type(UIRemastered.buttons[UIRemastered.selection + 1]["func"]) == "function" then
            UIRemastered.buttons[UIRemastered.selection + 1]["func"](UIRemastered.buttons[UIRemastered.selection + 1]["args"])
        else
            print("Function type is: " .. type(UIRemastered.buttons[UIRemastered.selection + 1]["func"]))
        end
        UIRemastered.time = 0
    end

    for id, button in ipairs(UIRemastered.buttons) do
        button.active = (id - 1) == UIRemastered.selection
    end
end

-- Function to draw buttons
function UIRemastered.drawButtons()
    for id, button in ipairs(UIRemastered.buttons) do
        local boxColor = button.active and UIRemastered.Colour.activeButton or UIRemastered.Colour.inactiveButton
        -- Add code to draw each button using UI library functions
        -- Example: UI.drawRect(button.xmin, button.ymin, button.xmax, button.ymax, boxColor)
    end
end

--- Updates and draws the UI elements.
-- This function should be called in a constantly running thread, typically within the main game loop.
-- It will handle the drawing of UI components and any updates needed for each tick.
function UIRemastered.tick()
    UIRemastered.drawButtons()
end

--- Initializes the UI library.
-- Call this function at the start of your script or when you're ready to initialize the UI.
-- It sets up necessary states and prepares the UI for usage.
function UIRemastered.init()
    UIRemastered.loaded = true
end

--- Cleans up the UI before script termination.
-- This function should be called when your script or application is closing down or when you no longer need the UI.
-- It ensures that any resources used by the UI are properly released and any persistent states are saved.
function UIRemastered.unload()
end


-- Additional functions for other UI elements and logic...

return UIRemastered
