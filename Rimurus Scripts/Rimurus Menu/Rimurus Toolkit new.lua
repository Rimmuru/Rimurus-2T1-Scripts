require("Rimuru\\Dependancies\\LuaUI\\LuaUI")
require("Rimuru\\Dependancies\\Functions")
require("Rimuru\\Dependancies\\BannerHandller")

LuaUI.Options.menuPos.x = 0.5
LuaUI.Options.menuPos.y = 0.4
LuaUI.Options.menuWH.x = 0.2
LuaUI.Options.menuWH.y = 0

LuaUI.Options.menus = {
    "main",
    "Local",
    "Vehicle",
    "Spawner",
    "Online",
    "Settings",
    "PlayerMenu"
}

LuaUI.Options.currentMenu = LuaUI.Options.menus[1]

local customColour

loaded()
LoadFaves()

local toggles = {
    grappleGun_t = false,
    objGun_t = false,
    fireGun_t = false,
    waterGun_t = false,
    deleteGun_t = false,
    dustGun_t = false,
    blackParade_t = false,
    AdminSpec_t = false,
    banner_t = true
}

local sliders = {
    pedSliderValue = 0,
    objectSliderValue = 0,
    worldSliderValue = 0,
    propSliderValue = 0,
    bannerSliderValue = 1
}

local function scrollBar(x, y)
    LuaUI.drawRect(x, y, LuaUI.Options.menuWH.x - 0.005, 0.02, customColour)
end

local names = ""
function UI()
    LuaUI.drawOutline(
        "Rimurus Menu 1.4",
        0.5,
        LuaUI.Options.menuPos.x,
        LuaUI.Options.menuPos.y,
        LuaUI.Options.menuWH.x,
        LuaUI.Options.menuWH.y + 0.06 + (0.042 * LuaUI.Options.maxScroll),
        customColour,
        Colour.black,
        true,
        true
    )
    if toggles.banner_t then
        LuaUI.drawBanner(LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y - 0.05, customColour) --1521x485
    end
    scrollBar(LuaUI.Options.menuPos.x, LuaUI.Options.menuPos.y + 0.05 + (0.34 * LuaUI.Options.scroll / 10))

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[1]) then
        LuaUI.Options.maxScroll = 4
        LuaUI.drawSubmenu("Local Options", 0)
        LuaUI.drawSubmenu("Vehicle Options", 1)
        LuaUI.drawSubmenu("Spawner", 2)
        LuaUI.drawSubmenu("Online", 3)
        LuaUI.drawSubmenu("Settings", 4)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[2]) then
        LuaUI.Options.maxScroll = 7
        LuaUI.drawOptionToggle("Grapple Gun", 0, toggles.grappleGun_t)
        LuaUI.drawOptionToggle("Object Gun", 1, toggles.objGun_t)
        LuaUI.drawOptionToggle("Water Gun", 2, toggles.waterGun_t)
        LuaUI.drawOptionToggle("Fire Gun", 3, toggles.fireGun_t)
        LuaUI.drawOptionToggle("Dust Gun", 4, toggles.dustGun_t)
        LuaUI.drawOptionToggle("Delete Gun", 5, toggles.deleteGun_t)
        LuaUI.drawOptionToggle("Black Parade", 6, toggles.blackParade_t)
        LuaUI.drawOptionToggle("Block Admin Spectate", 7, toggles.AdminSpec_t)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[3]) then
        LuaUI.Options.maxScroll = 2
        LuaUI.drawOption("Gta4 Style Neons", 0)
        LuaUI.drawOption("Remove Neons", 1)
        LuaUI.drawOption("Teleport Personal Vehicle", 2)
        --LuaUI.drawOption("Save Vehicle", 3)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[4]) then
        LuaUI.Options.maxScroll = 4
        LuaUI.drawStringSlider("SpawnPed", 0, pedList, sliders.pedSliderValue)
        LuaUI.drawStringSlider("SpawnObject", 1, Objs, sliders.objectSliderValue)
        LuaUI.drawStringSlider("SpawnWorld", 2, WorldObjects, sliders.worldSliderValue)
        LuaUI.drawStringSlider("SpawnProp", 3, Objs, -1)
        LuaUI.drawOption("SpawnObjectByName", 4)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[5]) then
        for i = 0, 5 do
            names = player.get_player_name(i)
            if (names == nil) then
            else
                LuaUI.Options.maxScroll = i
                LuaUI.drawSubmenu(names, i)
            end
        end
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
        LuaUI.Options.maxScroll = 5
        LuaUI.drawIntSlider("Colour Red", 0, customColour.r)
        LuaUI.drawIntSlider("Colour Green", 1, customColour.g)
        LuaUI.drawIntSlider("Colour Blue", 2, customColour.b)
        LuaUI.drawOptionToggle("Toggle Banner", 3, toggles.banner_t)
        LuaUI.drawStringSlider("Banners:", 4, bannerList, sliders.bannerSliderValue)
        LuaUI.drawOption("Save UI", 5)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[7]) then
        LuaUI.Options.maxScroll = 2
        LuaUI.drawOption("yes", 0)
        LuaUI.drawOption("yes", 1)
        LuaUI.drawOption("yes", 2)
    end
end

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
                toggles.grappleGun_t = not toggles.grappleGun_t
            end
            if (LuaUI.Options.scroll == 1) then
                toggles.objGun_t = not toggles.objGun_t
            end
            if (LuaUI.Options.scroll == 2) then
                toggles.waterGun_t = not toggles.waterGun_t
            end
            if (LuaUI.Options.scroll == 3) then
                toggles.fireGun_t = not toggles.fireGun_t
            end
            if (LuaUI.Options.scroll == 4) then
                toggles.dustGun_t = not toggles.dustGun_t
            end
            if (LuaUI.Options.scroll == 5) then
                toggles.deleteGun_t = not toggles.deleteGun_t
            end
            if (LuaUI.Options.scroll == 6) then
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
    if toggles.blackParade_t then
        BlackParade()
    end

    local channels = {
        redChannel = UIcolourSaved[1],
        greenChannel = UIcolourSaved[2],
        blueChannel = UIcolourSaved[3]
   }
    customColour = {r = channels.redChannel, g = channels.greenChannel, b = channels.blueChannel, a = 255}
end

menu.add_feature(
    "Toggle Rimurus Toolkit",
    "toggle",
    0,
    function(tog)
        local menuTog = false

        while tog do
            if (controls.is_control_pressed(2, 166)) then --f5
                menuTog = not menuTog
            end

            if menuTog then
                UI()
                keyHook()
            end

            functions()
            system.wait(0)
        end
    end
)
