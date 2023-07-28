---@diagnostic disable: undefined-global, lowercase-global, undefined-field

local globals <const> = require("Rimuru.tables.globals")

gltw = require("Rimuru.libs.GLTW")
assert(gltw, "GLTW library is not found, please install the menu with 'Rimuru' folder.")

require("Rimuru.tables.peds")
require("Rimuru.tables.scriptevents")
require("Rimuru.tables.states")

function createExplosion(type, pos)
    fire.add_explosion(pos, type, true, false, 0, player.player_ped())
end

function ExplosionTypeGun(num)
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.player_ped())

    if boolrtn then
        createExplosion(num, impact)
    end
end

function RGBRainbow(timer, frequency )
	local result = {}
	local curtime = timer / 1000 
 
	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

function Gta4Neons()
   local mvehicle =  ped.get_vehicle_ped_is_using(player.player_ped())
  
   if(ped.is_ped_in_any_vehicle(player.player_ped())) then
    for i=1, 8 do
       local obj = object.create_object(gameplay.get_hash_key("vw_prop_casino_phone_01b"), player.get_player_coords(player.player_id()), true, false)

       network.request_control_of_entity(mvehicle)
       if(not network.has_control_of_entity(mvehicle) and utils.time_ms() + 450 > utils.time_ms()) then
          system.wait(0)
       end
       vehicle.set_vehicle_neon_light_enabled(mvehicle, 255, true)
       entity.attach_entity_to_entity(obj, mvehicle, 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
    end
    else
        menu.notify("You are not in a vehicle")
   end
end

function RemoveGtaNeons()
    local objects = object.get_all_objects()
    for i = 1, #objects do
        entity.delete_entity(objects[i])
    end
end

function requestmodel(hash)
	streaming.request_model(hash)
    local timeout = 1000
    local timer = utils.time_ms() + (timeout or 1000)

	while (not streaming.has_model_loaded(hash) and timer > utils.time_ms()) do
		system.wait(0)
	end
	return streaming.has_model_loaded(hash)
end

function SubVectors(vect1, vect2)
    return v3(vect1.x - vect2.x, vect1.y - vect2.y, vect1.z - vect2.z)
end

function RotationToDirection(rotation)
    local retz = math.rad(rotation.z)
    local retx = math.rad(rotation.x)
    local absx = math.abs(math.cos(retx))
    return v3(-math.sin(retz) * absx, math.cos(retz) * absx, math.sin(retx))
end

function WorldToScreenRel(worldCoords)
    local check, coord = graphics.project_3d_coord(v3(worldCoords.x, worldCoords.y, worldCoords.z))
    if not check then
        return false
    end
    
    screenCoordsx = (coord.x - 0.5) * 2.0
    screenCoordsy = (coord.y - 0.5) * 2.0
    return true, screenCoordsx, screenCoordsy
end

function ScreenToWorld(screenCoord)
    local camRot = cam.get_gameplay_cam_rot()
    local camPos = cam.get_gameplay_cam_pos()
    
    local vect2x = 0.0
    local vect2y = 0.0
    local vect21y = 0.0
    local vect21x = 0.0
    local direction = RotationToDirection(camRot)
    local vect3 = v3(camRot.x + 10.0, camRot.y + 0.0, camRot.z + 0.0)
    local vect31 = v3(camRot.x - 10.0, camRot.y + 0.0, camRot.z + 0.0)
    local vect32 = v3(camRot.x, camRot.y + 0.0, camRot.z + -10.0)
    
    local direction1 = RotationToDirection(v3(camRot.x, camRot.y + 0.0, camRot.z + 10.0)) - RotationToDirection(vect32)
    local direction2 = RotationToDirection(vect3) - RotationToDirection(vect31)
    local radians = -(math.rad(camRot.y))
    
    local vect33 = (direction1 * math.cos(radians)) - (direction2 * math.sin(radians))
    local vect34 = (direction1 * math.sin(radians)) - (direction2 * math.cos(radians))
    
    local case1, x1, y1 = WorldToScreenRel(((camPos + (direction * 10.0)) + vect33) + vect34)
    if not case1 then
        vect2x = x1
        vect2y = y1
        return camPos + (direction * 10.0)
    end
    
    local case2, x2, y2 = WorldToScreenRel(camPos + (direction * 10.0))
    if not case2 then
        vect21x = x2
        vect21y = y2
        return camPos + (direction * 10.0)
    end
    
    if math.abs(vect2x - vect21x) < 0.001 or math.abs(vect2y - vect21y) < 0.001 then
        return camPos + (direction * 10.0)
    end
    
    local x = (screenCoord.x - vect21x) / (vect2x - vect21x)
    local y = (screenCoord.y - vect21y) / (vect2y - vect21y)
    return ((camPos + (direction * 10.0)) + (vect33 * x)) + (vect34 * y)

end

function GetCamDirFromScreenCenter()
    local pos = cam.get_gameplay_cam_pos()
    local world = ScreenToWorld(v2(0, 0))
    local ret = SubVectors(world, pos)
    return ret
end

function RGBAToInt(Red, Green, Blue, Alpha)
    Alpha = Alpha or 255
    return ((Red & 0x0ff) << 0x00) | ((Green & 0x0ff) << 0x08) | ((Blue & 0x0ff) << 0x10) | ((Alpha & 0x0ff) << 0x18)
end

function BlackParade()
    local scaleForm = graphics.request_scaleform_movie("POPUP_WARNING")
    if(graphics.has_scaleform_movie_loaded(scaleForm)) then
        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(scaleForm, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(scaleForm, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        graphics.scaleform_movie_method_add_param_texture_name_string("When I was a young boy, my father\nTook me into the city to see a marching band\nHe said, Son, when you grow up would you be\nThe savior of the broken, the beaten and the damned?\nHe said, Will you defeat them? Your demons\nAnd all the non-believers, the plans that they have made?\nBecause one day, Ill leave you a phantom\nTo lead you in the summer to join the black parade\n")
        graphics.end_scaleform_movie_method(scaleForm)
    end
end

function Get_Distance_Between_Coords(first, second)
    local x = second.x - first.x
    local y = second.y - first.y
    local z = second.z - first.z
    return math.sqrt(x * x + y * y + z * z)
end

function vehicleBypass()
    if network.is_session_started() and player.is_player_in_any_vehicle(player.player_id()) then
       local player_id = player.player_id()
       local player_ped = player.get_player_ped(player_id)
       local old_veh = ped.get_vehicle_ped_is_using(player_ped)
       local model = 970598228
       streaming.request_model(model)
        if (streaming.has_model_loaded(model)) then
            entity.set_entity_visible(old_veh, false)
            entity.set_entity_collision(old_veh, false, false, false)
            local vehicle = vehicle.create_vehicle(model, player.get_player_coords(player_id), entity.get_entity_rotation(ped.get_vehicle_ped_is_using(player_ped)).z, true, false)
            ped.set_ped_into_vehicle(player_ped, vehicle, -1)
        
            system.yield(5500)
        
            ped.set_ped_into_vehicle(player_ped, old_veh, -1)
            entity.set_entity_collision(old_veh, true, true, true)
            entity.delete_entity(model)
            entity.set_entity_as_no_longer_needed(model)
        end
       else
        menu.notify("You must be in a vehicle")
   end
end

function startListeners()
    if network.is_session_started() then
        local script_event = hook.register_script_event_hook(function(source, target, params, count)
            local name_source = player.get_player_name(source)

            local se_counter = 0;
            local se_event = '';

            for i = 1, #params do
                se_event = se_event .. params[i]
                if i ~= #params then
                    se_event = se_event .. ', '
                end
                se_counter = se_counter + 1;
            end
            
            if GStates.ceo then
                if (params[1] == scriptEvents.PlayerStateEvents.vip.hash) then
                    menu.notify(name_source .. " is now a CEO")
                end
                if (params[1] == scriptEvents.PlayerStateEvents.exitedVip.hash) then
                    menu.notify(name_source .. " is nolonger a CEO")
                end
            end
          
            if GStates.typing then
                if (params[1] == scriptEvents.PlayerStateEvents.typing.hash) then
                    menu.notify(name_source .. " is typing...")
                end                    
                if (params[1] == scriptEvents.PlayerStateEvents.noLongerTyping.hash) then
                    menu.notify(name_source .. " closed the chat box")
                end
            end
            
           if GStates.paused then
                if (params[1] == scriptEvents.PlayerStateEvents.paused.hash) then
                   menu.notify(name_source .. " is paused")
                end
                if (params[1] == scriptEvents.PlayerStateEvents.noLongerPaused.hash) then
                    menu.notify(name_source .. " is nolonger paused")
                end
            end
        end)

        event.add_event_listener("chat", function(e)
            --if GStates["uwu"] then
            --    if string.find(e.body, "l") or string.find(e.body, "r") or string.find(e.body, "L") or string.find(e.body, "R") then
            --        local msg = e.body:gsub("l", 'w'):gsub("L", 'W'):gsub("r", 'W'):gsub("R", 'W')
            --        network.send_chat_message(msg, false)
            --    end
            --end
--
            --if GStates["mock"] then
            --    if source ~= player.player_id() then
            --        local finalText = ""
            --        for let in string.gmatch(e.body, ".") do
            --            if math.random(0, 2) == 0 then 
            --                let = string.upper(let) 
            --            end
            --            finalText = finalText .. let				
            --        end
            --        network.send_chat_message(finalText, false)
            --    end
            --end
        end)
    end
end
startListeners()

function removeExtensions(s, extension)
    extension = extension or ""
    return assert(s:gsub("%."..extension, ""), "Failed to parse extension")
end


function setVehicleColour(colourPrim, colourSec, pid)
    assert(colourPrim.red, "Colour must not be nil")
    assert(colourPrim.green, "Colour must not be nil")
    assert(colourPrim.blue, "Colour must not be nil")
   
    assert(colourSec.red, "Colour must not be nil")
    assert(colourSec.green, "Colour must not be nil")
    assert(colourSec.blue, "Colour must not be nil")

    pid = pid or player.player_id()
    local veh = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))
    vehicle.set_vehicle_custom_primary_colour(veh, RGBAToInt(colourPrim.blue, colourPrim.green, colourPrim.red))--blue green red
    vehicle.set_vehicle_custom_secondary_colour(veh, RGBAToInt(colourSec.blue, colourSec.green, colourSec.red))--blue green red
end

function get_closest_train()
	local vehicles = vehicle.get_all_vehicles()

	for i=1, #vehicles do
		if entity.get_entity_model_hash(vehicles[i]) == 1030400667 then
			network.request_control_of_entity(vehicles[i])
			return vehicles[i]
		end
	end
	return 0
end

function get_closest_vehicle()
	local vehicles = vehicle.get_all_vehicles()

	for i=1, #vehicles do
        if Get_Distance_Between_Coords(entity.get_entity_coords(vehicles[i]), entity.get_entity_coords(player.player_ped())) <= 5 then
            return vehicles[i]
        end     
	end
	return 0
end

local offset <const> = {0x2E} -- stole from kek
function is_entity_frozen(Entity)
    if entity.is_an_entity(Entity) then -- read_u8 crashes the game if nil is passed. get_entity returns nil if entity doesn't exist.
        return memory.read_u8(memory.get_entity(Entity), offset) & 1 << 1 ~= 0
    else
        return false
    end
end
    
function deleteCallback(feat, data)
    entity.delete_entity(data)
    func.delete_feature(feat.parent)
end

function freezeEntCallback(f, data)
    entity.freeze_entity(data, f.on)
end

function outfitCallback(feat, data)
    ped.set_ped_component_variation(data, 11, math.random(0, 34), 0, 0) -- tops
    ped.set_ped_component_variation(data, 4, math.random(0, 34), 0, 0) -- legs
end

function teleportToMeCallback(feat, data)
    local entCoords = player.get_player_coords(player.player_id())
    entity.set_entity_coords_no_offset(data, entCoords)
end

function teleportToEntityCallback(feat, data)
    local entCoords = entity.get_entity_coords(data)
    entity.set_entity_coords_no_offset(player.player_ped(), entCoords)
end

function moveXCallback(f, data)
    local entCoords = entity.get_entity_coords(data)
    entity.set_entity_coords_no_offset(data, v3(entCoords.x + f.value, entCoords.y, entCoords.z))
end

function moveYCallback(f, data)
    local entCoords = entity.get_entity_coords(data)
    entity.set_entity_coords_no_offset(data, v3(entCoords.x, entCoords.y + f.value, entCoords.z))
end

function PitchCallback(f, data)
    entity.set_entity_rotation(data, v3(f.value, entity.get_entity_rotation(data).y, entity.get_entity_rotation(data).z))
    return entity.get_entity_rotation(data)
end

function YawCallback(f, data)
    entity.set_entity_rotation(data, v3(entity.get_entity_rotation(data).x, entity.get_entity_rotation(data).y, f.value))
    return entity.get_entity_rotation(data)
end

function RollCallback(f, data)
    entity.set_entity_rotation(data, v3(entity.get_entity_rotation(data).x, f.value, entity.get_entity_rotation(data).z))
    return entity.get_entity_rotation(data)
end

function moveZCallback(f, data)
    local entCoords = entity.get_entity_coords(data)
    entity.set_entity_coords_no_offset(data, v3(entCoords.x, entCoords.y, entCoords.z + f.value))
end

function getPos(data)
    return entity.get_entity_coords(data)
end

function getRot(data)
    return entity.get_entity_rotation(data)
end

function writeToFile(file, text)
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"

    io.output(io.open(appdata.."\\spoofer\\"..file, "w+"))
    io.write(text)
    io.close()
end

function savePlayerToSpoofer(pid)
    local scid = player.get_player_scid(pid)
    local name = player.get_player_name(pid)
    local wallet = 0
    local lvl = script.get_global_i(1853348+1 +(pid * 834)+205+6)
    local hostToken =  player.get_player_host_token(pid)
    local dev = native.call(0x544ABDDA3B409B6D):__tointeger()
    local ip = func.convert_int_ip(player.get_player_ip(pid))
    local kd = 0
    local total = 0

    writeToFile(name..".ini", "[Profile]\n"
    .."scid="..scid.."\n"
    .."name="..name.."\n"
    .."money_wallet="..wallet.."\n"
    .."level="..lvl.."\n"
    .."host_token="..hostToken.."\n"
    .."dev="..dev.."\n"
    .."ip="..ip.."\n"
    .."kd="..kd.."\n"
    .."money_total="..total.."\n"
)
end

rotate_dir = function(v, d)
	d = d * 0.01745329251

	local x = v3(math.cos(d), -math.sin(d), 0) * v.x
	local y = v3(math.sin(d),  math.cos(d), 0) * v.y
	local z = v3(0,            0,           1) * v.z
	
	return x + y + z
end

draw_box_esp = function(e, color)
	local lo, hi = entity.get_entity_model_dimensions(e)
	local heading = entity.get_entity_rotation(e).z
	local base = entity.get_entity_coords(e)
	
	if lo == nil or hi == nil then
		return
	end
	
	local cube = {
		-- bottom
		base + rotate_dir(v3(lo.x, lo.y, lo.z), -heading),
		base + rotate_dir(v3(hi.x, lo.y, lo.z), -heading),
		base + rotate_dir(v3(hi.x, hi.y, lo.z), -heading),
		base + rotate_dir(v3(lo.x, hi.y, lo.z), -heading),

		--top
		base + rotate_dir(v3(lo.x, lo.y, hi.z), -heading),
		base + rotate_dir(v3(hi.x, lo.y, hi.z), -heading),
		base + rotate_dir(v3(hi.x, hi.y, hi.z), -heading),
		base + rotate_dir(v3(lo.x, hi.y, hi.z), -heading),
	}
	
	for i=1,#cube do
		local b, s = graphics.project_3d_coord_rel(cube[i])
		if b == false then
			cube[i] = nil
		else
			cube[i] = s
		end
	end
	
	local idx = {
		0, 1,
		1, 2,
		2, 3,
		3, 0,
		
		0, 4,
		1, 5,
		2, 6,
		3, 7,
		
		4, 5,
		5, 6,
		6, 7,
		7, 4,
	}
	
	for i=1,#idx,2 do
		local s = cube[idx[i] + 1]
		local e = cube[idx[i + 1] + 1]
		if e ~= nil and s ~= nil then
			scriptdraw.draw_line(s, e, 1, color)
		end
	end
end

function SpawnProp(val)
    if val ~= nil then
        local o = object.create_world_object(gameplay.get_hash_key(objects[val+1]), player.get_player_coords(player.player_id()), true, false)
		streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(objects[val+1])) 
		return o
    end 
end

function SpawnPed(val, health, pid)
    health = health or 500
    pid = pid or player.player_id()

    if val ~= nil then
        local hash = gameplay.get_hash_key(pedList[val+1])

        streaming.request_model(hash)
    
        local timer = utils.time_ms() + 450
        while(not streaming.has_model_loaded(hash) and timer + 450 > utils.time_ms()) do
           system.wait(0)
        end

        if(streaming.has_model_loaded(hash)) then
            local p = ped.create_ped(26, hash, player.get_player_coords(pid), 0, true, false)
            ped.set_ped_health(p, tonumber(health))
			streaming.set_model_as_no_longer_needed(hash) 
			return p
        end
		return 0
    end
end

function SpawnAnimal(val, health, pid)
    health = health or 100
    pid = pid or player.player_id()

    if val ~= nil then
        local hash = gameplay.get_hash_key(animalsPeds[val+1])

        streaming.request_model(hash)
    
        local timer = utils.time_ms() + 450
        while(not streaming.has_model_loaded(hash) and timer > utils.time_ms()) do
           system.wait(0)
        end

        if(streaming.has_model_loaded(hash)) then
            local p = ped.create_ped(28, hash, player.get_player_coords(player.player_id()), 0, true, false)
            ped.set_ped_health(p, tonumber(health))
            streaming.set_model_as_no_longer_needed(hash) 
            return p
        end

    end
end

function SpawnPedFromName()
    local input, i = input.get("Input A Ped Name", "", 100, 0)

    if input == 1 then
       return HANDLER_CONTINUE
   end
   if input == 2 then
       return HANDLER_POP
   end
 
    local hash = gameplay.get_hash_key(i)
 
    streaming.request_model(hash)
 
    local timer = utils.time_ms() + 450
    while(not streaming.has_model_loaded(hash) and timer > utils.time_ms()) do
       system.wait(0)
    end
 
   return ped.create_ped(2, hash, player.get_player_coords(player.player_id()), 0, true, false)
end

function triggerLobbyJoin(id)
   network.join_new_lobby(id)
end