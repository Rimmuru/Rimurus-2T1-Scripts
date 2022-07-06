local scriptMain = menu.add_feature("Rimurus Test Script", "parent", 0)

menu.add_feature("Instantly Exit Vehicle", "toggle", scriptMain.id, function(f)
    while f.on do
        if player.is_player_in_any_vehicle(player.player_id()) then
            if controls.is_control_just_pressed(2, 75) then
                native.call(0xAAA34F8A7CB32098, player.get_player_ped(player.player_id()))
            end
        end
        system.wait(0)
    end
end)

local function Get_Distance_Between_Coords(first, second)
    local x = second.x - first.x
    local y = second.y - first.y
    local z = second.z - first.z
    return math.sqrt(x * x + y * y + z * z)
end

local function get_closest_vehicle()
	local vehicles = vehicle.get_all_vehicles()

	for i=1, #vehicles do
        if Get_Distance_Between_Coords(entity.get_entity_coords(vehicles[i]), entity.get_entity_coords(player.get_player_ped(player.player_id()))) <= 3 then
            return vehicles[i]
        end     
	end
	return 0
end

menu.add_feature("Instantly Enter Vehicle", "toggle", scriptMain.id, function(f)
    while f.on do
        local veh = get_closest_vehicle()
        if controls.is_control_just_pressed(2, 75) then
            if veh ~= 0 then
                ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), veh, -1)
            end
        end
        system.wait(0)
    end
end)

menu.add_feature("Vehicle Reduced Collision", "toggle", scriptMain.id, function(toggle)
    while toggle.on do
        local veh = player.get_player_vehicle(player.player_id())
        local nearbyvehicles = vehicle.get_all_vehicles()
        for i = 1, #nearbyvehicles do
            entity.set_entity_no_collision_entity(nearbyvehicles[i], veh, true)
        end
        system.wait(0)
    end
end)

menu.add_feature("Reduced Collision", "toggle", scriptMain.id, function(toggle)
    while toggle.on do
        local objects = object.get_all_objects() 
        local vehs = vehicle.get_all_vehicles()

        for i = 1, #objects do
            entity.set_entity_no_collision_entity(objects[i], player.get_player_ped(player.player_id()), true)
        end
        
        for i = 1, #vehs do
            entity.set_entity_no_collision_entity(vehs[i], player.get_player_ped(player.player_id()), true)
        end

        system.wait(0)
    end
end)

local function drawtext(text, pos)
    ui.set_text_scale(0.32)
    ui.set_text_font(0)
    ui.set_text_centre(0)
    ui.set_text_color(255, 255, 255, 255)
    ui.set_text_outline(true) 
    ui.draw_text(text, v2(pos.x, pos.y)) 
end

local function drawtextbox(text, posX, posY)
    ui.draw_rect(posX/graphics.get_screen_width(), posY/graphics.get_screen_height(), 0.05, 0.05, 0, 0, 0, 205)
    drawtext(text, v2(posX/graphics.get_screen_width(), posY/graphics.get_screen_height()-0.02)) 
end

local function wheel(pos, text, text1, text2, text3, text4)
    text = text or "empty" text1 = text1 or "empty" 
    text2 = text2 or "empty" text3 = text3 or "empty"

    while true do
        local retrn, screen = graphics.project_3d_coord(pos)
    
        if retrn then
            --box 1
            drawtextbox(text, screen.x, screen.y)
            --box 2
            drawtextbox(text1, screen.x, screen.y+0.08) 
            --box 3
            drawtextbox(text2, screen.x, screen.y+0.08) 
            --box 4
            drawtextbox(text3, screen.x, screen.y+0.08) 
        end
    
        system.wait(0)
    end

end

menu.add_feature("Watch Dogs", "toggle", scriptMain.id, function(f)
    while f.on do
        local rtrn, pos = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
        if rtrn then
            wheel(pos, "test", "test2")
            
        end
        system.wait(0)
    end
end)
