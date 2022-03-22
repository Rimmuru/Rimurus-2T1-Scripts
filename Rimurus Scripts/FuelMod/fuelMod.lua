require("fuelMod\\LuaUI")

local maxFuelLevel = 100
local fuelLevel = maxFuelLevel
local fuelFill = 5

function fuelLevelDecreaseLevel()
    if player.is_player_in_any_vehicle(player.player_id()) then
           if utils.time_ms() + 900000 > utils.time_ms() then
            if(fuelLevel >= 0 and entity.get_entity_speed(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))) > 4) then
                fuelLevel = fuelLevel - 0.003
            end
        end
    end
end

local orange2 = {r=255, g=128, b=0, a=255}
function drawFuelBar()
    fuelLevelDecreaseLevel()
    if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
        LuaUI.drawRect(0.5, 0.98, fuelLevel/400, 0.02, orange2)
        LuaUI.drawText(string.format("Fuel: %i/%i", math.floor(fuelLevel), maxFuelLevel), 0.5, 0.945, 0, 0.3, true, false)
    end
end

function fuelMod()
    drawFuelBar()
    if(fuelLevel <= 0) then
        vehicle.set_vehicle_engine_on(player.get_player_vehicle(player.player_id()), false, true, true)
    end    
end

menu.add_feature("Toggle FuelMod", "toggle", 0, function(tog)
    while tog do
        fuelMod()
        system.wait(0)
    end
end)