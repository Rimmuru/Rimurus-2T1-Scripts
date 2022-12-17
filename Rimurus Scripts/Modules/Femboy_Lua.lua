local function NotifyMap(title, subtitle, msg, iconname, intcolor)
    native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
    native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
    native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
    native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
    native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
end
NotifyMap("Femboy Lua", "~h~~r~Femboy Lua Script", "~b~Script Loaded, head to Script Features", "CHAR_MP_STRIPCLUB_PR", 140) --no_u = invalid image / does not exist

-- parents

local main = menu.add_feature("Femboy Script", "parent", 0)
local popt = menu.add_feature("Player Options", "parent", main.id)
local vehopt = menu.add_feature("Vehicle Options", "parent", main.id)
local lobopt = menu.add_feature("Lobby Options", "parent", main.id)
local wthopt = menu.add_feature("Weather Options", "parent", main.id)
local miscopt = menu.add_feature("Misc Options", "parent", main.id)
local cred = menu.add_feature("Credits", "parent", main.id)

-- locals
local player_ped = player.get_player_ped(player.player_id())
local veh = player.get_player_vehicle(player.player_id())

--player options
local RapidFireWeapons = {
    [2982836145] = true,
    [1672152130] = true,
    [2138347493] = true
}
local rapidfire = menu.add_feature("RPG Rapid Fire", "value_i", popt.id, function(f)
    menu.notify("Thank you GhostOne for making very good feature")
    while f.on do
        local old_player_weapon = ped.get_current_ped_weapon(player_ped)
        if RapidFireWeapons[old_player_weapon] and controls.get_control_normal(0, 142) == 1 then
            system.wait(100)
            weapon.give_delayed_weapon_to_ped(player_ped, 741814745, 0, true)
            system.wait(100)
            weapon.give_delayed_weapon_to_ped(player_ped, old_player_weapon, 0, true)
            system.wait(f.value)
        end
        system.wait(0)
    end
end)
rapidfire.max = 2500
rapidfire.mod = 25
rapidfire.value = 400 ----- Thank you ghost cause you're smart af <3333333333

local RapidFireWeapons = {
    [2982836145] = true,
    [1672152130] = true,
    [2138347493] = true,
    [2726580491] = true
}

local rgb = menu.add_feature("RGB Player Features", "parent", popt.id)

local AllRGBHair = menu.add_feature("Loop All Hair Colors", "value_i", rgb.id, function(f)
    while f.on do
        local playerped = player.get_player_ped(player.player_id())
        for i = 0, 63 do
            ped.set_ped_hair_colors(playerped, i, i)
            system.wait(f.value)
        end
    end
end)
AllRGBHair.min = 0
AllRGBHair.max = 10000
AllRGBHair.mod = 50 ----- Thank you Toph <3

local RGBHair = menu.add_feature("Rainbow Hair (better)", "value_i", rgb.id, function(f)
    while f.on do
        local playerped = player.get_player_ped(player.player_id())
        for i = 33, 53 do
            ped.set_ped_hair_colors(playerped, i, i)
            system.wait(f.value)
        end
    end
end)
RGBHair.min = 0
RGBHair.max = 10000
RGBHair.mod = 50 ------ Thank you Toph <3333

menu.add_feature("Mobile Radio", "toggle", popt.id, function(f)
    gameplay.set_mobile_radio(f.on)
end)

-- vehicle options
local dorctrl = menu.add_feature("Door Control", "parent", vehopt.id)
local lightctrl = menu.add_feature("Light Control", "parent", vehopt.id)
local vehaudio = menu.add_feature("Vehicle Audio", "parent", vehopt.id)

local rattle = menu.add_feature("engine rattle", "value_f", vehaudio.id, function(f)
    local veh = player.player_vehicle()
    native.call(0x01BB4D577D38BD9E, veh, f.value, f.on)
end)
rattle.min = 0.0
rattle.max = 1.0
rattle.mod = 0.1
rattle.value = 0.0

local enginedmg = menu.add_feature("engine dmg rattle", "value_f", vehaudio.id, function(f)
    local veh = player.player_vehicle()
    native.call(0x59E7B488451F4D3A, veh, f.value, f.on)
end)
enginedmg.min = 0.0
enginedmg.max = 1.0
enginedmg.mod = 0.1
enginedmg.value = 0.0

menu.add_feature("Fix Vehicle", "action", vehopt.id, function()
	vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()), true)
end)

menu.add_feature("Auto Repair", "toggle", vehopt.id, function(f)
    while f.on do
        local veh = player.player_vehicle()
        if vehicle.is_vehicle_damaged(player.player_vehicle()) then
            vehicle.set_vehicle_fixed(player.get_player_vehicle(player.player_id()), true)
        end
        system.wait(0.5)
    end
end)

local dirtLevel = menu.add_feature("Dirt Level", "autoaction_value_f", vehopt.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    while feat.value do
        native.call(0x79D3B596FE44EE8B, veh, feat.value)
        system.wait(0)
    end
end)
dirtLevel.min = 0.0
dirtLevel.max = 15.0
dirtLevel.mod = 1.0

menu.add_feature("Stay clean", "toggle", vehopt.id, function(feat)
    while feat.on do
        native.call(0x79D3B596FE44EE8B, player.get_player_vehicle(player.player_id()), 0)
        system.wait(0)
    end
end)

menu.add_feature("Set Custom License Plate", "action", vehopt.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())

    if player.is_player_in_any_vehicle(player.player_id()) then

        repeat
            rtn, plate = input.get("Command box", "", 50, eInputType.IT_ASCII)
            if rtn == 2 then  rtn = 0 end
            system.wait(0)
        until rtn == 0
        
    vehicle.set_vehicle_number_plate_text(veh, plate)
    else
        menu.notify("You are not in a vehicle!", "Femboy Menu")
    end
end)

menu.add_feature("Brake Lights", "toggle", lightctrl.id, function(feat)
    while feat.on do
        vehicle.set_vehicle_brake_lights(player.get_player_vehicle(player.player_id()), true)
        system.wait(0)
    end
end)

local grvty = menu.add_feature("Gravity", "value_f", vehopt.id, function(feat)
    if feat.on then
        vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), feat.value)
    else
        vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), 9.8)
    end
end)
grvty.min = -5.0
grvty.max = 20.0
grvty.mod = 1.0

menu.add_feature("Air Suspension", "toggle", vehopt.id, function(f)
local veh = player.get_player_vehicle(player.player_id())
    while f.on do
        system.wait()
        local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))
        if speed > 0.5 then
            native.call(0x3A375167F5782A65, veh, false)
        else
            native.call(0x3A375167F5782A65, veh, true)
        end
    end
end)

menu.add_feature("Native Drifting", "toggle", vehopt.id, function(feat)
	menu.notify("Slidy wheels equipped, Suspension dropped", "Femboy Menu")
	local veh = player.get_player_vehicle(player.player_id())
		native.call(0x3A375167F5782A65, veh, feat.on) -- SET_REDUCE_DRIFT_VEHICLE_SUSPENSION(veh, bool) 
		native.call(0x5AC79C98C5C17F05, veh, feat.on) -- SET_DRIFT_TYRES_ENABLED(veh, bool)
end)
		
menu.add_feature("Drift Suspension", "toggle", vehopt.id, function(feat)
	menu.notify("only works on vehicles released in the Tuners Update", "Femboy Menu")
	local veh = player.get_player_vehicle(player.player_id())
	native.call(0x3A375167F5782A65, veh, feat.on) -- SET_REDUCE_DRIFT_VEHICLE_SUSPENSION(veh, bool) 
end) 

menu.add_feature("Drift Tyres", "toggle", vehopt.id, function(feat)
	local veh = player.get_player_vehicle(player.player_id())
	native.call(0x5AC79C98C5C17F05, veh, feat.on) -- SET_DRIFT_TYRES_ENABLED(veh, bool)
end)

menu.add_feature("Launch Control", "toggle", vehopt.id, function(feat)
	local veh = player.get_player_vehicle(player.player_id())
	native.call(0xAA6A6098851C396F, feat.on)
end)

menu.add_feature("Exhaust backfire", "value_str", vehopt.id, function(f)
    if player.is_player_in_any_vehicle(player.player_id()) then 
        local veh = player.player_vehicle()
        native.call(0x2BE4BC731D039D5A, veh, f.value)
    end
end):set_str_data({"Disable", "Enable"})

local pwr = menu.add_feature("Power Increasinator", "value_i", vehopt.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    if feat.on then
        vehicle.modify_vehicle_top_speed(veh, feat.value)
    else 
        vehicle.modify_vehicle_top_speed(veh, 1)
    end
end)
pwr.min = 1
pwr.max = 10000
pwr.mod = 1

local fwdlaunch = menu.add_feature("Launch Forward", "action_slider", vehopt.id, function(feat)
	local veh = player.get_player_vehicle(player.player_id())
	native.call(0xAB54A438726D25D5, veh, feat.value)
end)
fwdlaunch.min = 0.0
fwdlaunch.max = 200.0
fwdlaunch.mod = 10.0

local rgbX = menu.add_feature("RGB Xenon", "value_i", lightctrl.id, function(feat)
    menu.notify("Xenon Lights Added, BEGIN THE RAVE")
    local veh = player.get_player_vehicle(player.player_id())
    native.call(0x2A1F4F37F95BAD08, veh, 22, feat.on) -- TOGGLE_VEHICLE_MOD
    while feat.on do
            for i=1,12 do
                native.call(0xE41033B25D003A07, veh, i) -- SET_VEHICLE_XENON_LIGHTS_COLOR
                system.wait(feat.value)
            end
        system.wait(0)
    end
end)
rgbX.min = 0
rgbX.max = 2500
rgbX.mod = 100

local Hedlit = menu.add_feature("Headlight Brightness", "autoaction_value_f", lightctrl.id, function(feat)
	local veh = player.get_player_vehicle(player.player_id())
	native.call(0xB385454F8791F57C, veh, feat.value)
end)
Hedlit.min = 0.0
Hedlit.max = 100.0
Hedlit.mod = 1.0

menu.add_feature("Turn engine off", "action", vehopt.id, function()
	local veh = player.get_player_vehicle(player.player_id())
	native.call(0x2497C4717C8B881E, veh, 0, 0, true)
end)
	
menu.add_feature("Kill engine", "action", vehopt.id, function()
	menu.notify("next bit of damage will kill the car, gl", "Femboy Menu")
	local veh = player.get_player_vehicle(player.player_id())
	native.call(0x45F6D8EEF34ABEF1, veh, 0)
end)

menu.add_feature("Notify Engine Health" , "action" , vehopt.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    local enginehealth = native.call(0xC45D23BAF168AAB8 , veh):__tonumber() --GET_VEHICLE_ENGINE_HEALTH
    menu.notify("Engine health is " .. enginehealth .. ".", "Femboy Menu")
end) -- thank you Toph

menu.add_feature("Set Patriot Tyre Smoke", "action" , vehopt.id, function()
    veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_tire_smoke_color(veh, 0 , 0, 0)
    menu.notify("Set tyre smoke color")
end) -- thank you Toph

-- door control
menu.add_feature("Open all doors", "action" , dorctrl.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    for i = 0 , 5 do
        vehicle.set_vehicle_door_open(veh , i , false , false)
    end
end) -- thank you Toph

menu.add_feature("Close All Doors", "action" , dorctrl.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_doors_shut(veh , false)
end) -- thank you Toph

menu.add_feature("Remove All Doors", "action" , dorctrl.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    for i = 0, 5 do
        native.call(0xD4D4F6A4AB575A33 , veh , i , true) -- SET_VEHICLE_DOOR_BROKEN
    end
end) -- thank you Toph

local brkdor = menu.add_feature("Remove Specific Door", "action_value_i", dorctrl.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
	native.call(0xD4D4F6A4AB575A33 , veh , feat.value, true) -- SET_VEHICLE_DOOR_BROKEN, true = delete, false = break
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

local wndwcol = menu.add_feature("Window Colour", "action_value_i", dorctrl.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    while feat.on do
        native.call(0x57C51E6BAD752696, veh, feat.value)
        system.wait(0)
    end
end)
wndwcol.min = 0
wndwcol.max = 5
wndwcol.mod = 1

menu.add_feature("Windows open/close", "toggle", dorctrl.id, function(feat)
	local veh = player.get_player_vehicle(player.player_id())
	if feat.on then
		native.call(0x85796B0549DDE156, veh) -- ROLL_DOWN_WINDOWS
	else 
		for i = 0, 3 do
			native.call(0x602E548F46E24D59, veh, i) -- ROLL_UP_WINDOW
		end
	end
end)

-- lobby options

local racismfilter = {
	"assnigger",
    "assnigga",
    "Assnigger",
    "Assnigga", 
    "beaner", 
    "Beaner", 
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
    "junglebunny",
    "Junglebunny",
    "jungle bunny", 
    "Jungle bunny", 
    "Jungle Bunny", 
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
    "ASSNIGGER",
    "ASSNIGGA", 
    "BEANER", 
    "BEANER", 
    "CHINK", 
    "CHINK", 
    "CHINC", 
    "CHINK", 
    "GOOK", 
    "GOOK", 
    "GUIDO", 
    "GUIDO", 
    "JAP", 
    "JAP", 
    "JIGABOO", 
    "JIGABOO", 
    "JUNGLEBUNNY",
    "JUNGLEBUNNY",
    "JUNGLE BUNNY", 
    "JUNGLE BUNNY", 
    "JUNGLE BUNNY", 
    "NEGRO", 
    "NEGRO", 
    "NIGABOO", 
    "NIGABOO", 
    "NIGGABOO", 
    "NIGGABOO", 
    "NIGGA", 
    "NIGGA", 
    "NIGGER", 
    "NIGGER", 
    "NIGGERISH", 
    "NIGGERISH",
    "NIGGERS", 
    "NIGGERS", 
    "NIGLET", 
    "NIGGLET",
    "NIGLET", 
    "NIGGLET", 
    "NIGNOG", 
    "NIGNOG", 
    "PAKI", 
    "PAKI", 
    "PORCH MONKEY", 
    "PORCH MONKEY", 
    "PORCHMONKEY", 
    "PORCHMONKEY", 
    "SAND NIGGER", 
    "SANDNIGGER", 
    "SAND NIGGER", 
    "SANDNIGGER",
    "SPIC", 
    "SPICK", 
    "SPIC", 
    "SPICK",  
    "WETBACK", 
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
menu.add_feature("Block Racism In Chat", "toggle", lobopt.id, function(func)
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

--weather options
local rainlvl = menu.add_feature("Magic puddles", "autoaction_value_f", wthopt.id, function(feat)
    native.call(0x643E26EA6E024D92, feat.value)
end)
rainlvl.min = 0.0
rainlvl.max = 10.0
rainlvl.mod = 0.5

local windspd = menu.add_feature("Wind speed", "autoaction_value_f", wthopt.id, function(feat)
    native.call(0xEE09ECEDBABE47FC, feat.value)
end)
windspd.min = 0.0
windspd.max = 12.0
windspd.mod = 0.5

--misc options
menu.add_feature("Show Player Talking", "toggle", miscopt.id, function(feat)
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
end, nil) -- thank you Ruly Pancake the whatever(th)

menu.add_feature("Make Nearby NPCs Riot", "toggle", miscopt.id, function(feat)
    native.call(0x2587A48BC88DFADF, feat.on)
end)

menu.add_feature("Auto Skip Cutscene", "toggle", miscopt.id, function(f)
    while f.on do
        if cutscene.is_cutscene_playing() then
            cutscene.stop_cutscene_immediately()
        end
        system.wait(0)
    end
end)

local mmdisco = menu.add_feature("minimap disco" , "value_i" , miscopt.id, function(feat)
    while feat.on do
        for i = 208, 213 do
            native.call(0x6B1DE27EE78E6A19 , i)
            system.wait(feat.value)
        end
        system.wait(0)
    end
end)
mmdisco.min = 0
mmdisco.max = 2500
mmdisco.mod = 100
mmdisco.value = 100 -- thank you Toph

menu.add_feature("Get All Achievements", "action", miscopt.id, function()
    for i=1,77 do
        native.call(0xBEC7076D64130195, i)
    end
end)

menu.add_feature("Hide HUD", "toggle", miscopt.id, function(feat)
    if feat.on then
        native.call(0xA6294919E56FF02A, false)
        native.call(0xA0EBB943C300E693, false)
    else 
        native.call(0xA6294919E56FF02A, true)
        native.call(0xA0EBB943C300E693, true)
    end
end)

menu.add_feature("Weapon Hash", "action", miscopt.id, function()
    local player_ped = player.get_player_ped(player.player_id())
    print(ped.get_current_ped_weapon(player_ped))
    menu.notify((ped.get_current_ped_weapon(player_ped)) .. " - Current Weapon Hash", "Femboy Menu")
end)

-- credits

menu.add_feature("Toph", "action", cred.id, function()
    local function NotifyMap(title, subtitle, msg, iconname, intcolor)
        native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
        native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
        native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
        native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
        native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
end
NotifyMap("Topher", "~h~~r~The Gopher", "~b~Helped an absolute BUNCH with understanding the API and helped with a lot of features!", "CHAR_HAO", 140) --no_u = invalid image / does not exist
end)
menu.add_feature("Rimuru", "action", cred.id, function()
    local function NotifyMap(title, subtitle, msg, iconname, intcolor)
        native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
        native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
        native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
        native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
        native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
end
NotifyMap("Rimuru", "~h~~r~Wannabe Welsh", "~b~'let' me learn LUA using her script and gave me many helpful tips", "CHAR_WENDY", 140) --no_u = invalid image / does not exist
end)
menu.add_feature("Aren", "action", cred.id, function()
    local function NotifyMap(title, subtitle, msg, iconname, intcolor)
        native.call(0x92F0DA1E27DB96DC, intcolor) --_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
        native.call(0x202709F4C58A0424, "STRING") --BEGIN_TEXT_COMMAND_THEFEED_POST
        native.call(0x6C188BE134E074AA, msg) --ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
        native.call(0x1CCD9A37359072CF, iconname, iconname, false, 0, title, subtitle) --END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT
        native.call(0x2ED7843F8F801023, true, true) --END_TEXT_COMMAND_THEFEED_POST_TICKER
end
NotifyMap("Aren", "~h~~r~Mostly Cringe", "~b~Helped me a lot with LUA at the beginning, taught me how to use natives", "CHAR_JIMMY", 140) --no_u = invalid image / does not exist
end)
