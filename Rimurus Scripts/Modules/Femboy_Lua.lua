local version = "1.9.1"
local feats, feat_vals, feat_tv = {}, {}, {}
local appdata = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
local INI = IniParser(appdata .. "\\scripts\\FemboyMenu.ini")
-- save settings
local function SaveSettings()
    for k, v in pairs(feats) do
        INI:set_b("Toggles", k, v.on)
    end
    for k, v in pairs(feat_vals) do
        INI:set_f("Values", k, v.value)
    end
    for k, v in pairs(feat_tv) do
        INI:set_b("Toggles", k, v.on)
        INI:set_f("Values", k, v.value)
    end
    INI:write()
    menu.notify("Settings Saved", "Femboy Menu", 7, 0xFF00FF00)
end
-- load settings
local function LoadSettings()
    if INI:read() then
        for k, v in pairs(feats) do
            local exists, val = INI:get_b("Toggles", k)
            if exists then
                v.on = val
            end
        end
    
        for k, v in pairs(feat_vals) do
            local exists, val = INI:get_f("Values", k)
            if exists then
                v.value = val
            end
        end

        for k, v in pairs(feat_tv) do
            local exists, val = INI:get_b("Toggles", k)
            if exists then
                v.on = val
            end
            local exists, val = INI:get_f("Values", k)
            if exists then
                v.value = val
            end
        end

    end
end
-- end of save/load
-- script startup notif
local function NotifyMap(title, subtitle, msg, iconname, intcolor)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Script loaded, head to Script Features", "Femboy Lua" .. version)
    else
        native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
        native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
        native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
        native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
        native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
    end
end
NotifyMap("Femboy Lua ", version .. " ~h~~r~Femboy Lua Script", "~b~Script Loaded, head to Script Features", "CHAR_MP_STRIPCLUB_PR", 140) --no_u = invalid image / does not exist

menu.notify("Saved Settings, Loaded", "Femboy Menu")
-- parent
local main = menu.add_feature("Femboy Script", "parent", 0)
-- player options
    local popt = menu.add_feature("Player Options", "parent", main.id)
        local mone = menu.add_feature("Money Features", "parent", popt.id)
        local rgb = menu.add_feature("RGB Player Features", "parent", popt.id)
-- vehicle options
    local vehopt = menu.add_feature("Vehicle Options", "parent", main.id)
        menu.add_feature("--    Sub Menus    --", "action", vehopt.id) -- separator 
        local dorctrl = menu.add_feature("Door Control", "parent", vehopt.id)
        local vcol = menu.add_feature("Vehicle Customisation", "parent", vehopt.id)
            local col = menu.add_feature("Colour Customisation", "parent", vcol.id)
        local lightctrl = menu.add_feature("Light Control", "parent", vehopt.id)
        menu.add_feature("--------------------", "action", vehopt.id) -- separator  
-- online options
    local onlopt = menu.add_feature("Online Options", "parent", main.id)
        local modopt = menu.add_feature("Moderation Options", "parent", onlopt.id)
            local automod = menu.add_feature("Auto Kicker By Modder Flags Options", "parent", modopt.id)
            local countrykick = menu.add_feature("Auto Kicker By IP Options", "parent", modopt.id)
            local chatmodopt = menu.add_feature("Chat Moderation Options", "parent", modopt.id)
-- weather options
    local worldopt = menu.add_feature("World Options", "parent", main.id)
-- misc options
    local miscopt = menu.add_feature("Misc Options", "parent", main.id)
-- settings 
    local set = menu.add_feature("Settings", "parent", main.id)
-- credits
    local cred = menu.add_feature("Credits", "parent", main.id)
-- Online Script Features
    local mainpid = menu.add_player_feature("Femboy Script", "parent", 0)
        local grifopt = menu.add_player_feature("Griefing Options", "parent", mainpid.id)
        -- local iplookuppid = menu.add_player_feature("IP Shits", "parent", mainpid.id, function(f, pid) line 2571
-- end of parents
-- player option functions
-- Money Options
local monloop = menu.add_feature("NightClub Safe Loop", "value_i", mone.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_STATS) and not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals and Stats are required to be enabled in trusted mode to use this", "Femboy Menu")
        f.on=false
    elseif f.on then 
        while f.on do
            script.set_global_i(262145 + 24045, 300000)
            script.set_global_i(262145 + 24041, 300000) 
            stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 10000, true)
            stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_PAY_TIME_LEFT"), -1, true)
            stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 100000, true)
            stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 10000, true)
            stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_PAY_TIME_LEFT"), -1, true)
            stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 100000, true)
        system.wait(f.value)
        end
    end
end)
monloop.min = 0
monloop.max = 2500
monloop.mod = 100
monloop.value = 500

local muneloop = menu.add_feature("300k loop", "value_i", mone.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_STATS) and not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals and Stats are required to be enabled in trusted mode to use this", "Femboy Menu")
        f.on=false
    elseif f.on then 
        menu.notify("This feature is very temperamental", "Femboy Menu")
        while f.on do
            script.set_global_i(262145 + 24045, 300000)
            script.set_global_i(262145 + 24041, 300000) 
            stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 10000, true)
            stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_PAY_TIME_LEFT"), -1, true)
            stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 100000, true)
            stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 10000, true)
            stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_PAY_TIME_LEFT"), -1, true)
            stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 100000, true)
            system.wait(f.value)
            menu.get_feature_by_hierarchy_key("online.business.safes.cash_out_nightclub_safe"):toggle()
        system.wait()
        end
        script.set_global_i(262145 + 24045, 300000)
        script.set_global_i(262145 + 24041, 300000) 
        stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 10000, true)
        stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_PAY_TIME_LEFT"), -1, true)
        stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 100000, true)
        stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 10000, true)
        stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_PAY_TIME_LEFT"), -1, true)
        stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 100000, true)
    end
end)
muneloop.min = 0
muneloop.max = 5000
muneloop.mod = 100
muneloop.value = 500

menu.add_feature("Auto Special Cargo Supplier", "toggle", mone.id, function(f)
    if f.on then
        menu.notify("Notifications above map disabled to prevent spam, Make sure to disable this feature before unloading script", "Femboy Menu") 
    end
    while f.on do
        menu.get_feature_by_hierarchy_key("online.business.special_cargo.supply_cargo"):toggle()
        system.wait()
        native.call(0x32888337579A5970, f.on) -- hide feed
        system.wait()
    end
    native.call(0x15CFA549788D35EF) -- THEFEED_SHOW
    native.call(0xA8FDB297A8D25FBA) -- THEFEED_FLUSH_QUEUE
    menu.notify("Notifications above map enabled", "Femboy Menu")
end)
-- RGB Player Options
feat_tv.AllRGBHair = menu.add_feature("Loop All Hair Colours", "value_i", rgb.id, function(f)
    while f.on do
        local playerped = player.get_player_ped(player.player_id())
        for i = 0, 63 do
            ped.set_ped_hair_colors(playerped, i, i)
            if not f.on then
                break
            end
            system.wait(f.value)
        end
    end
end)
feat_tv.AllRGBHair.min = 0
feat_tv.AllRGBHair.max = 10000
feat_tv.AllRGBHair.mod = 50 

feat_tv.RGBHair = menu.add_feature("Rainbow Hair (better)", "value_i", rgb.id, function(f)
    while f.on do
        local playerped = player.get_player_ped(player.player_id())
        for i = 33, 53 do
            ped.set_ped_hair_colors(playerped, i, i)
            if not f.on then
                break
            end
            system.wait(f.value)
        end
    end
end)
feat_tv.RGBHair.min = 0
feat_tv.RGBHair.max = 10000
feat_tv.RGBHair.mod = 50 
-- 
feats.mobileradio = menu.add_feature("Mobile Radio", "toggle", popt.id, function(f)
    gameplay.set_mobile_radio(f.on)
end)

local notified = false
menu.add_feature("Ragdoll On Q", "value_str", popt.id, function(f)
    if not notified then
        menu.notify("Normal Ragdoll is recommended. Press Q to enable ragdoll, Press Q again to stand back up", "Femboy Menu")
        notified = true
    end
    while f.on do
        if (controls.is_control_just_pressed(0, 44) or controls.is_control_just_pressed(2, 44)) then
            local pid = player.player_ped()
            if ped.is_ped_ragdoll(pid) then
                ped.clear_ped_tasks_immediately(player.player_ped())
            else
                ped.set_ped_to_ragdoll(pid, 10000, 20000, f.value + 2)
            end
        end
        system.wait()
    end
end):set_str_data({"Narrow Leg Stumble", "Wide Leg Stumble", "Normal Ragdoll"})

feats.clumsy = menu.add_feature("Clumsy Player", "toggle", popt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            native.call(0xF0A4F1BBF4FA7497, player.player_ped(), true)
            system.wait()
        end
    end
end)
-- vehicle options
-- door control
menu.add_feature("Open All Doors", "action" , dorctrl.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    for i = 0 , 5 do
        vehicle.set_vehicle_door_open(veh , i , false , false)
    end
end)

local opendor = menu.add_feature("Open Door", "action_value_i" , dorctrl.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_door_open(veh , f.value , false , false)
end)
opendor.min = 0
opendor.max = 5
opendor.mod = 1

menu.add_feature("Close All Doors", "action" , dorctrl.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_doors_shut(veh, false)
end) 

menu.add_feature("Remove All Doors", "action" , dorctrl.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        for i = 0, 5 do
            native.call(0xD4D4F6A4AB575A33 , veh , i , true) -- SET_VEHICLE_DOOR_BROKEN
        end
    end
end)

local brkdor = menu.add_feature("Remove Specific Door", "action_value_i", dorctrl.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0xD4D4F6A4AB575A33 , veh , f.value, true) -- SET_VEHICLE_DOOR_BROKEN, true = delete, false = break
    end
end)
brkdor.min = 0
brkdor.max = 5
brkdor.mod = 1 
--VEH_EXT_DOOR_DSIDE_F = 0,
--VEH_EXT_DOOR_DSIDE_R = 1,
--VEH_EXT_DOOR_PSIDE_F = 2,
--VEH_EXT_DOOR_PSIDE_R = 3,
--VEH_EXT_BONNET = 4,
--VEH_EXT_BOOT = 5,

local wndwcol = menu.add_feature("Window Tint", "action_value_i", dorctrl.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        while feat.on do
            native.call(0x57C51E6BAD752696, veh, feat.value)
            system.wait(0)
        end
    end
end)
wndwcol.min = 0
wndwcol.max = 5
wndwcol.mod = 1

menu.add_feature("Windows Open/Close", "toggle", dorctrl.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        if feat.on then
            native.call(0x85796B0549DDE156, veh) -- ROLL_DOWN_WINDOWS
        else 
            for i = 0, 3 do
                native.call(0x602E548F46E24D59, veh, i) -- ROLL_UP_WINDOW
            end
        end
    end
end)
-- Vehicle Customisation
menu.add_feature("Set Custom License Plate", "action", vcol.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then

        repeat
            rtn, plate = input.get("Command box", "", 8, eInputType.IT_ASCII)
            if rtn == 2 then  rtn = 0 end
            system.wait(0)
        until rtn == 0
        
    vehicle.set_vehicle_number_plate_text(veh, plate)
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Keep Custom License Plate", "toggle", vcol.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    if player.is_player_in_any_vehicle(player.player_id()) then
        repeat
            rtn, plate = input.get("Input Custom Plate", "", 8, eInputType.IT_ASCII)
            if rtn == 2 then  rtn = 0 end
            system.wait(0)
        until rtn == 0
        vehicle.set_vehicle_number_plate_text(veh, plate)
        while f.on do
            local new_veh = player.get_player_vehicle(player.player_id())
            if new_veh ~= veh then  -- if the player has changed vehicles
                veh = new_veh
                local current_plate = vehicle.get_vehicle_number_plate_text(veh)  -- get the current license plate of the vehicle
                if current_plate ~= plate then  -- if the current license plate is not the desired value
                    vehicle.set_vehicle_number_plate_text(veh, plate)  -- update the license plate of the new vehicle
                end
            end
            system.wait()
        end
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Set Primary Hex/RGB Colour", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then

        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000 or 320765)", "", 6, eInputType.IT_ASCII)
            if rtn == 2 then return end
            system.wait(0)
        until rtn == 0

        local hex_colour = tonumber(colour, 16)
        vehicle.set_vehicle_custom_primary_colour(veh, hex_colour)
        menu.notify("Custom primary colour set to " .. colour, "Custom Colour")
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Set Secondary Hex/RGB Colour", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then

        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000 or 320765)", "", 6, eInputType.IT_ASCII)
            if rtn == 2 then return end
            system.wait(0)
        until rtn == 0

        local hex_colour = tonumber(colour, 16)
        vehicle.set_vehicle_custom_secondary_colour(veh, hex_colour)
        menu.notify("Custom secondary colour set to " .. colour, "Custom Colour")
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Set Pearlescent Hex/RGB Colour", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then

        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000 or 320765)", "", 6, eInputType.IT_ASCII)
            if rtn == 2 then return end
            system.wait(0)
        until rtn == 0

        local hex_colour = tonumber(colour, 16)
        vehicle.set_vehicle_custom_pearlescent_colour(veh, hex_colour)
        menu.notify("Custom pearlescent colour set to " .. colour, "Custom Colour")
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Set Wheel Hex/RGB Colour", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then

        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000 or 320765)", "", 6, eInputType.IT_ASCII)
            if rtn == 2 then return end
            system.wait(0)
        until rtn == 0

        local hex_colour = tonumber(colour, 16)
        vehicle.set_vehicle_custom_wheel_colour(veh, hex_colour)
        menu.notify("Custom primary colour set to " .. colour, "Custom Colour")
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Set Patriot Tyre Smoke", "action" , col.id, function()
    veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_tire_smoke_color(veh, 0 , 0, 0)
    menu.notify("Set tyre smoke color")
end) 

menu.add_feature("Get Primary Hex/RGB Value", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    
    if player.is_player_in_any_vehicle(player.player_id()) then
        local hex_colour = vehicle.get_vehicle_custom_primary_colour(veh)
        local colour = string.format("#%06X", hex_colour)
        menu.notify("Current primary colour is " .. colour, "Custom Colour")
    else
        menu.notify("How do you expect me to do this? you're not in a vehicle????", "Femboy Menu")
    end
end)    

menu.add_feature("Get Secondary Hex/RGB Value", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    
    if player.is_player_in_any_vehicle(player.player_id()) then
        local hex_colour = vehicle.get_vehicle_custom_secondary_colour(veh)
        local colour = string.format("#%06X", hex_colour)
        menu.notify("Current secondary colour is " .. colour, "Custom Colour")
    else
        menu.notify("Yeh i'll just get the secondary colour of your car, oh wait, no car?", "Femboy Menu")
    end
end)  

menu.add_feature("Get Pearlescent Hex/RGB Value", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    
    if player.is_player_in_any_vehicle(player.player_id()) then
        local hex_colour = vehicle.get_vehicle_custom_pearlescent_colour(veh)
        local colour = string.format("#%06X", hex_colour)
        menu.notify("Current pearlescent colour is " .. colour, "Custom Colour")
    else
        menu.notify("Take the hint from the prior 2, you're not in a car ffs", "Femboy Menu")
    end
end)  

menu.add_feature("Get Wheel Hex/RGB Value", "action", col.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    
    if player.is_player_in_any_vehicle(player.player_id()) then
        local hex_colour = vehicle.get_vehicle_custom_wheel_colour(veh)
        local colour = string.format("#%06X", hex_colour)
        menu.notify("Current wheel colour is " .. colour, "Custom Colour")
    else
        menu.notify("idfk, look down, your shoes are you wheels since you can't afford a car broke ass", "Femboy Menu")
    end
end)  
-- Light Control
feats.brake_lights = menu.add_feature("Brake Lights When Stationary", "toggle", lightctrl.id, function(feat)
    while feat.on do
        local veh = player.get_player_vehicle(player.player_id())
        local speed = entity.get_entity_speed(veh)
        if speed < 0.5 then 
            vehicle.set_vehicle_brake_lights(veh, true)
        end
        system.wait()
    end
end)

local rgbX = menu.add_feature("RGB Xenon", "value_i", lightctrl.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        menu.notify("Xenon Lights Added, BEGIN THE RAVE")
        native.call(0x2A1F4F37F95BAD08, veh, 22, f.on) -- TOGGLE_VEHICLE_MOD
        while f.on do
            local veh = player.get_player_vehicle(player.player_id())
                for i=1,12 do
                    native.call(0xE41033B25D003A07, veh, i) -- SET_VEHICLE_XENON_LIGHTS_COLOR
                    system.wait(f.value)
                end
            system.wait(0)
        end
    end
end)
rgbX.min = 0
rgbX.max = 2500
rgbX.mod = 100

local Hedlit = menu.add_feature("Headlight Brightness", "autoaction_value_f", lightctrl.id, function(f) 
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            local veh = player.get_player_vehicle(player.player_id())
            native.call(0xB385454F8791F57C, veh, f.value)
            system.wait()
        end
    end
end)
Hedlit.min = 0.0
Hedlit.max = 100.0
Hedlit.mod = 1.0
-- rest of vehicle options
local vehicleop = {
	"Annihilator Stealth", 
	"B-11 Strikeforce", 
	"Akula",
	"Pyro",
	"Scramjet", 
	"FH-1 Hunter", 
	"Vigilante", 
	"APC", 
	"Chernobog", 
	"Deluxo",
	"Ruiner 2000", 
	"P-996 LAZER", 
	"LF-22 Starling",
	"Hydra",
	"Thruster",
	"Stromberg", 
	"P-45 Nokota",
	"Oppressor", 
	"Oppressor Mk II",
	"Toreador",
	"Savage", 
	"Sea Sparrow",
	"Sparrow", 
	"V-65 Molotok", 
    "Buzzard Attack Chopper",
	"Anti-Aircraft Trailer", 
	"Rogue"
}
menu.add_feature("Homing Lockon To Players", "toggle", vehopt.id, function(f)
	local pedTable = {}
	streaming.request_model(gameplay.get_hash_key("cs_jimmydisanto"))
	local timer = utils.time_ms() + 1000
	while not streaming.has_model_loaded(gameplay.get_hash_key("cs_jimmydisanto")) and timer > utils.time_ms() do
		system.wait(0)
	end
	if timer < utils.time_ms()+900 and not streaming.has_model_loaded(gameplay.get_hash_key("cs_jimmydisanto")) then
		f.on = false
	end
	while f.on do
		system.wait(100)
		local player_vehicle = vehicle.get_vehicle_model(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
		local is_vehicle_in_table = false
		for i, v in ipairs(vehicleop) do
			if v == player_vehicle then
				is_vehicle_in_table = true
				break
			end
		end
		if is_vehicle_in_table then
			if not pedTable then
				pedTable = {}
			end
			for pid = 0, 31 do
				if player.is_player_valid(pid) and pid ~= player.player_id() and not pedTable[pid] and not entity.is_entity_dead(player.get_player_ped(pid)) then
					pedTable[pid] = ped.create_ped(4, gameplay.get_hash_key("cs_jimmydisanto"), player.get_player_coords(pid), 0, false, true)
					entity.set_entity_as_mission_entity(pedTable[pid], true, true)
					entity.attach_entity_to_entity(pedTable[pid], player.get_player_ped(pid), 0, v3(0, 0, 0), v3(0, 0, 0), true, false, false, 0, false)
				elseif not player.is_player_valid(pid) or entity.is_entity_dead(player.get_player_ped(pid)) or entity.is_entity_dead(pedTable[pid] or 0) then -- ez skid
					pedTable[pid] = nil
				end
			end
		elseif pedTable then
			for k, v in pairs(pedTable) do
				entity.detach_entity(v)
				entity.set_entity_as_no_longer_needed(v)
				entity.set_entity_coords_no_offset(v, v3(16000, 16000, -2000))
			end
			pedTable = nil
		end
		system.wait(0)
	end
	streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("cs_jimmydisanto"))
	if pedTable then
		for k, v in pairs(pedTable) do
			entity.detach_entity(v)
			entity.set_entity_as_no_longer_needed(v)
			entity.set_entity_coords_no_offset(v, v3(16000, 16000, -2000))
		end
		pedTable = nil
	end
end)

menu.add_feature("Fix Vehicle", "action", vehopt.id, function()
	vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()), true)
end)

feats.autorepair = menu.add_feature("Auto Repair", "toggle", vehopt.id, function(f)
    while f.on do
        local veh = player.player_vehicle()
        if veh then 
            local speed = entity.get_entity_speed(veh)
            if speed < 80 then 
                if vehicle.is_vehicle_damaged(veh) then
                    vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()), true)
                end
            elseif veh and speed > 81 then  
            end
        end
        system.wait(0.5)
    end
end)
if feats.autorepair.on then
    feats.autorepair.on = false
    feats.autorepair.on = true
end

local rattle = menu.add_feature("Engine Rattle", "value_f", vehopt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.player_vehicle()
        native.call(0x01BB4D577D38BD9E, veh, f.value, f.on)
    end
end)
rattle.min = 0.0
rattle.max = 1.0
rattle.mod = 0.1
rattle.value = 0.0

local dirtLevel = menu.add_feature("Dirt Level", "autoaction_value_f", vehopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        feat.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        while feat.value do
            native.call(0x79D3B596FE44EE8B, veh, feat.value)
            system.wait(0)
        end
    end
end)
dirtLevel.min = 0.0
dirtLevel.max = 15.0
dirtLevel.mod = 1.0

feats.stayclean = menu.add_feature("Stay Clean", "toggle", vehopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        feat.on=false
    else
        while feat.on do
            native.call(0x79D3B596FE44EE8B, player.get_player_vehicle(player.player_id()), 0)
            system.wait(0)
        end
    end
end)

local grvty = menu.add_feature("Gravity", "value_f", vehopt.id, function(f)
    while f.on do 
        vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), f.value)
        system.wait()
    end
    vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), 9.8)
end)
grvty.min = -5.0
grvty.max = 20.0
grvty.mod = 1.0

feats.airsuspension = menu.add_feature("Air Suspension", "toggle", vehopt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            system.wait()
            local veh = player.get_player_vehicle(player.player_id())
            local speed = entity.get_entity_speed(veh)
            if speed > 0.5 then
                native.call(0x3A375167F5782A65, veh, false)
            else
                native.call(0x3A375167F5782A65, veh, true)
            end
            system.wait()
        end
    end
    local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
    native.call(0x3A375167F5782A65, veh, false)
end)

feats.driftsuspension = menu.add_feature("Drift Suspension", "toggle", vehopt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        menu.notify("only works on vehicles released in the Tuners Update", "Femboy Menu")
        while f.on do 
            local veh = player.get_player_vehicle(player.player_id())
            native.call(0x3A375167F5782A65, veh, f.on) -- SET_REDUCE_DRIFT_VEHICLE_SUSPENSION(veh, bool) 
            system.wait()
        end
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0x3A375167F5782A65, veh, f.off)
    end
end) 

feats.drifttyres = menu.add_feature("Drift Tyres", "toggle", vehopt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            local veh = player.get_player_vehicle(player.player_id())
            native.call(0x5AC79C98C5C17F05, veh, f.on) -- SET_DRIFT_TYRES_ENABLED(veh, bool)
            system.wait()
        end
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0x5AC79C98C5C17F05, veh, f.off)
    end
end)

feats.launchcontrol = menu.add_feature("Launch Control", "toggle", vehopt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do 
            local veh = player.get_player_vehicle(player.player_id())
            native.call(0xAA6A6098851C396F,veh, f.on)
            system.wait()
        end
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0xAA6A6098851C396F,veh, f.off)
    end
end)

menu.add_feature("Exhaust Backfire", "value_str", vehopt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        if player.is_player_in_any_vehicle(player.player_id()) then 
            while f.on do 
                local veh = player.player_vehicle()
                native.call(0x2BE4BC731D039D5A, veh, f.value)
                system.wait()
            end
        end
    end
end):set_str_data({"Disable", "Enable"})

feat_tv.pwr = menu.add_feature("Power Increasinator", "value_i", vehopt.id, function(f)
    while f.on do
        local veh = player.get_player_vehicle(player.player_id())
        vehicle.modify_vehicle_top_speed(veh, f.value)
        system.wait()
    end
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.modify_vehicle_top_speed(veh, 1)
end)
feat_tv.pwr.min = 0
feat_tv.pwr.max = 10000
feat_tv.pwr.mod = 10

feat_tv.veh_max_speed = menu.add_feature("Speed Limiter (Mph)", "value_f", vehopt.id, function(f)
    while f.on do
    local veh = player.get_player_vehicle(player.player_id())
        if veh then
            entity.set_entity_max_speed(veh, (f.value / 2.236936))
        end
        system.wait(0)
    end
    local veh = player.get_player_vehicle(player.player_id())
    entity.set_entity_max_speed(veh, 155)
end)
feat_tv.veh_max_speed.min = 1.0
feat_tv.veh_max_speed.max = 10000.0
feat_tv.veh_max_speed.mod = 5.0
feat_tv.veh_max_speed.value = 155.0

menu.add_feature("Speedometer", "value_str", vehopt.id, function(f)
    while f.on do
    local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
    local mph
    
        ui.set_text_scale(0.35)
        ui.set_text_font(0)
        ui.set_text_centre(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_outline(true)
    
            if f.value == 0 then
                ui.draw_text(math.floor(speed * 2.236936).." Mph", v2(0.5, 0.95))
            end
            if f.value == 1 then
                ui.draw_text(math.floor(speed * 3.6).." Kph", v2(0.5, 0.95))
            end
            if f.value == 2 then
                ui.draw_text(math.floor(speed * 1.943844).." kt", v2(0.5, 0.95))
            end
            if f.value == 3 then
                ui.draw_text(string.format("%.2f", speed * 0.00291545) .. " Mach", v2(0.5, 0.95))
            end
            if f.value == 4 then
                ui.draw_text(math.floor(speed).." mps", v2(0.5, 0.95))
            end
        system.wait(0)
    end
    
end):set_str_data({"Mph", "Kph", "Knots", "Mach", "Metres per second"})

local fwdlaunch = menu.add_feature("Launch Forward", "action_slider", vehopt.id, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0xAB54A438726D25D5, veh, f.value)
    end
end)
fwdlaunch.min = 0.0
fwdlaunch.max = 10000.0
fwdlaunch.mod = 50.0

menu.add_feature("Turn Engine Off", "action", vehopt.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0x2497C4717C8B881E, veh, 0, 0, true)
    end
end)
	
menu.add_feature("Kill engine", "action", vehopt.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        menu.notify("next bit of damage will kill the car, gl", "Femboy Menu")
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0x45F6D8EEF34ABEF1, veh, 0)
    end
end)

menu.add_feature("Notify Engine Health" , "action" , vehopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        local veh = player.get_player_vehicle(player.player_id())
        local enginehealth = native.call(0xC45D23BAF168AAB8 , veh):__tonumber() --GET_VEHICLE_ENGINE_HEALTH
        menu.notify("Engine health is " .. enginehealth .. ".", "Femboy Menu")
    end
end)
-- end of vehicle options
-- online options
menu.add_feature("Force Host", "toggle", onlopt.id, function(f)
    while f.on do
        local ped = player.player_id() -- get the player's ID
        if player.is_player_host(ped) then
            menu.notify("You Are Host", "Femboy Menu")
            f.on = false
        else 
            for pid = 0, 31 do
                local host = player.get_host()
                if host ~= ped then 
                    network.force_remove_player(host)
                    menu.notify("Getting Host", "Femboy Menu")
                end
            end
        end
        system.wait()
    end
end)
-- aim karma
local function request_model(hash, timeout)
	streaming.request_model(2859440138)
	local timer = utils.time_ms() + (timeout or 1000)
	while timer > utils.time_ms() and not streaming.has_model_loaded(2859440138) do
	  	system.wait(0)
	end
	return streaming.has_model_loaded(2859440138)
end

local autoaim = menu.add_feature("Aim Karma", "parent", onlopt.id)
local function APv2(f)
    local PlayerPed = player.get_player_ped(player.player_id())
    while f.on do 
        if APv2 then
            for pid = 0, 31 do -- for every player in the lobby 
                if player.is_player_valid(pid) == true then -- if the player matches an ID then 
                    local AimingAt = player.get_entity_player_is_aiming_at(pid) -- gets the entity a player is aiming at
                    local EnemyPos = player.get_player_coords(pid) -- gets the coords of the player above
                    ------ below is for the effects for the str
                    if AimingAt == PlayerPed then --- if ped being aimed at is the same as player ped, then do the following

                        if notifykarma then
                            menu.notify(player.get_player_name(pid) .. " aimed at you", "Femboy Menu")
                        end

                        if kickkarma then
                            network.force_remove_player(pid)
                            menu.notify(player.get_player_name(pid) .. " was kicked for aiming at you", "Femboy Menu")
                        end

                        if tazekarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 911657153, player.player_ped(), true, false, 100)
                        end

                        if killkarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 10000, 3219281620, player.player_ped(), true, false, 100)
                        end

                        if explokarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 1672152130, player.player_ped(), true, false, 100)
                        end

                        if firewrkkarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2138347493, player.player_ped(), true, false, 100)
                        end

                        if atomkarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2939590305, player.player_ped(), true, false, 100)
                        end

                        if tankkarma then
                            local playerloc = player.get_player_coords(pid) 
                            playerloc.z = playerloc.z + 2.7
                            request_model(2859440138)
                            vehicle.create_vehicle(2859440138, playerloc, 0, true, false)
                        end

                    end
                end    
            end
        end
        system.wait()
    end
end
feats.enableaimkarma = menu.add_feature("Enable Aim Karma", "toggle", autoaim.id, function(f)
    if f.on then
        APv2(f)
    end
end)
menu.add_feature("--------------------", "action", autoaim.id)
feats.notifykarma = menu.add_feature("Notify If Aimed At", "toggle", autoaim.id, function(f)
    notifykarma = f.on
end)
feats.kickkarma = menu.add_feature("Kick Player", "toggle", autoaim.id, function(f)
    kickkarma = f.on
end)
feats.tazekarma = menu.add_feature("Taze Player", "toggle", autoaim.id, function(f)
    tazekarma = f.on
end)
feats.killkarma = menu.add_feature("Kill Player", "toggle", autoaim.id, function(f)
    killkarma = f.on
end)
feats.explokarma = menu.add_feature("Explode Player", "toggle", autoaim.id, function(f)
    explokarma = f.on 
end)
feats.firewrkkarma = menu.add_feature("Firework Player", "toggle", autoaim.id, function(f)
    firewrkkarma = f.on 
end)
feats.atomkarma = menu.add_feature("Atomize Player (with damage)", "toggle", autoaim.id, function(f)
    atomkarma = f.on 
end)
feats.tankkarma = menu.add_feature("Crush Player", "toggle", autoaim.id, function(f)
    tankkarma = f.on 
end)
-- IP Lookup
local iplookup = menu.add_feature("IP Lookup", "parent", onlopt.id)
local function capitalise_first_letter(str)
    return str:sub(1, 1):upper()..str:sub(2, #str)
end
local ip_feats = {}
menu.add_feature("Press here to enter IP", "action", iplookup.id, function(f)
	repeat
		rtn, ip = input.get("Enter IP", "", 20, eInputType.IT_ASCII)
		if rtn == 2 then return end
		system.wait(0)
	until rtn == 0
    local response, my_info = web.get("http://ip-api.com/json/" .. ip .. "?fields=66846719")
    if response == 200 then
        for name, value in my_info:gmatch('",*"*(.-)":"*([^,"]*)"*,*') do -- goes through every line that matches `"smth": "value",`
          if not ip_feats[name] then -- checks if the feature already exists or not, if it doesnt exist then it creates one and stores it into ip_feats table
            ip_feats[name] = menu.add_feature(capitalise_first_letter(name), "action_value_str", iplookup.id)
          end
		  ip_feats[name].hidden = false
          ip_feats[name]:set_str_data({value}) -- updates str_data to have the value
        end
    else
        print("Error.")
    end
end)
menu.add_feature("                                    -- IP Info --                                        ", "action", iplookup.id)
ip_feats["query"] = menu.add_feature("Query", "action_value_str", iplookup.id)
ip_feats["query"].hidden = true
-- moderation options
-- Auto Kicker By Modder Flags Options
feats.automoder = menu.add_feature("Enable Auto Moderation", "toggle", automod.id)
local function kickPlayersForFlag(flag)
    if not feats.automoder.on then return end
        for pid = 0, 31 do
            if player.is_player_modder(pid, flag) then
                network.force_remove_player(pid)
                menu.notify(string.format("Player %s (ID: %d) has been kicked for having the %s modder flag", player.get_player_name(pid), pid, player.get_modder_flag_text(flag)), "Kick Player")
            end
        end
end
menu.add_feature("--------------------", "action", automod.id)
feats.manual = menu.add_feature("Manual flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_MANUAL)
        system.wait()
    end
end)
feats.model = menu.add_feature("Player Model flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_PLAYER_MODEL)
        system.wait()
    end
end)
feats.scidspoof = menu.add_feature("SCID Spoof flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SCID_SPOOF)
        system.wait()
    end
end)
feats.invobject = menu.add_feature("Invalid Object flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_INVALID_OBJECT)
        system.wait()
    end
end)
feats.pedcrash = menu.add_feature("Invalid Ped Crash flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_INVALID_PED_CRASH)
        system.wait()
    end
end)  
feats.modelcrash = menu.add_feature("Model Change Crash flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_MODEL_CHANGE_CRASH)
        system.wait()
    end
end)   
feats.modelchange = menu.add_feature("Player Model Change flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_PLAYER_MODEL_CHANGE)
        system.wait()
    end
end)    
feats.racflag = menu.add_feature("RAC flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_RAC)
        system.wait()
    end
end)
feats.moneydrop = menu.add_feature("Money Drop flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_MONEY_DROP)
        system.wait()
    end
end)    
feats.sep = menu.add_feature("SEP flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SEP)
        system.wait()
    end
end)  
feats.attachobject = menu.add_feature("Attach Object flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_ATTACH_OBJECT)
        system.wait()
    end
end)  
feats.attachped = menu.add_feature("Attach Ped flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_ATTACH_PED)
        system.wait()
    end
end) 
feats.netarraycrash = menu.add_feature("Net Array Crash flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_NET_ARRAY_CRASH)
        system.wait()
    end
end)
feats.netsynccrash = menu.add_feature("Net Sync Crash flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SYNC_CRASH)
        system.wait()
    end
end)
feats.neteventcrash = menu.add_feature("Net Event Crash flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_NET_EVENT_CRASH)
        system.wait()
    end
end)
feats.hosttoken = menu.add_feature("Host Token flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_HOST_TOKEN)
        system.wait()
    end
end)
feats.sespam = menu.add_feature("SE Spam flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SE_SPAM)
        system.wait()
    end
end)
feats.frameflags = menu.add_feature("Frame Flags flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_FRAME_FLAGS)
        system.wait()
    end
end)
feats.ipspoof = menu.add_feature("IP Spoof flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_IP_SPOOF)
        system.wait()
    end
end)
feats.karenflag = menu.add_feature("Karen flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_KAREN)
        system.wait()
    end
end)
feats.sessionmismatch = menu.add_feature("Session Mismatch flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SESSION_MISMATCH)
        system.wait()
    end
end)
feats.soundspam = menu.add_feature("Sound Spam flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SOUND_SPAM)
        system.wait()
    end
end)
feats.sepint = menu.add_feature("SEP INT flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SEP_INT)
        system.wait()
    end
end)
feats.suspiciousactivity = menu.add_feature("Suspicious Activity flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_SUSPICIOUS_ACTIVITY)
        system.wait()
    end
end)
feats.chatspoof = menu.add_feature("Chat Spoof flag", "toggle", automod.id, function(f)
    while f.on do
        kickPlayersForFlag(eModderDetectionFlags.MDF_CHAT_SPOOF)
        system.wait()
    end
end)
-- Auto Kicker By IP Options
local function dec_to_ipv4(ip)
    if ip then
        return string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255)
    end
end
local cheese = {
	{name = "Afghanistan", code = "AF"},
	{name = "Albania", code = "AL"},
	{name = "Algeria", code = "DZ"},
	{name = "American Samoa", code = "AS"},
	{name = "Andorra", code = "AD"},
	{name = "Angola", code = "AO"},
	{name = "Anguilla", code = "AI"},
	{name = "Antarctica", code = "AQ"},
	{name = "Antigua and Barbuda", code = "AG"},
	{name = "Argentina", code = "AR"},
	{name = "Armenia", code = "AM"},
	{name = "Aruba", code = "AW"},
	{name = "Australia", code = "AU"},
	{name = "Austria", code = "AT"},
	{name = "Azerbaijan", code = "AZ"},
	{name = "Bahamas", code = "BS"},
	{name = "Bahrain", code = "BH"},
	{name = "Bangladesh", code = "BD"},
	{name = "Barbados", code = "BB"},
	{name = "Belarus", code = "BY"},
	{name = "Belgium", code = "BE"},
	{name = "Belize", code = "BZ"},
	{name = "Benin", code = "BJ"},
	{name = "Bermuda", code = "BM"},
	{name = "Bhutan", code = "BT"},
	{name = "Bolivia", code = "BO"},
	{name = "Bonaire, Sint Eustatius and Saba", code = "BQ"},
	{name = "Bosnia and Herzegovina", code = "BA"},
	{name = "Botswana", code = "BW"},
	{name = "Bouvet Island", code = "BV"},
	{name = "Brazil", code = "BR"},
	{name = "British Indian Ocean Territory", code = "IO"},
	{name = "Brunei Darussalam", code = "BN"},
	{name = "Bulgaria", code = "BG"},
	{name = "Burkina Faso", code = "BF"},
	{name = "Burundi", code = "BI"},
	{name = "Cabo Verde", code = "CV"},
	{name = "Cambodia", code = "KH"},
	{name = "Cameroon", code = "CM"},
	{name = "Canada", code = "CA"},
	{name = "Cayman Islands", code = "KY"},
	{name = "Central African Republic", code = "CF"},
	{name = "Chad", code = "TD"},
	{name = "Chile", code = "CL"},
	{name = "China", code = "CN"},
	{name = "Christmas Island", code = "CX"},
	{name = "Cocos (Keeling) Islands", code = "CC"},
	{name = "Colombia", code = "CO"},
	{name = "Comoros", code = "KM"},
	{name = "Congo CD", code = "CD"},
	{name = "Congo CG", code = "CG"},
	{name = "Cook Islands", code = "CK"},
	{name = "Costa Rica", code = "CR"},
	{name = "Croatia", code = "HR"},
	{name = "Cuba", code = "CU"},
	{name = "Curaçao", code = "CW"},
	{name = "Cyprus", code = "CY"},
	{name = "Czechia", code = "CZ"},
	{name = "Côte d'Ivoire", code = "CI"},
	{name = "Denmark", code = "DK"},
	{name = "Djibouti", code = "DJ"},
	{name = "Dominica", code = "DM"},
	{name = "Dominican Republic", code = "DO"},
	{name = "Ecuador", code = "EC"},
	{name = "Egypt", code = "EG"},
	{name = "El Salvador", code = "SV"},
	{name = "Equatorial Guinea", code = "GQ"},
	{name = "Eritrea", code = "ER"},
	{name = "Estonia", code = "EE"},
	{name = "Eswatini", code = "SZ"},
	{name = "Ethiopia", code = "ET"},
	{name = "Falkland Islands [Malvinas]", code = "FK"},
	{name = "Faroe Islands", code = "FO"},
	{name = "Fiji", code = "FJ"},
	{name = "Finland", code = "FI"},
	{name = "France", code = "FR"},
	{name = "French Guiana", code = "GF"},
	{name = "French Polynesia", code = "PF"},
	{name = "French Southern Territories", code = "TF"},
	{name = "Gabon", code = "GA"},
	{name = "Gambia", code = "GM"},
	{name = "Georgia", code = "GE"},
	{name = "Germany", code = "DE"},
	{name = "Ghana", code = "GH"},
	{name = "Gibraltar", code = "GI"},
	{name = "Greece", code = "GR"},
	{name = "Greenland", code = "GL"},
	{name = "Grenada", code = "GD"},
	{name = "Guadeloupe", code = "GP"},
	{name = "Guam", code = "GU"},
	{name = "Guatemala", code = "GT"},
	{name = "Guernsey", code = "GG"},
	{name = "Guinea", code = "GN"},
	{name = "Guinea-Bissau", code = "GW"},
	{name = "Guyana", code = "GY"},
	{name = "Haiti", code = "HT"},
	{name = "Heard Island and McDonald Islands", code = "HM"},
	{name = "Holy See", code = "VA"},
	{name = "Honduras", code = "HN"},
	{name = "Hong Kong", code = "HK"},
	{name = "Hungary", code = "HU"},
	{name = "Iceland", code = "IS"},
	{name = "India", code = "IN"},
	{name = "Indonesia", code = "ID"},
	{name = "Iran", code = "IR"},
	{name = "Iraq", code = "IQ"},
	{name = "Ireland", code = "IE"},
	{name = "Isle of Man", code = "IM"},
	{name = "Israel", code = "IL"},
	{name = "Italy", code = "IT"},
	{name = "Jamaica", code = "JM"},
	{name = "Japan", code = "JP"},
	{name = "Jersey", code = "JE"},
	{name = "Jordan", code = "JO"},
	{name = "Kazakhstan", code = "KZ"},
	{name = "Kenya", code = "KE"},
	{name = "Kiribati", code = "KI"},
	{name = "Korea KP", code = "KP"},
	{name = "Korea KR", code = "KR"},
	{name = "Kuwait", code = "KW"},
	{name = "Kyrgyzstan", code = "KG"},
	{name = "Lao People's Democratic Republic", code = "LA"},
	{name = "Latvia", code = "LV"},
	{name = "Lebanon", code = "LB"},
	{name = "Lesotho", code = "LS"},
	{name = "Liberia", code = "LR"},
	{name = "Libya", code = "LY"},
	{name = "Liechtenstein", code = "LI"},
	{name = "Lithuania", code = "LT"},
	{name = "Luxembourg", code = "LU"},
	{name = "Macao", code = "MO"},
	{name = "Madagascar", code = "MG"},
	{name = "Malawi", code = "MW"},
	{name = "Malaysia", code = "MY"},
	{name = "Maldives", code = "MV"},
	{name = "Mali", code = "ML"},
	{name = "Malta", code = "MT"},
	{name = "Marshall Islands", code = "MH"},
	{name = "Martinique", code = "MQ"},
	{name = "Mauritania", code = "MR"},
	{name = "Mauritius", code = "MU"},
	{name = "Mayotte", code = "YT"},
	{name = "Mexico", code = "MX"},
	{name = "Micronesia", code = "FM"},
	{name = "Moldova", code = "MD"},
	{name = "Monaco", code = "MC"},
	{name = "Mongolia", code = "MN"},
	{name = "Montenegro", code = "ME"},
	{name = "Montserrat", code = "MS"},
	{name = "Morocco", code = "MA"},
	{name = "Mozambique", code = "MZ"},
	{name = "Myanmar", code = "MM"},
	{name = "Namibia", code = "NA"},
	{name = "Nauru", code = "NR"},
	{name = "Nepal", code = "NP"},
	{name = "Netherlands", code = "NL"},
	{name = "New Caledonia", code = "NC"},
	{name = "New Zealand", code = "NZ"},
	{name = "Nicaragua", code = "NI"},
	{name = "Niger", code = "NE"},
	{name = "Nigeria", code = "NG"},
	{name = "Niue", code = "NU"},
	{name = "Norfolk Island", code = "NF"},
	{name = "Northern Mariana Islands", code = "MP"},
	{name = "Norway", code = "NO"},
	{name = "Oman", code = "OM"},
	{name = "Pakistan", code = "PK"},
	{name = "Palau", code = "PW"},
	{name = "Palestine, State of", code = "PS"},
	{name = "Panama", code = "PA"},
	{name = "Papua New Guinea", code = "PG"},
	{name = "Paraguay", code = "PY"},
	{name = "Peru", code = "PE"},
	{name = "Philippines", code = "PH"},
	{name = "Pitcairn", code = "PN"},
	{name = "Poland", code = "PL"},
	{name = "Portugal", code = "PT"},
	{name = "Puerto Rico", code = "PR"},
	{name = "Qatar", code = "QA"},
	{name = "Republic of North Macedonia", code = "MK"},
	{name = "Romania", code = "RO"},
	{name = "Russian Federation", code = "RU"},
	{name = "Rwanda", code = "RW"},
	{name = "Réunion", code = "RE"},
	{name = "Saint Barthélemy", code = "BL"},
	{name = "Saint Helena", code = "SH"},
	{name = "Saint Kitts and Nevis", code = "KN"},
	{name = "Saint Lucia", code = "LC"},
	{name = "Saint Martin (French part)", code = "MF"},
	{name = "Saint Pierre and Miquelon", code = "PM"},
	{name = "Saint Vincent and the Grenadines", code = "VC"},
	{name = "Samoa", code = "WS"},
	{name = "San Marino", code = "SM"},
	{name = "Sao Tome and Principe", code = "ST"},
	{name = "Saudi Arabia", code = "SA"},
	{name = "Senegal", code = "SN"},
	{name = "Serbia", code = "RS"},
	{name = "Seychelles", code = "SC"},
	{name = "Sierra Leone", code = "SL"},
	{name = "Singapore", code = "SG"},
	{name = "Sint Maarten (Dutch part)", code = "SX"},
	{name = "Slovakia", code = "SK"},
	{name = "Slovenia", code = "SI"},
	{name = "Solomon Islands", code = "SB"},
	{name = "Somalia", code = "SO"},
	{name = "South Africa", code = "ZA"},
	{name = "South Georgia and the South Sandwich Islands", code = "GS"},
	{name = "South Sudan", code = "SS"},
	{name = "Spain", code = "ES"},
	{name = "Sri Lanka", code = "LK"},
	{name = "Sudan", code = "SD"},
	{name = "Suriname", code = "SR"},
	{name = "Svalbard and Jan Mayen", code = "SJ"},
	{name = "Sweden", code = "SE"},
	{name = "Switzerland", code = "CH"},
	{name = "Syrian Arab Republic", code = "SY"},
	{name = "Taiwan", code = "TW"},
	{name = "Tajikistan", code = "TJ"},
	{name = "Tanzania", code = "TZ"},
	{name = "Thailand", code = "TH"},
	{name = "Timor-Leste", code = "TL"},
	{name = "Togo", code = "TG"},
	{name = "Tokelau", code = "TK"},
	{name = "Tonga", code = "TO"},
	{name = "Trinidad and Tobago", code = "TT"},
	{name = "Tunisia", code = "TN"},
	{name = "Turkey", code = "TR"},
	{name = "Turkmenistan", code = "TM"},
	{name = "Turks and Caicos Islands", code = "TC"},
	{name = "Tuvalu", code = "TV"},
	{name = "Uganda", code = "UG"},
	{name = "Ukraine", code = "UA"},
	{name = "United Arab Emirates", code = "AE"},
	{name = "United Kingdom of Great Britain and Northern Ireland", code = "GB"},
	{name = "United States Minor Outlying Islands", code = "UM"},
	{name = "United States of America", code = "US"},
	{name = "Uruguay", code = "UY"},
	{name = "Uzbekistan", code = "UZ"},
	{name = "Vanuatu", code = "VU"},
	{name = "Venezuela", code = "VE"},
	{name = "Viet Nam", code = "VN"},
	{name = "Virgin Islands (British)", code = "VG"},
	{name = "Virgin Islands (U.S.)", code = "VI"},
	{name = "Wallis and Futuna", code = "WF"},
	{name = "Western Sahara", code = "EH"},
	{name = "Yemen", code = "YE"},
	{name = "Zambia", code = "ZM"},
	{name = "Zimbabwe", code = "ZW"},
	{name = "Aland Islands", code = "AX"}
}
menu.add_feature("Enable", "toggle", countrykick.id, function(f)
	if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_HTTP) then 
		menu.notify("HTTP trusted mode must be enabled to use this.", "Femboy Menu")
		f.on=false
	else
		while f.on do
			for pid = 0,31 do
				local player_ip = player.get_player_ip(pid)
				local response, info = web.get("http://ip-api.com/json/" .. dec_to_ipv4(player_ip) .."?fields=2")
				if response == 200 then
					for _, v in pairs(cheese) do
						if v.on and pid ~= player.player_id() then
							if string.find(info, v.code) then
								menu.notify(string.format("Player %s (IP: %s) is from " .. v.name .. "! Removing them now for you! :D", player.get_player_name(pid), dec_to_ipv4(player_ip)), "Location Detection")
								network.force_remove_player(pid)
							end
						end
					end
				end
			end
			system.wait(3000)
		end
	end
end)
menu.add_feature("Enable All", "toggle", countrykick.id, function(f)    
    menu.notify("if you enable this and then ask why you keep getting kicked from lobbies, im going to treat you like a retard, so make sure to check twice.", "Femboy Lua")
    for _, feat in pairs(countrykick.children) do
        if feat ~= f and feat.name ~= "Enable" then
          feat.on = f.on
        end
    end
end)
for _, v in pairs(cheese) do
    menu.add_feature("Auto Kick " .. v.name, "toggle", countrykick.id, function(f)
        v.on = f.on
    end)
end
-- Chat Moderation Options
local racismfilter = {
	"assnigger",
    "assnigga",
    "Assnigger",
    "Assnigga", 
    "beaner", 
    "Beaner",
    "coon", 
    "Coon",  
    "chink", 
    "Chink", 
    "chinc", 
    "Chink", 
    "gook", 
    "Gook", 
    "guido", 
    "Guido", 
    "jap", 
    "Jap", 
    "jigaboo", 
    "Jigaboo", 
    "negro", 
    "Negro", 
    "nigaboo", 
    "Nigaboo", 
    "niggaboo", 
    "Niggaboo", 
    "nigga", 
    "Nigga", 
    "nigger", 
    "Nigger", 
    "niggerish", 
    "Niggerish",
    "niggers", 
    "Niggers", 
    "niglet", 
    "nigglet",
    "Niglet", 
    "Nigglet", 
    "nignog", 
    "Nignog", 
    "paki", 
    "Paki", 
    "porch monkey", 
    "Porch Monkey", 
    "porchmonkey", 
    "Porchmonkey", 
    "sand nigger", 
    "sandnigger", 
    "Sand Nigger", 
    "Sandnigger",
    "spic", 
    "spick", 
    "Spic", 
    "Spick",  
    "wetback", 
    "Wetback",  
    "ASSNIGGER",
    "ASSNIGGA",
    "BEANER", 
    "COON",
    "CHINK", 
    "CHINC", 
    "GOOK", 
    "JAP", 
    "JIGABOO",  
    "NEGRO", 
    "NIGABOO", 
    "NIGGABOO", 
    "NIGGA", 
    "NIGGER", 
    "NIGGERISH", 
    "NIGGERS", 
    "NIGLET", 
    "NIGGLET", 
    "NIGNOG", 
    "PAKI",  
    "PORCH MONKEY", 
    "PORCHMONKEY",  
    "SAND NIGGER", 
    "SANDNIGGER",
    "SPIC", 
    "SPICK",  
    "WETBACK"
}
local f = function(s)
	for k,v in pairs(racismfilter) do
		if s:find(v) then
			return true
		end
	end
	return false
end
feats.blockracism = menu.add_feature("Block Racism", "toggle", chatmodopt.id, function(func)
    if func.on then
        racism = event.add_event_listener("chat", function(e)
	        if f(e.body) then
		        menu.notify(player.get_player_name(e.sender) .. " was removed for being too much of an edgelord", "Femboy Menu")
		        network.force_remove_player(e.sender)
	        end
        end)
    else 
        event.remove_event_listener("chat", racism)
    end
end)
local homophobicfilter = {
    "dike", 
    "dyke", 
    "fag", 
    "faggit", 
    "faggot", 
    "fagtard", 
    "fag tard", 
    "gay fuck", 
    "homo",
    "tranny", 
    "DIKE", 
    "DYKE", 
    "FAG", 
    "FAGGIT", 
    "FAGGOT", 
    "FAGTARD", 
    "FAG TARD", 
    "GAY FUCK", 
    "HOMO",
    "TRANNY", 
    "Dike", 
    "Dyke", 
    "Fag", 
    "Faggit", 
    "Faggot", 
    "Fagtard", 
    "Fag Tard", 
    "Gay Fuck", 
    "Homo",
    "Tranny", 
    "dIKE", 
    "dYKE", 
    "fAG", 
    "fAGGIT", 
    "fAGGOT", 
    "fAGTARD", 
    "fAG tARD", 
    "gAY fUCK", 
    "hOMO",
    "tRANNY"
}
local f = function(s)
	for k,v in pairs(homophobicfilter) do
		if s:find(v .. " ") or s:find(" " .. v) or s:find("^" .. v .. "$") then
			return true
		end
	end
	return false
end
feats.blockhomophobia = menu.add_feature("Block Homophobia", "toggle", chatmodopt.id, function(func)
    if func.on then
        homophobic = event.add_event_listener("chat", function(e)
	        if f(e.body) then
		        menu.notify(player.get_player_name(e.sender) .. " was removed for being too much of an edgelord, probably gets pegged :shrug:", "Femboy Menu")
		        network.force_remove_player(e.sender)
	        end
        end)
    else 
        event.remove_event_listener("chat", homophobic)
    end
end)
local botspam = {
	"gtagta.cc",
    "discord.gg/"
}
local f = function(s)
	for k,v in pairs(botspam) do
		if s:find(v) then
			return true
		end
	end
	return false
end
local messages = {}
local max_repeats = 3
feats.chatspam = menu.add_feature("Block Bot/Chat Spam", "toggle", chatmodopt.id, function(func)
    if func.on then
        spam = event.add_event_listener("chat", function(e)
	        local sender = e.sender
	        local message = e.body
	        if e.sender ~= player.player_id() then
                if not messages[sender] then
                    messages[sender] = {
                        count = 0,
                        last_message = ""
                    }
                end
                if message == messages[sender].last_message then
                    messages[sender].count = messages[sender].count + 1
                else
                    messages[sender].count = 0
                    messages[sender].last_message = message
                end                
                if f(message) or messages[sender].count >= max_repeats then
                    for pid = 0,31 do 
                        menu.notify(player.get_player_name(e.sender) .. " was removed for Chat Spam, likely an ad bot or just annoying", "Femboy Menu") 
                        network.force_remove_player(e.sender)
                    end
                    messages[sender].count = 0
                    messages[sender].last_message = message
                end
            end
        end)
    end
end)
local blockfrench= {
    "le",
    "la",
    "de",
    "et",
    "les",
    "des",
    "un",
    "une",
    "du",
    "en",
    "à",
    "se",
    "pas",
    "ce",
    "qui",
    "que",
    "ou",
    "mais",
    "pour",
    "dans",
    "sur",
    "par",
    "sa",
    "ses",
    "je",
    "tu",
    "il", 
    "elle", 
    "ils",
    "elles",
    "nous",
    "vous",
    "Le",
    "La",
    "De",
    "Et",
    "Les",
    "Des",
    "Un",
    "Une",
    "Du",
    "En",
    "à",
    "Se",
    "Pas",
    "Ce",
    "Qui",
    "Que",
    "Ou",
    "Mais",
    "Pour",
    "Dans",
    "Sur",
    "Par",
    "Sa",
    "Ses",
    "Je",
    "Tu",
    "Il", 
    "Elle", 
    "Ils",
    "Elles",
    "Nous",
    "Vous",
    "LE",
    "LA",
    "DE",
    "ET",
    "LES",
    "DES",
    "UN",
    "UNE",
    "DU",
    "EN",
    "À",
    "SE",
    "PAS",
    "CE",
    "QUI",
    "QUE",
    "OU",
    "MAIS",
    "POUR",
    "DANS",
    "SUR",
    "PAR",
    "SA",
    "SES",
    "JE",
    "TU",
    "IL", 
    "ELLE", 
    "ILS",
    "ELLES",
    "NOUS",
    "VOUS"
}
local f = function(s)
	for k,v in pairs(blockfrench) do
		if s:find(v .. " ") or s:find(" " .. v) or s:find("^" .. v .. "$") then
			return true
		end
	end
	return false
end
feats.blockfrench = menu.add_feature("Block French", "toggle", chatmodopt.id, function(func)
    if func.on then
        french = event.add_event_listener("chat", function(e)
	        if f(e.body) then
		        menu.notify(player.get_player_name(e.sender) .. " was removed for speaking Fr*nch", "Femboy Menu")
		        network.force_remove_player(e.sender)
	        end
        end)
    else 
        event.remove_event_listener("chat", french)
    end
end)
local blockdutch= {
    "de",
    "een",
    "ik",
    "van",
    "te",
    "dat",
    "op",
    "en",
    "met",
    "aan",
    "voor",
    "door",
    "naar",
    "ze",
    "er",
    "bij",
    "dit",
    "ja",
    "nee",
    "wel",
    "maar",
    "als",
    "het",
    "zo",
    "om",
    "heb",
    "De",
    "Een",
    "Ik",
    "Van",
    "Te",
    "Dat",
    "Op",
    "En",
    "Met",
    "Aan",
    "Voor",
    "Door",
    "Naar",
    "Ze",
    "Er",
    "Bij",
    "Dit",
    "Ja",
    "Nee",
    "Wel",
    "Maar",
    "Als",
    "Het",
    "Zo",
    "Om",
    "Heb",
    "DE",
    "EEN",
    "IK",
    "VAN",
    "TE",
    "DAT",
    "OP",
    "EN",
    "MET",
    "AAN",
    "VOOR",
    "DOOR",
    "NAAR",
    "ZE",
    "ER",
    "BIJ",
    "DIT",
    "JA",
    "NEE",
    "WEL",
    "MAAR",
    "ALS",
    "HET",
    "ZO",
    "OM",
    "HEB",
    "Kanker",
    "kanker", 
    "KANKER"
    -- cope aren
}
local f = function(s)
	for k,v in pairs(blockdutch) do
		if s:find(v .. " ") or s:find(" " .. v) or s:find("^" .. v .. "$") then
			return true
		end
	end
	return false
end
feats.blockdutch = menu.add_feature("Block Dutch", "toggle", chatmodopt.id, function(func)
    if func.on then
        dutch = event.add_event_listener("chat", function(e)
	        if f(e.body) then
		        menu.notify(player.get_player_name(e.sender) .. " was removed for speaking Dutch", "Femboy Menu")
		        network.force_remove_player(e.sender)
	        end
        end)
    else 
        event.remove_event_listener("chat", dutch)
    end
end)
local blockrussian= {
    "б",
    "в",
    "г",
    "д",
    "е",
    "ё",
    "ж",
    "з",
    "и",
    "й",
    "к",
    "л",
    "м",
    "н",
    "о",
    "п",
    "р",
    "с",
    "т",
    "у",
    "ф",
    "х",
    "ц",
    "ч",
    "ш",
    "щ",
    "ъ",
    "ы",
    "ь",
    "э",
    "ю",
    "я",
}
local f = function(s)
	for k,v in pairs(blockrussian) do
		if s:find(v) then
			return true
		end
	end
	return false
end
feats.blockrussian = menu.add_feature("Block Russian", "toggle", chatmodopt.id, function(func)
    if func.on then
        russian = event.add_event_listener("chat", function(e)
	        if f(e.body) then
		        menu.notify(player.get_player_name(e.sender) .. " was removed for speaking Russian", "Femboy Menu")
		        network.force_remove_player(e.sender)
	        end
        end)
    else 
        event.remove_event_listener("chat", russian)
    end
end)
local chinese = {
	"汉字",
    "字母",
    "字符",
    "拼音",
    "介绍",
    "区位码",
    "字体",
    "码位",
    "码表",
    "编码",
    "编号",
    "名称",
    "类型",
    "指针",
    "结构",
    "记录",
    "技术",
    "规范",
    "标准",
    "语言",
    "文字",
    "文化",
    "历史",
    "传统",
    "文学",
    "艺术",
    "科学",
    "技术",
    "教育",
    "培训",
    "训练",
    "知识",
    "理解",
    "能力",
    "思维",
    "创造",
    "研究",
    "研究所",
    "博物馆",
    "图书馆",
    "学院",
    "大学",
    "校园",
    "教室",
    "教师",
    "学生",
    "课程",
    "考试",
    "成绩",
    "学位",
    "论文",
    "题目",
    "摘要",
    "关键词",
    "引用",
    "参考文献",
    "文献综述",
    "书籍",
    "论著",
    "期刊",
    "论文集",
    "手册",
    "指南",
    "参考书",
    "教材",
    "教科书",
    "词典",
    "词汇",
    "语"
}
local f = function(s)
	for k,v in pairs(chinese) do
		if s:find(v) then
			return true
		end
	end
	return false
end
feats.blockchinese = menu.add_feature("Block Chinese", "toggle", chatmodopt.id, function(func)
    if func.on then
        china = event.add_event_listener("chat", function(e)
	        if f(e.body) then
		        menu.notify(player.get_player_name(e.sender) .. " was removed for speaking Chinese", "Femboy Menu")
		        network.force_remove_player(e.sender)
	        end
        end)
    else 
        event.remove_event_listener("chat", china)
    end
end)
local blockenglish= {
    "the",
    "be",
    "to",
    "of",
    "and",
    "a",
    "in",
    "that",
    "have",
    "I",
    "it",
    "for",
    "not",
    "on",
    "with",
    "he",
    "as",
    "you",
    "do",
    "at",
    "this",
    "but",
    "his",
    "by",
    "from",
    "they",
    "we",
    "say",
    "her",
    "she",
    "or",
    "an",
    "will",
    "my",
    "one",
    "all",
    "would",
    "there",
    "their",
    "The",
    "Be",
    "To",
    "Of",
    "And",
    "A",
    "In",
    "That",
    "Have",
    "I",
    "It",
    "For",
    "Not",
    "On",
    "With",
    "He",
    "As",
    "You",
    "Do",
    "At",
    "This",
    "But",
    "His",
    "By",
    "From",
    "They",
    "We",
    "Say",
    "Her",
    "She",
    "Or",
    "An",
    "Will",
    "My",
    "One",
    "All",
    "Would",
    "There",
    "Their", 
    "THE",
    "BE",
    "TO",
    "OF",
    "AND",
    "A",
    "IN",
    "THAT",
    "HAVE",
    "I",
    "IT",
    "FOR",
    "NOT",
    "ON",
    "WITH",
    "HE",
    "AS",
    "YOU",
    "DO",
    "AT",
    "THIS",
    "BUT",
    "HIS",
    "BY",
    "FROM",
    "THEY",
    "WE",
    "SAY",
    "HER",
    "SHE",
    "OR",
    "AN",
    "WILL",
    "MY",
    "ONE",
    "ALL",
    "WOULD",
    "THERE",
    "THEIR"
}
local f = function(s)
	for k,v in pairs(blockenglish) do
		if s:find(v) then
			return true
		end
	end
	return false
end
menu.add_feature("Block English", "toggle", chatmodopt.id, function(func)
    if func.on then
        english = event.add_event_listener("chat", function(e)
	        if f(e.body) then
		        menu.notify(player.get_player_name(e.sender) .. " was removed for speaking English", "Femboy Menu")
		        network.force_remove_player(e.sender)
	        end
        end)
    else 
        event.remove_event_listener("chat", english)
    end
end)
-- World Options
local distancescale = menu.add_feature("Distance Scale", "value_f", worldopt.id, function(f)
    menu.notify("This will effect your FPS massively", "Femboy Menu")
    while f.on do
        native.call(0xA76359FC80B2438E, f.value)
        system.wait()
    end
    native.call(0xA76359FC80B2438E, 1.0)
end)
distancescale.min=0.0
distancescale.max=200.0
distancescale.mod=0.5

menu.add_feature("Make Nearby NPC's Riot", "toggle", worldopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        native.call(0x2587A48BC88DFADF, feat.on)
    end
end)

menu.add_feature("Blackout", "toggle", worldopt.id, function(f)
    gameplay.set_blackout(f.on)
end)

local rainlvl = menu.add_feature("Magic puddles", "autoaction_value_f", worldopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
            menu.notify("Natives are required to be enabled to use this feature", "Femboy Menu")
            f.on=false
        else
            native.call(0x643E26EA6E024D92, feat.value)
        end
    end
end)
rainlvl.min = 0.0
rainlvl.max = 10.0
rainlvl.mod = 0.5

local windspd = menu.add_feature("Wind speed", "autoaction_value_f", worldopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        native.call(0xEE09ECEDBABE47FC, feat.value)
    end
end)
windspd.min = 0.0
windspd.max = 12.0
windspd.mod = 0.5

local waveint = menu.add_feature("Wave Intensity", "value_f", worldopt.id, function(f)
    if f.on then 
        water.set_waves_intensity(f.value)
    else  
        water.reset_waves_intensity()
    end
end)
waveint.min = 0.0
waveint.max = 1000.0
waveint.value = 1
waveint.mod = 10.0
-- misc options
feats.playerstalking = menu.add_feature("Show Player Talking", "toggle", miscopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        if feat.on then
            local IsTalking = {}
            while true do
                system.yield(100)
                for pid = 0, 31 do
                    if player.is_player_valid(pid) then
                        if native.call(0x031E11F3D447647E, pid):__tointeger() == 1 then
                            if not IsTalking[pid] then
                                menu.notify(player.get_player_name(pid) .. " started talking", "Femboy Script")
                                IsTalking[pid] = true
                            end
                        else
                            if IsTalking[pid] then
                                menu.notify(player.get_player_name(pid) .. " stopped talking", "Femboy Script")
                                IsTalking[pid] = false
                            end
                        end
                    end
                end
            end
        end
    end
end, nil)

menu.add_feature("Bail To SP", "action", miscopt.id, function(f)
    if native.call(0x580CE4438479CC61) then
        native.call(0x95914459A87EBA28, 0, 0, 0)
    end
end)

feats.skipcutscene = menu.add_feature("Auto Skip Cutscene", "toggle", miscopt.id, function(f)
    while f.on do
        if cutscene.is_cutscene_playing() then
            cutscene.stop_cutscene_immediately()
        end
        system.wait(0)
    end
end)

local mmdisco = menu.add_feature("Minimap Disco" , "value_i" , miscopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while feat.on do
            for i = 208, 213 do
                native.call(0x6B1DE27EE78E6A19 , i)
                system.wait(feat.value)
            end
            system.wait(0)
        end
    end
end)
mmdisco.min = 0
mmdisco.max = 2500
mmdisco.mod = 100
mmdisco.value = 100 

menu.add_feature("Get All Achievements", "action", miscopt.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        for i=1,77 do
            native.call(0xBEC7076D64130195, i)
        end
    end
end)

menu.add_feature("Hide HUD", "toggle", miscopt.id, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        if feat.on then
            native.call(0xA6294919E56FF02A, false)
            native.call(0xA0EBB943C300E693, false)
        else 
            native.call(0xA6294919E56FF02A, true)
            native.call(0xA0EBB943C300E693, true)
        end
    end
end)
-- settings
menu.add_feature("Save Settings", "action", set.id, function(f)
    SaveSettings()
end)

menu.add_feature("F8 To Save Settings", "toggle", set.id, function(f)
    while f.on do
        if controls.is_control_just_pressed(0, 169) or controls.is_control_just_pressed(2, 169) and f.on then
            SaveSettings()
        end
    system.wait()
    end
end).on=true

menu.add_feature("Femboy Lua Changelog", "action", set.id, function(f)
    menu.notify("#FFC0CBFF#https://github.com/Decuwu/femboylua/blob/main/Changelog.md #FFFFFFFF#copied to clipboard, paste it in your browser url to see the scripts changelog", "Femboy Menu")
    utils.to_clipboard("https://github.com/Decuwu/femboylua/blob/main/Changelog.md")
end)

menu.add_feature("Femboy Lua Feature List", "action", set.id, function(f)
    menu.notify("#FFC0CBFF#https://github.com/Decuwu/femboylua/blob/main/Femboy.md #FFFFFFFF#copied to clipboard, paste it in your browser url to see the scripts feature list", "Femboy Menu")
    utils.to_clipboard("https://github.com/Decuwu/femboylua/blob/main/Femboy.md")
end)

-- VPN Checker - thank you so much ghost
local function dec_to_ipv4(ip)
    if ip then
        return string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255)
    end
end
local flagged_players = {} 
local enable_vpn_check = true
menu.add_feature("Disable VPN Check", "toggle", set.id, function(f)
    if f.on then
        enable_vpn_check = not enable_vpn_check
    else 
        check_vpn(pid)
    end
end)
local function check_vpn(pid)
    if not enable_vpn_check then return end
    system.wait(1000)
    local paramType = type(pid)
    if paramType == "table" or paramType == "userdata" then
        pid = pid.player
    end
    local player_parent = menu.get_feature_by_hierarchy_key("online.online_players.player_"..pid)
    local ip = player.get_player_ip(pid)
    local response, my_info = web.get("http://ip-api.com/json/" .. dec_to_ipv4(ip) .."?fields=131072")
    if response == 200 then
        if string.find(my_info, "true") then
            menu.notify(player.get_player_name(pid) .. " was flagged for using a VPN", "Femboy Lua VPN Checker")
            if not player_parent.name:find("VPN") then
                player_parent.name = player_parent.name .. " #FFC0CBFF#[VPN]"
                flagged_players[pid] = true 
            end
        end     
    else
        print("Error.")
    end
end
local vpnListener = event.add_event_listener("player_join", check_vpn)
menu.create_thread(function()
    if network.is_session_started() then -- does a check when you change session
        for i = 0, 31 do
            check_vpn(i)
        end
    end
    for i = 0, 31 do
        if player.is_player_valid(i) then -- does a check for everyone in the session when loading the script
            check_vpn(i)
            system.wait(100)
        end
    end
end)
menu.create_thread(function() -- check if the player has been flagged before, if yes then give the flag back
    while true do
        for pid, v in pairs(flagged_players) do
            local player_parent = menu.get_feature_by_hierarchy_key("online.online_players.player_"..pid)
            if not player_parent.name:find("VPN") then
                local name = ""
                player_parent.name = player_parent.name .. " #FFC0CBFF#[VPN]"
            end
        end
        system.wait(3000)
    end
end)
-- end of settings
-- credits
menu.add_feature("Toph", "action", cred.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Helped an absolute BUNCH with understanding the API and helped with a lot of features!", "Toph")
    else
        local function NotifyMap(title, subtitle, msg, iconname, intcolor)
            native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
            native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
            native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
            native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
            native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
    end
end
NotifyMap("Topher", "~h~~r~The Gopher", "~b~Helped an absolute BUNCH with understanding the API and helped with a lot of features!", "CHAR_HAO", 140) --no_u = invalid image / does not exist
end)
menu.add_feature("Rimuru", "action", cred.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("'let' me learn LUA using her script and gave me many helpful tips", "Rimuru")
    else
        local function NotifyMap(title, subtitle, msg, iconname, intcolor)
            native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
            native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
            native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
            native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
            native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
    end
end
NotifyMap("Rimuru", "~h~~r~Wannabe Welsh", "~b~'let' me learn LUA using her script and gave me many helpful tips", "CHAR_WENDY", 140) --no_u = invalid image / does not exist
end)
menu.add_feature("GhostOne", "action", cred.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("I ask him for help, he give help ez pz. made: Homing lockon, VPN flag, IP info shit", "GhostOne")
    else
        local function NotifyMap(title, subtitle, msg, iconname, intcolor)
            native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
            native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
            native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
            native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
            native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
    end
end
NotifyMap("GhostOne", "~h~~r~Has Cheese", "~b~I ask him for help, he give help ez pz. Also, he make code, i steal", "CHAR_TAXI", 140) --no_u = invalid image / does not exist
end)
menu.add_feature("Aren", "action", cred.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Helped me a lot with LUA at the beginning, taught me how to use natives", "Aren")
    else
        local function NotifyMap(title, subtitle, msg, iconname, intcolor)
            native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
            native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
            native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
            native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
            native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
    end
end
NotifyMap("Aren", "~h~~r~Mostly Cringe", "~b~Helped me a lot with LUA at the beginning, taught me how to use natives", "CHAR_JIMMY", 140) --no_u = invalid image / does not exist
end)
menu.add_feature("RulyPancake", "action", cred.id, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then 
        menu.notify("Made the 'Show Player Talking' feature", "RulyPancake")
    else
        local function NotifyMap(title, subtitle, msg, iconname, intcolor)
            native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
            native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
            native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
            native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
            native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
    end
end
NotifyMap("RulyPancake", "~h~~r~4th, 5th, 6th, idk anymore", "~b~Made the 'Show Player Talking' feature", "CHAR_JOE", 140) --no_u = invalid image / does not exist
end)
-- Online Script Features Options
-- Griefing Options
local function request_model(hash, timeout)
	streaming.request_model(2859440138)
	local timer = utils.time_ms() + (timeout or 1000)
	while timer > utils.time_ms() and not streaming.has_model_loaded(2859440138) do
	  	system.wait(0)
	end
	return streaming.has_model_loaded(2859440138)
end
menu.add_player_feature("Crush Player", "action", grifopt.id, function(f, pid)
    local playerloc = player.get_player_coords(pid) 
    playerloc.z = playerloc.z + 2.7
	request_model(2859440138)
	vehicle.create_vehicle(2859440138, playerloc, 0, true, false)
end)

menu.add_player_feature("Taze Player", "toggle", grifopt.id, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 911657153, player.player_ped(), true, false, 100)
        system.wait()
    end
end)

menu.add_player_feature("Firework Player", "toggle", grifopt.id, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2138347493, player.player_ped(), true, false, 100)
        system.wait()
    end
end)

menu.add_player_feature("Atomize Player", "toggle", grifopt.id, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2939590305, player.player_ped(), true, false, 100)
        system.wait()
    end
end)
-- IP Shits
local ip_feats = {}
local iplookuppid = menu.add_player_feature("IP Shits", "parent", mainpid.id, function(f, pid)
    local response, my_info = web.get("http://ip-api.com/json/"..dec_to_ipv4(player.get_player_ip(pid)).."?fields=66846719")
    if response == 200 then
        for _, playerFeat in pairs(ip_feats) do
           for _, feat in pairs(playerFeat.feats) do
              feat.hidden = true
           end
        end
        for name, value in my_info:gmatch('",*"*(.-)":"*([^,"]*)"*,*') do -- goes through every line that matches `"smth": "value",`
          if not ip_feats[name] then -- checks if the feature already exists or not, if it doesnt exist then it creates one and stores it into ip_feats table
            ip_feats[name] = menu.add_player_feature(name, "action_value_str", f.id)
          end
          ip_feats[name].feats[pid]:set_str_data({value}) -- updates str_data to have the value
          ip_feats[name].feats[pid].hidden = false
        end
    else
        print("Error.")
    end
end)

menu.add_player_feature("Post IP Info In Chat", "action_value_str", iplookuppid.id, function(f, pid)
    local ip = player.get_player_ip(pid)
    local response, my_info = web.get("http://ip-api.com/json/" .. dec_to_ipv4(ip) .."?fields=1191481")
    if response == 200 then
        if f.value == 0 then
            network.send_chat_message(my_info:gsub( ",", "\n"), true)
        end
        if f.value == 1 then
            network.send_chat_message(my_info:gsub( ",", "\n"), false)
        end
    else
        print("Error.")
    end
end):set_str_data({"Team Chat", "All Chat"})

menu.add_player_feature("Copy IP To clipboard", "action", iplookuppid.id, function(f, pid)
    local ip = player.get_player_ip(pid)
    local p = player.get_player_name(pid)
    utils.to_clipboard(dec_to_ipv4(ip))
    menu.notify(p .."'s IP " .. dec_to_ipv4(ip) .. " has been added to clipboard")
end)

menu.add_player_feature("                                    -- IP Info --                                        ", "action", iplookuppid.id, function()
    menu.notify("Press this if you're gay", "rekt")
end)
-- end of IP Shits
LoadSettings()
