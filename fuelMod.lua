require("fuelMod\\LuaUI")

local maxFuelLevel = 50
local fuelLevel = 50
local fuelFill = 5

function fuelLevelDecreaseLevel()
    if player.is_player_in_any_vehicle(player.player_id()) then
           if utils.time_ms() + 900000 > utils.time_ms() then
            if(fuelLevel >= 0) then
                fuelLevel = fuelLevel - 0.005
            end
        end
    end
end

local orange2 = {r=255, g=128, b=0, a=255}
function drawFuelBar()
    fuelLevelDecreaseLevel()
    if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
        LuaUI.drawOutline("Fuel: "..fuelLevel.."/"..maxFuelLevel, 0.4, 0.1, 0.8, fuelLevel/250, 0.02, orange2, orange2, true, false)
    end
end

function fuelMod()
    drawFuelBar()
    if(fuelLevel == 0) then
        vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), false, true, true)
    end    
end

menu.add_feature("Toggle FuelMod", "toggle", 0, function(tog)
    while tog do
        fuelMod()
        system.wait(0)
    end
end)