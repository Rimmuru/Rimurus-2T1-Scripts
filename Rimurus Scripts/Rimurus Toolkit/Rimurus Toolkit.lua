require("Rimuru\\Dependancies\\Functions")

local MainMenu = menu.add_feature("Rimurus Toolkit", "parent", 0)
local LocalSub = menu.add_feature("Local Options", "parent", MainMenu.id)
local VehicleSub = menu.add_feature("Vehicle Options", "parent", MainMenu.id) 
local Spawner = menu.add_feature("Spawner", "parent", MainMenu.id)

local MainPlayer = menu.add_player_feature("Rimurus ToolKit", "parent", 0)
local Attachments = menu.add_player_feature("Attachments", "parent", MainPlayer.id)
local Fun = menu.add_player_feature("Fun", "parent", MainPlayer.id)
local Misc = menu.add_player_feature("Misc", "parent", MainPlayer.id)

loaded() 
LoadFaves()

menu.add_feature("Grapple Gun", "toggle", LocalSub.id, function(tog)
   while tog.on do
      GrappleGun()
      system.wait(0)
  end
end)

local value = 0 
menu.add_feature("Object For Gun", "autoaction_value_str", LocalSub.id, function(val)
  value = val
end):set_str_data(Objs)

menu.add_feature("Object Gun", "toggle", LocalSub.id, function(tog)
   while tog.on do
      ObjectGun(value)
      system.wait(0)
  end
end)

menu.add_feature("Spawn Vinewood Flipped", "action", Spawner.id, function(feat)
   SpawnFlippedMap()
end)

local objectsub = menu.add_feature("Object", "parent", Spawner.id)
local pedsub = menu.add_feature("Ped", "parent", Spawner.id)
menu.add_feature("Spawn Object From Input", "action", objectsub.id, function(feat)
   SpawnObjFromName()
end)

menu.add_feature("Spawn Ped From Input", "action", pedsub.id, function(feat)
   SpawnPedFromName()
end)

menu.add_feature("Spawn Object: ", "action_value_str", objectsub.id, function(val)
   SpawnObj(val)
end):set_str_data(Objs)

menu.add_feature("Spawn World: ", "action_value_str", objectsub.id, function(val)
    SpawnWrld(val)
end):set_str_data(Objs)

Pedhealth = menu.add_feature("Health", "action_value_i", pedsub.id, function(feat)
end)
Pedhealth.max = 5000
Pedhealth.min = 0
Pedhealth.mod = 5
Pedhealth.value = 200

menu.add_feature("Spawn Ped: ", "action_value_str", pedsub.id, function(val)
   SpawnPed(val, Pedhealth.value)
end):set_str_data(pedList)

local favourite = menu.add_feature("Favourites", "parent", Spawner.id)

faveobj_id = 0
menu.add_feature("Object Favourite Selection", "action_value_str", favourite.id, function(val)
   faveobj_id = val
end):set_str_data(Objs)

faveped_id = 0
menu.add_feature("Ped Favourite Selection", "action_value_str", favourite.id, function(val)
   faveped_id = val
end):set_str_data(pedList)

menu.add_feature("Spawn Favourite Objects", "action_value_str", favourite.id, function(val)
   SpawnObj(val)
end):set_str_data(favouriteModels)

menu.add_feature("Spawn Favourite Peds", "action_value_str", favourite.id, function(val)
   SpawnPed(val)
end):set_str_data(favouritePeds)

menu.add_feature("Save Favourites", "action", favourite.id, function()
   SaveFaves(faveobj_id, faveped_id)
end)

menu.add_feature("Gta4 Style Neons", "action", VehicleSub.id, function(playerfeat)
   Gta4Neons()
end)

menu.add_feature("Remove Neons", "action", VehicleSub.id, function()
   local objs = object.get_all_objects()
   for i=1, #objs do
      entity.delete_entity(objs[i])
   end
end)

menu.add_feature("Teleport Personal Vehicle", "action", VehicleSub.id, function(playerfeat)
   tpVehicle()
end)

--Online
menu.add_player_feature("DemiGod", "action", Misc.id, function(playerfeat, pid)
   DemiGod(pid)    
end)

menu.add_player_feature("Constant Waypoint", "toggle", Misc.id, function(toggle, pid)
   while toggle.on do
       AutoWaypoint(pid)
       system.wait(0)
   end 
end)

local Hitweapon
local Hitped

local hit = menu.add_player_feature("Hit Squad", "parent", Fun.id)
 menu.add_player_feature("Ped Selection", "autoaction_value_str", hit.id, function(scroll)
   Hitped = scroll
end):set_str_data(pedList)

local hitsqamount 
local Hitamount = menu.add_player_feature("Amount to Spawn", "action_value_i", hit.id, function(HitspawnAmount)
   hitsqamount = HitspawnAmount.value
end)
Hitamount.max = 100
Hitamount.min = 0
Hitamount.value = 10

menu.add_player_feature("Weapon Selection", "autoaction_value_str", hit.id, function(scroll)
   Hitweapon = scroll
end):set_str_data(Weapons)

local hitsqHealth
local Hithealth = menu.add_player_feature("Health", "action_value_i", hit.id, function(Hitahealth)
  hitsqHealth = Hitahealth.value
end)
Hithealth.max = 5000
Hithealth.min = 0
Hithealth.mod = 5
Hithealth.value = 150

menu.add_player_feature("Send HitSquad", "action", hit.id, function(feat, pid)
   streaming.request_model(gameplay.get_hash_key(pedList[Hitped.value+1]))
    while (not streaming.has_model_loaded(gameplay.get_hash_key(pedList[Hitped.value+1]))) do
       system.wait(0)
    end
    
       local pos = entity.get_entity_coords(player.get_player_ped(pid))
       pos.x = pos.x + math.random(-20, 20 )
       pos.y = pos.y + math.random(-20, 20)
     
       for i = 0, hitsqamount, 1 do
       local Peds = ped.create_ped(4, gameplay.get_hash_key(pedList[Hitped.value+1]), pos, 1.0, true, false)
       weapon.give_delayed_weapon_to_ped(Peds, gameplay.get_hash_key(Weapons[Hitweapon.value+1]), 0, true)
       ped.set_ped_health(Peds, hitsqHealth)
       ped.set_ped_combat_ability(Peds, 2)
       ped.set_ped_combat_attributes(Peds, 5, true)
       ai.task_combat_ped(Peds, player.get_player_ped(pid), 1, 16)
       ped.set_ped_relationship_group_hash(Peds, 0x84DCFAAD)
       gameplay.shoot_single_bullet_between_coords(entity.get_entity_coords(Peds), entity.get_entity_coords(Peds) + v3(0, 0.0, 0.1), 0, 453432689, player.get_player_ped(pid), false, true, 100)
       streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(pedList[Hitped.value+1]))
       end
      end)

menu.add_player_feature("Make Nearby Peds Flop", "action", Fun.id, function(playerfeat, pid)
   PedFlop()
end)

menu.add_player_feature("Light Up Player", "action", Fun.id, function(playerfeat, pid)
   LightUpPlayer(pid)
end)

menu.add_player_feature("Attach PoleDancer", "action", Attachments.id, function(feat, pid)
   local hash = gameplay.get_hash_key(pedList[1])
   local timer = utils.time_ms()

   streaming.request_model(hash)

   while(not streaming.has_model_loaded(hash) and utils.time_ms() < timer +5000) do
      system.wait(0)
   end

   streaming.request_anim_dict("mini@strip_club@pole_dance@pole_dance1")
   
   while (not streaming.has_anim_dict_loaded("amini@strip_club@pole_dance@pole_dance1") and utils.time_ms() < timer +5000) do 
      system.wait(0) 
   end
   
   local p = ped.create_ped(26, hash, player.get_player_coords(pid), 0, true, false)
   ped.clear_ped_tasks_immediately(p)
   ai.task_play_anim(p,"amini@strip_club@pole_dance@pole_dance1","pd_dance_01",1.0,-1.0, -1, 1, 1, true, true, true)
   entity.attach_entity_to_entity(p, player.get_player_ped(pid), 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
end)

menu.add_player_feature("Attach Me To Player", "action", Attachments.id, function(playerfeat, pid)
   entity.attach_entity_to_entity(player.get_player_ped(player.player_id()), player.get_player_ped(pid), 0, v3(0,0,0.0), v3(0.0,0,0.0), true, true, false, 0, true)
end)

menu.add_player_feature("Detach Me", "action", Attachments.id, function()
    entity.detach_entity(player.get_player_ped(player.player_id()))
 end)

local objatt = menu.add_player_feature("Object Attachments", "parent", Attachments.id)
menu.add_player_feature("Attach Object To All Bones: ", "action_value_str", objatt.id, function(val, pid)
   AttachBones(val, pid)
end):set_str_data(Objs)

local boneindex = 0
menu.add_player_feature("Bone Selection: ", "action_value_str", objatt.id, function(val, pid)
   boneindex = val
end):set_str_data(bones)

menu.add_player_feature("Attach Object To Selected Bone: ", "action_value_str", objatt.id, function(val, pid)
   AttachBonesByIndex(val, boneindex, pid)
end):set_str_data(Objs)

menu.add_player_feature("Attach Object From Input", "action", objatt.id, function(feat, pid)
   AttachBonesFromName()
end)

 local AttachVehicle =  menu.add_player_feature("Vehicle Attachments", "parent", Attachments.id)
 menu.add_player_feature("Attach My Vehicle To Player", "action", AttachVehicle.id, function(playerfeat, pid)
    AttachMyVehicle()
 end)

 menu.add_player_feature("Attach My Vehicle To Player Vehicle", "action", AttachVehicle.id, function(playerfeat, pid)
   AttachMyVehicleToPlayer()
end)

menu.add_player_feature("Attach Player Vehicle To My Vehicle", "action", AttachVehicle.id, function(playerfeat, pid)
   AttachPlayerVehicle()
end)

menu.add_player_feature("Detach Vehicle", "action", AttachVehicle.id, function(pid)
   entity.detach_entity(ped.get_vehicle_ped_is_using(player.get_player_ped(player.player_id())))
end)
 