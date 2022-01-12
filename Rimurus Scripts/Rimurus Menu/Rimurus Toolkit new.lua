require("Rimuru\\Dependancies\\keyHook")

LuaUI.Options.menuPos.x = 0.5
LuaUI.Options.menuPos.y = 0.4
LuaUI.Options.menuWH.x = 0.2
LuaUI.Options.menuWH.y = 0

LuaUI.Options.currentMenu = LuaUI.Options.menus[1]

loaded()
LoadFaves()

local function scrollBar(x, y)
    LuaUI.drawRect(x, y, LuaUI.Options.menuWH.x - 0.005, 0.02, customColour)
end

function UI()
    LuaUI.drawOutline(
        "Rimurus Menu 1.0",
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
        LuaUI.Options.maxScroll = 2
        LuaUI.drawStringSlider("Gun Types", 0, gunTypes, sliders.gunSliderValue)
        LuaUI.drawOptionToggle("Black Parade", 1, toggles.blackParade_t)
        LuaUI.drawOptionToggle("Block Admin Spectate", 2, toggles.AdminSpec_t)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[3]) then
        LuaUI.Options.maxScroll = 5
        LuaUI.drawOption("Gta4 Style Neons", 0)
        LuaUI.drawOption("Remove Neons", 1)
        LuaUI.drawOption("Teleport Personal Vehicle", 2)
        LuaUI.drawSubmenu("Garage Vehicles", 3)
        LuaUI.drawOption("Save Vehicle", 4)
        LuaUI.drawStringSlider("Load Vehicle", 5, gunTypes, 1)
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
            playerInfo.names = player.get_player_name(i)
            if (playerInfo.names == nil) then
                LuaUI.drawOption("nil", i)
            else
                LuaUI.Options.maxScroll = i
                LuaUI.drawSubmenu(playerInfo.names, i)
            end
        end
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
        LuaUI.Options.maxScroll = 3
        LuaUI.drawIntSlider("Colour Red", 0, customColour.r)
        LuaUI.drawIntSlider("Colour Green", 1, customColour.g)
        LuaUI.drawIntSlider("Colour Blue", 2, customColour.b)
        LuaUI.drawOptionToggle("Toggle Banner", 3, toggles.banner_t)
        --LuaUI.drawStringSlider("Banners:", 4, bannerList, sliders.bannerSliderValue)
        --LuaUI.drawOption("Save UI", 5)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[7]) then
        LuaUI.Options.maxScroll = 2
        LuaUI.drawOption("yes", 0)
        LuaUI.drawOption("yes", 1)
        LuaUI.drawOption("yes", 2)
    end
end

menu.add_feature(
    "Rimurus Menu",
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
            for k,v in pairs(tbl_GSV) do
                --LuaUI.drawText(v[1].." "..v[2].." "..v[4], 0.5, 0+k/30, 0, 0.25, true, false)           
            end
            
            functions()
            system.wait(0)
        end
    end
)
