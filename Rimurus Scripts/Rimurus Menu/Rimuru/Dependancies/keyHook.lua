local functInlude = require("Rimuru\\Dependancies\\Functions")
local bannerInlude = require("Rimuru\\Dependancies\\BannerHandller")

if not functInlude then menu.notify("Could not find function include") end
if not bannerInlude then menu.notify("Could not find banner include") end

customColour = {}
toggles = {
    grappleGun_t = false,
    objGun_t = false,
    fireGun_t = false,
    waterGun_t = false,
    deleteGun_t = false,
    dustGun_t = false,
    ropeGun_t = false,
    blackParade_t = false,
    AdminSpec_t = true,
    banner_t = false,
    flash_t = false
}

sliders = {
    pedSliderValue = 0,
    animalSliderValue = 0,
    objectSliderValue = 0,
    worldSliderValue = 0,
    propSliderValue = 0,
    gunSliderValue = 0,
    bannerSliderValue = 1,
    fontSliderValue = 1
}

channels = {
    redChannel = 0,
    greenChannel = 208,
    blueChannel = 242
}

gunTypes = {
    "Grapple",
    "Object",
    "Water",
    "Fire",
    "Dust",
    "Delete", 
    "Rope"
}

playerInfo ={
    names = "",
    playerID = 0
}

LuaUI.Options.menus = {
    "main",
    "Local",
    "Vehicle",
    "Spawner",
    "Online",
    "Settings",
    "PlayerMenu",
    "Garage Vehicles",
    "PlayerMenu2",
    "PlayerMenu3",
    "Ini Vehicles"
}

function keyHook()
    if isKeyDown(0x28) then --down arrow
        doKey(350, 0x28, true, function()
            if LuaUI.Options.scroll < LuaUI.Options.maxScroll then
                LuaUI.Options.scroll = LuaUI.Options.scroll + 1
                if LuaUI.Options.drawScroll + 15 - LuaUI.Options.scroll <= 2 and not (LuaUI.Options.drawScroll >= LuaUI.Options.maxScroll - 15) then
                    LuaUI.Options.drawScroll = LuaUI.Options.drawScroll + 1
                end
            elseif LuaUI.Options.scroll >= LuaUI.Options.maxScroll then
                LuaUI.Options.scroll = 0
                LuaUI.Options.drawScroll = 0
            end
        end)
    end

    if isKeyDown(0x26) then --up arrow
        doKey(350, 0x26, true, function()
            if LuaUI.Options.scroll > 0 and LuaUI.Options.scroll <= LuaUI.Options.maxScroll + 1 then
                LuaUI.Options.scroll = LuaUI.Options.scroll - 1
                if LuaUI.Options.scroll - LuaUI.Options.drawScroll <= 2 and not (LuaUI.Options.drawScroll - 1 < 0) then
                    LuaUI.Options.drawScroll = LuaUI.Options.drawScroll - 1
                end
            elseif LuaUI.Options.scroll == 0 then
                LuaUI.Options.scroll = LuaUI.Options.maxScroll
                if LuaUI.Options.maxScroll > 15 then
                    LuaUI.Options.drawScroll = LuaUI.Options.maxScroll - 15
                end
            end
        end)
    end

    if isKeyDown(0x25) then 
        doKey(350, 0x25, true, function() -- left arrow
        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[2]) then
            if (LuaUI.Options.scroll == 0) then
                sliders.gunSliderValue = sliders.gunSliderValue - 1
            end

            if (LuaUI.Options.scroll == 1) then
                sliders.objectSliderValue = sliders.objectSliderValue - 1
            end
        end
    
        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[4]) then
            if (LuaUI.Options.scroll == 0) then
                sliders.pedSliderValue = sliders.pedSliderValue - 1
            end

            if (LuaUI.Options.scroll == 1) then
                sliders.animalSliderValue = sliders.animalSliderValue - 1
            end
            if (LuaUI.Options.scroll == 2) then
                sliders.objectSliderValue = sliders.objectSliderValue - 1
            end
            if (LuaUI.Options.scroll == 3) then
                sliders.worldSliderValue = sliders.worldSliderValue - 1
            end
            if (LuaUI.Options.scroll == 4) then
                sliders.propSliderValue = sliders.propSliderValue - 1
            end
        end

        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
            if (LuaUI.Options.scroll == 0) then
                if channels.redChannel > 0 then
                    channels.redChannel = channels.redChannel - 1
                end
            end

            if (LuaUI.Options.scroll == 1) then
                if channels.greenChannel > 0 then
                    channels.greenChannel = channels.greenChannel - 1
                end
            end

            if (LuaUI.Options.scroll == 2) then
                if channels.blueChannel > 0 then
                    channels.blueChannel = channels.blueChannel - 1
                end
            end

            if (LuaUI.Options.scroll == 4) then
                if sliders.fontSliderValue > 0 and sliders.fontSliderValue <= 4 then
                    sliders.fontSliderValue = sliders.fontSliderValue - 1
                end
            end
            if (LuaUI.Options.scroll == 5) then
                if LuaUI.Options.menuPos.x > 0 and LuaUI.Options.menuPos.x <= 1 then
                    LuaUI.Options.menuPos.x = LuaUI.Options.menuPos.x - 0.05
                end
            end
            
            if (LuaUI.Options.scroll == 6) then
                if LuaUI.Options.menuPos.y > -0 and LuaUI.Options.menuPos.y <= 1 then
                    LuaUI.Options.menuPos.y = LuaUI.Options.menuPos.y - 0.05
                end
            end
        end
    end)
    end

    if isKeyDown(0x27) then -- right arrow
        doKey(350, 0x27, true, function() 
        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[2]) then
            if (LuaUI.Options.scroll == 0) then
                sliders.gunSliderValue = sliders.gunSliderValue + 1
            end

            if (LuaUI.Options.scroll == 1) then
                sliders.objectSliderValue = sliders.objectSliderValue + 1
            end
        end
        
        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[4]) then
            if (LuaUI.Options.scroll == 0) then
                sliders.pedSliderValue = sliders.pedSliderValue + 1
            end
            if (LuaUI.Options.scroll == 1) then
                sliders.animalSliderValue = sliders.animalSliderValue + 1
            end
            if (LuaUI.Options.scroll == 2) then
                sliders.objectSliderValue = sliders.objectSliderValue + 1
            end
            if (LuaUI.Options.scroll == 3) then
                sliders.worldSliderValue = sliders.worldSliderValue + 1
            end
            if (LuaUI.Options.scroll == 4) then
                sliders.propSliderValue = sliders.propSliderValue + 1
            end
        end

        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
            if (LuaUI.Options.scroll == 0) then
                if channels.redChannel < 255 then
                    channels.redChannel = channels.redChannel + 1
                end
            end

            if (LuaUI.Options.scroll == 1) then
                if channels.greenChannel < 255 then
                    channels.greenChannel = channels.greenChannel + 1
                end
            end

            if (LuaUI.Options.scroll == 2) then
                if channels.blueChannel < 255 then
                    channels.blueChannel = channels.blueChannel + 1
                end
            end

            if (LuaUI.Options.scroll == 4) then
                if sliders.fontSliderValue >= 0 and sliders.fontSliderValue <= 3 then
                    sliders.fontSliderValue = sliders.fontSliderValue + 1
                end
            end
            if (LuaUI.Options.scroll == 5) then
                if LuaUI.Options.menuPos.x >= 0 and LuaUI.Options.menuPos.x <= 1 then
                    LuaUI.Options.menuPos.x = LuaUI.Options.menuPos.x + 0.05
                end
            end
            if (LuaUI.Options.scroll == 6) then
                if LuaUI.Options.menuPos.y >= 0 and LuaUI.Options.menuPos.y <= 1 then
                    LuaUI.Options.menuPos.y = LuaUI.Options.menuPos.y + 0.05
                end
            end
        end
        end)
    end

    if isKeyDown(0x0D) then --enter
        doKey(350, 0x0D, false, function()
            if (LuaUI.Options.currentMenu == LuaUI.Options.menus[1]) then
                LuaUI.switchToSub(LuaUI.Options.scroll + 2)
                LuaUI.Options.scroll = 0
			   
	
            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[2]) then
                if (LuaUI.Options.scroll == 0) then
                    if(sliders.gunSliderValue == 0) then
                        toggles.grappleGun_t = not toggles.grappleGun_t
                    end
                    if(sliders.gunSliderValue == 1) then
                        toggles.objGun_t = not toggles.objGun_t
                    end
                    if(sliders.gunSliderValue == 2) then
                        toggles.waterGun_t = not toggles.waterGun_t
                    end
                    if(sliders.gunSliderValue == 3) then
                        toggles.fireGun_t = not toggles.fireGun_t
                    end
                    if(sliders.gunSliderValue == 4) then
                        toggles.dustGun_t = not toggles.dustGun_t
                    end
                    if(sliders.gunSliderValue == 5) then
                        toggles.deleteGun_t = not toggles.deleteGun_t
                    end
                    if(sliders.gunSliderValue == 6) then
                        toggles.ropeGun_t = not toggles.ropeGun_t
                    end
                end
                if(LuaUI.Options.scroll == 1) then
                    toggles.blackParade_t = not toggles.blackParade_t
                end
                if(LuaUI.Options.scroll == 2) then
                    toggles.AdminSpec_t = not toggles.AdminSpec_t
                end
                if(LuaUI.Options.scroll == 3) then
                    Wings()
                end
                if(LuaUI.Options.scroll == 4) then
                   toggles.flash_t = not toggles.flash_t
                end
                if(LuaUI.Options.scroll == 5) then
                    local val, txt = input.get("Enter message", "", 100, 0)
                    if val == 1 then
                     return HANDLER_CONTINUE
                    end
                    if val == 2 then
                     return HANDLER_POP
                    end
                    if not txt then
                    else
                        network.send_chat_message(string.format("¦ %s", txt), false)
                    end
                end
			   
	
            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[3]) then
                if (LuaUI.Options.scroll == 0) then
                    Gta4Neons()
                end
                if (LuaUI.Options.scroll == 1) then
                    local objs = object.get_all_objects()
                    for i = 1, #objs do
                        entity.delete_entity(objs[i])
                    end
                end
                if (LuaUI.Options.scroll == 2) then
                    tpVehicle()
                end
                if(LuaUI.Options.scroll == 3) then
                    LuaUI.switchToSub(8)
                end
                if(LuaUI.Options.scroll == 4) then
                    LuaUI.switchToSub(11)
                end	   
	
            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[4]) then
                if (LuaUI.Options.scroll == 0) then
                    SpawnPed(sliders.pedSliderValue, 100)
                end
                if (LuaUI.Options.scroll == 1) then
                    SpawnAnimal(sliders.animalSliderValue, 100)
                end              
                if (LuaUI.Options.scroll == 2) then
                    SpawnObj(sliders.objectSliderValue)
                end 
                if (LuaUI.Options.scroll == 3) then
                    SpawnWrld(sliders.objectSliderValue)
                end
                if (LuaUI.Options.scroll == 4) then
                    SpawnProp(sliders.propSliderValue)
                end
	
            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[5]) then
               if(LuaUI.Options.scroll > -1 ) then
                    LuaUI.switchToSub(7)
                    playerInfo.playerID = LuaUI.Options.scroll
               end
			   
            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
                if (LuaUI.Options.scroll == 3) then
                    --toggles.banner_t = not toggles.banner_t
                end
			   
	
            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[7]) then
                if (LuaUI.Options.scroll == 0) then
                    SpawnObj(math.random(1, #Objs), playerInfo.playerID)
                end
			   

            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[8]) then
                if (LuaUI.Options.scroll > -1 and LuaUI.Options.scroll < LuaUI.Options.maxScroll) then
                    script.set_global_i(2810287+911, 1)
                    script.set_global_i(2810287+961, 0)
                    script.set_global_i(2810287+958, LuaUI.Options.scroll) --veh index
                    script.set_global_i(2810287+176, 0)
                end   

            elseif (LuaUI.Options.currentMenu == LuaUI.Options.menus[11]) then
                if(LuaUI.Options.scroll > -1) then
                    ParseIniVehicle()
                end
            end
        end)
    end

    if (controls.is_control_pressed(2, 194)) then --backspace
        LuaUI.switchToSub(1)
        LuaUI.Options.scroll = 0
    end
end

function functions()
    if toggles.grappleGun_t then
        GrappleGun()
    end
    if toggles.objGun_t then
        ObjectGun()
    end
    if toggles.fireGun_t then
        ExplosionTypeGun(12)
        ExplosionTypeGun(42)
    end
    if toggles.waterGun_t then
        ExplosionTypeGun(13)
        ExplosionTypeGun(42)
    end
    if toggles.dustGun_t then
        ExplosionTypeGun(80)
        ExplosionTypeGun(42)
    end
    if toggles.deleteGun_t then
        DeleteGun()
    end
    if toggles.ropeGun_t then
        RopeGun()
    end  
    if toggles.blackParade_t then
        BlackParade()
    end

    if toggles.AdminSpec_t then
        script.set_global_i(262145+8528, 1)
    else
        script.set_global_i(262145+8528, 0)
    end

    if toggles.flash_t then
        doPTFX()
    end
    
    customColour = {r = channels.redChannel, g = channels.greenChannel, b = channels.blueChannel, a = 255}
end
