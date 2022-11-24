if vccloaded then
    menu.notify("Colour Changer already loaded!", "Vehicle Colour Changer", 6, 0x0000FF)
    return
end

local ppid = player.player_id
local sy = system.yield
local sw = sy
local pispiav = player.is_player_in_any_vehicle
local pgpv = player.get_player_vehicle
local utms = utils.time_ms
local mf = math.floor
local ms = math.sin
local mn = menu.notify
local mad = menu.add_feature
local nc = native.call
local vtvm = vehicle.toggle_vehicle_mod
local vsvhc = vehicle.set_vehicle_headlight_color
local svnlc = vehicle.set_vehicle_neon_lights_color
local cc = {
    features = {},
    colors = {
        primary = {0,0,0},
        secondary = {0,0,0},
        pearlescent = {0,0,0},
        wheel = {0,0,0},
        neon = {0,0,0},
        tyresmoke = {255,255,255}
    },
    savedir = utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts\\Vehicle Colour Changer\\", "")
}
cc.features.parent = mad("Vehicle Colour Changer", "parent", 0).id
cc.features.colourfix = mad("GTA Colour Correction", "toggle", cc.features.parent, function(f)
    if f.on then
        mn("This feature will darken the colours to make them more accurate", "Vehicle Colour Changer")
    end
end)

local lsccolours = { -- getting these took way too long and made me want to kill myself
    {"#080808"}, {"#0F0F0F"}, {"#1C1E21"}, {"#292C2E"}, {"#5A5E66"}, {"#777C87"}, {"#515459"}, {"#323B47"}, {"#333333"}, {"#1F2226"}, {"#23292E"}, {"#121110"}, {"#050505"}, {"#121212"}, {"#2F3233"}, {"#080808"}, {"#121212"}, {"#202224"}, {"#575961"}, {"#23292E"}, {"#323B47"}, {"#0F1012"}, {"#212121"}, {"#5B5D5E"}, {"#888A99"}, {"#697187"}, {"#3B4654"}, {"#690000"}, {"#8A0B00"}, {"#6B0000"}, {"#611009"}, {"#4A0A0A"}, {"#470E0E"}, {"#380C00"}, {"#26030B"}, {"#630012"}, {"#802800"}, {"#6E4F2D"}, {"#BD4800"}, {"#780000"}, {"#360000"}, {"#AB3F00"}, {"#DE7E00"}, {"#520000"}, {"#8C0404"}, {"#4A1000"}, {"#592525"}, {"#754231"}, {"#210804"}, {"#001207"}, {"#001A0B"}, {"#00211E"}, {"#1F261E"}, {"#003805"}, {"#0B4145"}, {"#418503"}, {"#0F1F15"}, {"#023613"}, {"#162419"}, {"#2A3625"}, {"#455C56"}, {"#000D14"}, {"#001029"}, {"#1C2F4F"}, {"#001B57"}, {"#3B4E78"}, {"#272D3B"}, {"#95B2DB"}, {"#3E627A"}, {"#1C3140"}, {"#0055C4"}, {"#1A182E"}, {"#161629"}, {"#0E316D"}, {"#395A83"}, {"#09142E"}, {"#0F1021"}, {"#152A52"}, {"#324654"}, {"#152563"}, {"#223BA1"}, {"#1F1FA1"}, {"#030E2E"}, {"#0F1E73"}, {"#001C32"}, {"#2A3754"}, {"#303C5E"}, {"#3B6796"}, {"#F5890F"}, {"#D9A600"}, {"#4A341B"}, {"#A2A827"}, {"#568F00"}, {"#57514B"}, {"#291B06"}, {"#262117"}, {"#120D07"}, {"#332111"}, {"#3D3023"}, {"#5E5343"}, {"#37382B"}, {"#221918"}, {"#575036"}, {"#241309"}, {"#3B1700"}, {"#6E6246"}, {"#998D73"}, {"#CFC0A5"}, {"#1F1709"}, {"#3D311D"}, {"#665847"}, {"#F0F0F0"}, {"#B3B9C9"}, {"#615F55"}, {"#241E1A"}, {"#171413"}, {"#3B372F"}, {"#3B4045"}, {"#1A1E21"}, {"#5E646B"}, {"#000000"}, {"#B0B0B0"}, {"#999999"}, {"#B56519"}, {"#C45C33"}, {"#47783C"}, {"#BA8425"}, {"#2A77A1"}, {"#243022"}, {"#6B5F54"}, {"#C96E34"}, {"#D9D9D9"}, {"#F0F0F0"}, {"#3F4228"}, {"#FFFFFF"}, {"#B01259"}, {"#8F2F55"}, {"#F69799"}, {"#8F2F55"}, {"#C26610"}, {"#69BD45"}, {"#00AEEF"}, {"#000108"}, {"#080000"}, {"#565751"}, {"#320642"}, {"#00080F"}, {"#080808"}, {"#320642"}, {"#050008"}, {"#6B0B00"}, {"#121710"}, {"#323325"}, {"#3B352D"}, {"#706656"}, {"#2B302B"}, {"#414347"}, {"#6690B5"}, {"#47391B"}, {"#47391B", "#FFD859"}
}

local nhcoe = network.has_control_of_entity
local eiae = entity.is_an_entity
local function reqCtrl(ent)
    local check_time = utms() + 1000
    network.request_control_of_entity(ent)
    while not nhcoe(ent) and eiae(ent) and check_time > utms() do
        sy(0)
    end
    return nhcoe(ent)
end

local function RGBAToInt(R, G, B)
    return ((R&255)<<0)|((G&255)<<8)|((B&255)<<0x10)|((255&255)<<24)
end

local function HexToRGB(hexArg)
    hexArg = hexArg:gsub('#','')
    if(string.len(hexArg) == 3) then
        return tonumber('0x'..hexArg:sub(1,1)) * 17, tonumber('0x'..hexArg:sub(2,2)) * 17, tonumber('0x'..hexArg:sub(3,3)) * 17
    elseif(string.len(hexArg) == 6) then
        return tonumber('0x'..hexArg:sub(1,2)), tonumber('0x'..hexArg:sub(3,4)), tonumber('0x'..hexArg:sub(5,6))
    else
        return 0, 0, 0
    end
end

local function RainbowRGB(speed)
    speed = speed * 0.25 * utms() / 1000
    return mf(ms(speed)*127+128), mf(ms(speed+2)*127+128), mf(ms(speed+4)*127+128)
end

local function RGBToHex(r,g,b)
    return string.format("#%02X%02X%02X", b, g, r)
end

local conversionValues = {a = 24, b = 16, g = 8, r = 0}
local function IntToRGBA(...)
    local int, val1, val2, val3, val4 = ...
    local values = {val1, val2, val3, val4}
    for k, v in pairs(values) do
        values[k] = int >> conversionValues[v] & 0xff
    end
    return table.unpack(values)
end

local function getVehRGB(veh,type)
    local funcs = {
        vehicle.get_vehicle_custom_primary_colour,
        vehicle.get_vehicle_custom_secondary_colour,
        vehicle.get_vehicle_custom_pearlescent_colour,
        vehicle.get_vehicle_custom_wheel_colour,
        vehicle.get_vehicle_neon_lights_color
    }
    if type == 1 and not vehicle.is_vehicle_primary_colour_custom(veh) then
        local r, g, b = HexToRGB(lsccolours[vehicle.get_vehicle_primary_color(veh)+1][1])
        return tonumber(b), tonumber(g), tonumber(r)
    elseif type == 2 and not vehicle.is_vehicle_secondary_colour_custom(veh) then
        local r, g, b = HexToRGB(lsccolours[vehicle.get_vehicle_secondary_color(veh)+1][1])
        return tonumber(b), tonumber(g), tonumber(r)
    else
        return IntToRGBA(funcs[type](veh), "r", "g", "b")
    end
end

local function getRGBInput(type)
    colorlist = {
        cc.colors.primary,
        cc.colors.secondary,
        cc.colors.pearlescent,
        cc.colors.wheel,
        cc.colors.neon,
        cc.colors.tyresmoke
    }
    local r, s
    repeat
        r,s = input.get("Enter R, G, B ("..colorlist[type][1]..", "..colorlist[type][2]..", "..colorlist[type][3]..")", "", 13, 0)
        if r == 2 then
            mn("Cancelled", "Vehicle Colour Changer")
            return false
        end
        sw(0)
    until r == 0
    local parts = {}
    for token in s:gmatch("[^,]+") do
        local num = tonumber(token)
        if not num or num < 0 or num > 255 then
            mn("Invalid RGB format", "Vehicle Colour Changer")
            return false
        end
        parts[#parts + 1] = num
    end
    if #parts ~= 3 then
        mn("Invalid RGB format", "Vehicle Colour Changer")
        return false
    end
    if cc.features.colourfix.on then
        for i=1,3 do
            parts[i] = math.floor(parts[i]*(1-0.6))
        end
    end
    return tonumber(parts[3]), tonumber(parts[2]), tonumber(parts[1])
end

local function getHEXInput()
    local r, s
    repeat
        r,s = input.get("Enter HEX", "", 7, 0)
        if r == 2 then
            if r == 2 then mn("Cancelled", "Vehicle Colour Changer") return false end
        end
        sw(0)
    until r == 0
    if s == (nil or "") then
        mn("Invalid HEX format", "Vehicle Colour Changer")
        return false
    end
    s = s:gsub(" ","")
    s = s:lower()
    local r, g, b = HexToRGB(s)
    if r ~= nil then
        r, g, b = tonumber(r), tonumber(g), tonumber(b)
        if cc.features.colourfix.on then
            return math.floor(b*(1-0.6)), math.floor(g*(1-0.6)), math.floor(r*(1-0.6))
        end
        return b, g, r
    else
        mn("Invalid HEX format", "Vehicle Colour Changer")
        return false
    end
end

mad("Paint type: ", "autoaction_value_str", cc.features.parent, function(f)
    pcall(function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end 

        cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1] = getVehRGB(veh,1)
        cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1] = getVehRGB(veh,2)
        local ptype = 0
        if f.value == 1 then
            ptype = 12
        elseif f.value == 2 then
            ptype = 118
        elseif f.value == 3 then
            ptype = 120
        end
        vehicle.set_vehicle_colors(veh, ptype, ptype)
        vehicle.set_vehicle_custom_primary_colour(veh, RGBAToInt(cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1]))
        vehicle.set_vehicle_custom_secondary_colour(veh, RGBAToInt(cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1]))
    end)
end):set_str_data({"Classic/Metallic","Matte","Metals","Chrome"})

cc.features.primary = mad("Primary", "parent", cc.features.parent).id
cc.features.secondary = mad("Secondary", "parent", cc.features.parent).id
cc.features.pearlescent = mad("Pearlescent", "parent", cc.features.parent).id
cc.features.wheel = mad("Wheel", "parent", cc.features.parent).id
cc.features.misc = mad("Miscellaneous", "parent", cc.features.parent).id
cc.features.saved = mad("Saved Colours", "parent", cc.features.parent)
cc.features.rgb = mad("Rainbow Options", "parent", cc.features.misc).id
cc.features.dirt = mad("Dirt Options", "parent", cc.features.misc).id
cc.features.neon = mad("Neons", "parent", cc.features.rgb).id
cc.features.xenons = mad("Headlights", "parent", cc.features.rgb).id
cc.features.tyresmoke = mad("Tyre Smoke", "parent", cc.features.rgb).id

menu.create_thread(function()

    local function refreshColoursFunc()
        local function saveColour(func, filename)
            local r, s
            if func ~= nil then
                repeat
                    r,s = input.get("Enter colour name", "", 100, 0)
                    if r == 2 then
                        mn("Cancelled", "Vehicle Colour Changer")
                        return false
                    end
                    sw(0)
                until r == 0
            else
                s = filename
            end
            
            
            if not utils.dir_exists(cc.savedir) then
                utils.make_dir(cc.savedir)
            end
            local file = io.open(cc.savedir .. "\\".. s.. ".lua", "wb")
            local charS,charE = "   ","\n"
            file:write("return {" .. charE)
            
            local colortypes = 0
            for i=1,5 do
                colortypes = colortypes+1
                file:write("["..i.."] = {")
                local color3, color2, color1 = getVehRGB(pgpv(ppid()),i)
                file:write(color1..", ".. color2..", "..color3.."}")
                if colortypes ~= 5 then
                    file:write(",")
                end
            end

            file:write("}")
            file:close()
            mn("Saved colours " .. s, "Vehicle Colour Changer")
            refreshColoursFunc()
        end

        local savecolours = menu.add_feature("Save current colours", "action", cc.features.saved.id, saveColour)

        local refreshcolours = menu.add_feature("Refresh saved colours", "action", cc.features.saved.id, refreshColoursFunc)

        for _, child in pairs(cc.features.saved.children) do
            if child.id ~= savecolours.id and child.id ~= refreshcolours.id then
                menu.delete_feature(child.id)
            end
        end
    
        local savedColours = {}
        savedColours = utils.get_all_files_in_directory(cc.savedir, "lua")
        for i=1, #savedColours do
            menu.add_feature(savedColours[i]:gsub("%.lua", ""), "action_value_str", cc.features.saved.id, function(f)
                local colourTable = dofile(cc.savedir .. "\\"..savedColours[i])
                cc.colors.primary = colourTable[1]
                cc.colors.secondary = colourTable[2]
                cc.colors.pearlescent = colourTable[3]
                cc.colors.wheel = colourTable[4]
                cc.colors.neon = colourTable[5]
    
                if f.value == 2 then
                    print(savedColours[i])
                    io.remove(cc.savedir .. "\\" .. savedColours[i])
                    refreshColoursFunc()
                    return
                end
    
                if not pispiav(ppid()) then
                    mn("Please enter a vehicle","Vehicle Colour Changer")
                    return
                end
    
                local veh = pgpv(ppid())
                if not nhcoe(veh) then
                    reqCtrl(veh)
                end

                if f.value == 1 then
                    saveColour(nil, savedColours[i]:gsub("%.lua", ""))
                end
    
                if f.value == 0 then
                    vehicle.set_vehicle_custom_primary_colour(veh, RGBAToInt(cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1]))
                    vehicle.set_vehicle_custom_secondary_colour(veh, RGBAToInt(cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1]))
                    vehicle.set_vehicle_custom_pearlescent_colour(veh, RGBAToInt(cc.colors.pearlescent[3], cc.colors.pearlescent[2], cc.colors.pearlescent[1]))
                    vehicle.set_vehicle_custom_wheel_colour(veh, RGBAToInt(cc.colors.wheel[3], cc.colors.wheel[2], cc.colors.wheel[1]))
                    svnlc(veh, RGBAToInt(cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1]))
                end
            end):set_str_data({"Apply","Overwrite","Delete"})
        end
    end
    refreshColoursFunc()

    -- Primary

    mad("Set HEX value", "action", cc.features.primary, function()
        pcall(function()
            cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1] = getVehRGB(pgpv(ppid()),1)
            cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1] = getHEXInput()
            if RGBToHex(cc.colors.primary[3],cc.colors.primary[2],cc.colors.primary[1]) ~= false then
                mn("Set primary HEX to:\n"..RGBToHex(cc.colors.primary[3],cc.colors.primary[2],cc.colors.primary[1]), "Vehicle Colour Changer")
            else
                mn("Invalid HEX format", "Vehicle Colour Changer")
            end
        end)
    end)

    mad("Set RGB value", "action", cc.features.primary, function()
        pcall(function()
            cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1] = getVehRGB(pgpv(ppid()),1)
            cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1] = getRGBInput(1)
            mn("Set primary RGB to:\n"..cc.colors.primary[1]..", "..cc.colors.primary[2]..", "..cc.colors.primary[3], "Vehicle Colour Changer")
        end)
    end)

    mad("Apply primary colour", "action", cc.features.primary, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        vehicle.set_vehicle_custom_primary_colour(veh, RGBAToInt(cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1]))
        mn("Changed primary colour to:\nRGB: "..
                cc.colors.primary[1]..", "..
                cc.colors.primary[2]..", "..
                cc.colors.primary[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),1))
        , "Vehicle Colour Changer")
    end)

    mad("Display colour values", "action", cc.features.primary, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        cc.colors.primary[3], cc.colors.primary[2], cc.colors.primary[1] = getVehRGB(pgpv(ppid()),1)
        mn("Primary colour values:\nRGB: "..
                cc.colors.primary[1]..", "..
                cc.colors.primary[2]..", "..
                cc.colors.primary[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),1))
        , "Vehicle Colour Changer")
    end)

    -- Secondary
    mad("Set HEX value", "action", cc.features.secondary, function()
        pcall(function()
            cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1] = getVehRGB(pgpv(ppid()),2)
            cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1] = getHEXInput()
            if RGBToHex(cc.colors.secondary[3],cc.colors.secondary[2],cc.colors.secondary[1]) ~= false then
                mn("Set secondary HEX to:\n"..RGBToHex(cc.colors.secondary[3],cc.colors.secondary[2],cc.colors.secondary[1]), "Vehicle Colour Changer")
            else
                mn("Invalid HEX format", "Vehicle Colour Changer")
            end
        end)
    end)

    mad("Set RGB value", "action", cc.features.secondary, function()
        pcall(function()
            cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1] = getVehRGB(pgpv(ppid()),2)
            cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1] = getRGBInput(2)
            mn("Set secondary RGB to:\n"..cc.colors.secondary[1]..", "..cc.colors.secondary[2]..", "..cc.colors.secondary[3], "Vehicle Colour Changer")
        end)
    end)

    mad("Apply secondary colour", "action", cc.features.secondary, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end

        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        vehicle.set_vehicle_custom_secondary_colour(veh, RGBAToInt(cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1]))
        mn("Changed secondary colour to:\nRGB: "..
                cc.colors.secondary[1]..", "..
                cc.colors.secondary[2]..", "..
                cc.colors.secondary[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),2))
        , "Vehicle Colour Changer")
    end)

    mad("Display colour values", "action", cc.features.secondary, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        cc.colors.secondary[3], cc.colors.secondary[2], cc.colors.secondary[1] = getVehRGB(pgpv(ppid()),2)
        mn("Secondary colour values:\nRGB: "..
                cc.colors.secondary[1]..", "..
                cc.colors.secondary[2]..", "..
                cc.colors.secondary[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),2))
        , "Vehicle Colour Changer")
    end)
    -- Pearlescent

    mad("Set HEX value", "action", cc.features.pearlescent, function()
        pcall(function()
            cc.colors.pearlescent[3], cc.colors.pearlescent[2], cc.colors.pearlescent[1] = getVehRGB(pgpv(ppid()),3)
            cc.colors.pearlescent[3], cc.colors.pearlescent[2], cc.colors.pearlescent[1] = getHEXInput()
            if RGBToHex(cc.colors.pearlescent[3],cc.colors.pearlescent[2],cc.colors.pearlescent[1]) ~= false then
                mn("Set pearlescent HEX to:\n"..RGBToHex(cc.colors.pearlescent[3],cc.colors.pearlescent[2],cc.colors.pearlescent[1]), "Vehicle Colour Changer")
            else
                mn("Invalid HEX format", "Vehicle Colour Changer")
            end
        end)
    end)

    mad("Set RGB value", "action", cc.features.pearlescent, function()
        pcall(function()
            cc.colors.pearlescent[3], cc.colors.pearlescent[2], cc.colors.pearlescent[1] = getVehRGB(pgpv(ppid()),3)
            cc.colors.pearlescent[3], cc.colors.pearlescent[2], cc.colors.pearlescent[1] = getRGBInput(3)
            mn("Set pearlescent RGB to:\n"..cc.colors.pearlescent[1]..", "..cc.colors.pearlescent[2]..", "..cc.colors.pearlescent[3], "Vehicle Colour Changer")
        end)
    end)

    mad("Apply pearlescent colour", "action", cc.features.pearlescent, function()
        if not pispiav(ppid()) then
            mn("Precise Colour Changer", 6, 0x0000FF)
            return
        end

        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        vehicle.set_vehicle_custom_pearlescent_colour(veh, RGBAToInt(cc.colors.pearlescent[3], cc.colors.pearlescent[2], cc.colors.pearlescent[1]))
        mn("Changed pearlescent colour to:\nRGB: "..
                cc.colors.pearlescent[1]..", "..
                cc.colors.pearlescent[2]..", "..
                cc.colors.pearlescent[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),3))
        , "Vehicle Colour Changer")
    end)

    mad("Display colour values", "action", cc.features.pearlescent, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        cc.colors.pearlescent[3], cc.colors.pearlescent[2], cc.colors.pearlescent[1] = getVehRGB(pgpv(ppid()),3)
        mn("Pearlescent colour values:\nRGB: "..
                cc.colors.pearlescent[1]..", "..
                cc.colors.pearlescent[2]..", "..
                cc.colors.pearlescent[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),3))
        , "Vehicle Colour Changer")
    end)

    -- Wheel
    mad("Set HEX value", "action", cc.features.wheel, function()
        pcall(function()
            cc.colors.wheel[3], cc.colors.wheel[2], cc.colors.wheel[1] = getVehRGB(pgpv(ppid()),4)
            cc.colors.wheel[3], cc.colors.wheel[2], cc.colors.wheel[1] = getHEXInput()
            if RGBToHex(cc.colors.wheel[3],cc.colors.wheel[2],cc.colors.wheel[1]) ~= false then
                mn("Set wheel HEX to:\n"..RGBToHex(cc.colors.wheel[3],cc.colors.wheel[2],cc.colors.wheel[1]), "Vehicle Colour Changer")
            else
                mn("Invalid HEX format", "Vehicle Colour Changer")
            end
        end)
    end)

    mad("Set RGB value", "action", cc.features.wheel, function()
        pcall(function()
            cc.colors.wheel[3], cc.colors.wheel[2], cc.colors.wheel[1] = getVehRGB(pgpv(ppid()),4)
            cc.colors.wheel[3], cc.colors.wheel[2], cc.colors.wheel[1] = getRGBInput(4)
            mn("Set wheel RGB to:\n"..cc.colors.wheel[1]..", "..cc.colors.wheel[2]..", "..cc.colors.wheel[3], "Vehicle Colour Changer")
        end)
    end)

    mad("Apply wheel colour", "action", cc.features.wheel, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        vehicle.set_vehicle_custom_wheel_colour(veh, RGBAToInt(cc.colors.wheel[3], cc.colors.wheel[2], cc.colors.wheel[1]))
        mn("Changed wheel colour to:\nRGB: "..
                cc.colors.wheel[1]..", "..
                cc.colors.wheel[2]..", "..
                cc.colors.wheel[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),4))
        , "Vehicle Colour Changer")
    end)

    mad("Display colour values", "action", cc.features.wheel, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        cc.colors.wheel[3], cc.colors.wheel[2], cc.colors.wheel[1] = getVehRGB(pgpv(ppid()),4)
        mn("Wheel colour values:\nRGB: "..
                cc.colors.wheel[1]..", "..
                cc.colors.wheel[2]..", "..
                cc.colors.wheel[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),4))
        , "Vehicle Colour Changer")
    end)

    -- Misc

    -- Dirt
    cc.features.dirtlevel = mad("Dirt Level", "autoaction_value_i", cc.features.dirt, function(f)
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        while f.value do
            sw(0)
            nc(0x79D3B596FE44EE8B, veh, f.value+0.0)
        end
    end)
    cc.features.dirtlevel.min, cc.features.dirtlevel.max, cc.features.dirtlevel.mod = 0.0, 15.0, 1.0

    local vgpivs = vehicle.get_ped_in_vehicle_seat
    local pgpp = player.get_player_ped
    mad("Auto Clean", "toggle", cc.features.dirt, function(f)
        while f.on do
            sy(0)
            local pid = ppid()
            if pispiav(pid) then
                local veh = pgpv(pid)
                if vgpivs(veh, -1) == pgpp(pid) and nc(0x8F17BC8BA08DA62B, veh):__tonumber() ~= 0.0 then
                    nc(0x79D3B596FE44EE8B, veh, 0.0)
                end
            end
        end
    end)

    -- Neon
    cc.features.neonenabled = mad("Neons enabled", "toggle", cc.features.neon, function(f)
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        for i=0,4 do
            vehicle.set_vehicle_neon_light_enabled(pgpv(ppid()), i, f.on)
        end
        if not f.on then
            cc.features.rainbowneon.on = false
        end
    end)

    cc.features.rainbowneon = mad("Rainbow Neons                Speed:", "value_i", cc.features.neon, function(f)
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        if f.on then
            cc.features.neonenabled.on = true
        end
        while f.on and cc.features.neonenabled.on do
            if pispiav(ppid()) then
                svnlc(pgpv(ppid()), RGBAToInt(RainbowRGB(f.value)))
            end
            sy(0)
        end
        if not f.on or not cc.features.neonenabled.on then
            svnlc(pgpv(ppid()), RGBAToInt(cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1]))
        end
    end)
    cc.features.rainbowneon.min, cc.features.rainbowneon.max, cc.features.rainbowneon.mod, cc.features.rainbowneon.value = 1, 20, 1, 1

    mad("Set HEX value", "action", cc.features.neon, function()
        pcall(function()
            cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1] = getVehRGB(pgpv(ppid()),5)
            cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1] = getHEXInput()
            if RGBToHex(cc.colors.neon[3],cc.colors.neon[2],cc.colors.neon[1]) ~= false then
                mn("Set neon HEX to:\n"..RGBToHex(cc.colors.neon[3],cc.colors.neon[2],cc.colors.neon[1]), "Vehicle Colour Changer")
            else
                mn("Invalid HEX format", "Vehicle Colour Changer")
            end
        end)
    end)

    mad("Set RGB value", "action", cc.features.neon, function()
        pcall(function()
            cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1] = getVehRGB(pgpv(ppid()),5)
            cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1] = getRGBInput(5)
            mn("Set neon RGB to:\n"..cc.colors.neon[1]..", "..cc.colors.neon[2]..", "..cc.colors.neon[3], "Vehicle Colour Changer")
        end)
    end)

    mad("Apply neon colour", "action", cc.features.neon, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        svnlc(veh, RGBAToInt(cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1]))
        mn("Changed neon colour to:\nRGB: "..
                cc.colors.neon[1]..", "..
                cc.colors.neon[2]..", "..
                cc.colors.neon[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),5))
        , "Vehicle Colour Changer")
    end)

    mad("Display colour values", "action", cc.features.neon, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        cc.colors.neon[3], cc.colors.neon[2], cc.colors.neon[1] = getVehRGB(pgpv(ppid()),5)
        mn("Neon colour values:\nRGB: "..
                cc.colors.neon[1]..", "..
                cc.colors.neon[2]..", "..
                cc.colors.neon[3].."\nHEX: "..
                RGBToHex(getVehRGB(pgpv(ppid()),5))
        , "Vehicle Colour Changer")
    end)

    cc.features.rgbxenons = mad("Rainbow Xenons               Delay:", "value_i", cc.features.xenons, function(f)
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        vtvm(veh, 22, f.on)
        while true do
            if not f.on then
                vtvm(veh, 22, false)
                vsvhc(veh, 0)
                break
            end
            while f.on do
                for i = 1, 12 do
                    if f.on then
                        vsvhc(veh, i)
                        sy(f.value*100)
                    end
                end
                sw(0)
            end
        end
    end)
    cc.features.rgbxenons.min = 0
    cc.features.rgbxenons.max = 25
    cc.features.rgbxenons.mod = 1

    mad("Xenon Lights", "value_str", cc.features.xenons, function(f)
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        if f.on and not cc.features.rgbxenons.on then
            vtvm(veh, 22, f.on)
            vsvhc(veh, f.value)
        end
        if not f.on and not cc.features.rgbxenons.on then
            vtvm(veh, 22, false)
        end
    end):set_str_data({"Xenon","White","Blue","Elec Blue","Mint Green","Lime Green","Yellow","Gold","Orange","Red","Pony Pink","Hot Pink","Purple","Blacklight"})

    mad("Render scorched", "toggle", cc.features.misc, function(f)
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        if f.on then
            nc(0x730F5F8D3F0F2050, veh, true)
        end
        if not f.on then
            nc(0x730F5F8D3F0F2050, veh, false)
        end
    end)

    -- Tyre Smoke
    cc.features.tyresenabled = mad("Tyre Smoke enabled", "toggle", cc.features.tyresmoke, function(f)
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        if f.on then
            vehicle.set_vehicle_mod(pgpv(ppid()), 20, 1)
        end
        if not f.on then
            vtvm(pgpv(ppid()), 20, false)
            cc.features.rainbowtsmoke.on = false
        end
    end)

    local svtsc = vehicle.set_vehicle_tire_smoke_color
    cc.features.rainbowtsmoke = mad("Rainbow Tyre Smoke        Speed:", "value_i", cc.features.tyresmoke, function(f)
        local veh = pgpv(ppid())
        if not veh then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        if f.on then
            cc.features.tyresenabled.on = true
        end
        while f.on and cc.features.tyresenabled.on do
            if pispiav(ppid()) then
                svtsc(veh, RainbowRGB(f.value*2))
            end
            sy(0)
        end
        if not f.on or not cc.features.tyresenabled.on then
            svtsc(veh, cc.colors.tyresmoke[1], cc.colors.tyresmoke[2], cc.colors.tyresmoke[3])
        end
    end)
    cc.features.rainbowtsmoke.min, cc.features.rainbowtsmoke.max, cc.features.rainbowtsmoke.mod, cc.features.rainbowtsmoke.value = 1, 10, 1, 1

    mad("Set HEX value", "action", cc.features.tyresmoke, function()
        pcall(function()
            cc.colors.tyresmoke[3], cc.colors.tyresmoke[2], cc.colors.tyresmoke[1] = getHEXInput()
            if RGBToHex(cc.colors.tyresmoke[3],cc.colors.tyresmoke[2],cc.colors.tyresmoke[1]) ~= false then
                mn("Set tyre smoke HEX to:\n"..RGBToHex(cc.colors.tyresmoke[3],cc.colors.tyresmoke[2],cc.colors.tyresmoke[1]), "Vehicle Colour Changer")
            else
                mn("Invalid HEX format", "Vehicle Colour Changer")
            end
        end)
    end)

    mad("Set RGB value", "action", cc.features.tyresmoke, function()
        pcall(function()
            cc.colors.tyresmoke[3], cc.colors.tyresmoke[2], cc.colors.tyresmoke[1] = getRGBInput(5)
            mn("Set tyre smoke RGB to:\n"..cc.colors.tyresmoke[1]..", "..cc.colors.tyresmoke[2]..", "..cc.colors.tyresmoke[3], "Vehicle Colour Changer")
        end)
    end)

    mad("Apply tyre smoke colour", "action", cc.features.tyresmoke, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        local veh = pgpv(ppid())
        if not nhcoe(veh) then
            reqCtrl(veh)
        end
        svtsc(veh, cc.colors.tyresmoke[1], cc.colors.tyresmoke[2], cc.colors.tyresmoke[3])
        mn("Changed tyre smoke colour to:\nRGB: "..
                cc.colors.tyresmoke[1]..", "..
                cc.colors.tyresmoke[2]..", "..
                cc.colors.tyresmoke[3].."\nHEX: "..
                RGBToHex(cc.colors.tyresmoke[1], cc.colors.tyresmoke[2], cc.colors.tyresmoke[3])
        , "Vehicle Colour Changer")
    end)

    mad("Display colour values", "action", cc.features.tyresmoke, function()
        if not pispiav(ppid()) then
            mn("Please enter a vehicle","Vehicle Colour Changer")
            return
        end
        mn("Tyre Smoke colour values:\nRGB: "..
                cc.colors.tyresmoke[1]..", "..
                cc.colors.tyresmoke[2]..", "..
                cc.colors.tyresmoke[3].."\nHEX: "..
                RGBToHex(cc.colors.tyresmoke[1], cc.colors.tyresmoke[2], cc.colors.tyresmoke[3])
        , "Vehicle Colour Changer")
    end)
end,nil)

vccloaded = true
