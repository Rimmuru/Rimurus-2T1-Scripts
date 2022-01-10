require("Rimuru\\Dependancies\\FileIO")

function loaded()
    ui.notify_above_map("Welcome "..os.getenv("USERNAME").." To Rimurus Toolkit", "", 140)
end

function AutoWaypoint(pid)
    local pos = player.get_player_coords(pid)
       local pos2 = v2()
       pos2.x = pos.x
       pos2.y = pos.y

       ui.set_new_waypoint(pos2)
end

local function roationToDirection(rotation) --Credits fivem
    local adjusted_rotation = v3()
    
    adjusted_rotation.x = (math.pi / 180) * rotation.x
    adjusted_rotation.y = (math.pi / 180) * rotation.y
    adjusted_rotation.z = (math.pi / 180) * rotation.z
    
    local direction = v3()
    direction.x = -math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x))
    direction.y = math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.y))
    direction.z = math.sin(adjusted_rotation.z)
    
    return direction
end

local function getPosFromCamera(dist)
    local roation = cam.get_gameplay_cam_rot()
    local postion = cam.get_gameplay_cam_pos()
    local direction = roationToDirection(roation)
    local destination = v3()
     
    destination.x = postion.x - direction.x * dist
    destination.y = postion.y - direction.y * dist
    destination.z = postion.z - direction.z * dist + 1000

    return destination
end

function GrappleGun()
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()), v3())
    local loc = player.get_player_coords(player.player_id())
    impact.x = impact.x - loc.x
    impact.y = impact.y - loc.y
    impact.z = impact.z - loc.z + 70
    
    if boolrtn then       
        entity.set_entity_velocity(player.get_player_ped(player.player_id()), impact)
        ai.task_sky_dive(player.get_player_ped(player.player_id()), true)
    end
end

function ObjectGun()
    local val = math.random(0, #Objs)
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))

    if boolrtn then
        object.create_world_object(gameplay.get_hash_key(Objs[val]), impact, true, false)
    end
end

function ExplosionTypeGun(num)
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))

    if boolrtn then
        fire.add_explosion(impact, num, true, false, 0, player.player_id())
    end
end

function DeleteGun()
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))

    if boolrtn then
        local obj = object.create_object(gameplay.get_hash_key("prop_golf_ball_p4"), impact, true, false)
        local timer = 0
        
        if(timer < 1000) then
            system.wait(0)
        else
            timer = timer+1
         end

         entity.delete_entity(obj)
    end
end

function SpawnFlippedMap()
    local pos = player.get_player_coords(player.player_id())
    pos.z = pos.z + 500

    local e = object.create_world_object(gameplay.get_hash_key("ch2_lod3_slod3"), pos, true, false)
    local roat = v3()
    roat.x = 0
    roat.y = -200
    roat.z = 5

    entity.set_entity_rotation(e, roat)
end

function SpawnObjFromName()
    local input, i = input.get("Input A Object Name", "", 100, 0)
    local iHash = gameplay.get_hash_key(i)
    
   if input == 1 then
      return HANDLER_CONTINUE
  end
  if input == 2 then
      return HANDLER_POP
  end

  if streaming.is_model_valid(iHash) then
    object.create_world_object(iHash, player.get_player_coords(player.player_id()), true, false)
  else
    menu.notify("invalid model was input")
  end
end

function SpawnObj(val)
    object.create_object(gameplay.get_hash_key(Objs[val+1]), player.get_player_coords(player.player_id()), true, false)
end

function SpawnWrld(val)
    local wrld = object.create_world_object(gameplay.get_hash_key(Objs[val+1]), player.get_player_coords(player.player_id()), true, false)
    entity.freeze_entity(wrld, true)
end

function SpawnProp(val)
    object.create_world_object(gameplay.get_hash_key(Objs[val+1]), player.get_player_coords(player.player_id()), true, false)
end

function SpawnPed(val, health)
    local hash = gameplay.get_hash_key(pedList[val+1])
    local ptype = 0

    streaming.request_model(hash)
    
    while(not streaming.has_model_loaded(hash) and utils.time_ms() + 450 > utils.time_ms()) do
       system.wait(0)
    end

    if(streaming.is_model_valid(hash)) then
        for i=1, #animals do
            if pedList[val] == animals[i] then
                ptype = 28
            else
                ptype = 26
            end
        
            local p = ped.create_ped(ptype, hash, player.get_player_coords(player.player_id()), 0, true, false)
            ped.set_ped_health(p, tonumber(health))
        end
    end

    streaming.set_model_as_no_longer_needed(hash) 
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
    while(not streaming.has_model_loaded(hash) and utils.time_ms() + 450 > utils.time_ms()) do
       system.wait(0)
    end
 
    ped.create_ped(2, hash, player.get_player_coords(player.player_id()), 0, true, false)
end

function Gta4Neons()
   local mvehicle =  ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  
   for i=1, 7 do
      local obj = object.create_object(gameplay.get_hash_key("vw_prop_casino_phone_01b"), player.get_player_coords(player.player_id()), true, false)

      network.request_control_of_entity(mvehicle)
      while(not network.has_control_of_entity(mvehicle) and utils.time_ms() + 450 > utils.time_ms()) do
         system.wait(0)
      end
      vehicle.set_vehicle_neon_light_enabled(mvehicle, 255, true)
      entity.attach_entity_to_entity(obj, mvehicle, 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
   end
end

function SaveVehicleState()
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"

    testing = io.open(appdata.."scripts\\Rimuru\\test.txt", "w+")
    io.write("yes")
end
SaveVehicleState()

function BlackParade()
    local scaleForm = graphics.request_scaleform_movie("POPUP_WARNING")
    if(not graphics.has_scaleform_movie_loaded(scaleForm)) then
    else
        ui.draw_rect(.5, .5, 1, 1, 0, 0, 0, 255)
        graphics.begin_scaleform_movie_method(scaleForm, "SHOW_POPUP_WARNING")
        graphics.draw_scaleform_movie_fullscreen(scaleForm, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_float(500.0)
        graphics.scaleform_movie_method_add_param_texture_name_string("alert")
        graphics.scaleform_movie_method_add_param_texture_name_string("When I was a young boy, my father\nTook me into the city to see a marching band\nHe said, Son, when you grow up would you be\nThe savior of the broken, the beaten and the damned?\nHe said, Will you defeat them? Your demons\nAnd all the non-believers, the plans that they have made?\nBecause one day, Ill leave you a phantom\nTo lead you in the summer to join the black parade\n")
        graphics.end_scaleform_movie_method(scaleForm)
    end
end

function tpVehicle()
    local vehicle = player.get_personal_vehicle()

    while(not network.request_control_of_entity(vehicle) and utils.time_ms() + 450 > utils.time_ms()) do
        system.wait(0)
  end
   entity.set_entity_coords_no_offset(vehicle, player.get_player_coords(player.player_id()))
end

function PedFlop()
    local peds = ped.get_all_peds()
    
    for i=1, #peds do
       if(not ped.is_ped_a_player(peds[i])) then
           ped.clear_ped_tasks_immediately(peds[i])
           ai.task_sky_dive(peds[i], true)
       end
   end
end

function AttachMyVehicle()
    local Vehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))

    if(ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), Vehicle)) then
      entity.attach_entity_to_entity(Vehicle, player.get_player_ped(pid), 0, v3(0,0,0.0), v3(0.0,0.0), true, true, false, 0, true)
    else
        menu.notify("You are not in a vehicle", "", 10, 2)
    end
end

function AttachMyVehicleToPlayer()
    local MyVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    local PlayerVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))

   if(ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), MyVehicle)) then
      
      network.request_control_of_entity(PlayerVehicle)
      while(not network.has_control_of_entity(PlayerVehicle) and utils.time_ms() + 450 > utils.time_ms()) do
         system.wait(0)
      end

      entity.attach_entity_to_entity(MyVehicle, PlayerVehicle, 0, v3(0,0,0.0), v3(0.0,0.0), true, true, false, 0, true)
   else
       menu.notify("You are not in a vehicle", "", 10, 2)
   end
end

function AttachPlayerVehicle()
    local MyVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
    local PlayerVehicle = ped.get_vehicle_ped_is_using(player.get_player_ped(pid))

   if(ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), MyVehicle)) then
      
      network.request_control_of_entity(PlayerVehicle)
      while(not network.has_control_of_entity(PlayerVehicle) and utils.time_ms() + 450 > utils.time_ms()) do
         system.wait(0)
      end

      entity.attach_entity_to_entity(PlayerVehicle, MyVehicle, 0, v3(0,0,0.0), v3(0.0,0.0), true, true, false, 0, true)
   else
       menu.notify("You are not in a vehicle", "", 10, 2)
   end
end

