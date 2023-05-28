# LuaUI
LuaUI is am early wip lua ui wrapper libary for 2take1.menu devloped by Rimuru.<br />
This project has and still is a huge undertaking for me that wouldnt be possible without all the great people who helped me gain confidence in using lua along with 2take1's api.

# Install
Add LuaUI.lua to your poject directory<br />
Add Require "LuaUI" to the top of your directory<br />

# Usage

Creating the hook:
This will just create a loop(hook) for our functions<br />
```lua
menu.add_feature("Example Menu", "toggle", 0, function(tog)
  while tog do
    
    system.wait(0)
  end
end)
```
<br />
The basics:<br />
This will draw an outlined rectangle with a title and draw some text over our rectangle<br />

```lua 
require("LuaUI")
--Set our position and width/height
LuaUI.Options.menuPos.x = 0.5
LuaUI.Options.menuPos.y = 0.4
LuaUI.Options.menuWH.x = 0.2
LuaUI.Options.menuWH.y = 0.25

function UI()
    --LuaUI.drawOutline(title, scale, x, y, w, h, colour, fillColour, filled)
    LuaUI.drawOutline("title", scale, LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y, LuaUI.Options.menuWH.x, LuaUI.Options.menuWH.y, foreColour, backgroundColour, filled)
    LuaUI.drawText("Text", LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y, font, scale, center, allignRight)
end

menu.add_feature("Example Menu", "toggle", 0, function(tog) --hook
  while tog do
    UI()
    system.wait(0)
  end
end)
```
<br />
Toggles:<br />

```lua
require("LuaUI")

--LuaUI.drawOptionToggle(text, num, toggle)
local example = false
LuaUI.drawOptionToggle("Text", 0, example)
```
<br />
Using the keyboard:<br />

```lua
require("LuaUI")

function keyHook()
  if(controls.is_control_pressed(2, 173)) then --down arrow     
        if LuaUI.Options.scroll < LuaUI.Options.maxScroll then
            LuaUI.Options.scroll = LuaUI.Options.scroll + 1
        end
    end
end

menu.add_feature("Example Menu", "toggle", 0, function(tog)
  keyHook()
end)
```
<br />
Adding options for a menu:<br />

```lua
require("LuaUI")

--Set our position and width/height
LuaUI.Options.menuPos.x = 0.5
LuaUI.Options.menuPos.y = 0.4
LuaUI.Options.menuWH.x = 0.2
LuaUI.Options.menuWH.y = 0.25

LuaUI.menus = { --Setup for our main menu and any submenus
    "main"
}

local example = false

function UI()
     LuaUI.drawOutline("Example Menu", 0.5, LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y, LuaUI.Options.menuWH.x, LuaUI.Options.menuWH.y + (LuaUI.Options.maxScroll/100), blue, black, true)

if(LuaUI.currentMenu == LuaUI.menus[1]) then
        LuaUI.Options.maxScroll = 1
        LuaUI.drawOptionToggle("Text", 0, example)
    end
end

function keyHook()
  if(controls.is_control_pressed(2, 173)) then --down arrow     
        if LuaUI.Options.scroll < LuaUI.Options.maxScroll then
            LuaUI.Options.scroll = LuaUI.Options.scroll + 1
        end
    end
end

menu.add_feature("Rope Menu", "toggle", 0, function(tog) --hook
  while tog do
    UI()
    keyHook()
    system.wait(0)
  end
end)
```
<br />

# Examples
[![GTA5-Bw-LZwjkl9-F.jpg](https://i.postimg.cc/XJXkT2Bx/GTA5-Bw-LZwjkl9-F.jpg)](https://postimg.cc/Q9G77JbW)
[![GTA5-Rmnimlq-Ih9.jpg](https://i.postimg.cc/mg2zXPHy/GTA5-Rmnimlq-Ih9.jpg)](https://postimg.cc/Vdpk5L4J)
