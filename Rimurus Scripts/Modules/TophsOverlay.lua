local feats, feat_vals = {}, {}
local appdata = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
local INI = IniParser(appdata .. "\\scripts\\TophsOverlaySettings.ini")
local local_version = "1.5.2"

menu.create_thread(function(f)
    if menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_HTTP) then
        local response, GitHub_Version = web.request("https://raw.githubusercontent.com/Toph2T1/Tophs-Overlay/main/TophsOverlayVersion")
	
        if response == 200 then
            if local_version ~= GitHub_Version:gsub("[\r\n]", "") then
                menu.notify("An update is available.\nCurrent Version: " .. local_version .. "\nLatest Version: " .. GitHub_Version, "Toph's Overlay", 7, 0xFF00FF00)
            end
        else
            menu.notify("There was a problem checking for new updates.", "Toph's Overlay", 7, 0x0000FF)
        end
    else
        menu.notify("Unable to check for new script updates as the trusted flag for Http is not enabled.", "Toph's Overlay", 7, 0x0000FF)
    end
end)

local function SaveSettings()
    for k, v in pairs(feats) do
        INI:set_b("Toggles", k, v.on)
    end
    for k, v in pairs(feat_vals) do
        INI:set_f("Values", k, v.value)
    end
    INI:write()
	menu.notify("Settings Saved", "Toph's Overlay", 7, 0xFF00FF00)
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
    end
end

local function RGBAToInt(R, G, B, A)
	A = A or 255
	return ((R&0x0ff)<<0x00)|((G&0x0ff)<<0x08)|((B&0x0ff)<<0x10)|((A&0x0ff)<<0x18)
end

local rgbcolor = {r = 255, g = 0, b = 0}
local function RainbowText()
	if (rgbcolor.r > 0 and rgbcolor.b == 0) then
		rgbcolor.r = rgbcolor.r - 1
		rgbcolor.g = rgbcolor.g + 1
	end
	if (rgbcolor.g > 0 and rgbcolor.r == 0) then
		rgbcolor.g = rgbcolor.g - 1
		rgbcolor.b = rgbcolor.b + 1
	end
	if (rgbcolor.b > 0 and rgbcolor.g == 0) then
		rgbcolor.r = rgbcolor.r + 1
		rgbcolor.b = rgbcolor.b - 1
	end
end

local function SessionType()
	if menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
		if network.is_session_started() then
        	if native.call(0xF3929C2379B60CCE):__tointeger() == 1 then 
            	return "Solo"
        	elseif native.call(0xCEF70AA5B3F89BA1):__tointeger() == 1 then
            	return "Invite Only"
        	elseif native.call(0xFBCFA2EA2E206890):__tointeger() == 1 then
            	return "Friends Only"
        	elseif native.call(0x74732C6CA90DA2B4):__tointeger() == 1 then 
            	return "Crew Only"
        	end
    		return "Public"
    	end
    	return "Singleplayer"
	else 
		return "Natives Trusted Mode Not Enabled."
	end
end

local function SessionHidden()
	if menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
    	if native.call(0xBA416D68C631496A):__tointeger() == 0 then
        	return "True"
    	end
    	return "False"
	else
		return "Natives Trusted Mode Not Enabled."
	end
end

local function GetStreetNameFromHashKey(hash)
    return native.call(0xD0EF8A959B8A4CB9, hash):__tostring(true)
end

local function GetStreetNameAtCoord(x, y, z)
    if menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
        local streetInfo = {name = "", crossingRoad = ""}
        local bufferN = native.ByteBuffer8()
        local bufferC = native.ByteBuffer8()

        native.call(0x2EB41072B4C1E4C0, x, y, z, bufferN, bufferC)
        streetInfo.name = GetStreetNameFromHashKey(bufferN:__tointeger())
        streetInfo.crossingRoad = GetStreetNameFromHashKey(bufferC:__tointeger())
        return streetInfo
    else
        local streetInfo = {name = "", crossingRoad = ""}
        streetInfo.name = "Natives Trusted Mode Not Enabled."
        streetInfo.crossingRoad = "Natives Trusted Mode Not Enabled."
        return streetInfo
    end
end

local main = menu.add_feature("Info Overlay", "parent", 0)
feats.EnableOverlay = menu.add_feature("Enable Overlay", "toggle", main.id, function(f)
	while f.on do
        local pped = player.player_ped()
		local pid = player.player_id()
		local playercoords = player.get_player_coords(pid)
		
        local AlivePlayers, DeadPlayers, ModderCount, SpectatorCount, FriendCount, GodCount, InIntCount = 0, 0, 0, 0, 0, 0, 0
		for i = 0, 31 do
			if player.is_player_valid(i) then
				if player.get_player_health(i) > 0 then 
					AlivePlayers = AlivePlayers + 1
				else
					DeadPlayers = DeadPlayers + 1
				end
				if player.is_player_modder(i, -1) then
					ModderCount = ModderCount + 1
				end
				if player.is_player_spectating(i) then
					SpectatorCount = SpectatorCount + 1
				end
				if player.is_player_friend(i) then
					FriendCount = FriendCount + 1
				end
				if player.is_player_god(i) then
					GodCount = GodCount + 1
				end
				if interior.get_interior_from_entity(player.get_player_ped(i)) ~= 0 then
					InIntCount = InIntCount + 1
				end
			end
		end

		local info = {}
		if feats.FPS.on then 
			info[#info + 1] = "FPS: " .. math.ceil(1 / gameplay.get_frame_time())
		end
		if feats.SessionType.on then
			info[#info + 1] = "Session Type: " .. SessionType()
		end
		if feats.SessionHost.on then
            local host = player.get_host()
            local SessionHost = player.get_host() >= 0 and player.get_player_name(host) or "N/A"

			if SessionHost == player.get_player_name(player.player_id()) then
				info[#info + 1] = "Session Host: #FFB6599B#" .. SessionHost .. "#DEFAULT#"
			elseif player.is_player_friend(host) then
				info[#info + 1] = "Session Host: #FFE5B55D#" .. SessionHost .. "#DEFAULT#" 
			elseif player.is_player_modder(host, -1) then
				info[#info + 1] = "Session Host: #FF0000FF#" .. SessionHost .. "#DEFAULT#"
			else
				info[#info + 1] = "Session Host: " .. SessionHost .. "#DEFAULT#"
			end
		end
		if feats.NextSessionHost.on then
    		local next_host = player.get_host()
    		for i = 0, 31 do
        		if player.is_player_valid(i) then
					if player.get_host() ~= -1 and player.get_player_host_priority(i) == 1 and not player.is_player_host(i) then
						next_host = i
					elseif player.get_host ~= -1 and player.get_player_host_priority(i) == 2 and not player.is_player_host(i) then
						next_host = i
					end
				end
			end

			if next_host == player.player_id() then
				info[#info + 1] = "Next Session Host: #FFB6599B#" .. player.get_player_name(next_host) .. "#DEFAULT#"
			elseif player.is_player_friend(next_host) then
				info[#info + 1] = "Next Session Host: #FFE5B55D#" .. player.get_player_name(next_host) .. "#DEFAULT#"
			elseif player.is_player_modder(next_host, -1) then
				info[#info + 1] = "Next Session Host: #FF0000FF#" .. player.get_player_name(next_host) .. "#DEFAULT#"
			else
				info[#info + 1] = "Next Session Host: " .. player.get_player_name(next_host) 
			end
		end
		if feats.ScriptHost.on then
			local shost = script.get_host_of_this_script()
			local scripthost = script.get_host_of_this_script() >= 0 and player.get_player_name(shost) or "N/A"
			--local scripthost = player.get_player_name(script.get_host_of_this_script())
			if scripthost == player.get_player_name(player.player_id()) then
				info[#info + 1] = "Script Host: #FFB6599B#" .. scripthost .. "#DEFAULT#"
			elseif player.is_player_friend(shost) then
				info[#info + 1] = "Script Host: #FFE5B55D#" .. scripthost .. "#DEFAULT#" 
			elseif player.is_player_modder(shost, -1) then
				info[#info + 1] = "Script Host: #FF0000FF#" .. scripthost .. "#DEFAULT#"
			else
				info[#info + 1] = "Script Host: " .. scripthost .. "#DEFAULT#"
			end
		end
		if feats.SessionHidden.on then
			info[#info + 1] = "Session Hidden: " .. SessionHidden()
		end
		if feats.PlayerCount.on then
			info[#info + 1] = "Player Count: " .. player.player_count()
		end

		if feats.AliveAndDeadCount.on then
			if feats.PlayerCount.on then
				info[#info + 1] = "\tAlive: " .. AlivePlayers .. " | Dead: " .. DeadPlayers
			else
				info[#info + 1] = "Alive: " .. AlivePlayers .. " | Dead: " .. DeadPlayers
			end
		end
		if feats.ModderCount.on then
			if feats.PlayerCount.on then
				info[#info + 1] = "\tModders: " .. ModderCount
			else
				info[#info + 1] = "Modders: " .. ModderCount
			end
		end
		if feats.FriendCount.on then
			if feats.PlayerCount.on then
				info[#info + 1] = "\tFriends: " .. FriendCount
			else
				info[#info + 1] = "Friends: " .. FriendCount
			end
		end
		if feats.SpectatorCount.on then
			if feats.PlayerCount.on then
				info[#info + 1] = "\tSpectators: " .. SpectatorCount
			else
				info[#info + 1] = "Spectators: " .. SpectatorCount
			end
		end
		if feats.GodModeCount.on then 
			if feats.PlayerCount.on then
				info[#info + 1] = "\tInvulnerable: " .. GodCount
			else
				info[#info + 1] = "Invulnerable: " .. GodCount
			end
		end
		if feats.InInteriorCount.on then
			if feats.PlayerCount.on then
				info[#info + 1] = "\tIn Interior: " .. InIntCount
			else
				info[#info + 1] = "In Interior: " .. InIntCount
			end
		end
		if feats.Health.on then
			info[#info + 1] = string.format("Health: %.0f", player.get_player_health(pid)) ..  string.format(" / %.0f", player.get_player_max_health(pid))
		end
		if feats.Armor.on then 
			info[#info + 1] = string.format("Armor: %.0f", player.get_player_armour(pid)) .. " / 50"
		end
		if feats.WantedLevel.on then
			info[#info + 1] = "Wanted Level: " .. player.get_player_wanted_level(pid)
		end
		if feats.VehicleInfo.on then
            if ped.is_ped_in_any_vehicle(player.player_ped()) then
                local veh = ped.get_vehicle_ped_is_using(player.player_ped())
                local VehModelLabel = vehicle.get_vehicle_model_label(veh)
                local VehBrand = vehicle.get_vehicle_brand(veh) or ""
                local VehModel = vehicle.get_vehicle_model(veh)
                info[#info + 1] = "Current Vehicle: " .. VehBrand .. " " .. VehModel .. " " .. "[" .. VehModelLabel .. "]"
            else
                info[#info + 1] = "Current Vehicle: No Vehicle."
            end
		end
        if feats.VehicleGears.on then
            if ped.is_ped_in_any_vehicle(player.player_ped()) then
                local veh = ped.get_vehicle_ped_is_using(player.player_ped())
                local VehCGear = vehicle.get_vehicle_current_gear(veh)
                local VehMGear = vehicle.get_vehicle_max_gear(veh)
			    info[#info + 1] = "Current Gear: " .. VehCGear .. "/" .. VehMGear
            else
                info[#info + 1] = "Current Gear: No Vehicle."
            end
		end
        if feats.Speedometer.on then
            if ped.is_ped_in_any_vehicle(player.player_ped()) then
                local veh = ped.get_vehicle_ped_is_using(player.player_ped())
                CurrentSpeed = entity.get_entity_speed(veh)
            else
                CurrentSpeed = entity.get_entity_speed(player.player_ped())
            end

			if feat_vals.SpeedometerType.value == 1 then --KPH
                CurrentSpeed = CurrentSpeed * 3.6
            elseif feat_vals.SpeedometerType.value == 2 then --MPH
                CurrentSpeed = CurrentSpeed * 2.236936
            end

            info[#info + 1] = "Current Speed: " .. math.floor(CurrentSpeed + 0.5) .. " " .. feat_vals.SpeedometerType.str_data[feat_vals.SpeedometerType.value+1]    
		end
		if feats.IngameTime.on then
			info[#info + 1] = "In-game Time: " .. time.get_clock_hours() .. ":" .. time.get_clock_minutes() .. ":" .. time.get_clock_seconds()
		end
		if feats.ActualTime.on then
			if feat_vals.ActualTimeFormat.value == 1 then
				info[#info + 1] = "IRL Time: " .. os.date("%H:%M:%S")
			else
				info[#info + 1] = "IRL Time: " .. os.date("%I:%M:%S %p")
			end
		end
		if feats.Date.on then
			if feat_vals.DateFormat.value == 0 then
				info[#info + 1] = "IRL Date: " .. os.date("%d/%m/%y")
			elseif feat_vals.DateFormat.value == 1 then
				info[#info + 1] = "IRL Date: " .. os.date("%x")
			elseif feat_vals.DateFormat.value == 2 then
				info[#info + 1] = "IRL Date: " .. os.date("%A, %d %B %Y")
			end
		end
		if feats.EntityInfo.on then
			if feat_vals.EntitiesFormat.value == 1 then
				info[#info + 1] = "Loaded Entities: Peds: " .. #ped.get_all_peds() .. " | Vehicles: " .. #vehicle.get_all_vehicles() .. " | Objects: " .. #object.get_all_objects() .. " | Pickups: " .. #object.get_all_pickups()
			else
				info[#info + 1] = "Loaded Entities:\n\tPeds: " .. #ped.get_all_peds() .. "\n\tVehicles: " .. #vehicle.get_all_vehicles() .. "\n\tObjects: " .. #object.get_all_objects() .. "\n\tPickups: " .. #object.get_all_pickups()
			end
		end

		if feats.ClosestPlayer.on then
			local playerPos = player.get_player_coords(player.player_id())
			local closestPlayer = ""
			local playername = ""
			local closestDistance = math.huge
		
			for pid = 0, 31 do
				if player.is_player_valid(pid) and pid ~= player.player_id() then
					local otherPlayerPos = player.get_player_coords(pid)
					local distance = playerPos:magnitude(otherPlayerPos)
					if distance < closestDistance then
						closestPlayer = pid
						closestDistance = math.floor(distance)
						playername = player.get_player_name(closestPlayer) or "None"
					end
					if playername == "None" then 
						closestDistance = 0
					end
				end
			end
			info[#info + 1] = string.format("Closest Player: " .. playername .. " (" .. closestDistance .."m)")
		end

		if feats.Coords.on then
			if feat_vals.CoordsFormat.value == 1 then
				info[#info + 1] = string.format("Current Coordinates: X: %.3f | Y: %.3f | Z: %.3f", playercoords.x, playercoords.y, playercoords.z)
			else
				info[#info + 1] = string.format("Current Coordinates:\n\tX: %.3f\n\tY: %.3f\n\tZ: %.3f", playercoords.x, playercoords.y, playercoords.z)
			end
		end

		if feats.StreetInfo.on then
			local currentstreet = GetStreetNameAtCoord(playercoords.x, playercoords.y, playercoords.z)
			if feats.DisplayIntersectingRoads.on then
				if currentstreet.crossingRoad ~= "" then
					info[#info + 1] = "Current Street: " .. currentstreet.name .. " (Intersecting With: " .. currentstreet.crossingRoad .. ")"
				else
					info[#info + 1] = "Current Street: " .. currentstreet.name
				end
			else
				info[#info + 1] = "Current Street: " .. currentstreet.name
			end
		end

		if feats.InteriorID.on then
			info[#info + 1] = "Interior ID: " .. interior.get_interior_from_entity(player.player_ped())
		end
		
		if feats.Heading.on then
			info[#info + 1] = string.format("Heading: %.0f", player.get_player_heading(player.player_id()))
		end


        local flags = 0
		if feats.Shadow.on then
			flags = flags | 1 << 1
		end
		if feat_vals.TextAllign.value == 1 or feat_vals.TextAllign.value == 3 then
			flags = flags | 1 << 4
		end
		if feat_vals.TextAllign.value == 2 or feat_vals.TextAllign.value == 3 then
			flags = flags | 1 << 3
		end
        
		local pos = v2(scriptdraw.pos_pixel_to_rel_x(feat_vals.XPos.value), scriptdraw.pos_pixel_to_rel_y(feat_vals.YPos.value))
		local color 
			if feats.RainbowText.on then
				RainbowText()
				color = RGBAToInt(rgbcolor.r, rgbcolor.g, rgbcolor.b, feat_vals.Alpha.value)
			else
				color = RGBAToInt(feat_vals.Red.value, feat_vals.Green.value, feat_vals.Blue.value, feat_vals.Alpha.value)
			end
		scriptdraw.draw_text(table.concat(info, "\n"), pos, v2(1, 1), feat_vals.Scale.value, color, flags, feat_vals.Font.value)
		system.wait()
	end
end)
feats.EnableOverlay.hint = "Enables the overlay.\nOptions to be displayed can be enabled in the 'Displayable Options' submenu."

local DisplayOptions = menu.add_feature("Displayable Options", "parent", main.id)
DisplayOptions.hint = "A submenu containing all the available options to be displayed in the overlay."
feats.FPS = menu.add_feature("Calculated FPS", "toggle", DisplayOptions.id)
feats.FPS.hint = "Displays your games current FPS (Frames Per Second)."
feats.SessionType = menu.add_feature("Session Type", "toggle", DisplayOptions.id)
feats.SessionType.hint = "Displays the current session type.\nThe possible session types are:\n\t- Single Player\n\t- Solo\n\t- Public\n\t- Invite Only\n\t- Friends Only\n\t- Crew Only\n\n#FF00A2FF#Requires the [Natives] trusted mode flag to be enabled."
feats.SessionHost = menu.add_feature("Session Host", "toggle", DisplayOptions.id)
feats.SessionHost.hint = "Displays who the current Session Host is."
feats.NextSessionHost = menu.add_feature("Next Session Host", "toggle", DisplayOptions.id)
feats.NextSessionHost.hint = "Displays who the next Session Host will be."
feats.ScriptHost = menu.add_feature("Script Host", "toggle", DisplayOptions.id)
feats.ScriptHost.hint = "Displays the current Script Host."
feats.SessionHidden = menu.add_feature("Session Hidden Status", "toggle", DisplayOptions.id)
feats.SessionHidden.hint = "Displays if the session is hidden or not.\n\n#FF00A2FF#Requires the [Natives] trusted mode flag to be enabled."
feats.PlayerCount = menu.add_feature("Player Count", "toggle", DisplayOptions.id)
feats.PlayerCount.hint = "Displays a count of the amount of players currently in the session."
local MoreCounts = menu.add_feature("Additional Player Counts", "parent", DisplayOptions.id)
MoreCounts.hint = "Additional counts to display, such as the amount of modders or friends in the session."
feats.AliveAndDeadCount = menu.add_feature("Alive / Dead Player Count", "toggle", MoreCounts.id)
feats.AliveAndDeadCount.hint = "Displays the amount of players who are alive, and the amount of players who are dead."
feats.ModderCount = menu.add_feature("Modder Count", "toggle", MoreCounts.id)
feats.ModderCount.hint = "Displays the amount of known modders in the session."
feats.FriendCount = menu.add_feature("Friend Count", "toggle", MoreCounts.id)
feats.FriendCount.hint = "Displays the amount of social club friends in the session."
feats.SpectatorCount = menu.add_feature("Spectator Count", "toggle", MoreCounts.id)
feats.SpectatorCount.hint = "Displays the amount of players who are spectating someone."
feats.GodModeCount = menu.add_feature("God Mode / Invulnerable Count", "toggle", MoreCounts.id)
feats.GodModeCount.hint = "Displays the amount of players who have been detected to be in god mode.\n\n#FF00A2FF#Not all modders use a detectable method for god mode, not all players who are in god mode are modding.\nThis detection is not an accurate way to identify modders."
feats.InInteriorCount = menu.add_feature("In an Interior Count", "toggle", MoreCounts.id)
feats.InInteriorCount.hint = "Displays the amount of players who are in an interior (such as their apartment)."

feats.Health = menu.add_feature("Current Health", "toggle", DisplayOptions.id)
feats.Health.hint = "Displays your current and maximum health."
feats.Armor = menu.add_feature("Current Armor", "toggle", DisplayOptions.id)
feats.Armor.hint = "Displays your current and maximum Armor."
feats.WantedLevel = menu.add_feature("Wanted Level", "toggle", DisplayOptions.id)
feats.WantedLevel.hint = "Displays your current wanted level."
feats.VehicleInfo = menu.add_feature("Vehicle Info", "toggle", DisplayOptions.id)
feats.VehicleInfo.hint = "Displays information about your current vehicle: \n\t- Brand Name\n\t- Model Name\n\t- Handling / Internal Name"
feats.VehicleGears = menu.add_feature("Vehicle Gear", "toggle", DisplayOptions.id)
feats.VehicleGears.hint = "Displays what gear your vehicle transmission is currently in, and how many gears total the vehicle has."
feats.Speedometer = menu.add_feature("Speedometer", "toggle", DisplayOptions.id)
feats.Speedometer.hint = "Displays a speedometer to show you how fast you are moving.\n\n#FF00A2FF#The measurement used can be changed in the overlay settings: \n\t- KPH (Kilometers Per Hour)\n\t- MPH (Miles Per Hour)\n\t- MPS (Meters Per Second)"
feats.IngameTime = menu.add_feature("In-game Time", "toggle", DisplayOptions.id)
feats.IngameTime.hint = "Displays what time it is in-game."
feats.ActualTime = menu.add_feature("IRL Time", "toggle", DisplayOptions.id)
feats.ActualTime.hint = "Displays what time it is in real life.\n\n#FF00A2FF#The format can be changed in the overlay settings:\n\t- 12 Hour\n\t- 24 Hour"
feats.Date = menu.add_feature("IRL Date", "toggle", DisplayOptions.id)
feats.Date.hint = "Displays what date it currently is.\n\n#FF00A2FF#The format can be changed in the overlay settings:\n\t- DD/MM/YY (Day / Month / Year)\n\t- MM/DD/YY (Month / Day / Year)\n\t- Full Written Date (e.g. Saturday, 24 December, 2022) "
feats.EntityInfo = menu.add_feature("Nearby Entity Counts", "toggle", DisplayOptions.id)
feats.EntityInfo.hint = "Displays how many of each entity type has been loaded by your client:\n\t- Peds\n\t- Vehicles\n\t- Objects\n\t- Pickups\n\n#FF00A2FF#The format can be changed in the overlay settings: \n\t- Horizontal\n\t- Vertical"
feats.ClosestPlayer = menu.add_feature("Closest Player", "toggle", DisplayOptions.id)
feats.ClosestPlayer.hint = "Displays the name of the closest player to your position, and how far away they are."
feats.Coords = menu.add_feature("Current Coordinates", "toggle", DisplayOptions.id)
feats.Coords.hint = "Displays your current XYZ Coordinates.\n\n#FF00A2FF#The format can be changed in the overlay settings:\n\t- Horizontal\n\t- Vertical"
feats.StreetInfo = menu.add_feature("Current Street Info", "toggle", DisplayOptions.id)
feats.StreetInfo.hint = "Displays the current street you are on, as well as the intersecting street if you are in an intersection (intersection display can be disabled in the overlay settings).\n\n#FF00A2FF#Requires the [Natives] trusted mode flag to be enabled."
feats.InteriorID = menu.add_feature("Interior ID", "toggle", DisplayOptions.id)
feats.InteriorID.hint = "Displays the ID for the interior you are currently in. Displays '0' if you are outside."
feats.Heading = menu.add_feature("Current Heading (Direction)", "toggle", DisplayOptions.id)
feats.Heading.hint = "Displays your current heading (direction you are facing.)\n\n0 / -0 points you directly to the top of the map.\n180 / -180 points you directly to the bottom.\n90 points you directly to the left.\n-90 points you directly to the right."

local settings = menu.add_feature("Settings", "parent", main.id)
local OverlayColors = menu.add_feature("Colors", "parent", settings.id)
feat_vals.Red = menu.add_feature("Red", "autoaction_value_i", OverlayColors.id)
feat_vals.Red.min = 0 feat_vals.Red.max = 255 feat_vals.Red.mod = 1 feat_vals.Red.value = 255
feat_vals.Green = menu.add_feature("Green", "action_value_i", OverlayColors.id)
feat_vals.Green.min = 0 feat_vals.Green.max = 255 feat_vals.Green.mod = 1 feat_vals.Green.value = 255
feat_vals.Blue = menu.add_feature("Blue", "action_value_i", OverlayColors.id)
feat_vals.Blue.min = 0 feat_vals.Blue.max = 255 feat_vals.Blue.mod = 1 feat_vals.Blue.value = 255
feat_vals.Alpha = menu.add_feature("Alpha", "action_value_i", OverlayColors.id)
feat_vals.Alpha.min = 0 feat_vals.Alpha.max = 255 feat_vals.Alpha.mod = 10 feat_vals.Alpha.value = 255
feats.RainbowText = menu.add_feature("Rainbow text", "toggle", OverlayColors.id)

local OverlayPosForm = menu.add_feature("Postion / Formatting", "parent", settings.id)
feat_vals.XPos = menu.add_feature("X Position", "action_value_i", OverlayPosForm.id)
feat_vals.XPos.min = 0 feat_vals.XPos.max = graphics.get_screen_width() feat_vals.XPos.mod = 5 feat_vals.XPos.value = 10
feat_vals.YPos = menu.add_feature("Y Position", "action_value_i", OverlayPosForm.id)
feat_vals.YPos.min = 0 feat_vals.YPos.max = graphics.get_screen_height() feat_vals.YPos.mod = 5 feat_vals.YPos.value = 10
feat_vals.TextAllign = menu.add_feature("Text Align", "action_value_str", OverlayPosForm.id)
feat_vals.TextAllign:set_str_data({"Top Left", "Top Right", "Bottom Left", "Bottom Right"})
feat_vals.Scale = menu.add_feature("Scale", "action_value_f", OverlayPosForm.id)
feat_vals.Scale.min = 0.1 feat_vals.Scale.max = 5 feat_vals.Scale.mod = 0.1 feat_vals.Scale.value = 0.80
feats.Shadow = menu.add_feature("Text Shadow", "toggle", OverlayPosForm.id)
feat_vals.Font = menu.add_feature("Match Font To: ", "action_value_str", OverlayPosForm.id)
feat_vals.Font:set_str_data({"Menu Head", "Menu Tab", "Menu Entry", "Menu Foot", "Script 1", "Script 2", "Script 3", "Script 4", "Script 5"})
feat_vals.Font.hint = "Matches the overlay font to the selected menu UI element.\n\nTo set a custom font, go to [Local > Settings > Menu UI > Fonts], change one of them such as script 5 to your desired font, then come back to this feature and change it until it matches script 5 (or whatever one you decided on)."
feat_vals.SpeedometerType = menu.add_feature("Speedometer Measurement", "action_value_str", OverlayPosForm.id)
feat_vals.SpeedometerType.set_str_data(feat_vals.SpeedometerType, ({"MPS", "KPH", "MPH"}))
feat_vals.ActualTimeFormat = menu.add_feature("IRL Time Format", "action_value_str", OverlayPosForm.id)
feat_vals.ActualTimeFormat:set_str_data({"12 Hour", "24 Hour"})
feat_vals.DateFormat = menu.add_feature("Date Format", "action_value_str", OverlayPosForm.id)
feat_vals.DateFormat:set_str_data({"DD/MM/YY", "MM/DD/YY", "Full Date"})
feat_vals.CoordsFormat = menu.add_feature("Current Coordinates Format", "action_value_str", OverlayPosForm.id)
feat_vals.CoordsFormat:set_str_data({"Vertical", "Horizontal"})
feat_vals.EntitiesFormat = menu.add_feature("Nearby Entities Format", "action_value_str", OverlayPosForm.id)
feat_vals.EntitiesFormat:set_str_data({"Vertical", "Horizontal"})
feats.DisplayIntersectingRoads = menu.add_feature("Street Info: Display Intersecting Roads", "toggle", OverlayPosForm.id) feats.DisplayIntersectingRoads.on = true

LoadSettings() -- yay :D

menu.add_feature("Save Settings", "action", settings.id, function(f)
	SaveSettings()
end)