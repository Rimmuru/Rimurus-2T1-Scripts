if REALISTIC_FUELMOD_LOADED  then
	ui.notify_above_map("Realistic FuelMod is already loaded", "Realistic FuelMod", 6)
	return
end

require("fuelMod\\LuaUI")
require("fuelMod\\stations")
local ini = require("fuelMod\\ini_parser")

local SCRIPT = {
    NAME = "Realistic FuelMod",
    VERSION = "2.0.0",
    CONFIG_LOADED = false
}

local usedVehicles = {}
local PATHS = {}
PATHS.root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
PATHS.fuelMod = PATHS.root .. "\\scripts\\fuelMod"
PATHS.settings = PATHS.root .. "\\scripts\\fuelMod\\config.ini"
local fuelSettings = {
    displayMode = 0,
    posX = -0.67,
    posY = -0.915,
    scale = 0.15,
    textscale = 0.3,
    textposX = 0.165,
    textposY = 0.97,
    stationsRange = 2.5,
    baseFuelLevel = 30,
    refuel = 1,
    manualRefuel = 0.5,
    consumptionRate = 1.0
}

local current = {
    FuelLevel = 30,
    TankSize = 100,
    latestHash = nil
}

local fuelConsumption = {}
-- VEHICLE TYPE = CONSUMPTION, TANK CAPACITY
fuelConsumption[0] = {5, 50} -- Compacts
fuelConsumption[1] = {7.5, 90} -- Sedans
fuelConsumption[2] = {9.5, 95} -- SUVs
fuelConsumption[3] = {8.5, 70} -- Coupes
fuelConsumption[4] = {10, 75} -- Muscle
fuelConsumption[5] = {8.5, 65} -- Sports Classics
fuelConsumption[6] = {7.5, 70} -- Sports
fuelConsumption[7] = {14.5, 100} -- Super
fuelConsumption[8] = {2.5, 25} -- Motorcycles
fuelConsumption[9] = {8.5, 75} -- Off-road
fuelConsumption[10] = {25, 300} -- Industrial
fuelConsumption[11] = {12.5, 150} -- Utility
fuelConsumption[12] = {9.5, 105} -- Vans
fuelConsumption[13] = {0, 0} -- Cycles
fuelConsumption[14] = {0, 0} -- Boats
fuelConsumption[15] = {0, 0} -- Helicopters
fuelConsumption[16] = {0, 0} -- Planes
fuelConsumption[17] = {7.5, 100} -- Service
fuelConsumption[18] = {4.5, 70} -- Emergency
fuelConsumption[19] = {6.5, 150} -- Military
fuelConsumption[20] = {30, 350} -- Commercial
fuelConsumption[21] = {0, 0} -- Trains 
fuelConsumption[22] = {25, 115} -- Open Wheel
fuelConsumption.electrics = {6.5, 100} -- Electric

local function notify(msg, title, seconds, color)
    --title = title or SCRIPT.NAME
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

local function file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

local function isEmpty(search) 
    return search == nil or search == ''
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

    for k,v in pairs(evList) do
        if vehicle.get_vehicle_model_label(currentVehicle()) == v then EV = true end
    end
    return EV
end

local function UPDATE_VEHICLE_DB()
    if isEmpty(usedVehicles[currentVehicle()]) then
        usedVehicles[currentVehicle()] = fuelSettings.baseFuelLevel / 100 * fuelConsumption[vehicle.get_vehicle_class(currentVehicle())][2]
        current.FuelLevel = fuelSettings.baseFuelLevel / 100 * fuelConsumption[vehicle.get_vehicle_class(currentVehicle())][2]
    else current.FuelLevel = usedVehicles[currentVehicle()] end
end

local function fuelLevelDecreaseLevel()
    if utils.time_ms() + 900000 > utils.time_ms() then
        if (current.FuelLevel > 0 and entity.get_entity_speed(currentVehicle()) > 4) then

            if IS_ELECTRIC() then current.FuelLevel = usedVehicles[currentVehicle()] - (fuelConsumption.electrics[1] / 10000) * fuelSettings.consumptionRate
                current.TankSize = fuelConsumption.electrics[2]
            else 
                current.FuelLevel = usedVehicles[currentVehicle()] - (fuelConsumption[vehicle.get_vehicle_class(currentVehicle())][1] / 10000) * fuelSettings.consumptionRate
                current.TankSize = fuelConsumption[vehicle.get_vehicle_class(currentVehicle())][2]
            end

            if current.FuelLevel < 0 then current.FuelLevel = 0 end
            if current.FuelLevel > current.TankSize then current.FuelLevel = current.TankSize end
            usedVehicles[currentVehicle()] = current.FuelLevel
        end
    end
end

local function CAN_REFUEL_CHECK()
    local isNearAnyStation = false
    for name,coords in pairs(stationsList) do
        if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), coords) <= fuelSettings.stationsRange then isNearAnyStation = true end
    end
    return isNearAnyStation
end

local AUTO_REFUEL_LOCK = false
local function fuelLevelIncreaseLevel()
    if CAN_REFUEL_CHECK() then
        if current.FuelLevel < current.TankSize and entity.get_entity_speed(currentVehicle()) == 0 and AUTO_REFUEL_LOCK == false then
            AUTO_REFUEL_LOCK = true
            current.FuelLevel = usedVehicles[currentVehicle()] + fuelSettings.refuel
            usedVehicles[currentVehicle()] = current.FuelLevel
            menu.create_thread(function()
                system.yield(250)
                AUTO_REFUEL_LOCK = false
            end, nil)
        end
        if (current.FuelLevel > current.TankSize) then current.FuelLevel = current.TankSize end
    end
end

local function drawFuelBar()
    if fuelSettings.displayMode == 1 then
        local posX = fuelSettings.posX
        local posY = fuelSettings.posY
        local fuelCol = LuaUI.RGBAToInt(255, 255, 255, 255)
        local fuelPos = v2(posX, posY)

        local fuelColor = "orange"
        if current.FuelLevel * 100 / current.TankSize <= 15 then fuelColor = "red"
        elseif current.FuelLevel * 100 / current.TankSize >= 75 then fuelColor = "green" end

        local FuelPercentage = Round(current.FuelLevel * 100 / current.TankSize, 0)
        LuaUI.drawText(math.floor(FuelPercentage) .. "%", fuelSettings.textposX, fuelSettings.textposY, 0, fuelSettings.textscale, Colour[fuelColor].r, Colour[fuelColor].g, Colour[fuelColor].b, true, false)
        local fuelType = "fuel"
        if IS_ELECTRIC() then fuelType = "electric" end
        local fuelSprite = "\\" .. fuelType .. "_" .. fuelColor .. ".dds"
        local fuelSpriteLocation = PATHS.root .. "\\scripts\\fuelMod\\sprites" .. fuelSprite
        fuelSpriteId = scriptdraw.register_sprite(fuelSpriteLocation)
        scriptdraw.draw_sprite(fuelSpriteId, fuelPos, fuelSettings.scale, 0, fuelCol)
    else
        local fuelType = "Fuel"
        if IS_ELECTRIC() then fuelType = "Battery" end
        if current.FuelLevel * 100 / current.TankSize <= 15 then
            LuaUI.drawText(string.format("Low " .. fuelType .. ": %i/%i", Round(current.FuelLevel, 0), current.TankSize), 0.5, 0.96, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
            LuaUI.drawRect(0.5, 0.99, (current.FuelLevel * 100 / current.TankSize) / 400, 0.015, Colour.red)
        elseif current.FuelLevel * 100 / current.TankSize >= 75 then
            LuaUI.drawText(string.format(fuelType .. ": %i/%i", Round(current.FuelLevel, 0), current.TankSize), 0.5, 0.96, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
            LuaUI.drawRect(0.5, 0.99, (current.FuelLevel * 100 / current.TankSize) / 400, 0.015, Colour.green)
        else
            LuaUI.drawRect(0.5, 0.99, (current.FuelLevel * 100 / current.TankSize) / 400, 0.015, Colour.orange)
            LuaUI.drawText(string.format(fuelType .. ": %i/%i", Round(current.FuelLevel, 0), current.TankSize), 0.5, 0.96, 0, 0.3, Colour.white.r, Colour.white.g, Colour.white.b, true, false)
        end
    end
end

local MANUAL_REFUEL_LOCK = false
local function MANUAL_REFUELLING()
    if MANUAL_REFUEL_LOCK == false then
        MANUAL_REFUEL_LOCK = true
        if usedVehicles[current.latestHash] < current.TankSize and ped.get_current_ped_weapon(player.get_player_ped(player.player_id())) == 883325847 and
            Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), player.get_player_coords(player.player_id())) <= 1 then
            usedVehicles[current.latestHash] = usedVehicles[current.latestHash] + fuelSettings.manualRefuel
            if (usedVehicles[current.latestHash] > current.TankSize) then usedVehicles[current.latestHash] = current.TankSize end
            notify("Vehicle manually refuelled at " .. Round(usedVehicles[current.latestHash], 2) .. "/" .. Round(current.TankSize, 0) .. ".", nil, 1, LuaUI.RGBAToInt(245, 128, 0, 255))
        end
        menu.create_thread(function()
            system.yield(500)
            MANUAL_REFUEL_LOCK = false
        end, nil)
    end
end

local function fuelMod()
    if (ped.is_ped_in_any_vehicle(player.get_player_ped(player.player_id()))) then
        if fuelConsumption[vehicle.get_vehicle_class(currentVehicle())][1] > 0 then
            drawFuelBar()
            drawFuelMarkers()
        end
        if IS_ELECTRIC() then current.TankSize = fuelConsumption.electrics[2]
        else current.TankSize = fuelConsumption[vehicle.get_vehicle_class(currentVehicle())][2] end
        UPDATE_VEHICLE_DB()
        fuelLevelDecreaseLevel()
        fuelLevelIncreaseLevel()
        if current.FuelLevel == 0 then vehicle.set_vehicle_engine_on(currentVehicle(), false, true, true) end
        current.latestHash = currentVehicle()
    end
    if not isEmpty(current.latestHash) then MANUAL_REFUELLING() end
end

local Realistic_FuelMod = menu.add_feature("Realistic FuelMod", "toggle", 0, function(tog)
    while tog.on do
        fuelMod()
        system.wait(0)
    end
end)

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

local FuelModPosY = menu.add_feature("Position Y", "autoaction_value_i", UISettingsID, function(f)
    fuelSettings.posY = f.value / 1000
end)
FuelModPosY.min = -1000
FuelModPosY.max = 1000
FuelModPosY.mod = 5

-- UI SCALE
local FuelModScale = menu.add_feature("Scale", "autoaction_slider", UISettingsID, function(f)
    fuelSettings.scale = Round(f.value, 2)
end)
FuelModScale.min = 0
FuelModScale.max = 2
FuelModScale.mod = 0.05

-- TEXT POSITION
local FuelModTextPosX = menu.add_feature("Text position X", "autoaction_value_i", UISettingsID, function(f)
    fuelSettings.textposX = f.value / 1000 
end)
FuelModTextPosX.min = 0
FuelModTextPosX.max = 1000
FuelModTextPosX.mod = 5

local FuelModTextPosY = menu.add_feature("Text position Y", "autoaction_value_i", UISettingsID, function(f)
    fuelSettings.textposY = f.value / 1000 
end)
FuelModTextPosY.min = 0
FuelModTextPosY.max = 1000
FuelModTextPosY.mod = 5

-- TEXT SCALE
local FuelModTextScale = menu.add_feature("Text scale", "autoaction_slider", UISettingsID, function(f)
    fuelSettings.textscale = Round(f.value, 2)
end)
FuelModTextScale.min = 0
FuelModTextScale.max = 2
FuelModTextScale.mod = 0.05

-- REFILL RANGE
local RefillRange = menu.add_feature("Refill range in gas stations", "autoaction_slider", MainID, function(f)
    fuelSettings.stationsRange = Round(f.value, 2) 
end)
RefillRange.min = 2.5
RefillRange.max = 25
RefillRange.mod = 0.5

-- REFUEL POWER
local Refuel = menu.add_feature("Refuelling power", "autoaction_value_f", MainID, function(f)
    fuelSettings.refuel = Round(f.value, 2)
end)
Refuel.min = 0.05
Refuel.max = 2.5
Refuel.mod = 0.05

-- MANUAL REFUEL POWER
local ManualRefuel = menu.add_feature("Manual Refuelling power", "autoaction_value_f", MainID, function(f)
    fuelSettings.manualRefuel = Round(f.value, 2)
end)
ManualRefuel.min = 0.05
ManualRefuel.max = 2.50
ManualRefuel.mod = 0.05

-- BASE FUEL LEVEL
local BaseFuel = menu.add_feature("Base fuel percentage", "autoaction_value_i", MainID, function(f)
    fuelSettings.baseFuelLevel = f.value
end)
BaseFuel.min = 0
BaseFuel.max = 100
BaseFuel.mod = 5

-- CONSUMPTION RATE
local ConsumptionRate = menu.add_feature("Fuel consumption rate", "autoaction_value_f", MainID, function(f)
    fuelSettings.consumptionRate = Round(f.value, 2)
end)
ConsumptionRate.min = 0.1
ConsumptionRate.max = 2.5
ConsumptionRate.mod = 0.1

local function saveConfig()
    local file = io.open(PATHS.settings, "w")
    for k,v in pairs(fuelSettings) do
        file:write(tostring(k) .. "=" .. tostring(v) .. "\n")
    end
    file:close()
end

local function defineSettingsValues()
    -- Define values according to default or config file
    FuelModPosX.value = fuelSettings.posX * 1000
    FuelModPosY.value = fuelSettings.posY * 1000
    FuelModScale.value = fuelSettings.scale
    FuelModTextPosY.value = fuelSettings.textposY * 1000
    FuelModTextPosX.value = fuelSettings.textposX * 1000
    FuelModTextScale.value = fuelSettings.textscale
    RefillRange.value = fuelSettings.stationsRange
    Refuel.value = fuelSettings.refuel
    ManualRefuel.value = fuelSettings.manualRefuel
    BaseFuel.value = fuelSettings.baseFuelLevel
    ConsumptionRate.value = fuelSettings.consumptionRate
end defineSettingsValues()

local function loadConfig()
    if file_exists(PATHS.fuelMod .. "\\config.ini") then
        local cfg = ini.parse("fuelMod\\config.ini")
        fuelSettings.displayMode = cfg.displayMode
        fuelSettings.posX = cfg.posX
        fuelSettings.posY = cfg.posY
        fuelSettings.scale = cfg.scale
        fuelSettings.textscale = cfg.textscale
        fuelSettings.textposX = cfg.textposX
        fuelSettings.textposY = cfg.textposY
        fuelSettings.stationsRange = cfg.stationsRange
        fuelSettings.refuel = cfg.refuel
        fuelSettings.manualRefuel = cfg.manualRefuel
        fuelSettings.baseFuelLevel = cfg.baseFuelLevel
        fuelSettings.consumptionRate = cfg.consumptionRate
        defineSettingsValues()
    else
        notify("Failed to find the config file, creating the default one !", nil, nil, LuaUI.RGBAToInt(245, 5, 50, 255))
        saveConfig()
        defineSettingsValues()
    end
end

menu.add_feature("Save config", "action", MainID, function()
    saveConfig()
    notify("Saved settings.", nil, nil, LuaUI.RGBAToInt(5, 245, 50, 255))
    loadConfig()
end)

menu.add_feature("Reload config", "action", MainID, function()
    loadConfig()
    notify("Config file reloaded.", nil, nil, LuaUI.RGBAToInt(5, 245, 50, 255))
end)

menu.create_thread(function()
    system.yield(10)
	Realistic_FuelMod.on = true
    notify(SCRIPT.NAME .. " v" .. SCRIPT.VERSION .. " successfully loaded.", nil, nil, LuaUI.RGBAToInt(245, 128, 0, 255))
    loadConfig()
end, nil)

REALISTIC_FUELMOD_LOADED = true

