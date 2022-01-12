require("Rimuru\\Dependancies\\LuaUI\\LuaUI")
require("Rimuru\\Dependancies\\Functions")
require("Rimuru\\Dependancies\\BannerHandller")

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
    banner_t = true
}

sliders = {
    pedSliderValue = 0,
    objectSliderValue = 0,
    worldSliderValue = 0,
    propSliderValue = 0,
    gunSliderValue = 0,
    bannerSliderValue = 1
}

gunTypes = {
    "GrappleGun",
    "Object Gun",
    "Water Gun",
    "Fire Gun",
    "Dust Gun",
    "Delete Gun", 
    "Rope Gun"
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
    "Garage Vehicles"
}

function keyHook()
    if (controls.is_control_pressed(2, 173)) then --down arrow
        if LuaUI.Options.scroll < LuaUI.Options.maxScroll then
            LuaUI.Options.scroll = LuaUI.Options.scroll + 1
        end
    end

    if (controls.is_control_pressed(2, 172)) then -- up arrow
        if LuaUI.Options.scroll > 0 and LuaUI.Options.scroll <= LuaUI.Options.maxScroll + 1 then
            LuaUI.Options.scroll = LuaUI.Options.scroll - 1
        end
    end

    if (controls.is_control_pressed(2, 174)) then -- left arrow
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
                sliders.objectSliderValue = sliders.objectSliderValue - 1
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
                if sliders.bannerSliderValue > 0 then
                    sliders.bannerSliderValue = sliders.bannerSliderValue - 1
                end
            end
         
        end
    end

    if (controls.is_control_pressed(2, 175)) then -- right arrow
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
                sliders.objectSliderValue = sliders.objectSliderValue + 1
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
                if sliders.bannerSliderValue < #bannerList then
                    sliders.bannerSliderValue = sliders.bannerSliderValue + 1
                end
            end
        end
    end

    if (controls.is_control_pressed(2, 191)) then --enter
        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[1]) then
            LuaUI.switchToSub(LuaUI.Options.scroll + 2)
            LuaUI.Options.scroll = -1
        end

        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[2]) then
            if (LuaUI.Options.scroll == 0) then
                if(sliders.gunSliderValue == 0) then
                    toggles.grappleGun_t = not toggles.grappleGun_t
                end
                if(sliders.gunSliderValue == 1) then
                    toggles.objGun_t = not toggles.objGun_t
                    print("Test")
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
        end

        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[3]) then
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
        end

        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[4]) then
            if (LuaUI.Options.scroll == 0) then
                SpawnPed(sliders.pedSliderValue, 100)
            end

            if (LuaUI.Options.scroll == 1) then
                SpawnObj(sliders.objectSliderValue)
            end
           
            if (LuaUI.Options.scroll == 4) then
                SpawnObjFromName()
            end
        end

        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[5]) then
            if (names == nil) then
            else
            end
        end

        if (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
            if (LuaUI.Options.scroll == 3) then
                toggles.banner_t = not toggles.banner_t
            end
        end
        if (LuaUI.Options.scroll == 5) then        
            local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
            saveUI = io.open(appdata.."scripts\\Rimuru\\UI.ini", "w")
           
            io.output(saveUI)  
            io.write((channels.redChannel .."\n"))
            io.write((channels.greenChannel.."\n"))
            io.write((channels.blueChannel.."\n"))
            io.close(saveUI)
        end

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

    local channels = {
        redChannel = 0,
        greenChannel = 208,
        blueChannel = 242
   }
    customColour = {r = channels.redChannel, g = channels.greenChannel, b = channels.blueChannel, a = 255}
end
