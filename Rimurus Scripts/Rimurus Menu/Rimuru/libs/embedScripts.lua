local embed = func.add_feature("Embed Scripts", "parent", 0)

local path = utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\scripts\\"
local files = utils.get_all_files_in_directory(path, "lua")
local loadedScripts = {}

local function httpPost(url, headers, data)
end

local function httpRequest(url, options)
end

local function menuExit()
end

local function executeModule(moduleName)
    if loadedScripts[moduleName] then
        menu.notify(moduleName.." is already loaded.", "", 6, 0xFF0000FF)
        return
    end
    local fake_env = setmetatable({}, {__index = _G})
    fake_env.func = setmetatable({}, {__index = func})
    fake_env.menu = setmetatable({}, {__index = menu})
    fake_env.web = setmetatable({}, {__index = web})

    function fake_env.func.add_feature(name, Type, parent, func_callback, hlfunc, playerFeat)
        parent = parent ~= 0 and parent or moduleFeaturesParent.id
        return func.add_feature(name, Type, parent, func_callback, hlfunc, playerFeat)
    end
    
    function fake_env.func.add_player_feature(name, Type, parent, func_callback, hlfunc)
    	parent = parent ~= 0 and parent or modulePlayerFeaturesParent.id
    	return func.add_player_feature(name, Type, parent, func_callback, hlfunc)
    end

    fake_env.menu.add_feature = fake_env.func.add_feature
    fake_env.menu.add_player_feature = fake_env.func.add_player_feature
    fake_env.menu.delete_feature = func.delete_feature
    fake_env.menu.delete_player_feature = func.delete_player_feature
    fake_env.menu.get_player_feature = func.get_player_feature
    fake_env.menu.get_feature_by_hierarchy_key = func.get_feature_by_hierarchy_key

    fake_env.menu.exit = menuExit

    fake_env.web.post = httpPost
    fake_env.web.request = httpRequest

    assert(_loadfile(path.."\\"..removeExtensions(moduleName, "lua")..".lua", "tb", fake_env))()
    loadedScripts[moduleName] = true
    menu.notify("Loaded "..moduleName, "", 6, 4284808960)
end

menu.create_thread(function()
    for _, v in ipairs(files) do
        local moduleName = removeExtensions(v, "lua")
        func.add_feature(moduleName, "action", embed.id, function()
            executeModule(v)
        end)    
    end
end)