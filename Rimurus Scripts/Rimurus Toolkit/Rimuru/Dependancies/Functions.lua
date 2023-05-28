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

function GrappleGun()
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()), v3())
    local loc = player.get_player_coords(player.player_id())
    impact.x = impact.x - loc.x
    impact.y = impact.y - loc.y
    impact.z = impact.z - loc.z + 4
    
    if boolrtn then
        rope.rope_load_textures()
        rope.add_rope(impact, v3(0,0,0), 10.2, 2, 10.0, 1.0, 1, false, false, false, 0, true)
        local obj = object.create_object(gameplay.get_hash_key("prop_devin_box_dummy_01"), impact, true, false)
        local pos = entity.get_entity_coords(obj)
      
        rope.attach_rope_to_entity(2, obj, v3(pos.x, pos.y, pos.z), true)
        system.wait(500)
        entity.set_entity_velocity(player.get_player_ped(player.player_id()), impact)
        rope.rope_load_textures()
        ai.task_sky_dive(player.get_player_ped(player.player_id()), true)
    end
end

function ObjectGun(val)
    local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))

    if boolrtn then
        object.create_world_object(gameplay.get_hash_key(Objs[val.value+1]), impact, true, false)
    end
end

function SpawnFlippedMap()
    local pos = player.get_player_coords(player.player_id())
    pos.x = pos.x 
    pos.y = pos.y
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

   if input == 1 then
      return HANDLER_CONTINUE
  end
  if input == 2 then
      return HANDLER_POP
  end

  local wrld = object.create_world_object(gameplay.get_hash_key(i), player.get_player_coords(player.player_id()), true, false)
end

function SpawnObj(val)
    object.create_object(gameplay.get_hash_key(Objs[val.value+1]), player.get_player_coords(player.player_id()), true, false)
end

function SpawnWrld(val)
    local wrld = object.create_world_object(gameplay.get_hash_key(Objs[val.value+1]), player.get_player_coords(player.player_id()), true, false)
    entity.freeze_entity(wrld, true)
end

function SpawnProp(val)
    object.create_world_object(gameplay.get_hash_key(Objs[val.value+1]), player.get_player_coords(player.player_id()), true, false)
end

function SpawnPed(val, health)
    local hash = gameplay.get_hash_key(pedList[val.value+1])

    streaming.request_model(hash)
    while(not streaming.has_model_loaded(hash) and utils.time_ms() < utils.time_ms() +5000) do
       system.wait(0)
    end
    if(streaming.is_model_valid(hash)) then
      local p = ped.create_ped(26, hash, player.get_player_coords(player.player_id()), 0, true, false)
       ped.set_ped_health(p, tonumber(health))
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
    while(not streaming.has_model_loaded(hash)) do
       system.wait(0)
    end
 
    ped.create_ped(2, hash, player.get_player_coords(player.player_id()), 0, true, false)
end

function Gta4Neons()
   local mvehicle =  ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id()))
  
   for i=1, 7 do
      local obj = object.create_object(gameplay.get_hash_key("vw_prop_casino_phone_01b"), player.get_player_coords(player.player_id()), true, false)
      local timer = utils.time_ms()

      network.request_control_of_entity(mvehicle)
      while(not network.has_control_of_entity(mvehicle) and utils.time_ms() < timer +5000) do
         system.wait(0)
      end
      vehicle.set_vehicle_neon_light_enabled(mvehicle, 255, true)
      entity.attach_entity_to_entity(obj, mvehicle, 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
   end
end

function tpVehicle()
    local vehicle = player.get_personal_vehicle()
    local timer = utils.time_ms()

    while(not network.request_control_of_entity(vehicle) and utils.time_ms() < timer +5000) do
        system.wait(0)
  end
   entity.set_entity_coords_no_offset(vehicle, player.get_player_coords(player.player_id()))
end

function DemiGod(pid)
    local DemiObject = object.create_object(gameplay.get_hash_key("Prop_Juicestand"), player.get_player_coords(pid), true, false)
    
    entity.attach_entity_to_entity(DemiObject, player.get_player_ped(pid), 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
    entity.set_entity_visible(DemiObject, false)
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

function LightUpPlayer(pid)
    for i=1, 10 do
        local obj = object.create_object(gameplay.get_hash_key("vw_prop_casino_phone_01b"), player.get_player_coords(pid), true, false)
     
        entity.attach_entity_to_entity(obj, player.get_player_ped(pid), 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
    end
end

bones = {
    "SKEL_Pelvis",
    "IK_Head",
    "MH_L_Elbow",
    "MH_R_Elbow",
    "SKEL_L_Hand",
    "SKEL_R_Hand",
    "IK_L_Foot",
    "IK_R_Foot"
 }

function AnimationOnPed(ped, dict, anim)
    local timer = utils.time_ms()
    streaming.request_anim_set(anim)

    while not streaming.has_anim_set_loaded(anim) and utils.time_ms() < timer +5000 do
        system.wait(0)
    end
    ai.task_play_anim(ped, dict, anim, 1, 1, 9999, 0, 1, false, false, false)
end

function AttachBones(val, pid)
    for i = 1, #bones do
        local id = entity.get_entity_bone_index_by_name(player.get_player_ped(pid), bones[i])
        local obj = object.create_world_object(gameplay.get_hash_key(Objs[val.value+1]), player.get_player_coords(pid), true, false)
        entity.attach_entity_to_entity(obj, player.get_player_ped(pid), id, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
     end
end

function AttachBonesByIndex(val, index, pid)
        local id = entity.get_entity_bone_index_by_name(player.get_player_ped(pid), bones[index.value+1])
        local obj = object.create_world_object(gameplay.get_hash_key(Objs[val.value+1]), player.get_player_coords(pid), true, false)
        entity.attach_entity_to_entity(obj, player.get_player_ped(pid), id, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
end

function AttachBonesFromName()
    local inpt, inputobj = input.get("Input Object Name", "", 100, 0)
    
    for i = 1, #bones do
      local id = entity.get_entity_bone_index_by_name(player.get_player_ped(pid), bones[i])
      local obj = object.create_world_object(gameplay.get_hash_key(inputobj), player.get_player_coords(pid), true, false)
      entity.attach_entity_to_entity(obj, player.get_player_ped(pid), id, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
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
    local timer = utils.time_ms()

   if(ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), MyVehicle)) then
      
      network.request_control_of_entity(PlayerVehicle)
      while(not network.has_control_of_entity(PlayerVehicle) and utils.time_ms() < timer +5000) do
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
    local timer = utils.time_ms()

   if(ped.is_ped_in_vehicle(player.get_player_ped(player.player_id()), MyVehicle)) then
      
      network.request_control_of_entity(PlayerVehicle)
      while(not network.has_control_of_entity(PlayerVehicle) and utils.time_ms() < timer +5000) do
         system.wait(0)
      end

      entity.attach_entity_to_entity(PlayerVehicle, MyVehicle, 0, v3(0,0,0.0), v3(0.0,0.0), true, true, false, 0, true)
   else
       menu.notify("You are not in a vehicle", "", 10, 2)
   end
end

