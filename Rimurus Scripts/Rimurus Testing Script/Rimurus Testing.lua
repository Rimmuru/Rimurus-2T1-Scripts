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

menu.add_feature("Instantly Enter Vehicle", "toggle", scriptMain.id, function(f)
    while f.on do
    
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

--void draw_rect(float x, float y, float width, float height, int r, int g, int b, int a)⚓︎
local function wheel(pos, text, text1, text2, text3, text4, text5)
    text = text or "empty" text1 = text1 or "empty" 
    text2 = text2 or "empty" text3 = text3 or "empty"
    text4 = text4 or "empty" text5 = text5 or "empty"

    while true do
        local retrn, screen = graphics.project_3d_coord(pos)
    
        if retrn then
            --box 1
            ui.draw_rect(screen.x/graphics.get_screen_width(), screen.y/graphics.get_screen_height(), 0.05, 0.05, 0, 0, 0, 205)
            drawtext(text, v2(screen.x/graphics.get_screen_width(), screen.y/graphics.get_screen_height())) 
            
            --box 2
            ui.draw_rect(screen.x/graphics.get_screen_width(), screen.y/graphics.get_screen_height()+0.08, 0.05, 0.05, 0, 0, 0, 205)
            drawtext(text1, v2(screen.x/graphics.get_screen_width(), screen.y/graphics.get_screen_height()+0.08)) 

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