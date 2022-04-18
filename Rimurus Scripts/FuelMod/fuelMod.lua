require("fuelMod\\LuaUI")
require("fuelMod\\stations")
local ini = require("fuelMod\\ini_parser")

local SCRIPT = {
    NAME = "Realistic FuelMod",
    VERSION = "1.3.0"
}

local usedVehicles = {}

local PATHS = {}
PATHS.root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
PATHS.settings = PATHS.root .. "\\scripts\\fuelMod\\config.ini"
local fuelSettings = {
    displayMode = 0,
    posX = -0.670,
    posY = -0.915,
    scale = 0.15,
    textscale = 0.3,
    textposX = 0.165,
    textposY = 0.97,
    stationsRange = 2.4,
    tankSize = 100,
    baseFuelLevel = 10,
    fuelFill = 0.25
}

local currentFuelLevel = fuelSettings.baseFuelLevel

local fuelDepreciations = {}
fuelDepreciations[0] = 0.25        --Compacts  
fuelDepreciations[1] = 0.85        --Sedans  
fuelDepreciations[2] = 1.0         --SUVs  
fuelDepreciations[3] = 0.35        --Coupes  
fuelDepreciations[4] = 1.0         --Muscle  
fuelDepreciations[5] = 1.15        --Sports Classics  
fuelDepreciations[6] = 1.25        --Sports  
fuelDepreciations[7] = 1.5         --Super  
fuelDepreciations[8] = 0.75        --Motorcycles  
fuelDepreciations[9] = 0.5         --Off-road  
fuelDepreciations[10] = 0.5        --Industrial  
fuelDepreciations[11] = 0.35       --Utility  
fuelDepreciations[12] = 0.35       --Vans  
fuelDepreciations[13] = 0          --Cycles  
fuelDepreciations[14] = 0          --Boats  
fuelDepreciations[15] = 0          --Helicopters  
fuelDepreciations[16] = 0          --Planes  
fuelDepreciations[17] = 0.45       --Service  
fuelDepreciations[18] = 0.45       --Emergency  
fuelDepreciations[19] = 0.65       --Military  
fuelDepreciations[20] = 0.75       --Commercial
fuelDepreciations[21] = 0          --Trains 
fuelDepreciations[22] = 1.85       --Open Wheel
fuelDepreciations.electrics = 0.95 --Electric

local function notify(msg, title, seconds, color)
    title = title or ScriptName
    menu.notify(msg, title, seconds, color)
    print(msg)
end

local function Round(num, dp)
    local mult = 10^(dp or 0)
    return math.floor(num * mult + 0.5)/mult
end

local function currentVehicle()
    return ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
end

local function insertCurrentVehicleInfomation()
    if usedVehicles.hash ~= currentVehicle() then
        table.insert(usedVehicles, {hash = currentVehicle(), fuelLevel = fuelSettings.baseFuelLevel})
    end
end

local function Get_Distance_Between_Coords(first, second)
    local x = second.x - first.x
    local y = second.y - first.y
    local z = second.z - first.z
    return math.sqrt(x * x + y * y + z * z)
end

local function IS_ELECTRIC()
    local EV = false
    local evList = {"VOLTIC2", "VOLTIC", "CYCLONE2", "CYCLONE", "TEZERACT", "IWAGEN", "NEON", "RAIDEN", "AIRTUG", "CADDY3", "CADDY2", "CADDY", "IMORGON", "KHAMEL", "DILETTANTE", "SURGE"}

    for k, v in pairs(evList) do
        if vehicle.get_vehicle_model_label(currentVehicle()) == v then 
            EV = true
        end
    end
    return EV
end

local function fuelLevelDecreaseLevel()
    if utils.time_ms() + 900000 > utils.time_ms() then
        if(currentFuelLevel > 0 and entity.get_entity_speed(currentVehicle()) > 4) then
            
            if IS_ELECTRIC() then currentFuelLevel = currentFuelLevel - (fuelDepreciations.electrics / 1000)
            else currentFuelLevel = currentFuelLevel - (fuelDepreciations[vehicle.get_vehicle_class(currentVehicle())] / 1000)
            end
          
            if currentFuelLevel < 0 then currentFuelLevel = 0 end
            if currentFuelLevel > fuelSettings.tankSize then currentFuelLevel = fuelSettings.tankSize end
        end
    end
end

local function CAN_REFUEL_CHECK()
    local isNearAnyStation = false
    
    for name, coords in pairs(Stations) do
        if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), coords) <= fuelSettings.stationsRange then 
            isNearAnyStation = true
        end
    end
    return isNearAnyStation
end

local function fuelLevelIncreaseLevel()
    if CAN_REFUEL_CHECK() then 
        if currentFuelLevel < fuelSettings.tankSize and entity.get_entity_speed(currentVehicle()) == 0 then
            currentFuelLevel = currentFuelLevel + fuelSettings.fuelFill
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
        if math.floor(currentFuelLevel * 100 / fuelSettings.tankSize) <= 15 then fuelColor = "red"
        elseif math.floor(currentFuelLevel * 100 / fuelSettings.tankSize) >= 85 then fuelColor = "green" end

        local FuelPercentage = math.floor(currentFuelLevel * 100 / fuelSettings.tankSize)
        LuaUI.drawText(FuelPercentage .."%", fuelSettings.textposX, fuelSettings.textposY, 0, fuelSettings.textscale, Colour[fuelColor].r, Colour[fuelColor].g, Colour[fuelColor].b, true, false)
        local fuelType = "fuel"
        if IS_ELECTRIC() then fuelType = "electric" end
        local fuelSprite = "\\" .. fuelType .. "_" .. fuelColor ..".dds"
        local fuelSpriteLocation = PATHS.root .. "\\scripts\\fuelMod\\sprites" .. fuelSprite
        fuelSpriteId = scriptdraw.register_sprite(fuelSpriteLocation)
        scriptdraw.draw_sprite(fuelSpriteId, fuelPos, fuelSettings.scale, 0, fuelCol)
    else
        local fuelType = "Fuel"
        if IS_ELECTRIC() then fuelType = "Battery" end

        if math.floor(currentFuelLevel * 100 / fuelSettings.tankSize) <= 15 then
            LuaUI.drawText(string.format("Low " .. fuelType .. ": %i/%i", math.floor(currentFuelLevel), fuelSettings.tankSize), 0.5, 0.945, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
            LuaUI.drawRect(0.5, 0.98, currentFuelLevel/400, 0.02, Colour.red)
        elseif math.floor(currentFuelLevel * 100 / fuelSettings.tankSize) >= 85 then
            LuaUI.drawText(string.format(fuelType .. ": %i/%i", math.floor(currentFuelLevel), fuelSettings.tankSize), 0.5, 0.945, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
            LuaUI.drawRect(0.5, 0.98, currentFuelLevel/400, 0.02, Colour.green)
        else
            LuaUI.drawRect(0.5, 0.98, currentFuelLevel/400, 0.02, Colour.orange2)
            LuaUI.drawText(string.format(fuelType .. ": %i/%i", math.floor(currentFuelLevel), fuelSettings.tankSize), 0.5, 0.945, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
        end
    end
end

local function fuelMod()
    if(ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
        if fuelDepreciations[vehicle.get_vehicle_class(currentVehicle())] > 0 then
            drawFuelBar()
            drawFuelMarkers()
        end
        fuelLevelDecreaseLevel()
        fuelLevelIncreaseLevel()
        insertCurrentVehicleInfomation()

        if currentFuelLevel == 0 then
            vehicle.set_vehicle_engine_on(currentVehicle(), false, true, true)
        end 
    end
    if currentFuelLevel < fuelSettings.tankSize and ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 883325847 
        and Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), player.get_player_coords(player.player_id())) <= 1
    then
        currentFuelLevel = currentFuelLevel + fuelSettings.fuelFill/1.5
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
local MainID = menu.add_feature("Realistic FuelMod settings", "parent").id
local UISettingsID = menu.add_feature("UI settings", "parent", MainID).id
-- DISPLAY MODE
local FuelModDisplay = menu.add_feature("Fuel gauge type", "action_value_str", UISettingsID, function(f)
	fuelSettings.displayMode = f.value
end):set_str_data({"Original (not editable)", "Modern"})

-- UI POSITION
local FuelModPosX = menu.add_feature("Position X", "autoaction_value_i", UISettingsID, function(f)
	fuelSettings.posX = f.value / 1000
end)
FuelModPosX.min = -1000
FuelModPosX.max = 1000
FuelModPosX.mod = 5
FuelModPosX.value = fuelSettings.posX * 1000

local FuelModPosY = menu.add_feature("Position Y", "autoaction_value_i", UISettingsID, function(f)
	fuelSettings.posY = f.value / 1000
end)
FuelModPosY.min = -1000
FuelModPosY.max = 1000
FuelModPosY.mod = 5
FuelModPosY.value = fuelSettings.posY * 1000

-- UI SCALE
local FuelModScale = menu.add_feature("Scale", "autoaction_slider", UISettingsID, function(f)
	fuelSettings.scale = Round(f.value, 2)
end)
FuelModScale.min = 0
FuelModScale.max = 0.5
FuelModScale.mod = 0.01
FuelModScale.value = fuelSettings.scale

-- TEXT POSITION
local FuelModTextPosX = menu.add_feature("Text position X", "autoaction_value_i", UISettingsID, function(f)
	fuelSettings.textposX = f.value / 1000
end)
FuelModTextPosX.min = 0
FuelModTextPosX.max = 1000
FuelModTextPosX.mod = 5
FuelModTextPosX.value = fuelSettings.textposX * 1000

local FuelModTextPosY = menu.add_feature("Text position Y", "autoaction_value_i", UISettingsID, function(f)
	fuelSettings.textposY = f.value / 1000
end)
FuelModTextPosY.min = 0
FuelModTextPosY.max = 1000
FuelModTextPosY.mod = 5
FuelModTextPosY.value = fuelSettings.textposY * 1000

-- TEXT SCALE
local FuelModScale = menu.add_feature("Text scale", "autoaction_slider", UISettingsID, function(f)
	fuelSettings.textscale = Round(f.value, 2)
end)
FuelModScale.min = 0
FuelModScale.max = 0.5
FuelModScale.mod = 0.01
FuelModScale.value = fuelSettings.textscale

-- REFILL RANGE
local FuelModRefillRange = menu.add_feature("Refill range in gas stations", "autoaction_slider", MainID, function(f)
	fuelSettings.stationsRange = Round(f.value, 2)
end)
FuelModRefillRange.min = 2.4
FuelModRefillRange.max = 12
FuelModRefillRange.mod = 0.5
FuelModRefillRange.value = fuelSettings.stationsRange

-- TANK SIZE
local FuelModTankSize = menu.add_feature("Default fuel tank size", "autoaction_value_i", MainID, function(f)
	fuelSettings.tankSize = f.value
end)
FuelModTankSize.min = 50
FuelModTankSize.max = 1000
FuelModTankSize.mod = 10
FuelModTankSize.value = fuelSettings.tankSize

-- REFUEL TIME
local FuelModFillTime = menu.add_feature("Refill time", "autoaction_slider", MainID, function(f)
	fuelSettings.fuelFill = Round(f.value, 2)
end)
FuelModFillTime.min = 0.0
FuelModFillTime.max = 1.0
FuelModFillTime.mod = 0.05
FuelModFillTime.value = fuelSettings.fuelFill

-- BASE FUEL LEVEL
local FuelModBaseFuel = menu.add_feature("Base fuel level", "autoaction_value_i", MainID, function(f)
    fuelSettings.baseFuelLevel = f.value
end)
FuelModBaseFuel.min = 0
FuelModBaseFuel.max = 1000
FuelModBaseFuel.mod = 10
FuelModBaseFuel.value = fuelSettings.baseFuelLevel

local function saveConfig()
    local file = io.open(PATHS.settings, "w")
    for k,v in pairs(fuelSettings) do
		file:write(tostring(k) .. "=" .. tostring(v) .. "\n")
	end
    file:close()
end

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
        fuelSettings.fuelFill = cfg.fuelFill
        fuelSettings.tankSize = cfg.tankSize
        fuelSettings.stationsRange = cfg.stationsRange
        fuelSettings.baseFuelLevel = cfg.baseFuelLevel
        notify(SCRIPT.NAME .. " v" .. SCRIPT.VERSION .. " successfully loaded.", nil, nil, LuaUI.RGBAToInt(255, 177, 0, 255))
    else 
        notify("Failed to find the config file, creating the default one !", nil, nil, LuaUI.RGBAToInt(245, 5, 50, 255))
        saveConfig()
    end
end
loadConfig()

menu.add_feature("Save config", "action", MainID, function()
    saveConfig()
	notify("Saved settings.", nil, nil, LuaUI.RGBAToInt(0, 255, 0, 255))
    loadConfig()
end)

menu.add_feature("Reload config", "action", MainID, function()
    loadConfig()
end)