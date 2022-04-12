require("fuelMod\\LuaUI")
require("fuelMod\\stations")

local fuelStates = {
    maxFuelLevel = 100,
    fuelLevel = 6,
    fuelFill = 0.5,
    depreciation = 0.001,
    canFuel = false
}


local usedVehicles = {}

local function getMyCurrentVehicle()
    return ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
end

local function insertCurrentVehicleInfomation()
    if usedVehicles.hash ~= getMyCurrentVehicle() then
        table.insert(usedVehicles, {hash = getMyCurrentVehicle(), fuelLevel = fuelStates.fuelLevel})
    end
end

local function Get_Distance_Between_Coords(first, second)
    local x = second.x - first.x
    local y = second.y - first.y
    local z = second.z - first.z
    return math.sqrt(x * x + y * y + z * z)
end

local function fuelLevelDecreaseLevel()
    if utils.time_ms() + 900000 > utils.time_ms() then
        if(fuelStates.fuelLevel > 0 and entity.get_entity_speed(getMyCurrentVehicle()) > 4) then
            fuelStates.fuelLevel = fuelStates.fuelLevel - fuelStates.depreciation
          
            if fuelStates.fuelLevel < 0 then --should fix -1 fuelLevel
                fuelStates.fuelLevel = 0
            end
        end
    end
end

local function checkIfCanRefuel()
    if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Davis) <= 2.4 
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.GroveStreet) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.SandyShores) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Paleto) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Strawberry) <= 2.4 then
        fuelStates.canFuel = true
    end
end

local function fuelLevelIncreaseLevel()
    if fuelStates.canFuel then 
        if fuelStates.fuelLevel < 100 and entity.get_entity_speed(getMyCurrentVehicle()) == 0 then
            fuelStates.fuelLevel = fuelStates.fuelLevel + fuelStates.fuelFill
        end
    end
end

local function drawFuelBar()
    if fuelStates.fuelLevel <= 10 then
        LuaUI.drawText(string.format("Low Fuel: %i/%i", math.floor(fuelStates.fuelLevel), fuelStates.maxFuelLevel), 0.5, 0.945, 0, 0.3, true, false)
        LuaUI.drawRect(0.5, 0.98, fuelStates.fuelLevel/400, 0.02, Colour.red)
    else
        LuaUI.drawRect(0.5, 0.98, fuelStates.fuelLevel/400, 0.02, Colour.orange2)
        LuaUI.drawText(string.format("Fuel: %i/%i", math.floor(fuelStates.fuelLevel), fuelStates.maxFuelLevel), 0.5, 0.945, 0, 0.3, true, false)
    end
end

local toggle = false
local function fuelMod()
    if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
        drawFuelBar()
        drawFuelMarkers()
        fuelLevelDecreaseLevel()
        fuelLevelIncreaseLevel()
        insertCurrentVehicleInfomation()
        checkIfCanRefuel()
    
        if fuelStates.fuelLevel == 0 then
            vehicle.set_vehicle_engine_on(getMyCurrentVehicle(), false, true, true)
        end 
    end
end

menu.add_feature("Realistic FuelMod", "toggle", 0, function(tog)
    while tog.on do
        fuelMod()
        system.wait(0)
    end
end)