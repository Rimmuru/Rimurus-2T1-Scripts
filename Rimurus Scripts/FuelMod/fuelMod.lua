require("fuelMod\\LuaUI")
require("fuelMod\\stations")

local usedVehicles = {}

local fuelStates = {
    maxFuelLevel = 100,
    fuelLevel = math.random(10, 35),
    fuelFill = 0.5,
    canFuel = false
}

local fuelDepreciations = {}
    fuelDepreciations[0] = 0.25   --Compacts  
    fuelDepreciations[1] = 0.85   --Sedans  
    fuelDepreciations[2] = 1.0    --SUVs  
    fuelDepreciations[3] = 0.35   --Coupes  
    fuelDepreciations[4] = 1.0    --Muscle  
    fuelDepreciations[5] = 1.15   --Sports Classics  
    fuelDepreciations[6] = 1.25   --Sports  
    fuelDepreciations[7] = 1.5    --Super  
    fuelDepreciations[8] = 0.75   --Motorcycles  
    fuelDepreciations[9] = 0.5    --Off-road  
    fuelDepreciations[10] = 0.5   --Industrial  
    fuelDepreciations[11] = 0.35  --Utility  
    fuelDepreciations[12] = 0.35  --Vans  
    fuelDepreciations[13] = 0     --Cycles  
    fuelDepreciations[14] = 0     --Boats  
    fuelDepreciations[15] = 0     --Helicopters  
    fuelDepreciations[16] = 0     --Planes  
    fuelDepreciations[17] = 0.45  --Service  
    fuelDepreciations[18] = 0.45  --Emergency  
    fuelDepreciations[19] = 0.65  --Military  
    fuelDepreciations[20] = 0.75  --Commercial
    fuelDepreciations[21] = 0     --Trains 

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
            fuelStates.fuelLevel = fuelStates.fuelLevel - (fuelDepreciations[vehicle.get_vehicle_class(getMyCurrentVehicle())] / 1000)
          
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
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Chilliad) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Strawberry) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.LittleSeoul) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.PopularStreet) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Harmony) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.MirrorPark) <= 2.4 
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Morningwood) <= 2.4
    or Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), Stations.Vinewood) <= 2.4 then
        fuelStates.canFuel = true
    else
        fuelStates.canFuel = false
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
    if fuelStates.fuelLevel <= 15 then
        LuaUI.drawText(string.format("Low Fuel: %i/%i", math.floor(fuelStates.fuelLevel), fuelStates.maxFuelLevel), 0.5, 0.945, 0, 0.3, true, false)
        LuaUI.drawRect(0.5, 0.98, fuelStates.fuelLevel/400, 0.02, Colour.red)
    elseif fuelStates.fuelLevel >= 85 then
        LuaUI.drawText(string.format("Fuel: %i/%i", math.floor(fuelStates.fuelLevel), fuelStates.maxFuelLevel), 0.5, 0.945, 0, 0.3, true, false)
        LuaUI.drawRect(0.5, 0.98, fuelStates.fuelLevel/400, 0.02, Colour.green)
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
--   else
--      if fuelStates.fuelLevel < 100 and ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 883325847 
--          and Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), entity.get_entity_coords(usedVehicles.hash)) <= 2 
--      then
--          fuelStates.fuelLevel = fuelStates.fuelLevel + fuelStates.fuelFill
--      end
    end
end

menu.add_feature("Realistic FuelMod", "toggle", 0, function(tog)
    while tog.on do
        fuelMod()
        system.wait(0)
    end
end)