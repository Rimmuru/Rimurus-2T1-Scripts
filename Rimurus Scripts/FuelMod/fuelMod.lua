require("fuelMod\\LuaUI")

local fuelLevel = 100
local fuelDepreciation = 2
function getFuelLevel(level)
    if player.is_player_in_any_vehicle(player.player_id()) then
        
    end
    return level
end

local orange2 = {r=255, g=128, b=0, a=255}
function drawFuelBar()
    LuaUI.drawRect(0.1, 0.8, 0.13, 0.01, orange2) --background
    LuaUI.drawRect(0.1, 0.8, fuelLevel/100, 0.01, Colour.orange) --fuel level 
    LuaUI.drawText("")
end

function fuelMod()
    drawFuelBar()
end

menu.add_feature("Togggle FuelMod", "toggle", 0, function(tog)
    while tog.on do
        fuelMod()
        system.wait(0)
    end
end)