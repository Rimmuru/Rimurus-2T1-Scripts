local version = "2.2.0" 
local feats, feat_vals, feat_tv = {}, {}, {}
local appdata = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
local INI = IniParser(appdata .. "\\scripts\\Femboy.ini")

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

local main = menu.add_feature("Femboy Lua", "parent", 0).id 
local player_feature = menu.add_feature("Player Features", "parent", main).id 
local player_proof = menu.add_feature("Player Proofs", "parent", player_feature).id 
local rgb_player_feature = menu.add_feature("RGB Player Features", "parent", player_feature).id 
local vehicle_feature = menu.add_feature("Vehicle Feature", "parent", main).id
local door_control = menu.add_feature("Door Controls", "parent", vehicle_feature).id 
local vehicle_customisation = menu.add_feature("Vehicle Customisation", "parent", vehicle_feature).id
local light_control = menu.add_feature("Light Controls", "parent", vehicle_feature).id

local online_feature = menu.add_feature("Online Features", "parent", main).id 
local friendly_feature = menu.add_feature("Friendly Options", "parent", online_feature).id 
local moderation_options = menu.add_feature("Moderation Options", "parent", online_feature).id 
local auto_moderation = menu.add_feature("Auto Moderation", "parent", moderation_options).id 
local country_kick = menu.add_feature("Country Kick", "parent", moderation_options).id 
local ip_lookup = menu.add_feature("IP Lookup", "parent", online_feature).id

local recovery_feature = menu.add_feature("Recovery Features", "parent", main).id
local collectibles = menu.add_feature("Collectibles", "parent", recovery_feature).id
local remote_business = menu.add_feature("Remote Business", "parent", recovery_feature).id
local special_cargo = menu.add_feature("Special Cargo Options", "parent", recovery_feature).id 
local normal_crate = menu.add_feature("Choose Normal Crate To Buy", "parent", special_cargo).id 
local special_crate = menu.add_feature("Choose Special Crate To Buy", "parent", special_cargo).id 

local air_cargo = menu.add_feature("Air Freight Cargo Options", "parent", recovery_feature).id
local steal_missions_air = menu.add_feature("Steal Missions", "parent", air_cargo).id 
local sell_missions_air = menu.add_feature("Sell Missions", "parent", air_cargo).id 

local night_club = menu.add_feature("Nightclub Options", "parent", recovery_feature).id
local vehicle_cargo = menu.add_feature("Vehicle Cargo Options", "parent", recovery_feature).id 
local source_vehicle = menu.add_feature("Source Vehicle Options", "parent", vehicle_cargo).id 
local top_range_vehicle = menu.add_feature("Top Range Vehicles", "parent", source_vehicle).id 
local mid_range_vehicles = menu.add_feature("Mid Range Vehicles", "parent", source_vehicle).id 
local standard_range_vehicles = menu.add_feature("Standard Range Vehicles", "parent", source_vehicle).id 
local unknown_range_vehicles  = menu.add_feature("Unknown Range Vehicles", "parent", source_vehicle).id 

local recovery_tool = menu.add_feature("Tools/Services", "parent", recovery_feature).id 
local bad_sport_manager = menu.add_feature("Bad Sport Manager", "parent", recovery_tool).id
local disable_tools = menu.add_feature("Disable Options", "parent", recovery_tool).id
local maximize_options = menu.add_feature("Maximize Options", "parent", recovery_tool).id

local world_feature = menu.add_feature("World Features", "parent", main).id
local misc_feature = menu.add_feature("Misc Features", "parent", main).id
local logging_feature = menu.add_feature("Logging Features", "parent", main).id 
local settings = menu.add_feature("Settings", "parent", main).id 
local credits = menu.add_feature("Credits", "parent", main).id

--local dev_build_stuff = menu.add_feature("Dev Build Shit", "parent", main).id
--local webhook = menu.add_feature("Discord Webhook", "parent", dev_build_stuff).id 
--local colour_list = menu.add_feature("Colour List", "parent", dev_build_stuff).id

local main_online = menu.add_player_feature("Femboy Lua", "parent", 0).id
--local ip_online_lookup = menu.add_player_feature("IP Lookup", "parent", main_online).id
local griefing_options = menu.add_player_feature("Griefing Features", "parent", main_online).id 
local friendly_options = menu.add_player_feature("Friendly Features", "parent", main_online).id 

-- functions
function RGBRainbow(timer, frequency )
    local result = {}
    local curtime = timer / 1000 
 
    result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
    result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
    result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
    
    return result
end

local function dec_to_ipv4(ip)
    if ip then
        return string.format("%i.%i.%i.%i", ip >> 24 & 255, ip >> 16 & 255, ip >> 8 & 255, ip & 255)
    end
end

local function capitalise_first_letter(str)
    return str:sub(1, 1):upper() .. str:sub(2, #str)
end

local function request_model(hash, timeout)
    streaming.request_model(hash)
    local timer = utils.time_ms() + (timeout or 1000)
    while timer > utils.time_ms() and not streaming.has_model_loaded(hash) do
        system.wait(0)
    end
    return streaming.has_model_loaded(hash)
end

local function kickPlayersForFlag(flag)
    if not feats.automoder.on then return end
    for pid = 0, 31 do
        if player.is_player_modder(pid, flag) then
            network.force_remove_player(pid)
            menu.notify(
                string.format("Player %s (ID: %d) has been kicked for having the %s modder flag",
                    player.get_player_name(pid), pid, player.get_modder_flag_text(flag)), "Kick Player")
        end
    end
end

local function check_vpn(pid)
    if not enable_vpn_check then return end
    system.wait(1000)
    local paramType = type(pid)
    if paramType == "table" or paramType == "userdata" then
        pid = pid.player
    end
    local player_parent = menu.get_feature_by_hierarchy_key("online.online_players.player_" .. pid)
    local ip = player.get_player_ip(pid)
    local response, my_info = web.get("http://ip-api.com/json/" .. dec_to_ipv4(ip) .. "?fields=131072")
    if response == 200 then
        if string.find(my_info, "true") then
            menu.notify(player.get_player_name(pid) .. " was flagged for using a VPN", "Femboy Lua VPN Checker")
            if not player_parent.name:find("VPN") then
                player_parent.name = player_parent.name .. " #DEFAULT#[#FFC0CBFF#VPN#DEFAULT#]"
                flagged_players[pid] = true
            end
        end
    else
        print("Error.")
    end
end

local function NotifyMap(title, subtitle, msg, iconname, intcolor)
    native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
    native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
    native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
    native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
    native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
end

local function AlertMessage(body)
    local scaleForm = graphics.request_scaleform_movie("POPUP_WARNING")
    if(graphics.has_scaleform_movie_loaded(scaleForm)) then
        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(scaleForm, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(scaleForm, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("Alert")
        graphics.scaleform_movie_method_add_param_texture_name_string(body)
        graphics.end_scaleform_movie_method(scaleForm)
    end
end

-- 
local name = player.get_player_name(player.player_id())
NotifyMap("Femboy Lua ", version .. " ~h~~r~Femboy Lua Script", "~b~Script Loaded, head to Script Features\n\nCongratulations ~r~"..name.."~b~ you are now a femboy.", "CHAR_MP_STRIPCLUB_PR", 140)

-- player_feature 
local bullet_proof, fire_proof, explosion_proof, collision_proof, melee_proof, steam_proof, water_proof
local native_call = native.call

menu.add_feature("Set All Entity Proofs", "toggle", player_proof, function(f)
	while f.on do
		system.wait()
		bullet_proof.on=f.on
		fire_proof.on=f.on
		explosion_proof.on=f.on
		collision_proof.on=f.on
		melee_proof.on=f.on 
		steam_proof.on=f.on 
		water_proof.on=f.on
	end
end)

bullet_proof = menu.add_feature("Set Bulletproof", "toggle", player_proof, function(f)
	while f.on do
		native_call(0xFAEE099C6F890BB8, player.get_player_ped(player.player_id()), true, 0, 0, 0, 0, 0, 1, 0)
		system.wait()
	end
end) 

fire_proof = menu.add_feature("Set Fireproof", "toggle", player_proof, function(f)
	while f.on do
		native_call(0xFAEE099C6F890BB8, player.get_player_ped(player.player_id()), 0, true, 0, 0, 0, 0, 1, 0)
		system.wait()
	end
end) 

explosion_proof = menu.add_feature("Set Explosion Proof", "toggle", player_proof, function(f)
	while f.on do
		native_call(0xFAEE099C6F890BB8, player.get_player_ped(player.player_id()), 0, 0, true, 0, 0, 0, 1, 0)
		system.wait()
	end
end) 

collision_proof = menu.add_feature("Set Collision Proof", "toggle", player_proof, function(f)
	while f.on do
		native_call(0xFAEE099C6F890BB8, player.get_player_ped(player.player_id()), 0, 0, 0, true, 0, 0, 1, 0)
		system.wait()
	end
end) 

melee_proof = menu.add_feature("Set Melee Proof", "toggle", player_proof, function(f)
	while f.on do
		native_call(0xFAEE099C6F890BB8, player.get_player_ped(player.player_id()), 0, 0, 0, 0, true, 0, 1, 0)
		system.wait()
	end
end) 

steam_proof = menu.add_feature("Set Steam Proof", "toggle", player_proof, function(f)
	while f.on do
		native_call(0xFAEE099C6F890BB8, player.get_player_ped(player.player_id()), 0, 0, 0, 0, 0, true, 1, 0)
		system.wait()
	end
end) 

water_proof = menu.add_feature("Set Water Proof", "toggle", player_proof, function(f)
	while f.on do
		native_call(0xFAEE099C6F890BB8, player.get_player_ped(player.player_id()), 0, 0, 0, 0, 0, 0, 1, true)
		system.wait()
	end
end) 

feat_tv.AllRGBHair = menu.add_feature("Loop All Hair Colours", "value_i", rgb_player_feature, function(f)
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

feat_tv.RGBHair = menu.add_feature("Rainbow Hair (better)", "value_i", rgb_player_feature, function(f)
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

feats.mobileradio = menu.add_feature("Mobile Radio", "toggle", player_feature, function(f)
    gameplay.set_mobile_radio(f.on)
end)

local notified = false
menu.add_feature("Ragdoll On Q", "value_str", player_feature, function(f)
    if not notified then
        menu.notify("Normal Ragdoll is recommended. Press Q to enable ragdoll, Press Q again to stand back up",
            "Femboy Menu")
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

feats.clumsy = menu.add_feature("Clumsy Player", "toggle", player_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        while f.on do
            native.call(0xF0A4F1BBF4FA7497, player.player_ped(), true)
            system.wait()
        end
    end
end)

-- vehicle_feature 
menu.add_feature("Open All Doors", "action", door_control, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    for i = 0, 5 do
        vehicle.set_vehicle_door_open(veh, i, false, false)
    end
end)

local opendor = menu.add_feature("Open Door", "action_value_i", door_control, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_door_open(veh, f.value, false, false)
end)
opendor.min = 0
opendor.max = 5
opendor.mod = 1

menu.add_feature("Close All Doors", "action", door_control, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_doors_shut(veh, false)
end)

menu.add_feature("Remove All Doors", "action", door_control, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        local veh = player.get_player_vehicle(player.player_id())
        for i = 0, 5 do
            native.call(0xD4D4F6A4AB575A33, veh, i, true) -- SET_VEHICLE_DOOR_BROKEN
        end
    end
end)

local brkdor = menu.add_feature("Remove Specific Door", "action_value_i", door_control, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0xD4D4F6A4AB575A33, veh, f.value, true) -- SET_VEHICLE_DOOR_BROKEN, true = delete, false = break
    end
end)
brkdor.min = 0
brkdor.max = 5
brkdor.mod = 1

local wndwcol = menu.add_feature("Window Tint", "action_value_i", door_control, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
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

menu.add_feature("Windows Open/Close", "toggle", door_control, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
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

menu.add_feature("Change Engine Noise", "action", vehicle_customisation, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        local veh = player.get_player_vehicle(player.player_id())
        local rtn, noise 
        repeat 
            rtn, noise = input.get("Enter Vehicle Hash", "", 20, eInputType.IT_ASCII)
            if rtn == 2 then return end
            system.wait()
        until rtn == 0
        native.call(0x4F0C413926060B38, veh, noise)
    end
end) 

menu.add_feature("Set Custom License Plate", "action", vehicle_customisation, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then
        repeat
            rtn, plate = input.get("Command box", "", 8, eInputType.IT_ASCII)
            if rtn == 2 then rtn = 0 end
            system.wait(0)
        until rtn == 0

        vehicle.set_vehicle_number_plate_text(veh, plate)
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Keep Custom License Plate", "toggle", vehicle_customisation, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    if player.is_player_in_any_vehicle(player.player_id()) then
        repeat
            rtn, plate = input.get("Input Custom Plate", "", 8, eInputType.IT_ASCII)
            if rtn == 2 then rtn = 0 end
            system.wait(0)
        until rtn == 0
        vehicle.set_vehicle_number_plate_text(veh, plate)
        while f.on do
            local new_veh = player.get_player_vehicle(player.player_id())
            if new_veh ~= veh then -- if the player has changed vehicles
                veh = new_veh
                local current_plate = vehicle.get_vehicle_number_plate_text(veh) -- get the current license plate of the vehicle
                if current_plate ~= plate then -- if the current license plate is not the desired value
                    vehicle.set_vehicle_number_plate_text(veh, plate) -- update the license plate of the new vehicle
                end
            end
            system.wait()
        end
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Set Primary Hex Colour", "action", vehicle_customisation, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then
        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000)", "", 6,eInputType.IT_ASCII)
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

menu.add_feature("Set Secondary Hex Colour", "action", vehicle_customisation, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then
        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000)", "", 6,
                eInputType.IT_ASCII)
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

menu.add_feature("Set Pearlescent Hex Colour", "action", vehicle_customisation, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then
        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000)", "", 6,
                eInputType.IT_ASCII)
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

menu.add_feature("Set Wheel Hex Colour", "action", vehicle_customisation, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then
        repeat
            rtn, colour = input.get("Enter custom colour hex or rgb value (e.g. FF0000)", "", 6,
                eInputType.IT_ASCII)
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

--menu.add_feature("RGB Vehicle Colour", "toggle", vehicle_customisation, function(f)
--    while f.on do
--        local get_game_timer = native.call(0x9CD27B0045628463):__tointeger()
--        local rgb = RGBRainbow(get_game_timer, 2)
--        local veh = player.get_player_vehicle(player.player_id())
--       vehicle.set_vehicle_custom_primary_colour(veh, rgb.r, rgb.b, rgb.g)
--        vehicle.set_vehicle_custom_secondary_colour(veh, rgb.r, rgb.b, rgb.g)
--        vehicle.set_vehicle_custom_pearlescent_colour(veh, rgb.r, rgb.b, rgb.g)
--        vehicle.set_vehicle_custom_wheel_colour(veh, rgb.r, rgb.b, rgb.g)
--        system.wait()
--    end
--end)

menu.add_feature("RGB Tyre Smoke", "toggle", vehicle_customisation, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        while f.on do 
            local get_game_timer = native.call(0x9CD27B0045628463):__tointeger()
            local rgb = RGBRainbow(get_game_timer, 2)
            local veh = player.get_player_vehicle(player.player_id())
            vehicle.set_vehicle_tire_smoke_color(veh, rgb.r, rgb.g, rgb.b)
            system.wait()
        end
    end
end)

menu.add_feature("Set Patriot Tyre Smoke", "action", vehicle_customisation, function()
    veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_tire_smoke_color(veh, 0, 0, 0)
end)

feats.rgb_neons = menu.add_feature("RGB Neons", "toggle", light_control, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        while f.on do
            local get_game_timer = native.call(0x9CD27B0045628463):__tointeger()
            local rgb = RGBRainbow(get_game_timer, 2)
            local veh = player.get_player_vehicle(player.player_id())
            for i = 0,3 do
                vehicle.set_vehicle_neon_light_enabled(veh, i, true) 
                native.call(0x8E0A582209A62695, veh, rgb.r, rgb.g, rgb.b)
            end
            system.wait()
        end
    end
end)

feats.brake_lights = menu.add_feature("Brake Lights When Stationary", "toggle", light_control, function(feat)
    while feat.on do
        local veh = player.get_player_vehicle(player.player_id())
        local speed = entity.get_entity_speed(veh)
        if speed < 0.5 then
            vehicle.set_vehicle_brake_lights(veh, true)
        end
        system.wait()
    end
end)

feat_tv.rgbX = menu.add_feature("RGB Xenon", "value_i", light_control, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        menu.notify("Xenon Lights Added, BEGIN THE RAVE")
        native.call(0x2A1F4F37F95BAD08, veh, 22, f.on) -- TOGGLE_VEHICLE_MOD
        while f.on do
            local veh = player.get_player_vehicle(player.player_id())
            for i = 1, 12 do
                native.call(0xE41033B25D003A07, veh, i) -- SET_VEHICLE_XENON_LIGHTS_COLOR
                system.wait(f.value)
            end
            system.wait(0)
        end
    end
end)
feat_tv.rgbX.min = 0
feat_tv.rgbX.max = 2500
feat_tv.rgbX.mod = 100

feat_tv.headlight_brightness = menu.add_feature("Headlight Brightness", "autoaction_value_f", light_control, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        while f.on do
            local veh = player.get_player_vehicle(player.player_id())
            native.call(0xB385454F8791F57C, veh, f.value)
            system.wait()
        end
    end
end)
feat_tv.headlight_brightness.min = 0.0
feat_tv.headlight_brightness.max = 100.0
feat_tv.headlight_brightness.mod = 1.0

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
menu.add_feature("Homing Lockon To Players", "toggle", vehicle_feature, function(f)
    local pedTable = {}
    streaming.request_model(gameplay.get_hash_key("cs_jimmydisanto"))
    local timer = utils.time_ms() + 1000
    while not streaming.has_model_loaded(gameplay.get_hash_key("cs_jimmydisanto")) and timer > utils.time_ms() do
        system.wait(0)
    end
    if timer < utils.time_ms() + 900 and not streaming.has_model_loaded(gameplay.get_hash_key("cs_jimmydisanto")) then
        f.on = false
    end
    while f.on do
        system.wait(100)
        local player_vehicle = vehicle.get_vehicle_model(ped.get_vehicle_ped_is_using(player.get_player_ped(player
        .player_id())))
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
                    pedTable[pid] = ped.create_ped(4, gameplay.get_hash_key("cs_jimmydisanto"),
                        player.get_player_coords(pid), 0, false, true)
                    entity.set_entity_as_mission_entity(pedTable[pid], true, true)
                    entity.attach_entity_to_entity(pedTable[pid], player.get_player_ped(pid), 0, v3(0, 0, 0), v3(0, 0, 0),
                        true, false, false, 0, false)
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

menu.add_feature("Fix Vehicle", "action", vehicle_feature, function()
    vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()), true)
end)

feats.autorepair = menu.add_feature("Auto Repair", "toggle", vehicle_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        while f.on do
            local veh = player.player_vehicle()
            if veh then
                local speed = entity.get_entity_speed(veh)

                if speed < 80 then
                    if vehicle.is_vehicle_damaged(veh) then
                        vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()), true)
                    end
                elseif veh and speed > 81 then return end

                if native.call(0x11D862A3E977A9EF, veh):__tointeger() then -- ARE_ALL_VEHICLE_WINDOWS_INTACT
                    for i = 0, 7 do 
                        native.call(0x772282EBEB95E682, veh, i) -- FIX_VEHICLE_WINDOW
                    end 
                end
                
            end
            system.wait(5)
        end
    end
end)
if feats.autorepair.on then
    feats.autorepair.on = false
    feats.autorepair.on = true
end

local rattle = menu.add_feature("Engine Rattle", "value_f", vehicle_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        local veh = player.player_vehicle()
        native.call(0x01BB4D577D38BD9E, veh, f.value, f.on)
    end
end)
rattle.min = 0.0
rattle.max = 1.0
rattle.mod = 0.1
rattle.value = 0.0

local dirtLevel = menu.add_feature("Dirt Level", "autoaction_value_f", vehicle_feature, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        feat.on = false
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

feats.stayclean = menu.add_feature("Stay Clean", "toggle", vehicle_feature, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        feat.on = false
    else
        while feat.on do
            native.call(0x79D3B596FE44EE8B, player.get_player_vehicle(player.player_id()), 0)
            system.wait(0)
        end
    end
end)

local grvty = menu.add_feature("Gravity", "value_f", vehicle_feature, function(f)
    while f.on do
        vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), f.value)
        system.wait()
    end
    vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), 9.8)
end)
grvty.min = -5.0
grvty.max = 20.0
grvty.mod = 1.0

feats.airsuspension = menu.add_feature("Air Suspension", "toggle", vehicle_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
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

feats.driftsuspension = menu.add_feature("Drift Suspension", "toggle", vehicle_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
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

feats.drifttyres = menu.add_feature("Drift Tyres", "toggle", vehicle_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
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

menu.add_feature("Exhaust Backfire", "value_str", vehicle_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        if player.is_player_in_any_vehicle(player.player_id()) then
            while f.on do
                local veh = player.player_vehicle()
                native.call(0x2BE4BC731D039D5A, veh, f.value)
                system.wait()
            end
        end
    end
end):set_str_data({ "Disable", "Enable" })

feat_tv.pwr = menu.add_feature("Power Increasinator", "value_i", vehicle_feature, function(f)
    while f.on do
        local veh = player.get_player_vehicle(player.player_id())
        vehicle.modify_vehicle_top_speed(veh, f.value)
        system.wait()
    end
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.modify_vehicle_top_speed(veh, 1)
end)
feat_tv.pwr.min = 0
feat_tv.pwr.max = 100000
feat_tv.pwr.mod = 10

feat_tv.veh_max_speed = menu.add_feature("Speed Limiter (Mph)", "value_f", vehicle_feature, function(f)
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

menu.add_feature("Speedometer", "value_str", vehicle_feature, function(f)
    while f.on do
        local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
        local mph

        ui.set_text_scale(0.35)
        ui.set_text_font(0)
        ui.set_text_centre(0)
        ui.set_text_color(255, 255, 255, 255)
        ui.set_text_outline(true)

        if f.value == 0 then
            ui.draw_text(math.floor(speed * 2.236936) .. " Mph", v2(0.5, 0.95))
        end
        if f.value == 1 then
            ui.draw_text(math.floor(speed * 3.6) .. " Kph", v2(0.5, 0.95))
        end
        if f.value == 2 then
            ui.draw_text(math.floor(speed * 1.943844) .. " kt", v2(0.5, 0.95))
        end
        if f.value == 3 then
            ui.draw_text(string.format("%.2f", speed * 0.00291545) .. " Mach", v2(0.5, 0.95))
        end
        if f.value == 4 then
            ui.draw_text(math.floor(speed) .. " mps", v2(0.5, 0.95))
        end
        system.wait(0)
    end
end):set_str_data({ "Mph", "Kph", "Knots", "Mach", "Metres per second" })

local fwdlaunch = menu.add_feature("Launch Forward", "action_slider", vehicle_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0xAB54A438726D25D5, veh, f.value)
    end
end)
fwdlaunch.min = 0.0
fwdlaunch.max = 10000.0
fwdlaunch.mod = 50.0

menu.add_feature("Turn Engine Off", "action", vehicle_feature, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0x2497C4717C8B881E, veh, 0, 0, true)
    end
end)

menu.add_feature("Kill engine", "action", vehicle_feature, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        menu.notify("next bit of damage will kill the car, gl", "Femboy Menu")
        local veh = player.get_player_vehicle(player.player_id())
        native.call(0x45F6D8EEF34ABEF1, veh, 0)
    end
end)

menu.add_feature("Notify Engine Health", "action", vehicle_feature, function(feat)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        local veh = player.get_player_vehicle(player.player_id())
        local enginehealth = native.call(0xC45D23BAF168AAB8, veh):__tonumber() --GET_VEHICLE_ENGINE_HEALTH
        menu.notify("Engine health is " .. enginehealth .. ".", "Femboy Menu")
    end
end)

-- online_feature
menu.add_feature("Script Hostaholic", "toggle", online_feature, function(f)
    while f.on do
        menu.get_feature_by_hierarchy_key("online.lobby.force_script_host"):toggle()
        system.wait(2000)
    end
end)

menu.add_feature("Force Host", "toggle", online_feature, function(f)
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

menu.add_feature("Bail To SP", "action", online_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        if native.call(0x580CE4438479CC61) then
            native.call(0x95914459A87EBA28, 0, 0, 0)
        end
    end
end)

local aim_karma = menu.add_feature("Aim Karma", "parent", online_feature).id
local function APv2(f)
    while f.on do
        local PlayerPed = player.get_player_ped(player.player_id())
        if APv2 then
            for pid = 0, 31 do -- for every player in the lobby
                if player.is_player_valid(pid) == true then -- if the player matches an ID then
                    local AimingAt = player.get_entity_player_is_aiming_at(pid) -- gets the entity a player is aiming at
                    local EnemyPos = player.get_player_coords(pid) -- gets the coords of the player above
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
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 911657153,
                                player.player_ped(), true, false, 100)
                        end

                        if killkarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 10000, 3219281620,
                                player.player_ped(), true, false, 100)
                        end

                        if explokarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 1672152130,
                                player.player_ped(), true, false, 100)
                        end

                        if firewrkkarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2138347493,
                                player.player_ped(), true, false, 100)
                        end

                        if atomkarma then
                            local playerstart = player.get_player_coords(pid) + 1
                            local playerloc = player.get_player_coords(pid)
                            gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2939590305,
                                player.player_ped(), true, false, 100)
                        end

                        if tankkarma then
                            local playerloc = player.get_player_coords(pid)
                            playerloc.z = playerloc.z + 2.7
                            request_model(2859440138)
                            local veh = vehicle.create_vehicle(2859440138, playerloc, 0, true, false)
                            entity.set_entity_visible(veh, false)
                            system.wait(10000)
                            entity.delete_entity(veh)
                        end

                    end
                end
            end
        end
        system.wait()
    end
end

feats.enableaimkarma = menu.add_feature("Enable Aim Karma", "toggle", aim_karma, function(f)
    if f.on then
        APv2(f)
    end
end)

menu.add_feature("--------------------", "action", aim_karma)

local aim_karma_table = {
    {name = "Notify If Aimed At", feat = "notifykarma"},
    {name = "Kick Player", feat = "kickkarma"},
    {name = "Taze Player", feat = "tazekarma"},
    {name = "Kill Player", feat = "killkarma"},
    {name = "Explode Player", feat = "explokarma"},
    {name = "Firework Player", feat = "firewrkkarma"},
    {name = "Atomize Player (with damage)", feat = "atomkarma"},
    {name = "Crush Player", feat = "tankkarma"}
}
for _,v in ipairs(aim_karma_table) do
    feats[v.feat] = menu.add_feature(v.name, "toggle", aim_karma,function(f)
        v.feat = f.on    
    end)
end

local ip_feats = {}
menu.add_feature("Press here to enter IP", "action", ip_lookup, function(f)
    repeat
        rtn, ip = input.get("Enter IP", "", 20, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0
    local response, my_info = web.get("http://ip-api.com/json/" .. ip .. "?fields=66846719")
    if response == 200 then
        for name, value in my_info:gmatch('",*"*(.-)":"*([^,"]*)"*,*') do -- goes through every line that matches `"smth": "value",`
            if not ip_feats[name] then -- checks if the feature already exists or not, if it doesnt exist then it creates one and stores it into ip_feats table
                ip_feats[name] = menu.add_feature(capitalise_first_letter(name), "action_value_str", ip_lookup)
            end
            ip_feats[name].hidden = false
            ip_feats[name]:set_str_data({ value }) -- updates str_data to have the value
        end
    else
        print("Error.")
    end
end)
menu.add_feature("                                    -- IP Info --                                        ", "action", ip_lookup)
ip_feats["query"] = menu.add_feature("Query", "action_value_str", ip_lookup)
ip_feats["query"].hidden = true

feats.auto_moderation = menu.add_feature("Enable Auto Moderation", "toggle", auto_moderation)
menu.add_feature("--------------------", "action", auto_moderation)
local modder_flags = {
    {name = "Manual", detection = "MDF_MANUAL"},
    {name = "Player Model", detection = "MDF_PLAYER_MODEL"},
    {name = "SCID Spoof", detection = "MDF_SCID_SPOOF"},
    {name = "Invalid Object", detection = "MDF_INVALID_OBJECT"},
    {name = "Invalid Ped Crash", detection = "MDF_INVALID_PED_CRASH"},
    {name = "Model Change Crash", detection = "MDF_MODEL_CHANGE_CRASH"},
    {name = "Player Model Change", detection = "MDF_PLAYER_MODEL_CHANGE"},
    {name = "RAC", detection = "MDF_RAC"},
    {name = "Money Drop", detection = "MDF_MONEY_DROP"},
    {name = "SEP", detection = "MDF_SEP"},
    {name = "Attach Object", detection = "MDF_ATTACH_OBJECT"},
    {name = "Attach Ped", detection = "MDF_ATTACH_PED"},
    {name = "Array Crash", detection = "MDF_ARRAY_CRASH"},
    {name = "Sync Crash", detection = "MDF_SYNC_CRASH"},
    {name = "Net Event Crash", detection = "MDF_NET_EVENT_CRASH"},
    {name = "Host Token", detection = "MDF_HOST_TOKEN"},
    {name = "SE Spam", detection = "MDF_SE_SPAM"},
    {name = "Frame Flags", detection = "MDF_FRAME_FLAGS"},
    {name = "IP Spoof", detection = "MDF_IP_SPOOF"},
    {name = "Karen", detection = "MDF_KAREN"},
    {name = "Session Mismatch", detection = "MDF_SESSION_MISMATCH"},
    {name = "Sound Spam", detection = "MDF_SOUND_SPAM"},
    {name = "Sep Int", detection = "MDF_SEP_INT"},
    {name = "Suspsicious Activity", detection = "MDF_SUSPICIOUS_ACTIVITY"},
    {name = "Chat Spoof", detection = "MDF_CHAT_SPOOF"}
}
for _,v in ipairs(modder_flags) do 
    feats[v.detection] = menu.add_feature(v.name .. " flag", "toggle", auto_moderation, function(f)
        while f.on do
            kickPlayersForFlag(eModderDetectionFlags[v.detection])
            system.wait()
        end
    end)
    feats[v.detection] = modder_flags[#modder_flags]
end

local cheese = {
    { name = "Afghanistan",                                          code = "AF" },
    { name = "Albania",                                              code = "AL" },
    { name = "Algeria",                                              code = "DZ" },
    { name = "American Samoa",                                       code = "AS" },
    { name = "Andorra",                                              code = "AD" },
    { name = "Angola",                                               code = "AO" },
    { name = "Anguilla",                                             code = "AI" },
    { name = "Antarctica",                                           code = "AQ" },
    { name = "Antigua and Barbuda",                                  code = "AG" },
    { name = "Argentina",                                            code = "AR" },
    { name = "Armenia",                                              code = "AM" },
    { name = "Aruba",                                                code = "AW" },
    { name = "Australia",                                            code = "AU" },
    { name = "Austria",                                              code = "AT" },
    { name = "Azerbaijan",                                           code = "AZ" },
    { name = "Bahamas",                                              code = "BS" },
    { name = "Bahrain",                                              code = "BH" },
    { name = "Bangladesh",                                           code = "BD" },
    { name = "Barbados",                                             code = "BB" },
    { name = "Belarus",                                              code = "BY" },
    { name = "Belgium",                                              code = "BE" },
    { name = "Belize",                                               code = "BZ" },
    { name = "Benin",                                                code = "BJ" },
    { name = "Bermuda",                                              code = "BM" },
    { name = "Bhutan",                                               code = "BT" },
    { name = "Bolivia",                                              code = "BO" },
    { name = "Bonaire, Sint Eustatius and Saba",                     code = "BQ" },
    { name = "Bosnia and Herzegovina",                               code = "BA" },
    { name = "Botswana",                                             code = "BW" },
    { name = "Bouvet Island",                                        code = "BV" },
    { name = "Brazil",                                               code = "BR" },
    { name = "British Indian Ocean Territory",                       code = "IO" },
    { name = "Brunei Darussalam",                                    code = "BN" },
    { name = "Bulgaria",                                             code = "BG" },
    { name = "Burkina Faso",                                         code = "BF" },
    { name = "Burundi",                                              code = "BI" },
    { name = "Cabo Verde",                                           code = "CV" },
    { name = "Cambodia",                                             code = "KH" },
    { name = "Cameroon",                                             code = "CM" },
    { name = "Canada",                                               code = "CA" },
    { name = "Cayman Islands",                                       code = "KY" },
    { name = "Central African Republic",                             code = "CF" },
    { name = "Chad",                                                 code = "TD" },
    { name = "Chile",                                                code = "CL" },
    { name = "China",                                                code = "CN" },
    { name = "Christmas Island",                                     code = "CX" },
    { name = "Cocos (Keeling) Islands",                              code = "CC" },
    { name = "Colombia",                                             code = "CO" },
    { name = "Comoros",                                              code = "KM" },
    { name = "Congo CD",                                             code = "CD" },
    { name = "Congo CG",                                             code = "CG" },
    { name = "Cook Islands",                                         code = "CK" },
    { name = "Costa Rica",                                           code = "CR" },
    { name = "Croatia",                                              code = "HR" },
    { name = "Cuba",                                                 code = "CU" },
    { name = "Curaçao",                                             code = "CW" },
    { name = "Cyprus",                                               code = "CY" },
    { name = "Czechia",                                              code = "CZ" },
    { name = "Côte d'Ivoire",                                       code = "CI" },
    { name = "Denmark",                                              code = "DK" },
    { name = "Djibouti",                                             code = "DJ" },
    { name = "Dominica",                                             code = "DM" },
    { name = "Dominican Republic",                                   code = "DO" },
    { name = "Ecuador",                                              code = "EC" },
    { name = "Egypt",                                                code = "EG" },
    { name = "El Salvador",                                          code = "SV" },
    { name = "Equatorial Guinea",                                    code = "GQ" },
    { name = "Eritrea",                                              code = "ER" },
    { name = "Estonia",                                              code = "EE" },
    { name = "Eswatini",                                             code = "SZ" },
    { name = "Ethiopia",                                             code = "ET" },
    { name = "Falkland Islands [Malvinas]",                          code = "FK" },
    { name = "Faroe Islands",                                        code = "FO" },
    { name = "Fiji",                                                 code = "FJ" },
    { name = "Finland",                                              code = "FI" },
    { name = "France",                                               code = "FR" },
    { name = "French Guiana",                                        code = "GF" },
    { name = "French Polynesia",                                     code = "PF" },
    { name = "French Southern Territories",                          code = "TF" },
    { name = "Gabon",                                                code = "GA" },
    { name = "Gambia",                                               code = "GM" },
    { name = "Georgia",                                              code = "GE" },
    { name = "Germany",                                              code = "DE" },
    { name = "Ghana",                                                code = "GH" },
    { name = "Gibraltar",                                            code = "GI" },
    { name = "Greece",                                               code = "GR" },
    { name = "Greenland",                                            code = "GL" },
    { name = "Grenada",                                              code = "GD" },
    { name = "Guadeloupe",                                           code = "GP" },
    { name = "Guam",                                                 code = "GU" },
    { name = "Guatemala",                                            code = "GT" },
    { name = "Guernsey",                                             code = "GG" },
    { name = "Guinea",                                               code = "GN" },
    { name = "Guinea-Bissau",                                        code = "GW" },
    { name = "Guyana",                                               code = "GY" },
    { name = "Haiti",                                                code = "HT" },
    { name = "Heard Island and McDonald Islands",                    code = "HM" },
    { name = "Holy See",                                             code = "VA" },
    { name = "Honduras",                                             code = "HN" },
    { name = "Hong Kong",                                            code = "HK" },
    { name = "Hungary",                                              code = "HU" },
    { name = "Iceland",                                              code = "IS" },
    { name = "India",                                                code = "IN" },
    { name = "Indonesia",                                            code = "ID" },
    { name = "Iran",                                                 code = "IR" },
    { name = "Iraq",                                                 code = "IQ" },
    { name = "Ireland",                                              code = "IE" },
    { name = "Isle of Man",                                          code = "IM" },
    { name = "Israel",                                               code = "IL" },
    { name = "Italy",                                                code = "IT" },
    { name = "Jamaica",                                              code = "JM" },
    { name = "Japan",                                                code = "JP" },
    { name = "Jersey",                                               code = "JE" },
    { name = "Jordan",                                               code = "JO" },
    { name = "Kazakhstan",                                           code = "KZ" },
    { name = "Kenya",                                                code = "KE" },
    { name = "Kiribati",                                             code = "KI" },
    { name = "Korea KP",                                             code = "KP" },
    { name = "Korea KR",                                             code = "KR" },
    { name = "Kuwait",                                               code = "KW" },
    { name = "Kyrgyzstan",                                           code = "KG" },
    { name = "Lao People's Democratic Republic",                     code = "LA" },
    { name = "Latvia",                                               code = "LV" },
    { name = "Lebanon",                                              code = "LB" },
    { name = "Lesotho",                                              code = "LS" },
    { name = "Liberia",                                              code = "LR" },
    { name = "Libya",                                                code = "LY" },
    { name = "Liechtenstein",                                        code = "LI" },
    { name = "Lithuania",                                            code = "LT" },
    { name = "Luxembourg",                                           code = "LU" },
    { name = "Macao",                                                code = "MO" },
    { name = "Madagascar",                                           code = "MG" },
    { name = "Malawi",                                               code = "MW" },
    { name = "Malaysia",                                             code = "MY" },
    { name = "Maldives",                                             code = "MV" },
    { name = "Mali",                                                 code = "ML" },
    { name = "Malta",                                                code = "MT" },
    { name = "Marshall Islands",                                     code = "MH" },
    { name = "Martinique",                                           code = "MQ" },
    { name = "Mauritania",                                           code = "MR" },
    { name = "Mauritius",                                            code = "MU" },
    { name = "Mayotte",                                              code = "YT" },
    { name = "Mexico",                                               code = "MX" },
    { name = "Micronesia",                                           code = "FM" },
    { name = "Moldova",                                              code = "MD" },
    { name = "Monaco",                                               code = "MC" },
    { name = "Mongolia",                                             code = "MN" },
    { name = "Montenegro",                                           code = "ME" },
    { name = "Montserrat",                                           code = "MS" },
    { name = "Morocco",                                              code = "MA" },
    { name = "Mozambique",                                           code = "MZ" },
    { name = "Myanmar",                                              code = "MM" },
    { name = "Namibia",                                              code = "NA" },
    { name = "Nauru",                                                code = "NR" },
    { name = "Nepal",                                                code = "NP" },
    { name = "Netherlands",                                          code = "NL" },
    { name = "New Caledonia",                                        code = "NC" },
    { name = "New Zealand",                                          code = "NZ" },
    { name = "Nicaragua",                                            code = "NI" },
    { name = "Niger",                                                code = "NE" },
    { name = "Nigeria",                                              code = "NG" },
    { name = "Niue",                                                 code = "NU" },
    { name = "Norfolk Island",                                       code = "NF" },
    { name = "Northern Mariana Islands",                             code = "MP" },
    { name = "Norway",                                               code = "NO" },
    { name = "Oman",                                                 code = "OM" },
    { name = "Pakistan",                                             code = "PK" },
    { name = "Palau",                                                code = "PW" },
    { name = "Palestine, State of",                                  code = "PS" },
    { name = "Panama",                                               code = "PA" },
    { name = "Papua New Guinea",                                     code = "PG" },
    { name = "Paraguay",                                             code = "PY" },
    { name = "Peru",                                                 code = "PE" },
    { name = "Philippines",                                          code = "PH" },
    { name = "Pitcairn",                                             code = "PN" },
    { name = "Poland",                                               code = "PL" },
    { name = "Portugal",                                             code = "PT" },
    { name = "Puerto Rico",                                          code = "PR" },
    { name = "Qatar",                                                code = "QA" },
    { name = "Republic of North Macedonia",                          code = "MK" },
    { name = "Romania",                                              code = "RO" },
    { name = "Russian Federation",                                   code = "RU" },
    { name = "Rwanda",                                               code = "RW" },
    { name = "Réunion",                                             code = "RE" },
    { name = "Saint Barthélemy",                                    code = "BL" },
    { name = "Saint Helena",                                         code = "SH" },
    { name = "Saint Kitts and Nevis",                                code = "KN" },
    { name = "Saint Lucia",                                          code = "LC" },
    { name = "Saint Martin (French part)",                           code = "MF" },
    { name = "Saint Pierre and Miquelon",                            code = "PM" },
    { name = "Saint Vincent and the Grenadines",                     code = "VC" },
    { name = "Samoa",                                                code = "WS" },
    { name = "San Marino",                                           code = "SM" },
    { name = "Sao Tome and Principe",                                code = "ST" },
    { name = "Saudi Arabia",                                         code = "SA" },
    { name = "Senegal",                                              code = "SN" },
    { name = "Serbia",                                               code = "RS" },
    { name = "Seychelles",                                           code = "SC" },
    { name = "Sierra Leone",                                         code = "SL" },
    { name = "Singapore",                                            code = "SG" },
    { name = "Sint Maarten (Dutch part)",                            code = "SX" },
    { name = "Slovakia",                                             code = "SK" },
    { name = "Slovenia",                                             code = "SI" },
    { name = "Solomon Islands",                                      code = "SB" },
    { name = "Somalia",                                              code = "SO" },
    { name = "South Africa",                                         code = "ZA" },
    { name = "South Georgia and the South Sandwich Islands",         code = "GS" },
    { name = "South Sudan",                                          code = "SS" },
    { name = "Spain",                                                code = "ES" },
    { name = "Sri Lanka",                                            code = "LK" },
    { name = "Sudan",                                                code = "SD" },
    { name = "Suriname",                                             code = "SR" },
    { name = "Svalbard and Jan Mayen",                               code = "SJ" },
    { name = "Sweden",                                               code = "SE" },
    { name = "Switzerland",                                          code = "CH" },
    { name = "Syrian Arab Republic",                                 code = "SY" },
    { name = "Taiwan",                                               code = "TW" },
    { name = "Tajikistan",                                           code = "TJ" },
    { name = "Tanzania",                                             code = "TZ" },
    { name = "Thailand",                                             code = "TH" },
    { name = "Timor-Leste",                                          code = "TL" },
    { name = "Togo",                                                 code = "TG" },
    { name = "Tokelau",                                              code = "TK" },
    { name = "Tonga",                                                code = "TO" },
    { name = "Trinidad and Tobago",                                  code = "TT" },
    { name = "Tunisia",                                              code = "TN" },
    { name = "Turkey",                                               code = "TR" },
    { name = "Turkmenistan",                                         code = "TM" },
    { name = "Turks and Caicos Islands",                             code = "TC" },
    { name = "Tuvalu",                                               code = "TV" },
    { name = "Uganda",                                               code = "UG" },
    { name = "Ukraine",                                              code = "UA" },
    { name = "United Arab Emirates",                                 code = "AE" },
    { name = "United Kingdom of Great Britain and Northern Ireland", code = "GB" },
    { name = "United States Minor Outlying Islands",                 code = "UM" },
    { name = "United States of America",                             code = "US" },
    { name = "Uruguay",                                              code = "UY" },
    { name = "Uzbekistan",                                           code = "UZ" },
    { name = "Vanuatu",                                              code = "VU" },
    { name = "Venezuela",                                            code = "VE" },
    { name = "Viet Nam",                                             code = "VN" },
    { name = "Virgin Islands (British)",                             code = "VG" },
    { name = "Virgin Islands (U.S.)",                                code = "VI" },
    { name = "Wallis and Futuna",                                    code = "WF" },
    { name = "Western Sahara",                                       code = "EH" },
    { name = "Yemen",                                                code = "YE" },
    { name = "Zambia",                                               code = "ZM" },
    { name = "Zimbabwe",                                             code = "ZW" },
    { name = "Aland Islands",                                        code = "AX" }
}
local country_features = {}
feats.enable_auto_kick = menu.add_feature("Enable", "toggle", country_kick, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_HTTP) then
        menu.notify("HTTP trusted mode must be enabled to use this.", "Femboy Menu")
        f.on = false
    else
        while f.on do
            for pid = 0, 31 do
                local player_ip = player.get_player_ip(pid)
                local response, info = web.get("http://ip-api.com/json/" .. dec_to_ipv4(player_ip) .. "?fields=2")
                if response == 200 then
                    for _, v in pairs(cheese) do
                        if v.on and pid ~= player.player_id() then
                            if string.find(info, v.code) then
                                menu.notify(
                                    string.format(
                                        "Player %s (IP: %s) is from " .. v.name .. "! Removing them now for you! :D",
                                        player.get_player_name(pid), dec_to_ipv4(player_ip)), "Location Detection")
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

menu.add_feature("Enable All", "toggle", country_kick, function(f)
    menu.notify("if you enable this and then ask why you keep getting kicked from lobbies, im going to treat you like a retard, so make sure to check twice.", "Femboy Lua")
    for _, feat in pairs(country_features) do
        feat.on = f.on
    end
end)
menu.add_feature("Filter Countries", "action_value_str", country_kick, function(f)
    repeat
        rtn, filter = input.get("Filter Countries", "", 50, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    f:set_str_data({ filter ~= "" and filter or "Search" })

    -- if filter contains something then filter by checking if name matches and if it doesnt it sets .hidden to true else false
    if filter ~= "" then
        filter = "^" .. filter or filter
        filter = filter:lower()
        for _, feat in pairs(country_features) do
            feat.hidden = (not feat.data.name:lower():match(filter))
        end
        return
    end

    -- reset if filter is nothing ie ""
    for _, feat in pairs(country_features) do
        feat.hidden = false
    end
end):set_str_data({ "Search" })

menu.add_feature("-- Country List --", "action", country_kick)

for _, v in pairs(cheese) do
    country_features[#country_features + 1] = menu.add_feature("Auto Kick " .. v.name, "toggle", country_kick, function(f)
        v.on = f.on
    end)
    country_features[#country_features].data = v
    feats[v.code] = country_features[#country_features]
end

-- recovery_feature
-- remote_business
menu.add_feature("Start CEO", "action", remote_business, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(1894584,0)
        script.set_global_i(274986,32)
        script.set_global_i(274984,32)
    end
end)

local remote_business_table = {
    {name = "Open Airfrieght App", hash = "appsmuggler"},
    {name = "Open Bunker App", hash = "appbunkerbusiness"},
    {name = "Franklin's Agency", hash = "appfixersecurity"},
    {name = "Master Control Terminal", hash = "apparcadebusinesshub"},
    {name = "Nightclub App App", hash = "appbusinesshub"},
    {name = "Terrobyte Terminal", hash = "apphackertruck"}
}
for _,v in ipairs(remote_business_table) do
    menu.add_feature(v.name, "action", remote_business, function()
        if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
            menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        else
            script.set_global_i(1854376,-1)
            script.set_global_i(1894584,0)
            script.set_global_i(274986,32)
            script.set_global_i(274984,32)
            native.call(0x6EB5F71AA68F2E8E, v.hash) -- VOID REQUEST_SCRIPT(const char* scriptName)
            native.call(0xE6CC9F3BA0FB9EF1, v.hash) -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
            native.call(0xE81651AD79516E48, v.hash, 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
        end
    end)
end

-- special_cargo
menu.add_feature("Sell Cargo For 5 Million", "toggle", special_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(278133, 5780000)
            script.set_global_i(278131, 5780000)
            script.set_global_i(278135, 5780000)
            script.set_global_i(278129, 5780000)
            script.set_global_i(278127, 5780000)
            script.set_global_i(278137, 5780000)
            script.set_global_i(277933, 5791000)
            script.set_global_i(277934, 2895500)
            script.set_global_i(277935, 1930333)
            script.set_global_i(277936, 1158200)
            script.set_global_i(277937, 827285)
            script.set_global_i(277938, 643444)
            script.set_global_i(277939, 413642)
            script.set_global_i(277940, 304789)
            script.set_global_i(277941, 241291)
            script.set_global_i(277942, 199689)
            script.set_global_i(277943, 170323)
            script.set_global_i(277944, 148487)
            script.set_global_i(277945, 131613)
            script.set_global_i(277946, 118183)
            script.set_global_i(277947, 98152)
            script.set_global_i(277948, 83927)
            script.set_global_i(277949, 73303)
            script.set_global_i(277950, 65067)
            script.set_global_i(277951, 58494)
            script.set_global_i(277952, 52645)
            script.set_global_i(277953, 52171)
            system.wait()
        end
    end
end)

menu.add_feature("Auto Supplier", "toggle", special_cargo, function(f)
    while f.on do
        menu.get_feature_by_hierarchy_key("online.business.manual_actions.supply_special_cargo"):toggle()
        system.wait()
        native.call(0x32888337579A5970, f.on) -- hide feed
        system.wait()
    end
    native.call(0x15CFA549788D35EF) -- THEFEED_SHOW
    native.call(0xA8FDB297A8D25FBA) -- THEFEED_FLUSH_QUEUE
end)

menu.add_feature("Instant Buy", "toggle", special_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(3942964741,603,1)
            script.set_local_i(3942964741,789,6)
            script.set_local_i(3942964741,790,4)
            system.wait(2500)
        end
    end
end)

menu.add_feature("Instant Sell", "toggle", special_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(2067673554,541,99999)
            system.wait(2500)
        end
    end
end)

menu.add_feature("Get Max Crates w/ One Purchase", "toggle", special_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(3942964741, 599, 111)
            system.wait()
        end
    end
end)

menu.add_feature("Remove Special Cargo Cooldown", "toggle", special_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        while f.on do
            script.set_global_i(277698,0)
            script.set_global_i(277699,0)        
            system.wait(2500)
        end
    end
end)

menu.add_feature("Start CEO", "action", special_cargo, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(1894584,0)
        script.set_global_i(274986,32)
        script.set_global_i(274984,32)
    end
end)

menu.add_feature("Terrobyte Touchscreen Terminal","action", special_cargo,function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) and not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Natives and Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(1854376,-1)
        script.set_global_i(1894584,0)
        script.set_global_i(274986,32)
        script.set_global_i(274984,32)
        native.call(0x6EB5F71AA68F2E8E, "apphackertruck") -- VOID REQUEST_SCRIPT(const char* scriptName)
        native.call(0xE6CC9F3BA0FB9EF1, "apphackertruck") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
        native.call(0xE81651AD79516E48, "apphackertruck", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
    end
end)

local normal_crates = {
    {name = "Medical Supplies", idx = 0},
    {name = "Tobacco & Alcohol", idx = 1},
    {name = "Art & Antiques", idx = 2},
    {name = "Electronic Goods", idx = 3},
    {name = "Weapons & Ammo", idx = 4},
    {name = "Narcotics", idx = 5},
    {name = "Gemstones", idx = 6},
    {name = "Animal Materials", idx = 7},
    {name = "Counterfeit Goods", idx = 8},
    {name = "Jewelry", idx = 9},
    {name = "Bullion", idx = 10}
}
for _, v in ipairs(normal_crates) do
    menu.add_feature(v.name, "toggle", normal_crate,function(f)
        while f.on do
            script.set_global_i(1949968,0)
            script.set_global_i(1949814,v.idx)
            system.wait()
        end
    end)
end

local special_crates = {
    {name = "Ornamental Egg", idx = 2},
    {name = "Golden Minigun", idx = 4},
    {name = "Large Diamond", idx = 6},
    {name = "Rare Hide", idx = 7},
    {name = "Film Reel", idx = 8},
    {name = "Rare Pocket Watch", idx = 9}
}
for _, v in ipairs(special_crates) do
    menu.add_feature(v.name, "toggle", special_crate,function(f)
        while f.on do
            script.set_global_i(1949968,1)
            script.set_global_i(1949814,v.idx)
            system.wait()
        end
    end)
end

-- air_cargo 

--menu.add_feature("Set Air Cargo Price To 1 Billion", "toggle", air_cargo, function(f)
--    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
--        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
--        f.on=false
--    else
--        while f.on do
--            script.set_global_i(284955,1147483647)
--            script.set_global_i(284956,1147483647)
--            script.set_global_i(284957,1147483647)
--            script.set_global_i(284958,1147483647)
--            script.set_global_i(284959,1147483647)
--            script.set_global_i(284960,1147483647)
--            script.set_global_i(284961,1147483647)
--            script.set_global_i(284962,1147483647)
--            script.set_global_i(284963,1147483647)
--            system.wait()
--        end
--    end
--end)

--menu.add_feature("Set Air Cargo Price To 2 Billion", "toggle", air_cargo, function(f)
--    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
--        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
--        f.on=false
--    else
--        while f.on do
--            script.set_global_i(284955,2147483647)
--            script.set_global_i(284956,2147483647)
--            script.set_global_i(284957,2147483647)
--            script.set_global_i(284958,2147483647)
--            script.set_global_i(284959,2147483647)
--            script.set_global_i(284960,2147483647)
--            script.set_global_i(284961,2147483647)
--            script.set_global_i(284962,2147483647)
--            script.set_global_i(284963,2147483647)
--            system.wait()
--        end
--    end
--end)

menu.add_feature("Open AirFrieght App", "action", air_cargo, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(1854376,-1)
        script.set_global_i(1894584,0)
        script.set_global_i(274986,32)
        script.set_global_i(274984,32)
        native.call(0x6EB5F71AA68F2E8E, "appsmuggler") -- VOID REQUEST_SCRIPT(const char* scriptName)
        native.call(0xE6CC9F3BA0FB9EF1, "appsmuggler") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
        native.call(0xE81651AD79516E48, "appsmuggler", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
    end
end)

menu.add_feature("Instant Sell", "toggle", air_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(2882788887,2963,0)
            system.wait(1500)
        end
    end
end)

menu.add_feature("Instant Source", "toggle", air_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(2882788887,1999,-1)
            system.wait(1500)
        end
    end
end)

menu.add_feature("Source Cargo", "toggle", air_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(2882788887,2698,15)
            script.set_global_i(2798615,25)
            system.wait(1500)
        end
    end
end)

menu.add_feature("Remove Sell Cooldown", "toggle", air_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(2766148,0)
            script.set_global_i(284896,0)
            script.set_global_i(284897,0)
            script.set_global_i(284898,0)
            script.set_global_i(284899,0)
            script.set_global_i(284900,0)
            system.wait(0)
        end
    end
end)

menu.add_feature("Alien Egg", "toggle", steal_missions_air, function(f) 
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_STATS) and not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Stats and Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            stats.stat_set_int(3550228704, 1200, true)
            stats.stat_set_int(2531035799, 1200, true)
            stats.stat_set_int(723574901, 1200, true)
            stats.stat_set_int(295142111, 1200, true)
            script.set_global_i(2798615, 2, true)
            system.wait()
        end
    end
end)

local steal_missions = {
    {name = "Altruist Camp", idx = 1},
    {name = "The Dune Buggy", idx = 2},
    {name = "Police Riot", idx = 3},
    {name = "Mine", idx = 4},
    {name = "The Technical Aqua", idx = 5},
    {name = "Rival Operation", idx = 6},
    {name = "Zancudo River", idx = 7},
    {name = "LSIA", idx = 8},
    {name = "Merryweather HQ", idx = 9},
    {name = "Training Ground", idx = 10},
    {name = "Del Perro Beach", idx = 11},
    {name = "Cholla Springs Avenue", idx = 12},
    {name = "Chupacabra Street", idx = 13}
}
for _, v in ipairs(steal_missions) do
    menu.add_feature(v.name, "toggle", steal_missions_air,function(f)
        while f.on do
            script.set_global_i(2798615, v.idx)
            system.wait()
        end
    end)
end

local sell_missions = {
    {name = "HVY Insurgent Pick Up", idx = 14},
    {name = "HVY Insurgent", idx = 15},
    {name = "Marshall", idx = 16},
    {name = "HVY Insurgent Pick Up (custom)", idx = 17},
    {name = "Phantom Wedge", idx = 18},
    {name = "Dune FAV", idx = 19}
}
for _, v in ipairs(sell_missions) do
    menu.add_feature(v.name, "toggle", sell_missions_air,function(f)
        while f.on do
            script.set_global_i(2798615, v.idx)
            system.wait()
        end
    end)
end

-- night_club
local nightclub_notif = false
menu.add_feature("300k Safe Loop", "toggle", night_club, function(f)
    if nightclub_notif == false then 
        menu.notify("- Activate Loop\n- Go to nightclub safe, directly ahead of the computer\n- Open the safe and stand right against it", "Femboy Lua", 5, 0xFF00EEEE)
        nightclub_notif = true
    end
    while f.on do
        script.set_global_i(262145 + 24045, 300000)
        script.set_global_i(262145 + 24041, 300000) 
        stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 10000, true)
        stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_PAY_TIME_LEFT"), -1, true)
        stats.stat_set_int(gameplay.get_hash_key("MP0_CLUB_POPULARITY"), 100000, true)
        stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 10000, true)
        stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_PAY_TIME_LEFT"), -1, true)
        stats.stat_set_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 100000, true)
        system.wait()
    end
end)

menu.add_feature("Instant Sell","toggle",night_club,function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(4093145562,2507,15)
            script.set_local_i(4093145562,2508,15)
            script.set_local_i(4093145562,2336,0)
            system.wait(2500)
        end
    end
end)

menu.add_feature("Sell Cargo For 4 Million","toggle",night_club,function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_local_i(3518909077,148,3870000)
            system.wait()
        end
    end
end)

menu.add_feature("Remove Nightclub Sell Cooldown","toggle",night_club,function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(1962972,-1)
            system.wait()
        end
    end
end)

-- vehicle_cargo 
menu.add_feature("Disable Sell Cooldown", "toggle", vehicle_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(281830,-1)
            script.set_global_i(2766116,-1)
            script.set_global_i(2766118,-1)
            system.wait()
        end
    end
end)

menu.add_feature("Disable Source Cooldown", "toggle", vehicle_cargo, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(281459,0)
            script.set_global_i(281827,0)
            script.set_global_i(281828,0)
            script.set_global_i(281829,0)
            script.set_global_i(281830,0)
            system.wait()
        end
    end
end)
 
local top_range = {
    {name = "Roosevelt Valor - [L4WLE55]", idx = 37},
    {name = "Stirling GT - [M4J3ST1C]", idx = 40},
    {name = "FMJ - [C4TCHM3]", idx = 19},
    {name = "Osiris - [OH3LL0]", idx = 16},
    {name = "Pfister 811 - [M1DL1F3]", idx = 25},
    {name = "X80 Prototype - [FUTUR3]", idx = 1},
    {name = "Reaper - [2FA5T4U]", idx = 22},
    {name = "ETR1 - [B1GB0Y]", idx = 13},
    {name = "T20 - [CAR4M3L]", idx = 10},
    {name = "Tyrus - [C1TRUS]", idx = 4},
    {name = "Z-Type - [B1GMON3Y]", idx = 43},
    {name = "Roosevelt Valor - [0LDT1M3R]", idx = 38},
    {name = "Stirling GT - [T0UR3R]", idx = 41},
    {name = "FMJ - [J0K3R]", idx = 20},
    {name = "Mamba - [BLKM4MB4]", idx = 32},
    {name = "Osiris - [PH4R40H]", idx = 17},
    {name = "Pfister 811 - [R3G4L]", idx = 26},
    {name = "X80 Prototype - [M4K3B4NK]", idx = 2},
    {name = "Reaper - [D34TH4U]", idx = 23},
    {name = "ETR1 - [M0N4RCH]", idx = 14},
    {name = "T20 - [T0PSP33D]", idx = 11},
    {name = "Z-Type - [K1NGP1N]", idx = 44},
    {name = "Stirling GT - [R4LLY]", idx = 42},
    {name = "FMJ - [H0T4U]", idx = 21},
    {name = "Mamba - [V1P]", idx = 33},
    {name = "Osiris - [SL33K]", idx = 18},
    {name = "Pfister 811 - [SL1CK]", idx = 27},
    {name = "X80 Prototype - [TURB0]", idx = 3},
    {name = "Reaper - [GR1M]", idx = 24},
    {name = "T20 - [D3V1L]", idx = 12},
    {name = "Tyrus - [TR3X]", idx = 6},
    {name = "Z-Type - [CE0]", idx = 45}
}
for _, v in ipairs(top_range) do
    menu.add_feature(v.name, "toggle", top_range_vehicle,function(f)
        while f.on do
            script.set_global_i(1894772, v.idx)
            system.wait()
        end
    end)
end

local mid_range = {
    {name = "Cheetah - [BUZZ3D]", idx = 76},
    {name = "Coquette Classic - [T0PL3SS]", idx = 73},
    {name = "Coquette BlackFin- [V1NT4G3]", idx = 61},
    {name = "Entity XF - [IML4TE]", idx = 49},
    {name = "Omnis - [0BEYM3]", idx = 58},
    {name = "Seven-70 - [FRU1TY]", idx = 64},
    {name = "Sultan RS - [SN0WFLK3]", idx = 52},
    {name = "Tropos - [1MS0RAD]", idx = 46},
    {name = "Verlierer - [PR3C1OUS]", idx = 67},
    {name = "Zentorno - [W1NN1NG]", idx = 55},
    {name = "Cheetah - [M1DN1GHT]", idx = 77},
    {name = "Coquette Classic - [T0FF33]", idx = 74},
    {name = "Coquette  BlackFin - [W1P30UT]", idx = 62},
    {name = "Entity XF - [0V3RFL0D]", idx = 50},
    {name = "Omnis - [W1D3B0D]", idx = 59},
    {name = "Seven 70 - [4LL0Y5]", idx = 65},
    {name = "Sultan RS - [F1D3L1TY]", idx = 53},
    {name = "Tropos Rallye - [31GHT135]", idx = 47},
    {name = "Verlierer - [0UTFR0NT]", idx = 68},
    {name = "Zentorno - [0LDN3W5]", idx = 56},
    {name = "Cheetah - [B1GC4T]", idx = 78},
    {name = "Coquette Classic - [CL45SY]", idx = 75},
    {name = "Coquette  BlackFin - [BLKF1N]", idx = 63},
    {name = "Entity XF - [W1DEB0Y]", idx = 51},
    {name = "Omnis - [D1RTY]", idx = 60},
    {name = "Seven 70 - [SP33DY]", idx = 66},
    {name = "Sultan RS - [5H0W0FF]", idx = 54},
    {name = "Tropos Rallye - [1985]", idx = 48},
    {name = "Verlierer - [CURV35]", idx = 69},
    {name = "Zentorno - [H3R0]", idx = 57}
}
for _, v in ipairs(mid_range) do
    menu.add_feature(v.name, "toggle", mid_range_vehicles,function(f)
        while f.on do
            script.set_global_i(1894772, v.idx)
            system.wait()
        end
    end)
end

local standard_range = {
    {name = "Alpha- [V1S1ONRY]", idx = 28},
    {name = "Banshee 900R - [DR1FT3R]", idx = 82},
    {name = "Bestia GTS - [BE4STY]", idx = 7},
    {name = "Feltzer - [P0W3RFUL]", idx = 70},
    {name = "Jester - [H0TP1NK]", idx = 94},
    {name = "Massacro - [TR0P1CAL]", idx = 88},
    {name = "Nightshade - [DE4DLY]", idx = 79},
    {name = "Sabre Turbo Custom - [GUNZ0UT]", idx = 91},
    {name = "Tampa - [CH4RG3D]", idx = 34},
    {name = "Alpha- [L0NG80Y]", idx = 29},
    {name = "Banshee 900R - [DOM1NO]", idx = 83},
    {name = "Bestia GTS - [5T34LTH]", idx = 8},
    {name = "Feltzer - [K3YL1M3]", idx = 71},
    {name = "Jester - [T0PCL0WN]", idx = 95},
    {name = "Massacro - [B4N4N4]", idx = 89},
    {name = "Nightshade - [TH37OS]", idx = 80},
    {name = "Sabre Turbo Custom - [0R1G1N4L]", idx = 92},
    {name = "Tampa - [CRU151N]", idx = 35},
    {name = "Turismo R - [M1LKYW4Y]", idx = 86},
    {name = "Alpha- [R31GN]", idx = 30},
    {name = "Banshee 900R - [H0WL3R]", idx = 84},
    {name = "Bestia GTS - [5M00TH]", idx = 9},
    {name = "Feltzer - [R4C3R]", idx = 72},
    {name = "Jester - [NOF00L]", idx = 96},
    {name = "Massacro - [B055]", idx = 90},
    {name = "Nightshade - [E4TM3]", idx = 81},
    {name = "Sabre Turbo Custom - [B0UNC3]", idx = 93},
    {name = "Tampa - [MU5CL3]", idx = 36},
    {name = "Turismo R - [TPD4WG]", idx = 87}
}
for _,v in ipairs(standard_range) do
    menu.add_feature(v.name, "toggle", standard_range_vehicles,function(f)
        while f.on do
            script.set_global_i(1894772, v.idx)
            system.wait()
        end
    end)
end

local unknown_range = {
    {name = "Mamba - [0LDBLU3]", idx = 31},
    {name = "Turismo R - [IN4H4ZE]", idx = 85},
    {name = "Tyrus - [B35TL4P]", idx = 5},
    {name = "Roosevelt Valor - [V4L0R]", idx = 39},
    {name = "ETR1 - [PR3TTY]", idx = 15},
}
for _,v in ipairs(unknown_range) do
    menu.add_feature(v.name, "toggle", unknown_range_vehicles,function(f)
        while f.on do
            script.set_global_i(1894772, v.idx)
            system.wait()
        end
    end)
end

-- recovery_tool 
menu.add_feature("Become a bad sport", "action", bad_sport_manager, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_STATS) then
        menu.notify("Stats are required to be enabled to use this feature", "Femboy Lua")
    else
        stats.stat_set_int(2829961636, 1, true)
        stats.stat_set_int(2301392608, 1, true)
    end
end)

menu.add_feature("Remove bad sport", "action", bad_sport_manager, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_STATS) then
        menu.notify("Stats are required to be enabled to use this feature", "Femboy Lua")
    else
        stats.stat_set_int(2301392608, 0, true)
    end
end)

menu.add_feature("Force Cloud Save", "action", recovery_tool, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        native.call(0xE07BCA305B82D2FD, 0, 0, 3, 0)
    end
end)

menu.add_feature("Request Acid Lab", "action", recovery_tool, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2793984,1)
    end
end)

menu.add_feature("Request Avenger", "action", recovery_tool, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        cript.set_global_i(2793979,1)
    end
end)

menu.add_feature("Request Ballistic Equipment", "action", recovery_tool, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2793942,1)
    end
end)

menu.add_feature("Request Dinghy", "action", recovery_tool, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2794012,1)
    end
end)

menu.add_feature("Request Kosatka", "action", recovery_tool, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        cript.set_global_i(2794000,1)
    end
end)

menu.add_feature("Request Motorcycle", "action", recovery_tool, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2794034,1)
    end
end)

menu.add_feature("Request MOC", "action", recovery_tool, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2793971,1)
    end
end)

menu.add_feature("Request Mini Tank", "action", recovery_tool, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2799921,1)
    end
end)

menu.add_feature("Request RC Bandito", "action", recovery_tool, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2799920,1)
    end
end)

menu.add_feature("Request Terrobyte", "action", recovery_tool, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
    else
        script.set_global_i(2793983,1)
    end
end)

feats.disable_transaction_error = menu.add_feature("Remove Transaction Error", "toggle", disable_tools, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(4536673, 0)
            script.set_global_i(4536674, 0)
            script.set_global_i(4536675, 0)
            system.wait()
        end
    end
end)

feats.disable_kosatka_missiles_cd = menu.add_feature("Disable Kosatka Missiles Cooldown", "toggle", disable_tools, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(292332, 0)
            script.set_global_i(292333, 99999)
            system.wait()
        end
    end
end)

feats.disable_mk2_cd = menu.add_feature("Disable MK2 Cooldown", "toggle", disable_tools, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_SCRIPT_VARS) then
        menu.notify("Globals/Locals are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            script.set_global_i(290553, 0)
            system.wait()
        end
    end
end)

menu.add_feature("Maximize nightclub popularity", "action", maximize_options, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_STATS) then
        menu.notify("Stats are required to be enabled to use this feature", "Femboy Lua")
    else
        stats.stat_set_int(2724973317, 1000, true)
        stats.stat_set_int(2295992369, 1000, true)
    end
end)

menu.add_feature("Maximize Inventory", "action", maximize_options, function()
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_STATS) then
        menu.notify("Stats are required to be enabled to use this feature", "Femboy Lua")
    else
        stats.stat_set_int(3154358306, 30, true)
        stats.stat_set_int(2983015990, 15, true)
        stats.stat_set_int(2098164755, 5, true)
        stats.stat_set_int(3097587663, 10, true)
        stats.stat_set_int(853483879, 10, true)
        stats.stat_set_int(2022518763, 20, true)
        stats.stat_set_int(1031694059, 20, true)
        stats.stat_set_int(1734518001, 11, true)
        stats.stat_set_int(3689384104, 11, true)
    end
end)
-- collectibles 
local collect = {
    {name = "Action Figures", global = 2765117, max = 100},
    {name = "LD Organics Product", global = 2765501, max = 100},
    {name = "Playing Cards", global = 2765118, max = 54},
    {name = "Signal Jammers", global = 2765119, max = 50},
    {name = "Movie Props", global = 2765402, max = 10},
    {name = "Buried Stashes (Daily)", global = 2765461, max = 50},
    {name = "Hidden Cache (Daily)", global = 2765412, max = 10},
    {name = "Treasure Chests (Daily)", global = 2765414, max = 10},
    {name = "Shipwrecks (Daily)", global = 2765455, max = 10},
    {name = "Trick or Treat (halloween)", global = 2765499, max = 200}
}
for _,v in ipairs(collect) do
    local feat = menu.add_feature(v.name, "action_value_i", collectibles, function(f)
        script.set_global_i(v.global, f.value)
    end)
    feat.min = 0
    feat.max = v.max 
    feat.mod = 1
    v.feat = feat
end

-- world_feature 
local distancescale = menu.add_feature("Distance Scale", "value_f", world_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        menu.notify("This will effect your FPS massively", "Femboy Menu")
        while f.on do
            native.call(0xA76359FC80B2438E, f.value)
            system.wait()
        end
        native.call(0xA76359FC80B2438E, 1.0)
    end
end)
distancescale.min = 0.0
distancescale.max = 200.0
distancescale.mod = 0.5

local set_time_scale = menu.add_feature("Set Time Scale", "value_f", world_feature, function(f)
	if f.on then
		native.call(0x1D408577D440E81E, f.value) -- SET_TIME_SCALE
	else 
		native.call(0x1D408577D440E81E, 1.0)
	end
end) 
set_time_scale.min = 0.0
set_time_scale.max = 1.0
set_time_scale.mod = 0.1

menu.add_feature("Load Map", "action_value_str", world_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        if f.value == 0 then
            native.call(0xD7C10C4A637992C9) -- on_enter_sp
        elseif f.value == 1 then 
            native.call(0x0888C3502DBBEEF5) -- on_enter_mp
        end 
    end 
end):set_str_data({"SP Map", "MP Map"})

menu.add_feature("Make Nearby NPC's Riot", "toggle", world_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        native.call(0x2587A48BC88DFADF, f.on)
    end
end)

menu.add_feature("Blackout", "toggle", world_feature, function(f)
    gameplay.set_blackout(f.on)
end)

local rainlvl = menu.add_feature("Magic puddles", "autoaction_value_f", world_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
            menu.notify("Natives are required to be enabled to use this feature", "Femboy Menu")
            f.on = false
        else
            native.call(0x643E26EA6E024D92, f.value)
        end
    end
end)
rainlvl.min = 0.0
rainlvl.max = 10.0
rainlvl.mod = 0.5

local windspd = menu.add_feature("Wind speed", "autoaction_value_f", world_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        native.call(0xEE09ECEDBABE47FC, f.value)
    end
end)
windspd.min = 0.0
windspd.max = 12.0
windspd.mod = 0.5

local waveint = menu.add_feature("Wave Intensity", "value_f", world_feature, function(f)
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

-- misc_feature 
feats.skipcutscene = menu.add_feature("Auto Skip Cutscene", "toggle", misc_feature, function(f)
    while f.on do
        if cutscene.is_cutscene_playing() then
            cutscene.stop_cutscene_immediately()
        end
        system.wait(0)
    end
end)

menu.add_feature("Get All Achievements", "action", misc_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        for i = 1, 77 do
            native.call(0xBEC7076D64130195, i)
        end
    end
end)

local set_radar_angle = menu.add_feature("Set Radar Angle", "value_i", misc_feature, function(f)
	while f.on do 
		native.call(0x299FAEBB108AE05B, f.value) -- LOCK_MINIMAP_ANGLE
		system.wait()
	end
	native.call(0x8183455E16C42E3A) -- UNLOCK_MINIMAP_ANGLE
end) 
set_radar_angle.min = 1
set_radar_angle.max = 360 
set_radar_angle.mod = 1

menu.add_feature("Hide HUD", "toggle", misc_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on = false
    else
        if f.on then
            native.call(0xA6294919E56FF02A, false)
            native.call(0xA0EBB943C300E693, false)
        else
            native.call(0xA6294919E56FF02A, true)
            native.call(0xA0EBB943C300E693, true)
        end
    end
end)

menu.add_feature("Custom Error Message", "toggle", misc_feature, function(f)

	local rtn, subtitle
	repeat
		rtn, body = input.get("Insert Message", "", 50, eInputType.IT_ASCII)
		if rtn == 2 then return end
		system.wait()
	until rtn == 0 

	while f.on do 
		AlertMessage(body)
		system.wait()
	end
end)

menu.add_feature("Disable Above Map Notifs", "toggle", misc_feature, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        while f.on do
            native.call(0x32888337579A5970, f.on) -- hide feed
            system.wait()
        end
        native.call(0x15CFA549788D35EF) -- THEFEED_SHOW
        native.call(0xA8FDB297A8D25FBA) -- THEFEED_FLUSH_QUEUE
        menu.notify("Notifications above map enabled", "Femboy Menu")
    end
end)

menu.add_feature("Fix Weapon Wheel", "action", misc_feature, function(f)
	native.call(0xEB354E5376BC81A7) -- HUD_FORCE_WEAPON_WHEEL
end)

-- logging_feature
feats.log_joins_to_console = menu.add_feature("Log Joins To Console", "toggle", logging_feature, function(f)
    if f.on then
        joinlog = event.add_event_listener("player_join", function(e)
            local pid = player.get_player_name(e.player)
            local ip = player.get_player_ip(e.player)
            local time = os.time()
            local badtime = os.time()
            local goodtime = os.date("%A, %B %d %Y, %X", badtime)
            print("[" .. goodtime .. "] " .. pid .. " [" .. dec_to_ipv4(ip) .. "] Joined The Session")
        end)
    else
        event.remove_event_listener("player_join", joinlog)
    end
end)

feats.log_script_events_to_console = menu.add_feature("Log Script Events To Console", "toggle", logging_feature, function(f)
    if f.on then
        script_listener = event.add_event_listener("script", function(e)
            local pid = e.player
            local script = e.id
            local params = e.params

            for i = 1, #params do
                params[i] = params[i] & 0xFFFFFFFF
            end

            print(string.format("Player %s sent script %d %s", player.get_player_name(pid), script,
                "(" .. table.concat(params, ", ") .. ")"))
        end)
    else
        event.remove_event_listener("script", script_listener)
    end
end)

-- settings 
menu.add_feature("Save Settings", "action", settings, function(f)
    SaveSettings()
end)

feats.f8_to_save = menu.add_feature("F8 To Save Settings", "toggle", settings, function(f)
    while f.on do
        if controls.is_control_just_pressed(0, 169) or controls.is_control_just_pressed(2, 169) and f.on then
            SaveSettings()
        end
        system.wait()
    end
end)

menu.add_feature("Changelog", "action_value_str", settings, function(f)
    if f.value == 0 then
        menu.notify(
            "#FFC0CBFF#https://github.com/Decuwu/femboylua/blob/main/Changelog.md\n\n#DEFAULT#copied to clipboard, paste it in your browser url to see the scripts changelog",
            "Femboy Menu")
        utils.to_clipboard("https://github.com/Decuwu/femboylua/blob/main/Changelog.md")
    elseif f.value == 1 then
        local response, body = web.get("https://raw.githubusercontent.com/Decuwu/femboylua/main/Changelog.md")
        if response == 200 then
            print(body)
        else
            menu.notify(response)
        end
    end
end):set_str_data({ "Copy Link", "Print To Console" })

menu.add_feature("Feature List", "action", settings, function(f)
    menu.notify(
        "#FFC0CBFF#https://github.com/Decuwu/femboylua/blob/main/Femboy.md\n\n#DEFAULT#copied to clipboard, paste it in your browser url to see the scripts feature list",
        "Femboy Menu")
    utils.to_clipboard("https://github.com/Decuwu/femboylua/blob/main/Femboy.md")
end)

-- vpn checker 
local flagged_players = {}
local enable_vpn_check = true
feats.disable_vpn = menu.add_feature("Disable VPN Check", "toggle", settings, function(f)
    if f.on then
        enable_vpn_check = not enable_vpn_check
    else
        check_vpn(pid)
    end
end)
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
            local player_parent = menu.get_feature_by_hierarchy_key("online.online_players.player_" .. pid)
            if not player_parent.name:find("VPN") then
                local name = ""
                player_parent.name = player_parent.name .. " #DEFAULT#[#FFC0CBFF#VPN#DEFAULT#]"
            end
        end
        system.wait(3000)
    end
end)

-- credits 
menu.add_feature("Toph", "action_value_str", credits, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        return menu.notify("Helped an absolute BUNCH with understanding the API and helped with a lot of features!","Toph")
    else
        if f.value == 0 then
            NotifyMap("Topher", "~h~~r~The Gopher","~b~Helped an absolute BUNCH with understanding the API and helped with a lot of features!", "CHAR_HAO", 140)
        elseif f.value == 1 then
            menu.notify("#FFFFCC00#Credits:\n-#FFFFDD00#Made above map notification\n-#FFFFDD22#IP info function\n-#FFFFDD33#Aim Karma\n-#FFFFDD44#Air Suspension\n-#FFFFDD55#Chat Moderation\n-#FFFFDD66#Bail To SP\n-#FFFFDD77#Minimap Disco\n-#FFFFDD88#Save and Load settings function", "#FFFFCC00#Toph", 5, 0xFFFFCC00)
        end
    end
end):set_str_data({"Credit", "Features Made/Helped With"})

menu.add_feature("Rimuru", "action_value_str", credits, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        return menu.notify("'let' me learn LUA using her script and gave me many helpful tips", "Rimuru")
    else
        if f.value == 0 then
            NotifyMap("Rimuru", "~h~~r~Wannabe Welsh", "~b~'let' me learn LUA using her script and still continues to help me all the time","CHAR_WENDY", 140) --no_u = invalid image / does not exist
        elseif f.value == 1 then
            menu.notify("#FFFF55AA#Credits:\n-#FFFF4488#Made Auto Updater\n-#FFFF4499#Taught me how to use tables to make features\n-#FFFF44AA#Yelled at me for bad code\n-#FFFF44BB#Let me ask dumb af questions\n-#FFFF44CC#Gave the code for nightclub loop\n-#FFFF44DD#Gave the function for RGB Neon", "#FFFF55AA#Rimuru", 5, 0xFFFF55AA)
        end
    end 
end):set_str_data({"Credit", "Features Made/Helped With"})

menu.add_feature("GhostOne", "action_value_str", credits, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        return menu.notify("Makes zero sense when giving help but still helps a lot. made: Homing lockon, VPN flag, IP info shit","GhostOne")
    else
        if f.value == 0 then
            NotifyMap("GhostOne", "~h~~r~Has Cheese", "~b~Makes zero sense when giving help but still helps a lot. made: Homing lockon, VPN flag, IP info shit","CHAR_TAXI", 140) --no_u = invalid image / does not exist
        elseif f.value == 1 then
            menu.notify("#FF00FFEE#Credits:\n-#FF00EEFF#Made Auto Kick By Country\n-#FF00DDFF#Made VPN detection flag\n-#FF00CCFF#Made IP lookup\n-#FF00BBFF#Made a lot of different functions\n-#FF00AAFF#Taught me a lot to do with functions and tables\n-#FF0099FF#Cheese", "#FF00FFFF#GhostOne", 5, 0xFF00FFFF)
        end
    end
end):set_str_data({"Credit", "Features Made/Helped With"})

menu.add_feature("Aren", "action_value_str", credits, function(f)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        return menu.notify("Helped me a lot with LUA at the beginning, taught me how to use natives", "Aren")
    else
        if f.value == 0 then
            NotifyMap("Aren", "~h~~r~Mostly Cringe", "~b~Helped me a lot with LUA at the beginning, taught me how to use natives","CHAR_JIMMY", 140) --no_u = invalid image / does not exist
        elseif f.value == 1 then
            menu.notify("#FFFF1100#Credits:\n-#FFFF2211#Taught me how to use natives\n-#FFFF3311#Taught me how to start making luas", "#FFFF1111#Aren", 5, 0xFFFF1111)
        end
    end 
end):set_str_data({"Credit", "Features Made/Helped With"})

-- main_online 
--- ip_online_lookup
local ip_feats = {}
local ip_online_lookup = menu.add_player_feature("IP Lookup", "parent", main_online, function(f, pid)
    local response, my_info = web.get("http://ip-api.com/json/" ..
    dec_to_ipv4(player.get_player_ip(pid)) .. "?fields=66846719")
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
            ip_feats[name].feats[pid]:set_str_data({ value }) -- updates str_data to have the value
            ip_feats[name].feats[pid].hidden = false
        end
    else
        print("Error.")
    end
end).id

menu.add_player_feature("Post IP Info In Chat", "action_value_str", ip_online_lookup, function(f, pid)
    local ip = player.get_player_ip(pid)
    local response, my_info = web.get("http://ip-api.com/json/" .. dec_to_ipv4(ip) .. "?fields=1189433")
    local message = my_info:gsub(",", "\n"):gsub('[{}"]', ""):gsub(":", " - "):gsub("proxy", "VPN"):gsub("regionName","Region"):gsub("query", "IP"):gsub("continent", "Continent"):gsub("country", "Country"):gsub("city", "City"):gsub("zip", "ZIP/Post Code"):gsub("isp", "ISP"):gsub("org", "Organisation")
    if response == 200 then
        if f.value == 0 then
            local name = player.get_player_name(pid)
            network.send_chat_message(name .. "'s IP info:\n" .. message, true)
        elseif f.value == 1 then
            local name = player.get_player_name(pid)
            network.send_chat_message(name .. "'s IP info:\n" .. message, false)
        end
    else
        print(response)
    end
end):set_str_data({ "Team Chat", "All Chat" })

menu.add_player_feature("Copy IP To clipboard", "action", ip_online_lookup, function(f, pid)
    local ip = player.get_player_ip(pid)
    local p = player.get_player_name(pid)
    utils.to_clipboard(dec_to_ipv4(ip))
    menu.notify(p .. "'s IP " .. dec_to_ipv4(ip) .. " has been added to clipboard")
end)

menu.add_player_feature("                                    -- IP Info --                                        ","action", ip_online_lookup, function()
    menu.notify("Press this if you're gay", "rekt")
end)

--- griefing_options 
menu.add_player_feature("Crush Player", "action", griefing_options, function(f, pid)
    local playerloc = player.get_player_coords(pid)
    playerloc.z = playerloc.z + 2.7
    request_model(2859440138)
    local veh = vehicle.create_vehicle(2859440138, playerloc, 0, true, false)
    entity.set_entity_visible(veh, false)
    system.wait(10000)
    entity.delete_entity(veh)
end)

menu.add_player_feature("Cargoplane Spam", "toggle", griefing_options, function(f, pid)
    while f.on do
        local playerloc = player.get_player_coords(pid)
        playerloc.z = playerloc.z + 2.7
        request_model(2336777441)
        local veh = vehicle.create_vehicle(2336777441, playerloc, 0, true, false)
        system.wait(100)
    end
end)

menu.add_player_feature("Taze Player", "toggle", griefing_options, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 911657153, player.player_ped(), true,
            false, 100)
        system.wait()
    end
end)

menu.add_player_feature("Firework Player", "toggle", griefing_options, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2138347493, player.player_ped(), true,
            false, 100)
        system.wait()
    end
end)

menu.add_player_feature("RPG Player", "toggle", griefing_options, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 3204302209, player.player_ped(), true,
            false, 100)
        system.wait()
    end
end)

menu.add_player_feature("Atomize Player", "toggle", griefing_options, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 1000, 2939590305, player.player_ped(), true,
            false, 100)
        system.wait()
    end
end)

menu.add_player_feature("Kill Player", "toggle", griefing_options, function(f, pid)
    while f.on do
        local playerstart = player.get_player_coords(pid) + 1
        local playerloc = player.get_player_coords(pid)
        gameplay.shoot_single_bullet_between_coords(playerstart, playerloc, 10000, 3219281620, player.player_ped(), true,
            false, 100)
        system.wait()
    end
end)

--- friendly_options
menu.add_player_feature("RP Drop", "toggle", friendly_options, function(f, pid)
    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        menu.notify("Natives are required to be enabled to use this feature", "Femboy Lua")
        f.on=false
    else
        request_model(437412629)
        while f.on do
            local coords = player.get_player_coords(pid)
            native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 437412629, 0, 1)
            system.wait(5)
        end
    end
end)

LoadSettings()
