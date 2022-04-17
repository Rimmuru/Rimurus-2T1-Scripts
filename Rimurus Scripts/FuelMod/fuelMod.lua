require("fuelMod\\LuaUI")
require("fuelMod\\stations")
local ini = require("fuelMod\\ini_parser")

local SCRIPT = {
    NAME = "Realistic FuelMod",
    VERSION = "1.2.0"
}

local usedVehicles = {}

local PATHS = {}
PATHS.root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
PATHS.settings = PATHS.root .. "\\scripts\\fuelMod\\config.ini"

local fuelStates = {
    maxFuelLevel = 100,
    fuelLevel = math.random(10, 35),
    fuelFill = 0.25
}

local fuelSettings = {
    displayMode = 0,
    posX = -0.670,
    posY = -0.915,
    scale = 0.15,
    textscale = 0.3,
    textposX = 0.165,
    textposY = 0.97
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

local function notify(msg, title, seconds, color)
    title = title or ScriptName
    menu.notify(msg, title, seconds, color)
    print(msg)
end

local function Round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5)/mult
end

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

local function CAN_REFUEL_CHECK()
    local isNearAnyStation = false
    
    for name, coords in pairs(Stations) do
        if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), coords) <= 2.4 then 
            isNearAnyStation = true
        end
    end
    return isNearAnyStation
end

local function fuelLevelIncreaseLevel()
    if CAN_REFUEL_CHECK() then 
        if fuelStates.fuelLevel < 100 and entity.get_entity_speed(getMyCurrentVehicle()) == 0 then
            fuelStates.fuelLevel = fuelStates.fuelLevel + fuelStates.fuelFill
        end
    end
end

local function drawFuelBar()
    if fuelSettings.displayMode == 1 then
        local posX = fuelSettings.posX
        local posY = fuelSettings.posY
        local fuelCol = LuaUI.RGBAToInt(255, 255, 255, 255)
        local fuelPos = v2(posX, posY)

        local fuelColor = "orange"
        if math.floor(fuelStates.fuelLevel * 100 / fuelStates.maxFuelLevel) <= 15 then fuelColor = "red"
        elseif math.floor(fuelStates.fuelLevel * 100 / fuelStates.maxFuelLevel) >= 85 then fuelColor = "green" end

        local FuelPercentage = math.floor(fuelStates.fuelLevel * 100 / fuelStates.maxFuelLevel)
        LuaUI.drawText(FuelPercentage .."%", fuelSettings.textposX, fuelSettings.textposY, 0, fuelSettings.textscale, Colour[fuelColor].r, Colour[fuelColor].g, Colour[fuelColor].b, true, false)
        local fuelSprite = "\\fuel_" .. fuelColor ..".dds"
        local fuelSpriteLocation = PATHS.root .. "\\scripts\\fuelMod\\sprites" .. fuelSprite
        fuelSpriteId = scriptdraw.register_sprite(fuelSpriteLocation)
        scriptdraw.draw_sprite(fuelSpriteId, fuelPos, fuelSettings.scale, 0, fuelCol)
    else
        if math.floor(fuelStates.fuelLevel * 100 / fuelStates.maxFuelLevel) <= 15 then
            LuaUI.drawText(string.format("Low Fuel: %i/%i", math.floor(fuelStates.fuelLevel), fuelStates.maxFuelLevel), 0.5, 0.945, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
            LuaUI.drawRect(0.5, 0.98, fuelStates.fuelLevel/400, 0.02, Colour.red)
        elseif math.floor(fuelStates.fuelLevel * 100 / fuelStates.maxFuelLevel) >= 85 then
            LuaUI.drawText(string.format("Fuel: %i/%i", math.floor(fuelStates.fuelLevel), fuelStates.maxFuelLevel), 0.5, 0.945, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
            LuaUI.drawRect(0.5, 0.98, fuelStates.fuelLevel/400, 0.02, Colour.green)
        else
            LuaUI.drawRect(0.5, 0.98, fuelStates.fuelLevel/400, 0.02, Colour.orange2)
            LuaUI.drawText(string.format("Fuel: %i/%i", math.floor(fuelStates.fuelLevel), fuelStates.maxFuelLevel), 0.5, 0.945, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
        end
    end
end

local function fuelMod()
    if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
        if fuelDepreciations[vehicle.get_vehicle_class(getMyCurrentVehicle())] > 0 then
            drawFuelBar()
            drawFuelMarkers()
        end
        fuelLevelDecreaseLevel()
        fuelLevelIncreaseLevel()
        insertCurrentVehicleInfomation()

        if fuelStates.fuelLevel == 0 then
            vehicle.set_vehicle_engine_on(getMyCurrentVehicle(), false, true, true)
        end 
    end
    if fuelStates.fuelLevel < 100 and ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 883325847 
        and Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), player.get_player_coords(player.player_id())) <= 1
    then
        fuelStates.fuelLevel = fuelStates.fuelLevel + fuelStates.fuelFill/1.5
    end
end

menu.add_feature("Realistic FuelMod", "toggle", 0, function(tog)
    while tog.on do
        fuelMod()
        system.wait(0)
    end
end)

--------------
-- SETTINGS --
--------------
local ParentId = menu.add_feature("Realistic FuelMod settings", "parent").id

-- DISPLAY MODE
local FuelModDisplay = menu.add_feature("Fuel gauge type", "action_value_str", ParentId, function(f)
	fuelSettings.displayMode = f.value
end):set_str_data({"Original (not editable)", "Modern"})

-- UI POSITION
local FuelModPosX = menu.add_feature("Position X", "autoaction_value_i", ParentId, function(f)
	fuelSettings.posX = f.value / 1000
end)
FuelModPosX.min = -1000
FuelModPosX.max = 1000
FuelModPosX.mod = 5
FuelModPosX.value = fuelSettings.posX * 1000

local FuelModPosY = menu.add_feature("Position Y", "autoaction_value_i", ParentId, function(f)
	fuelSettings.posY = f.value / 1000
end)
FuelModPosY.min = -1000
FuelModPosY.max = 1000
FuelModPosY.mod = 5
FuelModPosY.value = fuelSettings.posY * 1000

-- UI SCALE
local FuelModScale = menu.add_feature("Scale", "autoaction_slider", ParentId, function(f)
	fuelSettings.scale = Round(f.value, 2)
end)
FuelModScale.min = 0
FuelModScale.max = 0.5
FuelModScale.mod = 0.01
FuelModScale.value = fuelSettings.scale

-- TEXT POSITION
local FuelModTextPosX = menu.add_feature("Text position X", "autoaction_value_i", ParentId, function(f)
	fuelSettings.textposX = f.value / 1000
end)
FuelModTextPosX.min = 0
FuelModTextPosX.max = 1000
FuelModTextPosX.mod = 5
FuelModTextPosX.value = fuelSettings.textposX * 1000

local FuelModTextPosY = menu.add_feature("Text position Y", "autoaction_value_i", ParentId, function(f)
	fuelSettings.textposY = f.value / 1000
end)
FuelModTextPosY.min = 0
FuelModTextPosY.max = 1000
FuelModTextPosY.mod = 5
FuelModTextPosY.value = fuelSettings.textposY * 1000

-- TEXT SCALE
local FuelModScale = menu.add_feature("Text scale", "autoaction_slider", ParentId, function(f)
	fuelSettings.textscale = Round(f.value, 2)
end)
FuelModScale.min = 0
FuelModScale.max = 0.5
FuelModScale.mod = 0.01
FuelModScale.value = fuelSettings.textscale

local function loadConfig()
    local cfg = ini.parse "fuelMod\\config.ini"

    if cfg then
        fuelSettings.displayMode = cfg.displayMode
        fuelSettings.posX = cfg.posX
        fuelSettings.posY = cfg.posY
        fuelSettings.scale = cfg.scale
        fuelSettings.textscale = cfg.textscale
        fuelSettings.textposX = cfg.textposX
        fuelSettings.textposY = cfg.textposY
        notify(SCRIPT.NAME .. " v" .. SCRIPT.VERSION .. " successfully loaded.", nil, nil, LuaUI.RGBAToInt(255, 177, 0, 255))
    else notify("Failed to find config.ini", nil, nil, LuaUI.RGBAToInt(245, 5, 50, 255))
    end
end
loadConfig()

menu.add_feature("Save config", "action", ParentId, function()
    local file = io.open(PATHS.settings, "w")
    for k,v in pairs(fuelSettings) do
		file:write(tostring(k) .. "=" .. tostring(v) .. "\n")
	end
    file:close()
	notify("Saved settings.", nil, nil, LuaUI.RGBAToInt(0, 255, 0, 255))
    loadConfig()
end)

menu.add_feature("Reload config", "action", ParentId, function()
    loadConfig()
end)