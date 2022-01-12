---@diagnostic disable: undefined-global
-- Author: well in that case#0082 (700091773695033505)
-- INI Parser: An object-oriented approach to parsing INI configuration files.
--
-- Licensing:
--      - You're granted the four essential freedoms of free software (https://www.gnu.org/philosophy/free-sw.html#four-freedoms) under these conditions:
--          - You don't claim you've originally made this script.
--          - If you modify this script, you include a link to the original source on GitLab (found below) inside of your repository or source:
--              - https://gitlab.com/wellinthatcase/2take1-scripts-case/-/blob/main/ini_parser.lua

local ini = {
    version = "0.1.4",
    __lwsec = false,
    __debug = false
}

-----------------------
--  Debug Utilities  --
-----------------------
function ini._Case_Ini_Recurse(tab, tab_name)
    for key, val in pairs(tab) do
        if type(val) == "table" then
            ini._Case_Ini_Recurse(val, key)
        else
            tab = tostring(tab)
            print("KEY: "..key.."\nTYPE: "..type(val).."\nVALUE: "..tostring(val).."\nTABLE: "..(tab_name or tab).."\n")
        end
    end
end

-------------------------
-- Beginning of Parser --
-------------------------

local luaBoolValues = {
    ["nil"] = "nil",
    ["true"] = true,
    ["false"] = false
}

local function serializeKey(str)
    if str:sub(-1) == " " then
        str = str:sub(1, #str - 1)
    end

    return str
end

local function stringIsComment(str)
    local s = str:sub(1, 1)
    return s == ";" or s == " " or s == "\\n"
end

local function stringIsCategory(str)
    if ini.__lwsec == true then
        return str:sub(1, 1) == "["
    else
        return str:sub(1, 1) == "[" and str:sub(-1) == "]"
    end
end

local function getCategoryFromString(str)
    return str:sub(2, -2)
end

local function parseStringIntoLuaValue(val)
    if val:sub(1, 1) == " " then
        val = val:sub(2)
    end

    local nVal = tonumber(val)
    local bVal = luaBoolValues[val]

    if nVal then
        return nVal
    elseif bVal ~= nil then
        if bVal == "nil" then
            return nil
        else
            return bVal
        end
    end

    return val
end

-- Parse an INI file from `path`.
-- `cwd` is an optional parameter to specify the current working directory. Useful for relative importing.
function ini.parse(path, cwd)
    do
        cwd = tostring(cwd or utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\")
        local f1 = utils.file_exists(path)
        local f2 = utils.file_exists(cwd..path)

        if f2 then
            path = cwd..path
        elseif not f2 and not f1 then
            print("Paths that may've lead to nil file: \n1: " .. path .. "\n2: " .. cwd..path)
            return error "INI Parser: Path leads to nil file."
        end
    end

    local res = {}
    local currcat = nil

    for str in io.lines(path) do
        if not stringIsComment(str) then
            if stringIsCategory(str) then
                str = getCategoryFromString(str)

                if currcat ~= str then
                    currcat = serializeKey(str)
                end
            else
                for key, value in str:gmatch "%s*([^=]*)=([^=]*)%f[%s%z]" do
                    key = serializeKey(key)
                    value = parseStringIntoLuaValue(value)
                    if currcat then
                        if not res[currcat] then
                            res[currcat] = {}
                        end

                        res[currcat][key] = value
                    else
                        res[key] = value
                    end
                end
            end
        end
    end

    res.save = function (_path)
        local cats = {}
        local resl = ""

        for key, value in pairs(res) do
            if type(value) == "table" then
                table.insert(cats, key)
            end
        end

        for key, value in pairs(res) do
            if type(value) ~= "table" and type(value) ~= "function" then
                key = tostring(key)
                value = tostring(value)

                if value:sub(1, 1) == " " then
                    value = value:gsub(2, #value)
                end

                resl = resl .. key .. "=" .. value .. "\n"
            end
        end

        for _, tab in pairs(cats) do
            resl = resl .. "[" .. tab .. "]" .. "\n"
            for key, value in pairs(res[tab]) do
                key = tostring(key)
                value = tostring(value)

                if value:sub(1, 1) == " " then
                    value = value:gsub(2, #value)
                end

                resl = resl .. key .. "=" .. value .. "\n"
            end
        end

        local status, _ = pcall(function ()
            local f = io.open(_path or path, "w+")
            f:write(resl)
            f:close()
        end)

        return status
    end

    setmetatable(res, {
        __index = function (_, k)
            res[k] = {}

            setmetatable(res[k], {
                __newindex = function (tab, key, val)
                    local mt = getmetatable(tab)
                    local ni = nil

                    if mt then
                        ni = mt.__newindex
                        mt.__newindex = nil
                    end

                    res[k][key] = val

                    if ni then
                        mt.__newindex = ni
                    end
                end
            })

            return res[k]
        end
    })

    return res
end

if ini.__debug == true then
    menu.add_feature("Run _Case_Ini_Recurse Debug Test", "action", 0, function ()
        ---------------------------------
        -- Test: Absolute path parsing --
        ---------------------------------
        do
            local p = utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\"
            print "INI Parser debug, absolute path parsing, parsing file."
            local c = ini.parse(p.."example.ini")
            print "INI Parser debug, absolute path parsing, ini._Case_Ini_Recurse call:"
            ini._Case_Ini_Recurse(c)
            print "INI Parser debug, absolute path parsing, ini._Case_Ini_Recurse call finished."
        end

        ---------------------------------
        -- Test: Relative path parsing --
        ---------------------------------
        do
            -- Stage 1: Testing default CWD

            print "INI Parser debug, relative path parsing stage 1, parsing file."
            local c = ini.parse "example.ini"
            print "INI Parser debug, relative path parsing stage 1, ini._Case_Ini_Recurse call:"
            ini._Case_Ini_Recurse(c)
            print "INI Parser debug, relative path parsing stage 1, ini._Case_Ini_Recurse call finished."

            -- Stage 2: Testing different CWDs

            print "INI Parser debug, relative path parsing stage 2, parsing file."
            local w = ini.parse("example.ini", utils.get_appdata_path("PopstarDevs\\2Take1Menu\\scripts", "") .. "\\INI Parser Debug\\")
            print "INI Parser debug, relative path parsing stage 2, ini._Case_Ini_Recurse call:"
            ini._Case_Ini_Recurse(w)
            print "INI Parser debug, relative path parsing stage 2, ini._Case_Ini_Recurse call finished."
        end

        print "INI Parser debug, finished."
    end)
end

return ini
