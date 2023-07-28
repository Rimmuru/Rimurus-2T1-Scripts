func.add_player_feature("Go Ghosted To Player", "toggle", 0, function(feat, pid)
	natives.NETWORK._SET_RELATIONSHIP_TO_PLAYER(pid, feat.on)
end)

func.add_player_feature("Spectate Player", "toggle", 0, function(feat, pid)
	menu.get_feature_by_hierarchy_key("online.online_players.player_"..pid..".spectate_player"):toggle()
end)

local playerVeh = func.add_player_feature("Vehicle", "parent", 0)
local playerMalic = func.add_player_feature("Malicious", "parent", 0)
local playerTroll = func.add_player_feature("Trolling", "parent", 0)
local playerTeleport = func.add_player_feature("Teleport", "parent", 0)
local playerEvents = func.add_player_feature("Invites", "parent", 0)
local playerMisc = func.add_player_feature("Miscellaneous", "parent", 0)
local playerDrops = func.add_player_feature("Drops", "parent", playerMisc.id)

local pickups = require("Rimuru.tables.pickups")

local function getGamerHandle(pid)
	local handle = native.ByteBuffer16()
	natives.NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle, 13)
	return handle
end

func.add_player_feature("Send SMS", "action", 0, function(feat, pid)
	local status, msg = input.get("Input your sms", "", 100, 0)    
	if status == 0 then
		natives.NETWORK.NETWORK_SEND_TEXT_MESSAGE(msg, getGamerHandle(pid))
	end
end)

func.add_player_feature("Discord", "action", 0, function(feat, pid)
	script.trigger_script_event_2(1 << pid, 1186559054, player.player_id(), "~b~discord.gg/rimurus")
end)

func.add_player_feature("Job Text", "action", 0, function(feat, pid)
	local status, msg = input.get("Input your text", "", 70, 0)    
	if status == 0 then
		script.trigger_script_event_2(1 << pid, 1186559054, player.player_id(), "<font size='30'>~g~~h~"..msg)
	end
end)

local explosions <const> = {
	"GRENADE ",
	"GRENADELAUNCHER ",
	"STICKYBOMB ",
	"MOLOTOV ",
	"ROCKET ",
	"TANKSHELL ",
	"HI_OCTANE ",
	"CAR ",
	"PLANE ",
	"PETROL_PUMP ",
	"BIKE ",
	"DIR_STEAM ",
	"DIR_FLAME ",
	"DIR_WATER_HYDRANT ",
	"DIR_GAS_CANISTER ",
	"BOAT ",
	"SHIP_DESTROY ",
	"TRUCK ",
	"BULLET ",
	"SMOKEGRENADELAUNCHER ",
	"SMOKEGRENADE ",
	"BZGAS ",
	"FLARE ",
	"GAS_CANISTER ",
	"EXTINGUISHER ",
	"EXP_TAG_TRAIN ",
	"EXP_TAG_BARREL ",
	"EXP_TAG_PROPANE ",
	"EXP_TAG_BLIMP ",
	"EXP_TAG_DIR_FLAME_EXPLODE ",
	"EXP_TAG_TANKER ",
	"PLANE_ROCKET ",
	"EXP_TAG_VEHICLE_BULLET ",
	"EXP_TAG_GAS_TANK ",
	"EXP_TAG_BIRD_CRAP ",
	"EXP_TAG_RAILGUN ",
	"EXP_TAG_BLIMP2 ",
	"EXP_TAG_FIREWORK ",
	"EXP_TAG_SNOWBALL ",
	"EXP_TAG_PROXMINE ",
	"EXP_TAG_VALKYRIE_CANNON ",
	"EXP_TAG_AIR_DEFENCE ",
	"EXP_TAG_PIPEBOMB ",
	"EXP_TAG_VEHICLEMINE ",
	"EXP_TAG_EXPLOSIVEAMMO ",
	"EXP_TAG_APCSHELL ",
	"EXP_TAG_BOMB_CLUSTER ",
	"EXP_TAG_BOMB_GAS ",
	"EXP_TAG_BOMB_INCENDIARY ",
	"EXP_TAG_BOMB_STANDARD ",
	"EXP_TAG_TORPEDO ",
	"EXP_TAG_TORPEDO_UNDERWATER ",
	"EXP_TAG_BOMBUSHKA_CANNON ",
	"EXP_TAG_BOMB_CLUSTER_SECONDARY ",
	"EXP_TAG_HUNTER_BARRAGE ",
	"EXP_TAG_HUNTER_CANNON ",
	"EXP_TAG_ROGUE_CANNON ",
	"EXP_TAG_MINE_UNDERWATER ",
	"EXP_TAG_ORBITAL_CANNON ",
	"EXP_TAG_BOMB_STANDARD_WIDE ",
	"EXP_TAG_EXPLOSIVEAMMO_SHOTGUN ",
	"EXP_TAG_OPPRESSOR2_CANNON ",
	"EXP_TAG_MORTAR_KINETIC ",
	"EXP_TAG_VEHICLEMINE_KINETIC ",
	"EXP_TAG_VEHICLEMINE_EMP ",
	"EXP_TAG_VEHICLEMINE_SPIKE ",
	"EXP_TAG_VEHICLEMINE_SLICK ",
	"EXP_TAG_VEHICLEMINE_TAR ",
	"EXP_TAG_SCRIPT_DRONE ",
	"EXP_TAG_RAYGUN ",
	"EXP_TAG_BURIEDMINE ",
	"EXP_TAG_SCRIPT_MISSILE ",
	"EXP_TAG_RCTANK_ROCKET ",
	"EXP_TAG_BOMB_WATER ",
	"EXP_TAG_BOMB_WATER_SECONDARY ",
	"EXP_TAG_FLASHGRENADE ",
	"EXP_TAG_STUNGRENADE ",
	"EXP_TAG_SCRIPT_MISSILE_LARGE ",
	"EXP_TAG_SUBMARINE_BIG GRENADE ",
	"GRENADELAUNCHER ",
	"STICKYBOMB ",
	"MOLOTOV ",
	"ROCKET ",
	"TANKSHELL ",
	"HI_OCTANE ",
	"CAR ",
	"PLANE ",
	"PETROL_PUMP ",
	"BIKE ",
	"DIR_STEAM ",
	"DIR_FLAME ",
	"DIR_WATER_HYDRANT ",
	"DIR_GAS_CANISTER ",
	"BOAT ",
	"SHIP_DESTROY ",
	"TRUCK ",
	"BULLET ",
	"SMOKEGRENADELAUNCHER ",
	"SMOKEGRENADE ",
	"BZGAS ",
	"FLARE ",
	"GAS_CANISTER ",
	"EXTINGUISHER ",
	"EXP_TAG_TRAIN ",
	"EXP_TAG_BARREL ",
	"EXP_TAG_PROPANE ",
	"EXP_TAG_BLIMP ",
	"EXP_TAG_DIR_FLAME_EXPLODE ",
	"EXP_TAG_TANKER ",
	"PLANE_ROCKET ",
	"EXP_TAG_VEHICLE_BULLET ",
	"EXP_TAG_GAS_TANK ",
	"EXP_TAG_BIRD_CRAP ",
	"EXP_TAG_RAILGUN ",
	"EXP_TAG_BLIMP2 ",
	"EXP_TAG_FIREWORK ",
	"EXP_TAG_SNOWBALL ",
	"EXP_TAG_PROXMINE ",
	"EXP_TAG_VALKYRIE_CANNON ",
	"EXP_TAG_AIR_DEFENCE ",
	"EXP_TAG_PIPEBOMB ",
	"EXP_TAG_VEHICLEMINE ",
	"EXP_TAG_EXPLOSIVEAMMO ",
	"EXP_TAG_APCSHELL ",
	"EXP_TAG_BOMB_CLUSTER ",
	"EXP_TAG_BOMB_GAS ",
	"EXP_TAG_BOMB_INCENDIARY ",
	"EXP_TAG_BOMB_STANDARD ",
	"EXP_TAG_TORPEDO ",
	"EXP_TAG_TORPEDO_UNDERWATER ",
	"EXP_TAG_BOMBUSHKA_CANNON ",
	"EXP_TAG_BOMB_CLUSTER_SECONDARY ",
	"EXP_TAG_HUNTER_BARRAGE ",
	"EXP_TAG_HUNTER_CANNON ",
	"EXP_TAG_ROGUE_CANNON ",
	"EXP_TAG_MINE_UNDERWATER ",
	"EXP_TAG_ORBITAL_CANNON ",
	"EXP_TAG_BOMB_STANDARD_WIDE ",
	"EXP_TAG_EXPLOSIVEAMMO_SHOTGUN ",
	"EXP_TAG_OPPRESSOR2_CANNON ",
	"EXP_TAG_MORTAR_KINETIC ",
	"EXP_TAG_VEHICLEMINE_KINETIC ",
	"EXP_TAG_VEHICLEMINE_EMP ",
	"EXP_TAG_VEHICLEMINE_SPIKE ",
	"EXP_TAG_VEHICLEMINE_SLICK ",
	"EXP_TAG_VEHICLEMINE_TAR ",
	"EXP_TAG_SCRIPT_DRONE ",
	"EXP_TAG_RAYGUN ",
	"EXP_TAG_BURIEDMINE ",
	"EXP_TAG_SCRIPT_MISSILE ",
	"EXP_TAG_RCTANK_ROCKET ",
	"EXP_TAG_BOMB_WATER ",
	"EXP_TAG_BOMB_WATER_SECONDARY ",
	"EXP_TAG_FLASHGRENADE ",
	"EXP_TAG_STUNGRENADE ",
	"EXP_TAG_SCRIPT_MISSILE_LARGE ",
	"EXP_TAG_SUBMARINE_BIG "
}

func.add_player_feature("Explode Player", "action_value_str", playerMalic.id, function(feat, pid)
	fire.add_explosion(player.get_player_coords(pid), feat.value, true, false, 1.0, player.player_ped())
end):set_str_data(explosions)

func.add_player_feature("Kill Player", "action", playerMalic.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.cameraManipulation.hash, pid, {player.player_id(), scriptEvents.cameraManipulation.param, math.random(0, 9999)})
	menu.get_feature_by_hierarchy_key("online.online_players.player_"..pid..".griefing.bitch_slap_blamed"):toggle()
end)

func.add_player_feature("Sound Crash", "action", playerMalic.id, function(feat, pid)
	local time = utils.time_ms() + 2000
	while time > utils.time_ms() do
		local netsoundpos = player.get_player_coords(pid)
		for i = 1, 10 do
			audio.play_sound_from_coord(-1, '5s', netsoundpos, 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 45, false)
		end
		system.wait(0)
	end	
end)

func.add_player_feature("Script Crash", "action", playerMalic.id, function(feat, pid)
	requestmodel(gameplay.get_hash_key("u_m_y_rsranger_01"))
	requestmodel(gameplay.get_hash_key("technical2"))
	local crashoffset = v3(5, 0, 0)

	local anothercrashbruh = ped.create_ped(26, gameplay.get_hash_key("u_m_y_rsranger_01"), player.get_player_coords(pid) + crashoffset, entity.get_entity_heading(player.get_player_ped(pid)), true, false)
	local thecrashvehicle = vehicle.create_vehicle(gameplay.get_hash_key("technical2"), player.get_player_coords(pid) + crashoffset, entity.get_entity_heading(player.get_player_ped(pid)), true, false)

	entity.freeze_entity(thecrashvehicle, true)

	--SET_ENTITY_COMPLETELY_DISABLE_COLLISION
	native.call(0x9EBC85ED0FFFE51C, thecrashvehicle, false, false)

	ped.set_ped_into_vehicle(anothercrashbruh, thecrashvehicle, 1)
	system.wait(1000)
	local time = utils.time_ms() + 3000
	while time > utils.time_ms() do
		network.request_control_of_entity(anothercrashbruh)
		network.request_control_of_entity(thecrashvehicle)

		--CONTROL_MOUNTED_WEAPON
		network.request_control_of_entity(anothercrashbruh)
		network.request_control_of_entity(thecrashvehicle)
		native.call(0xDCFE42068FE0135A, anothercrashbruh)

		--SET_MOUNTED_WEAPON_TARGET
		network.request_control_of_entity(anothercrashbruh)
		network.request_control_of_entity(thecrashvehicle)
		native.call(0xCCD892192C6D2BB9, anothercrashbruh, anothercrashbruh, 0, player.get_player_coords(pid), 5, true)
		system.wait(50)
	end
	system.wait(5000)
	entity.delete_entity(anothercrashbruh)
	entity.delete_entity(thecrashvehicle)
end)

func.add_player_feature("Force Into Severe Weather", "action", playerMalic.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.jobInvite.hash, pid, {pid, 0})
end)

func.add_player_feature("Force Into Work Dispute", "action", playerMalic.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.jobInvite.hash, pid, {387748548, 916750009, })
end)

func.add_player_feature("Penthouse Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.penthouse.hash, player.player_id(), {0, 124, pid})
end)

func.add_player_feature("Apartment Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.eclipse.hash, pid, {-1, 1, 1, 0, 1, 0})
end)

func.add_player_feature("Los Santos Customs Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 124})
end)

func.add_player_feature("Los Santos GolfClub Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 123})
end)

func.add_player_feature("Hookies Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 122})
end)

func.add_player_feature("Pitchers Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 120})
end)

func.add_player_feature("Vehicle Kick", "action", playerVeh.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.vehicleKick.hash, pid, {pid, 0, 0, 0, 0, 1, pid, math.min(2147483647, gameplay.get_frame_count())}) --kickout
end)

func.add_player_feature("Vehicle Godmode", "value_str", playerVeh.id, function(feat, pid)
	while feat.on do
		if ped.is_ped_in_any_vehicle(player.get_player_ped(pid)) then
			if feat.value == 0 then
				network.request_control_of_entity(player.get_player_vehicle(pid))
				while not network.has_control_of_entity(player.get_player_vehicle(pid)) and utils.time_ms() + 10000 > utils.time_ms() do
					system.wait(0)
				end

				if network.has_control_of_entity(player.get_player_vehicle(pid)) then
					natives.ENTITY.SET_ENTITY_PROOFS(ped.get_vehicle_ped_is_using(player.get_player_ped(pid)), true, true, true, true, true, true, true, true)
				end
			end

			if feat.value == 1 then
				network.request_control_of_entity(player.get_player_vehicle(pid))
				while not network.has_control_of_entity(player.get_player_vehicle(pid)) and utils.time_ms() + 10000 > utils.time_ms() do
					system.wait(0)
				end

				if network.has_control_of_entity(player.get_player_vehicle(pid)) then
					natives.ENTITY.SET_ENTITY_PROOFS(ped.get_vehicle_ped_is_using(player.get_player_ped(pid)), false, false, false, false, false, false, false, false)
				end
			end
		end
	system.wait(0)
	end
end):set_str_data({"Give", "Remove"})

func.add_player_feature("Repair Vehicle", "action", playerVeh.id, function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		natives.VEHICLE.SET_VEHICLE_FIXED(player.get_player_vehicle(pid))
	end
end)

func.add_player_feature("Upgrade Vehicle", "action", playerVeh.id, function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		local veh = player.get_player_vehicle(pid)
		natives.VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 0, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 0) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 1, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 1) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 2, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 2) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 3, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 3) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 4, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 4) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 5, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 5) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 6, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 6) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 7, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 7) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 8, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 8) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 9, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 9) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 10, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 10) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 11, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 11) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 12, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 12) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 13, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 13) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 14, 10, false)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 15, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 15) - 1, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 16, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 16) - 1, true)
		natives.VEHICLE.SET_VEHICLE_WHEEL_TYPE(veh, 7)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 23, 19, true)
		natives.VEHICLE.SET_VEHICLE_MOD(veh, 24, 30, true)
		natives.VEHICLE.TOGGLE_VEHICLE_MOD(veh, 18, true)
		natives.VEHICLE.TOGGLE_VEHICLE_MOD(veh, 20, true)
		natives.VEHICLE.TOGGLE_VEHICLE_MOD(veh, 22, true)
		natives.VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(veh, 255, 105, 180)
		natives.VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
		natives.VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
		natives.VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, "Rimuru")
		natives.VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, 25, 25, 112)
		natives.VEHICLE.SET_VEHICLE_MOD_COLOR_1(veh, 3, 0, 0)
		natives.VEHICLE.SET_VEHICLE_MOD_COLOR_2(veh, 3, 0)
		natives.VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, 255, 255, 255)
	end
end)

func.add_player_feature("Boost Vehicle", "action", playerVeh.id, function(f, pid)
	if player.is_player_in_any_vehicle(pid) then
		natives.VEHICLE.SET_VEHICLE_FORWARD_SPEED(player.get_player_vehicle(pid), 2000.0)
	end
end)

func.add_player_feature("Destroy Personal Vehicle", "action", playerVeh.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.destroyPersonalVehicle.hash, pid, {pid, pid}) --destroy personal
	script.trigger_script_event(scriptEvents.vehicleKick.hash, pid, {pid, 0, 0, 0, 0, 1, pid, math.min(2147483647, gameplay.get_frame_count())}) --kickout
end)


func.add_player_feature("Give Bounty", "action", playerMisc.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.bounty.hash, pid, {69, pid, 1, 10000, 0, 1,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1924276 + 9), script.get_global_i(1924276 + 10)})
end)

local wanted = func.add_player_feature("Give Wanted", "action_value_i", playerMisc.id, function(feat, pid)    
	natives.PLAYER.SET_PLAYER_WANTED_LEVEL(pid, feat.value, false)
end)
wanted.min = 0
wanted.max = 5
wanted.value = 1

func.add_player_feature("Trick Or Treat", "action", playerMisc.id, function(f, pid)
	script.set_global_i(globals["trick"], 1)
	script.trigger_script_event(scriptEvents.peyote.hash , pid, {pid, 8, -5, 1, 1, 1}) 
end)

func.add_player_feature("Send Mugger", "action", playerMisc.id, function(f, pid)
	menu.get_feature_by_hierarchy_key("online.online_players.player_" .. pid .. ".griefing.send_mugger"):toggle()

end)

func.add_player_feature("Copy player to spoof profile", "action", playerMisc.id, function(f, pid)
	savePlayerToSpoofer(pid)
end)

func.add_player_feature("Copy SCID", "action", playerMisc.id, function(f, pid)
	utils.to_clipboard(tostring(player.get_player_scid(pid)))
	menu.notify("Copied "..player.get_player_scid(pid).." to clipboard")
end)

func.add_player_feature("Copy Name + SCID", "action", playerMisc.id, function(f, pid)
	utils.to_clipboard(tostring(player.get_player_scid(pid).." "..player.get_player_name(pid)))
	menu.notify("Copied: "..player.get_player_scid(pid).." "..player.get_player_name(pid).." to clipboard")
end)

-----------

func.add_player_feature("Spawn Ped", "action_value_str", playerDrops.id, function(feat, pid)
	SpawnPed(feat.value, 100, pid)
end):set_str_data(pedList)


func.add_player_feature("Rank up", "action", playerDrops.id, function(f, pid)
	for i = 0, 9 do
		script.trigger_script_event(968269233, pid, {pid, 0, i, 1, 1, 1})
		script.trigger_script_event(968269233, pid, {pid, 1, i, 1, 1, 1})
		script.trigger_script_event(968269233, pid, {pid, 3, i, 1, 1, 1})
		script.trigger_script_event(968269233, pid, {pid, 10, i, 1, 1, 1})
	end
end)

func.add_player_feature("RP Drop", "toggle", playerDrops.id, function(feat, pid)
	streaming.request_model(1025210927)
	while feat.on do	
		
		if streaming.has_model_loaded(1025210927) then
			local pos = player.get_player_coords(pid)
			natives.OBJECT.CREATE_AMBIENT_PICKUP(0x2C014CA6, pos.x, pos.y, pos.z, 0, 1, 1025210927, true, true)
		end
		system.wait(0)
	end		
end)

--func.add_player_feature("Money Drop", "toggle", playerDrops.id, function(feat, pid)
--	local hash = gameplay.get_hash_key("h4_prop_h4_cash_stack_02a")
--	streaming.request_model(hash)
--	while feat.on do	
--		if streaming.has_model_loaded(hash) then
--			local pos = player.get_player_coords(pid)
--			natives.OBJECT.CREATE_AMBIENT_PICKUP(gameplay.get_hash_key("pickup_custom_script"), pos.x, pos.y, pos.z, 0, 1000, hash, false, true)
--		end
--		system.wait(0)
--	end		
--end)

func.add_player_feature("Semi God", "toggle", playerDrops.id, function(feat, pid)
	streaming.request_model(1025210927)
	while feat.on do	
		if streaming.has_model_loaded(1025210927) then
			native.call(0x673966A0C0FD7171, gameplay.get_hash_key("REWARD_ARMOUR"), player.get_player_coords(pid), 0, 1, 1025210927, 0, 1)
			native.call(0x673966A0C0FD7171, gameplay.get_hash_key("REWARD_HEALTH"), player.get_player_coords(pid), 0, 1, 1111175276, 0, 1)
		end
		system.wait(0)
	end		
end)

func.add_player_feature("Fake Money Bag Drop", "toggle", playerTroll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("prop_money_bag_01"))		
	while feat.on do
		local bags = object.create_object(gameplay.get_hash_key("prop_money_bag_01"), player.get_player_coords(pid), true, true)
		entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
			entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
			entity.set_entity_heading(bags, player.get_player_heading(pid))
		system.wait(40)
	end		
end)

func.add_player_feature("Fake Money Drop", "toggle", playerTroll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("bkr_prop_scrunched_moneypage"))		
	local bags = object.create_object(gameplay.get_hash_key("bkr_prop_scrunched_moneypage"), player.get_player_coords(pid), true, true)
	entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
	while feat.on do
			entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
			entity.set_entity_heading(bags, player.get_player_heading(pid))
		system.wait(10)
	end		
end)

func.add_player_feature("Cage", "action", playerTroll.id, function(feat, pid)
	if natives.NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
		if ped.is_ped_in_any_vehicle(player.get_player_ped(pid)) then
			ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
		end
		object.create_object(2718056036, player.get_player_coords(pid), true, false)
	end
end)

func.add_player_feature("Fake Suspended", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event_2(1 << pid, -1773335296, 1000, "HUD_ROSBANX", 1)
end)

func.add_player_feature("Fake Ban", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event_2(1 << pid, -1773335296, player.player_id(), "HUD_SCSBANNED")
end)

func.add_player_feature("Kinetic Emp", "action", playerTroll.id, function(feat, pid)
	createExplosion(63, player.get_player_coords(pid))
end)

func.add_player_feature("Water Jet", "action", playerTroll.id, function(feat, pid)
	createExplosion(13, player.get_player_coords(pid))
end)

func.add_player_feature("Fire Jet", "action", playerTroll.id, function(feat, pid)
	createExplosion(12, player.get_player_coords(pid))
end)

func.add_player_feature("Steam Jet", "action", playerTroll.id, function(feat, pid)
	createExplosion(11, player.get_player_coords(pid))
end)

func.add_player_feature("Cash Removed ", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.message.hash, pid, {pid, -242911964, 2147483647}) --cash removed
end)

func.add_player_feature("Cash Stolen", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.message.hash, pid, {pid, -295926414, 2147483647}) --cash removed
end)	

func.add_player_feature("Cash Banked", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.message.hash, pid, {pid, 94410750, 2147483647}) --cash banked
end)

func.add_player_feature("Cash Dropped", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.message.hash, pid, {pid, 1549986304, 2147483647}) --cash dropped
end)
-------

func.add_player_feature("Teleport To Player", "action", playerTeleport.id, function(feat, pid)
	entity.set_entity_coords_no_offset(player.player_ped(), player.get_player_coords(pid))		
end)

func.add_player_feature("Teleport Peds To Player", "action", playerTeleport.id, function(feat, pid)
    local peds = ped.get_all_peds()
    local myped = player.player_ped()
    for i=1, #peds do
        if peds[i] ~= myped then
            entity.set_entity_coords_no_offset(peds[i], player.get_player_coords(pid))
        end
    end
end)

func.add_player_feature("Teleport Vehicles To Player", "action", playerTeleport.id, function(feat, pid)
    local vehs = vehicle.get_all_vehicles()
    local myvehicle =  ped.get_vehicle_ped_is_using(player.player_ped())
    for i=1, #vehs do
        if myvehicle ~= nil then
            if vehs[i] ~= myvehicle then
                entity.set_entity_coords_no_offset(vehs[i], player.get_player_coords(pid))
            end
        end
    end
end)