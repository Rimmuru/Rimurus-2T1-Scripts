require("Rimuru\\Dependancies\\keyHook")

if loadedVer then 
	menu.notify(""..os.getenv("USERNAME").." dont be a dummy", "Rimuru's Menu is already loaded", 5, 200) 
	return
end
loadedVer = "1.0"

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
        LuaUI.Options.maxScroll = 3
        LuaUI.drawStringSlider("Gun Types", 0, gunTypes, sliders.gunSliderValue)
        LuaUI.drawOptionToggle("Black Parade", 1, toggles.blackParade_t)
        LuaUI.drawOptionToggle("Block Admin Spectate", 2, toggles.AdminSpec_t)
        LuaUI.drawOption("Give Wings", 3)
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
        for i = 0, 10 do
            playerInfo.names = player.get_player_name(i)
            if (playerInfo.names == nil) then
                LuaUI.drawOption("nil", i)
            else
                LuaUI.Options.maxScroll = i+1
                LuaUI.drawSubmenu(playerInfo.names, i)
                LuaUI.drawOption("Next Page", 11)
            end
        end
    end
    
    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[6]) then
        LuaUI.Options.maxScroll = 3
        LuaUI.drawIntSlider("Colour Red", 0, channels.redChannel)
        LuaUI.drawIntSlider("Colour Green", 1, channels.greenChannel)
        LuaUI.drawIntSlider("Colour Blue", 2, channels.blueChannel)
        LuaUI.drawOptionToggle("Toggle Banner", 3, toggles.banner_t)
        --LuaUI.drawStringSlider("Banners:", 4, bannerList, sliders.bannerSliderValue)
        --LuaUI.drawOption("Save UI", 5)
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[7]) then
        LuaUI.Options.maxScroll = 0
        LuaUI.drawOption("Spawn Random Object", 0)
    end
    
    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[8]) then
        for k,v in pairs(garageSlots) do
            LuaUI.Options.maxScroll = k-1
            LuaUI.drawOption(v[2], k-1)
        end
    end

    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[9]) then
        for i = 10, 20 do
            playerInfo.names = player.get_player_name(i)
            if (playerInfo.names == nil) then
                LuaUI.drawOption("nil", i)
            else
                LuaUI.Options.maxScroll = i+1
                LuaUI.drawSubmenu(playerInfo.names, i)
                LuaUI.drawOption("Next Page", 11)
            end
        end
    end
    if (LuaUI.Options.currentMenu == LuaUI.Options.menus[10]) then
        for i = 20, 30 do
            playerInfo.names = player.get_player_name(i)
            if (playerInfo.names == nil) then
                LuaUI.drawOption("nil", i)
            else
                LuaUI.Options.maxScroll = i+1
                LuaUI.drawSubmenu(playerInfo.names, i)
                LuaUI.drawOption("Next Page", 11)
            end
        end
    end
end

local menuTog = false
menu.add_feature(
    "Rimurus Menu",
    "toggle",
    0,
    function(tog)

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
end)
