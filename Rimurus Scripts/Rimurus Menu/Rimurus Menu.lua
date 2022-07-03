--UI made by GhostOne

local Feats = {}
local features = {OnlinePlayers = {}}
local currentMenu = features

require("Rimuru\\keys") 
require("Rimuru\\libs\\feats\\Esp") 
require("Rimuru\\libs\\Functions lib") 
require("Rimuru\\libs\\feats\\Aimbot") 
require("Rimuru\\libs\\feats\\playerinfo") 

if Rimuru_menu then 
    menu.notify("Rimurus Menu is already loaded!", "Initialization cancelled.", 3, 0xff0000ff) 
    return
end

if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_NATIVES) then
	func.notification("Trusted mode is not enabled")
	return
end

local alert_screen = graphics.request_scaleform_movie("MP_BIG_MESSAGE_FREEMODE")
local function loaded()
    local i = 0
    while i < 320 do
        graphics.begin_scaleform_movie_method(alert_screen, "SHOW_SHARD_WASTED_MP_MESSAGE")
        graphics.draw_scaleform_movie_fullscreen(alert_screen, 255, 255, 255, 255, 0)
        graphics.scaleform_movie_method_add_param_texture_name_string("Rimurus Menu")
        graphics.scaleform_movie_method_add_param_texture_name_string(string.format("%s to open %s to select\n%s/%s to scroll", convertVKToKey(menuKeys.open), convertVKToKey(menuKeys.select), convertVKToKey(menuKeys.up), convertVKToKey(menuKeys.down)))
		graphics.end_scaleform_movie_method(alert_screen)
        i = i+1
        system.wait(0)
    end
	func.notification("Special thanks to Decco and Aren\nfor testing and giving example suggestions")
end 

stuff.featMethods = {
	set_str_data = function(self, stringTable)
		assert(type(stringTable) == "table", "tried to set str_data property to a non-table value")
		self.str_data = stringTable
	end,

	toggle = function(self, bool)
		if self.type == "toggle" then
			if bool ~= nil then
				self.on = bool
				stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
					self:func()
				end, nil)
			else
				self.on = not self.on
				stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
					self:func()
				end, nil)
			end
		else
			stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
				self:func()
			end, nil)
		end
	end,

	sort_table_and_id = function(self, withInfo)
	--return ((a.info.name:lower()):set_sub(1, 1) < (b.info.name:lower()):set_sub(1, 1)) end
		if next(self) then
			table.sort(self, function(a, b) return a.pid < b.pid end)
			for k, v in pairs(self) do
				if type(k) == "number" then
					local id = v.id:gsub("%d+$", "")
					v.id = id..k
				end
			end
		end
	end,

	set_value = function(self, val)
		assert(type(val) == "number", "tried to set value property to a non-number value")
		if self.type:match("_i") or self.type:match("_val_str") then
			val = val + 0.5
			val = math.floor(val)
			self.value = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.value = val
		end
	end,

	set_min = function(self, val)
		assert(type(val) == "number", "tried to set min property to a non-number value")
		if self.type:match("_i") then
			val = val + 0.5
			val = math.floor(val)
			self.min = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.min = val
		end
	end,

	set_max = function(self, val)
		assert(type(val) == "number", "tried to set max property to a non-number value")
		if self.type:match("_i") then
			val = val + 0.5
			val = math.floor(val)
			self.max = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.max = val
		end
	end,

	set_mod = function(self, val)
		assert(type(val) == "number", "tried to set mod property to a non-number value")
		if self.type:match("_i") then
			val = val + 0.5
			val = math.floor(val)
			self.mod = val
		elseif self.type:match("_f") then
			val = (val * 10000) + 0.5
			val = math.floor(val)
			val = val / 10000
			self.mod = val
		end
	end

}
stuff.metatable = {
	__index = stuff.featMethods,
}

function drawOutline(x, y, w, h, Colour)
	ui.draw_rect(x, y, w, 0.003, Colour.r, Colour.g, Colour.b, Colour.a)
	ui.draw_rect(x-w/2, y+h/2, 0.003, h+0.003,  Colour.r, Colour.g, Colour.b, Colour.a) --left
	ui.draw_rect(x+w/2, y+h/2, 0.003, h+0.003,  Colour.r, Colour.g, Colour.b, Colour.a) -- right
	ui.draw_rect(x, y+h, w, 0.003,  Colour.r, Colour.g, Colour.b, Colour.a) 
end

--Functions
function func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo, playerFeat)--, playerid)
	assert((type(nameOfFeat) == "string"), "invalid name in add_feature")
	assert((type(TypeOfFeat) == "string"), "invalid type in add_feature")
	assert(((type(parentOfFeat) == "string") or (type(parentOfFeat) == "number")) or not parentOfFeat, "invalid parent id in add_feature")
	assert((type(functionToDo) == "function") or not functionToDo, "invalid function in add_feature")
	if TypeOfFeat:match("value_i") or TypeOfFeat:match("value_f") or TypeOfFeat:match("slider") or TypeOfFeat:match("value_str") then
		TypeOfFeat = "toggle_"..TypeOfFeat
	end
	local currentParent = features
	if playerFeat then
		currentParent = features["OnlinePlayers"]
	end
	if parentOfFeat ~= 0 and parentOfFeat then
		for parentLine in parentOfFeat:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				currentParent = currentParent[tonumber(parentLine)]
			end
		end
	end
	currentParent[#currentParent + 1] = {name = nameOfFeat, type = TypeOfFeat, id = tostring(parentOfFeat).."-"..tostring(#currentParent + 1)}
	setmetatable(currentParent[#currentParent], stuff.metatable)
	currentParent[#currentParent].thread = 0
	if TypeOfFeat:match("toggle") then
		currentParent[#currentParent].on = false
	end
	if TypeOfFeat:match(".*value_str.*") then
		currentParent[#currentParent].value = 0
		currentParent[#currentParent].str_data = {}
	elseif TypeOfFeat:match(".*value") then
		currentParent[#currentParent].value = 0
		currentParent[#currentParent]:set_max(0)
		currentParent[#currentParent]:set_min(0)
		currentParent[#currentParent]:set_mod(1)
	end
	currentParent[#currentParent].hidden = false
	if functionToDo then
		if playerFeat then
			currentParent[#currentParent]["func"] = function(self)
				functionToDo(self, stuff.pid)
			end
		else
			currentParent[#currentParent]["func"] = function(self)
				functionToDo(self)
			end
		end
	end
	return currentParent[#currentParent]
end

--player feature functions

function func.add_player_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo)
	local pfeat = func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo, true)
	if stuff.playerIds then
		for k, v in pairs(stuff.playerIds) do
			func.addToTable(features["OnlinePlayers"], v, 0, v.id)
		end
	end
	return pfeat
end

function func.addToTable(getTable, addTable, playerid, featId)
	for k, v in pairs(getTable) do
		if tostring(v):match("table") then
			addTable[k] = {}
			if v.type == "parent" then
				func.addToTable(v, addTable[k], 0, featId)
			else 
				for i, e in pairs(v) do
					if not addTable[k][i] then
						addTable[k][i] = e
					end
				end
			end
		else
			if not addTable[k] then
				addTable[k] = v
			end
		end
	end
end

function func.set_player_feat_parent(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo)
	local parentTable
	parentTable = func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionToDo)
	stuff.PlayerParent = parentTable
	stuff.playerIds = {}
		for i = 0, 31 do
			if player.is_player_valid(i) then
				stuff.playerIds[i] = func.add_feature(tostring(player.get_player_name(i)), "parent", parentTable.id, function(f)
					stuff.pid = i
				end)
				stuff.playerIds[i].pid = i
				func.addToTable(features["OnlinePlayers"], stuff.playerIds[i], i, stuff.playerIds[i].id)
			end
		end

		stuff.PlayerParent:sort_table_and_id(true)

	event.add_event_listener("player_join", function(listener)
		stuff.addList[listener.player] = true
	end)
	event.add_event_listener("player_leave", function(listener)
		if stuff.playerIds[listener.player] then
			stuff.deleteList[listener.player] = true
		end
	end)
	return parentTable
end

--end of player feature functions

function func.get_parent_table(id)
	if type(id) == "table" then
		id = id.id
	end
	local currentParent = features
	if id ~= 0 then
		for parentLine in id:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				currentParent = currentParent[tonumber(parentLine)]
			end
		end
	end
	return currentParent
end

function func.delete_feature(id)
	if type(id) == "table" then
		id = id.id
	end
	local Parents = {features}
	if id ~= 0 then
		for parentLine in id:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				Parents[#Parents + 1] = Parents[#Parents][tonumber(parentLine)]
			end
		end
	end
	
	table.remove(Parents[#Parents - 1], id:match("%d+$"))
	for k, v in pairs(Parents[#Parents - 1]) do
		if type(k) == "number" then
			if type(v.id) ~= "nil" then
				if tonumber(v.id:match("%d+$")) > tonumber(id:match("%d+$")) then
					local id = v.id:match("%d+$")
					v.id = v.id:gsub("%d+$", "")
					v.id = v.id..tonumber(id - 1)
				end
			end
		end
	end
	if Parents[#Parents].type == "parent" then
		local originIndex = 999
		for k = #stuff.previousMenus, 1, -1 do
			if currentMenu.id == id then
				stuff.previousMenus[k].scroll = 1
				stuff.previousMenus[k].drawScroll = 0
				currentMenu = stuff.previousMenus[k].menu
				stuff.previousMenus[k] = nil
				break
			elseif stuff.previousMenus[k].menu.id == id then
				stuff.previousMenus[k - 1].scroll = 1
				stuff.previousMenus[k - 1].drawScroll = 0
				currentMenu = stuff.previousMenus[k - 1].menu
				originIndex = k
				for i, e in pairs(stuff.previousMenus) do
					if i > originIndex - 2 then
						stuff.previousMenus[i] = nil
					end
				end
				break
			end
		end
	end
end

function func.delete_player_feature(id)
	if type(id) == "table" then
		id = id.id
	end

	local Parents = {features["OnlinePlayers"]}
	if id ~= 0 then
		for parentLine in id:gmatch("(%d+)-*") do
			if parentLine ~= "0" then
				Parents[#Parents + 1] = Parents[#Parents][tonumber(parentLine)]
			end
		end
	end

	table.remove(Parents[#Parents - 1], tonumber(id:match("%d+$")))
	for k, v in pairs(Parents[#Parents - 1]) do
		if type(k) == "number" then
			if type(v.id) ~= "nil" then
				if tonumber(v.id:match("%d+$")) > tonumber(id:match("%d+$")) then
					local id = v.id:match("%d+$")
					v.id = v.id:gsub("%d+$", "")
					v.id = v.id..tonumber(id - 1)
				end
			end
		end
	end

	local featIds = {}
	for k, v in pairs(stuff.PlayerParent) do
		if type(k) == "number" then
			featIds[#featIds + 1] = v.id..id:sub(2, #id)
		end
	end
	for k, v in pairs(featIds) do
		func.delete_feature(v)
	end
end

function func.get_player_feature(id)
	local featIds = {}
	for k, v in pairs(stuff.PlayerParent) do
		if type(k) == "number" then
			featIds[#featIds + 1] = v.id..id:sub(2, #id)
		end
	end
	local playerFeatTable = {}
	for k, v in pairs(featIds) do
		local parent = features
		if id ~= 0 then
			for parentLine in id:gmatch("(%d+)-*") do
				if parentLine ~= "0" then
					parent = parent[tonumber(parentLine)]
				end
			end
		end
		playerFeatTable[#playerFeatTable + 1] = parent
	end
	return playerFeatTable
end



function func.isKeyDown(keyNum)
    local key = MenuKey()
    key:push_vk(keyNum)
    return key:is_down()
  end

function func.doKey(time, key, doLoopedFunction, functionToDo)
	if func.isKeyDown(key) then
		functionToDo()
		local timer = utils.time_ms() + time
		while timer > utils.time_ms() and func.isKeyDown(key) do
			system.wait(0)
		end
		while timer < utils.time_ms() and func.isKeyDown(key) do
			if doLoopedFunction then
				functionToDo()
			end
			local timer = utils.time_ms() + 25
			while timer > utils.time_ms() do
				system.wait(0)
			end
		end
	end
end

local function RGBFade()
    if stuff.menuData.fadeColour.r > 0 and stuff.menuData.fadeColour.b == 0 then
        stuff.menuData.fadeColour.r = stuff.menuData.fadeColour.r - 1
        stuff.menuData.fadeColour.g = stuff.menuData.fadeColour.g + 1
    end
    if stuff.menuData.fadeColour.g > 0 and stuff.menuData.fadeColour.r == 0 then
        stuff.menuData.fadeColour.g = stuff.menuData.fadeColour.g - 1
        stuff.menuData.fadeColour.b = stuff.menuData.fadeColour.b + 1
    end
    if stuff.menuData.fadeColour.b > 0 and stuff.menuData.fadeColour.g == 0 then
        stuff.menuData.fadeColour.r = stuff.menuData.fadeColour.r + 1
        stuff.menuData.fadeColour.b = stuff.menuData.fadeColour.b - 1
    end
end

function func.draw_text(text, pos, font, scale, color, flags)
    ui.set_text_scale(scale)
    ui.set_text_font(font)
    ui.set_text_centre(0)
    ui.set_text_color(color.r, color.g, color.b, 255)
    ui.set_text_outline(false)
    ui.draw_text(text, pos)
end

function func.drawFeat(k, v, offset, hiddenOffset)
	stuff.drawFeatParams = {rectPos = v2(stuff.menuData.x + 0.01, stuff.menuData.y - 0.11), indexOffset = 0.0270833, scale = v2(stuff.menuData.width, 0.025), textOffset = v2(-0.097, -0.016)}
	local offset = offset or 0
	if offset == 0 then
	end
	ui.set_text_scale(0.5)
	if stuff.scroll == k + stuff.drawScroll then
		stuff.scrollHiddenOffset = hiddenOffset or stuff.scrollHiddenOffset
		--scroll bar
		ui.draw_rect(stuff.drawFeatParams.rectPos.x - 0.01, stuff.drawFeatParams.rectPos.y + (stuff.drawFeatParams.indexOffset * k), stuff.drawFeatParams.scale.x, stuff.drawFeatParams.scale.y, stuff.menuData.mainColour.r, stuff.menuData.mainColour.g, stuff.menuData.mainColour.b, 255)
	else
		ui.set_text_color(255, 255, 255, 200)
	end
	ui.set_text_font(6)
	ui.set_text_outline(true)
	ui.set_text_justification(1)
	if v.rightJust then
		ui.set_text_justification(v.rightJust)
	end
	if v.type == "parent" then
		ui.draw_text(v["name"], v2(stuff.drawFeatParams.rectPos.x + stuff.drawFeatParams.textOffset.x, stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.drawFeatParams.indexOffset * k)))
		func.drawFeat(k, {name = ">>", type = "action"}, 0.16)
	elseif v.type:match(".*action.*") then
		ui.draw_text(v.name, v2(stuff.drawFeatParams.rectPos.x + stuff.drawFeatParams.textOffset.x + offset, stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.drawFeatParams.indexOffset * k)))
	elseif v.type:match(".*toggle.*") then
		ui.draw_text(v.name..": "..tostring(v.on), v2(stuff.drawFeatParams.rectPos.x + stuff.drawFeatParams.textOffset.x, stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.drawFeatParams.indexOffset * k)))
	end
	if v.type then
		if v.type:match(".*value_str.*") and v.str_data then
			func.drawFeat(k, {name = "< "..tostring(v.str_data[v.value + 1]).." >", type = "action", rightJust = 0}, 0.15)
		elseif v.type:match(".*value_f") then
			func.drawFeat(k, {name = "< "..tostring(v.value).." >", type = "action", rightJust = 0}, 0.15)
		elseif v.type:match(".*value_i") then 
			func.drawFeat(k, {name = "< "..tostring(v.value).." >", type = "action", rightJust = 0}, 0.15)
		end
	end
end

local white = {r=255, g=255, b=255}

function func.DrawCurrentMenu()
	stuff.drawHiddenOffset = 0
	for k, v in pairs(currentMenu) do
		if type(k) == "number" then
			if v.hidden then
				stuff.drawHiddenOffset = stuff.drawHiddenOffset + 1
			end
		end
	end

	func.draw_text(stuff.scroll.." / "..#currentMenu, v2(stuff.menuData.x+stuff.menuData.width/2.5,  stuff.menuData.y + stuff.menuData.height/2.02), 0, 0.32, white, 1)
	func.draw_text("v2.0.0", v2(stuff.menuData.x-stuff.menuData.width/2.5,  stuff.menuData.y + stuff.menuData.height/2.02), 0, 0.32, white, 1)

	
	--Background
	ui.draw_rect(stuff.menuData.x, stuff.menuData.y, stuff.menuData.width, stuff.menuData.height, stuff.menuData.backColour.r, stuff.menuData.backColour.g, stuff.menuData.backColour.b, stuff.menuData.backColour.a)
	--header
	ui.draw_rect(stuff.menuData.x, stuff.menuData.y - stuff.menuData.height/1.85, stuff.menuData.width, 0.030, 0, 0, 0, stuff.menuData.mainColour.a)
	--header line
	ui.draw_rect(stuff.menuData.x, stuff.menuData.y -stuff.menuData.height/2.06, stuff.menuData.width, 0.004, stuff.menuData.mainColour.r, stuff.menuData.mainColour.g, stuff.menuData.mainColour.b, stuff.menuData.mainColour.a)
	
	--footer
	ui.draw_rect(stuff.menuData.x, stuff.menuData.y + stuff.menuData.height/1.85, stuff.menuData.width, 0.03, 0, 0, 0, stuff.menuData.mainColour.a)
	--footer line
	ui.draw_rect(stuff.menuData.x, stuff.menuData.y + stuff.menuData.height/2.06, stuff.menuData.width, 0.004, stuff.menuData.mainColour.r, stuff.menuData.mainColour.g, stuff.menuData.mainColour.b, stuff.menuData.mainColour.a)
	drawBanner(RGBAToInt(white.r, white.g, white.b, white.a))

	if #currentMenu - stuff.drawHiddenOffset > stuff.menuData.maxOptions then
		stuff.maxDrawScroll = #currentMenu - stuff.drawHiddenOffset - stuff.menuData.maxOptions
	else
		stuff.maxDrawScroll = 0
	end
	if stuff.scroll > #currentMenu - stuff.drawHiddenOffset then
		stuff.scroll = #currentMenu - stuff.drawHiddenOffset
	elseif stuff.scroll < 1 then
		stuff.scroll = 1
	end
	local hiddenOffset = 0
	for k, v in pairs(currentMenu) do
		if type(k) == "number" then
			if v.hidden then
				hiddenOffset = hiddenOffset + 1
			else
				if k <= stuff.drawScroll + stuff.drawHiddenOffset + stuff.menuData.maxOptions and k >= stuff.drawScroll + 1 then
					func.drawFeat(k - stuff.drawScroll - hiddenOffset, v, 0, hiddenOffset)
				end
			end
		end
	end
	system.wait(0)
end

function func.activateFeatFunc(featTable)
	if featTable.func and menu.has_thread_finished(featTable.thread) then
		if not (featTable.thread) then
			featTable.thread = 0
		end
		featTable.thread = menu.create_thread(function()
			featTable:func()
		end, nil)
	end
end
--End of functions

-- Threads
stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
	loaded()
	
	while true do
		if next(stuff.deleteList) then
			for k, v in pairs(stuff.deleteList) do
				func.delete_feature(stuff.playerIds[k])
				stuff.deleteList[k] = nil
				stuff.playerIds[k] = nil
				system.wait(50)
			end
			stuff.deleteList = {}
			stuff.PlayerParent:sort_table_and_id(true)
		end
		if next(stuff.addList) then
			for k, v in pairs(stuff.addList) do
				if player.is_player_valid(k) then
					local tempTable
					stuff.playerIds[k] = func.add_feature(tostring(player.get_player_name(k)), "parent", stuff.PlayerParent.id, function(f)
						stuff.pid = k
					end)
					stuff.playerIds[k].pid = k
					func.addToTable(features["OnlinePlayers"], stuff.playerIds[k], k, stuff.playerIds[k].id)
					stuff.addList[k] = nil
					system.wait(50)
				end
			end
			stuff.addList = {}
			stuff.PlayerParent:sort_table_and_id(true)
		end
		system.wait(1000)
	end
end, nil)

stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
	while true do
		RGBFade()	
		system.wait(30)
	end
end, nil)

--key threads
menu.create_thread(function()
	while true do
		if stuff.menuToggle then
			func.DrawCurrentMenu()
			controls.disable_control_action(0, 172, true)
			controls.disable_control_action(0, 27, true)
		else
			system.wait(0)
		end
	end
end, nil)

menu.create_thread(function()
	while true do
		func.doKey(500, menuKeys.open, false, function() -- F5
			stuff.menuToggle = not stuff.menuToggle
		end)
		if controls.is_control_just_pressed(2, 44) and menuSaveToggles.controllerSupport then --RB
			stuff.menuToggle = not stuff.menuToggle
		end

		if stuff.menuToggle then
			func.doKey(500, menuKeys.down, true, function() -- downKey
				if stuff.scroll + stuff.scrollHiddenOffset >= #currentMenu then
					stuff.scroll = 1
					stuff.drawScroll = 0
				else
					stuff.scroll = stuff.scroll + 1
					if stuff.scroll - stuff.drawScroll + stuff.scrollHiddenOffset >= stuff.menuData.maxOptions and stuff.drawScroll < stuff.maxDrawScroll then
						stuff.drawScroll = stuff.drawScroll + 1
					end
				end
			end)

			if controls.is_control_just_pressed(2, 19) and menuSaveToggles.controllerSupport then --dpad down
				if stuff.scroll + stuff.scrollHiddenOffset >= #currentMenu then
					stuff.scroll = 1
					stuff.drawScroll = 0
				else
					stuff.scroll = stuff.scroll + 1
					if stuff.scroll - stuff.drawScroll + stuff.scrollHiddenOffset >= stuff.menuData.maxOptions and stuff.drawScroll < stuff.maxDrawScroll then
						stuff.drawScroll = stuff.drawScroll + 1
					end
				end
			end

			func.doKey(500, menuKeys.up, true, function() -- upKey
				if stuff.scroll <= 1 then
					stuff.hiddenfeats = 0
					for k, v in pairs(currentMenu) do
						if type(v) == "table" then
							if v.hidden then
								stuff.hiddenfeats = stuff.hiddenfeats + 1
							end
						end
					end
					stuff.scroll = #currentMenu - stuff.hiddenfeats
					stuff.drawScroll = stuff.maxDrawScroll
				else
					stuff.scroll = stuff.scroll - 1
					if stuff.scroll - stuff.drawScroll + stuff.scrollHiddenOffset <= 2 and stuff.drawScroll > 0 then
						stuff.drawScroll = stuff.drawScroll - 1
					end
				end
			end)

			if controls.is_control_just_pressed(2, 188) and menuSaveToggles.controllerSupport then --dpad up
				if stuff.scroll <= 1 then
					stuff.hiddenfeats = 0
					for k, v in pairs(currentMenu) do
						if type(v) == "table" then
							if v.hidden then
								stuff.hiddenfeats = stuff.hiddenfeats + 1
							end
						end
					end
					stuff.scroll = #currentMenu - stuff.hiddenfeats
					stuff.drawScroll = stuff.maxDrawScroll
				else
					stuff.scroll = stuff.scroll - 1
					if stuff.scroll - stuff.drawScroll + stuff.scrollHiddenOffset <= 2 and stuff.drawScroll > 0 then
						stuff.drawScroll = stuff.drawScroll - 1
					end
				end
			end

			func.doKey(500, menuKeys.select, true, function() --enter
				if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then--and not stuff.inputOn then
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type == "parent" then
						stuff.previousMenus[#stuff.previousMenus + 1] = {menu = currentMenu, scroll = stuff.scroll, drawScroll = stuff.drawScroll, scrollHiddenOffset = stuff.scrollHiddenOffset}
						currentMenu = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
						func.activateFeatFunc(currentMenu)
						stuff.scroll = 1
						system.wait(0)
						stuff.drawScroll = 0
						stuff.scrollHiddenOffset = 0
						while func.isKeyDown(menuKeys.select) do
							system.wait(0)
						end
					elseif currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match(".*action.*") then
						func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
					elseif currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("toggle") then
						currentMenu[stuff.scroll + stuff.scrollHiddenOffset].on = not currentMenu[stuff.scroll + stuff.scrollHiddenOffset].on
						func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
					end
				else
					system.wait(100)
				end
			end)
			
			if controls.is_control_just_pressed(2, 22) and menuSaveToggles.controllerSupport then --controller X
				if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then--and not stuff.inputOn then
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type == "parent" then
						stuff.previousMenus[#stuff.previousMenus + 1] = {menu = currentMenu, scroll = stuff.scroll, drawScroll = stuff.drawScroll, scrollHiddenOffset = stuff.scrollHiddenOffset}
						currentMenu = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
						func.activateFeatFunc(currentMenu)
						stuff.scroll = 1
						system.wait(0)
						stuff.drawScroll = 0
						stuff.scrollHiddenOffset = 0
						while func.isKeyDown(menuKeys.select) do
							system.wait(0)
						end
					elseif currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match(".*action.*") then
						func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
					elseif currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("toggle") then
						currentMenu[stuff.scroll + stuff.scrollHiddenOffset].on = not currentMenu[stuff.scroll + stuff.scrollHiddenOffset].on
						func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
					end
				else
					system.wait(100)
				end
			end

			func.doKey(500, menuKeys.back, false, function() --backspace
				if stuff.previousMenus[#stuff.previousMenus] then
					currentMenu = stuff.previousMenus[#stuff.previousMenus].menu
					stuff.scroll = stuff.previousMenus[#stuff.previousMenus].scroll
					stuff.drawScroll = stuff.previousMenus[#stuff.previousMenus].drawScroll
					stuff.scrollHiddenOffset = stuff.previousMenus[#stuff.previousMenus].scrollHiddenOffset
					stuff.previousMenus[#stuff.previousMenus] = nil
				end
			end)

			if controls.is_control_just_pressed(2, 45) and menuSaveToggles.controllerSupport then --dpad down
				if stuff.previousMenus[#stuff.previousMenus] then
					currentMenu = stuff.previousMenus[#stuff.previousMenus].menu
					stuff.scroll = stuff.previousMenus[#stuff.previousMenus].scroll
					stuff.drawScroll = stuff.previousMenus[#stuff.previousMenus].drawScroll
					stuff.scrollHiddenOffset = stuff.previousMenus[#stuff.previousMenus].scrollHiddenOffset
					stuff.previousMenus[#stuff.previousMenus] = nil
				end
			end

			func.doKey(500, menuKeys.sideScrollLeft, true, function() -- left
				if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data then
							if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value <= 0 then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = #currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data - 1
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value - 1
							end
						else
							if tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) <= currentMenu[stuff.scroll + stuff.scrollHiddenOffset].min then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].max
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) - currentMenu[stuff.scroll + stuff.scrollHiddenOffset].mod
							end
						end
					end
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("auto") or currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("toggle_value") then
							func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
						end
					end
				end
			end)
			func.doKey(500, menuKeys.sideScrollRight, true, function() -- right
				if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data then
							if tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) >= tonumber(#currentMenu[stuff.scroll + stuff.scrollHiddenOffset].str_data) - 1 then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = 0
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value + 1
							end
						else
							if tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) >= currentMenu[stuff.scroll + stuff.scrollHiddenOffset].max then
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].min
							else
								currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value = tonumber(currentMenu[stuff.scroll + stuff.scrollHiddenOffset].value) + currentMenu[stuff.scroll + stuff.scrollHiddenOffset].mod
							end
						end
					end
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type then
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("auto") or currentMenu[stuff.scroll + stuff.scrollHiddenOffset].type:match("toggle_value") then
							func.activateFeatFunc(currentMenu[stuff.scroll + stuff.scrollHiddenOffset])
						end
					end
				end
			end)
		end
		system.wait(0)
	end
end, nil)
--End of threads


local localOpt = func.add_feature("Player", "parent", 0)
local weapOpt = func.add_feature("Weapon", "parent", 0)
local vehOpt = func.add_feature("Vehicle", "parent", 0, function()
	getVehicleSlots()
end)
local spawnOpt = func.add_feature("Editor", "parent", 0)
local onlineOpt = func.add_feature("Online", "parent", 0)
local miscOpt = func.add_feature("Miscellaneous", "parent", 0)


func.set_player_feat_parent("Players", "parent", onlineOpt.id)
local lobbyOpt = func.add_feature("All Players", "parent", onlineOpt.id)
--local seenAsOpt = func.add_feature("Player History", "parent", onlineOpt.id)
local walletOpt = func.add_feature("Money Manager", "parent", onlineOpt.id)

-- Local Options
local visionsOpt = func.add_feature("Visions", "parent", localOpt.id)

func.add_feature("Night Vision", "toggle", visionsOpt.id, function(f)
	if f.on then
		GRAPHICS.SET_NIGHTVISION(true)	
	else
		GRAPHICS.SET_NIGHTVISION(false)
	end
end)

func.add_feature("Heat Vision", "toggle", visionsOpt.id, function(f)
	if f.on then
			GRAPHICS.SET_HEATVISION(true)	
	else
		GRAPHICS.SET_HEATVISION(false)
	end
end)

func.add_feature("Clear All", "action", visionsOpt.id, function()
	GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
end)

function loadAllVisions()
	for i=1, #visions do
		func.add_feature(visions[i], "action", visionsOpt.id, function()
			GRAPHICS.SET_TIMECYCLE_MODIFIER(visions[i])
		end)
	end
end
loadAllVisions()

local fov = func.add_feature("Field Of View", "value_f", localOpt.id, function(f)
	while f.on do
		
		CAM.CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", 0.5, 0.5, 0.5, 0, 0, 0, 1.0, f.on, 0)
		
		CAM.SET_CAM_ACTIVE(CAM.GET_RENDERING_CAM(), false)
		CAM.SET_CAM_FOV(CAM.GET_RENDERING_CAM(), f.value)
		system.wait(0)
	end
end)
fov.min = 1.0
fov.mod = 2.0
fov.max = 130.0

local pAlpha = func.add_feature("Player Opacity", "autoaction_value_i", localOpt.id, function(f)
	ENTITY.SET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID(), f.value, false)
end)
pAlpha.min = 0
pAlpha.mod = 1
pAlpha.max = 255
pAlpha.value = 255

func.add_feature("Reset Player Opacity", "action ", localOpt.id, function()
	ENTITY.RESET_ENTITY_ALPHA(PLAYER.PLAYER_PED_ID())
	func.notification("Reset Player Opacity")
end)

func.add_feature("Become A Cop", "action ", localOpt.id, function()
	PED.SET_PED_AS_COP(player.get_player_ped(player.player_id()), true)
	func.notification("You are now on duty, cops will ignore you")
	func.notification("Swat and army can still shoot you")
end)
--End


-- weapOpt
func.add_feature("Silent Aimbot Ped", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		silent_aimbot_ped()
		system.wait(0)
	end
end)

func.add_feature("Silent Aimbot Player", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		silent_aimbot_player()      
		system.wait(0)
	end
end)


local wepObj = func.add_feature("Object Weapons", "parent", weapOpt.id)

func.add_feature("Cartoon Gun", "toggle", weapOpt.id, function(toggle)
    while (toggle.on) do
		graphics.set_next_ptfx_asset('scr_rcbarry2')

		while not graphics.has_named_ptfx_asset_loaded('scr_rcbarry2') do
			graphics.request_named_ptfx_asset('scr_rcbarry2')
			system.wait(0)
		end

		if ped.is_ped_shooting(PLAYER.PLAYER_PED_ID()) then
			local rtrn, pos = ped.get_ped_bone_coords(PLAYER.PLAYER_PED_ID(), 0x67f2, v3(0.01, 0, 0))
			graphics.start_networked_ptfx_looped_at_coord("muz_clown", pos, v3(0,0,0), 1, true, true, true)
			
		end

		system.wait(0)
    end
end)

func.add_feature("Dildo Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
	
		if boolrtn then
			object.create_world_object(gameplay.get_hash_key("prop_cs_dildo_01"), impact, true, false)
		end
		system.wait(0)
	end
end)

func.add_feature("Ped Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		local val = math.random(1, #pedList)
		local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
	
		streaming.request_model(gameplay.get_hash_key(pedList[val]))
		while not streaming.has_model_loaded(gameplay.get_hash_key(pedList[val])) do
			system.yield(0)
		end

		if boolrtn then
			ped.create_ped(26, gameplay.get_hash_key(pedList[val]), impact, 0.0, true, false)
		end

		system.wait(0)
	end
end)

func.add_feature("Paint Gun", "toggle", weapOpt.id, function(toggle)
	func.notification("kick the ped out the car first")
	while toggle.on do
		local rtrn, ent = ENTITY.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player.player_id())
	
		if rtrn then
			requestControl(ent)
			vehicle.set_vehicle_custom_primary_colour(ent, RGBAToInt(stuff.menuData.fadeColour.r, stuff.menuData.fadeColour.g, stuff.menuData.fadeColour.b, 255))
			vehicle.set_vehicle_custom_secondary_colour(ent, RGBAToInt(stuff.menuData.fadeColour.r, stuff.menuData.fadeColour.g, stuff.menuData.fadeColour.b, 255))	
		end
		system.wait(0)
	end
end)

func.add_feature("Object Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		local val = math.random(1, #objects)
		local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()))
	
		if boolrtn then
			object.create_object(gameplay.get_hash_key(objects[val]), impact, true, false)
		end
		system.wait(0)
	end
end)

func.add_feature("Delete Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		local ent = player.get_entity_player_is_aiming_at(player.player_id())
		entity.delete_entity(ent)
		system.wait(0)
	end
end)

func.add_feature("Grapple Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		local boolrtn, impact = ped.get_ped_last_weapon_impact(player.get_player_ped(player.player_id()), v3())
		local loc = player.get_player_coords(player.player_id())
		impact.x = impact.x - loc.x
		impact.y = impact.y - loc.y
		impact.z = impact.z - loc.z + 25
		
		if boolrtn then       
			entity.set_entity_velocity(player.get_player_ped(player.player_id()), impact)
			ai.task_sky_dive(player.get_player_ped(player.player_id()), true)
		end
	system.wait(0)
	end
end)

func.add_feature("Dust Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		ExplosionTypeGun(80)
        ExplosionTypeGun(42)
		system.wait(0)
	end
end)
	
func.add_feature("Money Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do			
		streaming.request_model(gameplay.get_hash_key("prop_cash_pile_01"))

		if streaming.has_model_loaded(gameplay.get_hash_key("prop_cash_pile_01")) then
			local boolrtn, impact = ped.get_ped_last_weapon_impact(PLAYER.PLAYER_PED_ID())
			OBJECT.CREATE_MONEY_PICKUPS(impact.x, impact.y, impact.z, 2000, 20, gameplay.get_hash_key("prop_cash_pile_01"))
		end
		
		system.wait(0)
	end
end)
	
func.add_feature("Teleport Gun", "toggle", weapOpt.id, function(toggle)
	while toggle.on do
		if ped.is_ped_shooting(PLAYER.PLAYER_PED_ID()) then
			local boolrtn, impact = ped.get_ped_last_weapon_impact(PLAYER.PLAYER_PED_ID())
			local rt, z = gameplay.get_ground_z(impact)
			
			if impact.z >= z then
				entity.set_entity_coords_no_offset(PLAYER.PLAYER_PED_ID(), impact)		
			end
		end
		system.wait(0)
	end
end)
	
---object Weapon Options
func.add_feature("Give FireAxe", "action", wepObj.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 940833800, 0, true)
end)

func.add_feature("Give Sword", "action", wepObj.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 1141786504, 0, true)
end)

func.add_feature("Give Sledgehammer", "action", wepObj.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 1737195953, 0, true)
end)

func.add_feature("Give NailGun", "action", wepObj.id, function(feat, tog)
	weapon.give_delayed_weapon_to_ped(player.get_player_ped(player.player_id()), 324215364, 0, true)
end)

--end

-- Vehicle Options
local colVeh = func.add_feature("Modded Colours", "parent", vehOpt.id)

local colourList = {}
local function parseModdedcolours()
	local ini = require("Rimuru\\libs\\ini_parser") 
	local cfg = ini.parse("Rimuru\\modded colours\\"..colourList[stuff.scroll])

	if cfg.secondary.red ~= nil and cfg.pearl.green ~= nil then
		setVehicleColour({r=cfg.colour.red, g=cfg.colour.green, b=cfg.colour.blue}, 
		{r=cfg.colour.red, g=cfg.colour.green, b=cfg.colour.blue}, 
		{r=cfg.pearl.red, g=cfg.pearl.green, b=cfg.pearl.blue})	
	else
		setVehicleColour({r=cfg.colour.red, g=cfg.colour.green, b=cfg.colour.blue}, 
		{r=cfg.colour.red, g=cfg.colour.green, b=cfg.colour.blue}, 
		{r=255, g=255, b=255})
	end
end

local function loadModdedColours()
	local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
	colourList = utils.get_all_files_in_directory(appdata.."scripts\\Rimuru\\modded colours", "ini")
	for i=1, #colourList do
		func.add_feature(colourList[i], "action", colVeh.id, function()
			parseModdedcolours()
		end)
	end
end
loadModdedColours()

func.add_feature("Save Current Vehicle Colour", "action", vehOpt.id, function()
	local status, inputString = input.get("Give your colour a name", "", 100, 0)    
	local file = io.open(stuff.appdata.."\\scripts\\Rimuru\\modded colours\\"..inputString..".ini", "w")
	
	local veh = ped.get_vehicle_ped_is_using(PLAYER.PLAYER_PED_ID())

	--colour
	file:write("[colour]\n")
	file:write("red=".. VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh).r .."\n")
	file:write("green=".. VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh).g .."\n")
	file:write("blue=".. VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh).b .."\n")


	--secondary
	file:write("[secondary]\n")
	file:write("red=".. VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh).r .."\n")
	file:write("green=".. VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh).g .."\n")
	file:write("blue=".. VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh).b .."\n")

	file:close()
end)

local garageVeh = func.add_feature("Garage Vehicles", "parent", vehOpt.id)

for k,v in pairs(Slots) do
	func.add_feature(v[2], "action", garageVeh.id, function()
		if menu.is_trusted_mode_enabled() then
			script.set_global_i(globals.pv.mechanicDeliver.hash, 1) --mechanic deliver
			script.set_global_i(globals.pv.findLocation.hash, 0) --find location near road
			script.set_global_i(17437+176, 0) --insta deliver
			script.set_global_i(globals.pv.vehicleIndex.hash, stuff.scroll) --veh index
		else
			menu.notify("Enable Trusted Mode", "Rimurus Menu", 4, RGBAToInt(144, 151, 245, 255))
		end
	end)
end

func.add_feature("No Grip", "toggle", vehOpt.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    if feat.on then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, true)
		VEHICLE.SET_VEHICLE_REDUCE_TRACTION(veh, 50)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, false)
		VEHICLE.SET_VEHICLE_REDUCE_TRACTION(veh, 100)
    end
end)

func.add_feature("Vehicle Godmode", "toggle", vehOpt.id, function(tog)
	while tog.on do
		local veh = player.get_player_vehicle(player.player_id())
		if veh ~= 0 then
			ENTITY.SET_ENTITY_PROOFS(veh, true, true, true, true, true, true, true, true, true)
		end
		system.wait(0)
	end
end)

local pAlpha = func.add_feature("Vehicle Opacity", "autoaction_value_i", vehOpt.id, function(f)
	ENTITY.SET_ENTITY_ALPHA(ped.get_vehicle_ped_is_using(PLAYER.PLAYER_PED_ID()), f.value, false)
end)
pAlpha.min = 0
pAlpha.mod = 1
pAlpha.max = 255
pAlpha.value = 255

local gravMult = func.add_feature("Vehicle Gravity", "autoaction_value_f", vehOpt.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    vehicle.set_vehicle_gravity_amount(veh, f.value)
end)
gravMult.min = -10.00
gravMult.max = 100.00
gravMult.mod = 1.00

local topSpeed = func.add_feature("Modify Top Speed", "autoaction_value_f", vehOpt.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    network.request_control_of_entity(veh)
    entity.set_entity_max_speed(veh, f.value)
end)
topSpeed.min = -1.00
topSpeed.max = 9999.00
topSpeed.mod = 2.00

local dirtLevel = func.add_feature("Dirt Level", "autoaction_value_f", vehOpt.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    while feat.value do
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(veh, feat.value)
        system.wait(0)
    end
end)
dirtLevel.min = 0.0
dirtLevel.max = 15.0
dirtLevel.mod = 1.0

func.add_feature("Xenon RGB", "toggle", vehOpt.id, function(feat)
	local veh = player.get_player_vehicle(player.player_id())
    VEHICLE.TOGGLE_VEHICLE_MOD(veh, 22, feat.on)
    while feat.on do
            for i=1,12 do
                VEHICLE.SET_VEHICLE_XENON_LIGHTS_COLOR(veh, i)
                system.wait(200)
            end
        system.wait(0)
    end
	func.notification("Xenon Lights Added, BEGIN THE RAVE")
end)

func.add_feature("Destroy Personal Vehicle", "action", vehOpt.id, function()
	script.trigger_script_event(3268179810, player.player_id(), {player.player_id(), player.player_id()}) --destroy personal
	script.trigger_script_event(578856274, player.player_id(), {player.player_id(), 0, 0, 0, 0, 1, player.player_id(), math.min(2147483647, gameplay.get_frame_count())}) --kickout
end)

func.add_feature("TP Into Personal Vehicle", "action", vehOpt.id, function()
	local vehicle = player.get_personal_vehicle()

    while(not network.request_control_of_entity(vehicle) and utils.time_ms() + 450 > utils.time_ms() and streaming.is_model_valid(vehicle)) do
        system.wait(0)
    end
	ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), vehicle, -1)
end)

func.add_feature("Store Vehicle In Garage", "action", vehOpt.id, function()
	vehicleBypass()
end)

func.add_feature("GTA4 Neons", "toggle", vehOpt.id, function(feat)
	if feat.on then
		Gta4Neons()
	else
		RemoveGtaNeons()
	end
end)

func.add_feature("RGB Neons", "toggle", vehOpt.id, function(feat)
    while feat.on do
		local veh = player.get_player_vehicle(player.player_id())       
		for i=0, 3 do
			VEHICLE.SET_VEHICLE_NEON_LIGHT_ENABLED(veh, i, true)
		end
        VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(veh, stuff.menuData.fadeColour.r, stuff.menuData.fadeColour.g, stuff.menuData.fadeColour.b)

		system.wait(0)
	end
end)

func.add_feature("Exhaust Trails", "toggle", vehOpt.id, function(feat)
	while feat.on do
		if ped.is_ped_in_any_vehicle(PLAYER.PLAYER_PED_ID()) then
			local veh = ped.get_vehicle_ped_is_using(PLAYER.PLAYER_PED_ID())
			local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(veh, "exhaust")
			local bone_pos = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(veh, bone);
			local entity_pitch = ENTITY.GET_ENTITY_PITCH(veh)

			graphics.set_next_ptfx_asset('scr_carsteal4')

			while not graphics.has_named_ptfx_asset_loaded('scr_carsteal4') do
				graphics.request_named_ptfx_asset('scr_carsteal4')
				system.wait(0)
			end

			graphics.start_networked_ptfx_non_looped_at_coord('scr_carsteal4_wheel_burnout', bone_pos, v3(60, 0, 0), 1.33, true, true, true)
			GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(144,245,99)
		end
		system.wait(0)
		
	end
end)


--- Editor Options
local spawnedEditor ={objects = {}, worldObjects = {},
props = {}, peds = {}, animals = {}}

func.add_feature("Objects", "action_value_str", spawnOpt.id, function(feat)
	spawnedEditor.objects[#spawnedEditor.objects+1] = SpawnObj(feat.value)
end):set_str_data(objects)

func.add_feature("World Objects", "action_value_str", spawnOpt.id, function(feat)
	SpawnWrld(feat.value)
end):set_str_data(worldObjects)

func.add_feature("Props", "action_value_str", spawnOpt.id, function(feat)
	SpawnProp(feat.value)
end):set_str_data(props)

func.add_feature("Spawn Objects By Name", "action", spawnOpt.id, function(feat)
	SpawnObjFromName()
end)

func.add_feature("Peds", "action_value_str", spawnOpt.id, function(feat)
	SpawnPed(feat.value)
end):set_str_data(pedList)

func.add_feature("Animals", "action_value_str", spawnOpt.id, function(feat)
	SpawnAnimal(feat.value)
end):set_str_data(animalsPeds)

--Misc

func.add_feature("Esp", "value_str", miscOpt.id, function(feat)
	while feat.on do
		esp(feat.value)
		system.wait(0)
	end
end):set_str_data({"Names", "Distance", "Heart", "Box", "All"})

func.add_feature("FlashMod", "toggle", miscOpt.id, function(toggle)
	while toggle.on do
		doPTFX()
		system.wait(0)
	end
end)

func.add_feature("Type As Rockstar", "action", miscOpt.id, function()
	local status, msg = input.get("Input A Message", "", 100, 0)    
	network.send_chat_message(string.format("¦ %s", msg), false)
end)

func.add_feature("Send Locked Chat Message", "action", miscOpt.id, function()
	local status, msg = input.get("Input A Message", "", 100, 0)    
	network.send_chat_message(string.format("Ω %s", msg), false)
end)

func.add_feature("Recon Drone", "toggle", miscOpt.id, function(feat)
	menu.notify("Press E To Fire", "Made By Err_Net_Array", 6, RGBAToInt(144, 151, 245, 255))
	droneMode(feat)
end)

func.add_feature("BlackParade", "toggle", miscOpt.id, function(toggle)
	while toggle.on do
		BlackParade()
		system.wait(0)
	end
end)

func.add_feature("Give Wings", "action", miscOpt.id, function()
	local wingsHash = gameplay.get_hash_key("vw_prop_art_wings_01a")

    if streaming.is_model_valid(wingsHash) then
	    streaming.request_model(wingsHash)
	    while not streaming.has_model_loaded(wingsHash) and utils.time_ms() + 450 > utils.time_ms() do
		    system.wait(0)
	    end

	    local wings = object.create_object(wingsHash, entity.get_entity_coords(player.player_id(), true), true, true)

	    entity.attach_entity_to_entity(wings, player.get_player_ped(player.player_id()), ped.get_ped_bone_index(player.get_player_ped(player.player_id()), 0x5c01), v3(-1,0,0), v3(00,90,0), true, false, true, 0, true)
	    streaming.set_model_as_no_longer_needed(wingsHash)
    end
end)

func.add_feature("Remove Wings", "action", miscOpt.id, function()
	local allObjects = object.get_all_objects()

	for i=1, #allObjects do
		if Get_Distance_Between_Coords(player.get_player_coords(player.player_id()), entity.get_entity_coords(allObjects[i])) <= 2 then
			network.request_control_of_entity(allObjects[i])
			while not network.has_control_of_entity(allObjects[i]) and utils.time_ms() + 450 > utils.time_ms() do
				system.wait(0)
			end
			
		entity.delete_entity(allObjects[i])
		end
	end
end)

local camObject = 0
func.add_feature("Place SpikeCam", "action", miscOpt.id, function(f)
	local objectHash = gameplay.get_hash_key("p_tv_cam_02_s")
	streaming.request_model(objectHash)

	while not streaming.has_model_loaded(objectHash) do
		system.wait(0)
	end

	local camObject = object.create_object(objectHash, player.get_player_coords(player.player_id()), true, false)
end)

func.add_feature("Render SpikeCam", "toggle", miscOpt.id, function(f)
	local camObjectPos = entity.get_entity_coords(camObject)
	camObjectPos.x = camObjectPos.x - 5

	local camObjectCam = CAM.CREATE_CAM_WITH_PARAMS("TIMED_SPLINE_CAMERA", camObjectPos.x, camObjectPos.y, camObjectPos.z, 1,1, 1, 1.5, true, 0)
	CAM.ATTACH_CAM_TO_ENTITY(camObjectCam, camObject, 0, 0, 0, true)
	CAM.RENDER_SCRIPT_CAMS(f.on, false, 0, false, false)
end)

func.add_feature("Party Traffic Lights", "toggle", miscOpt.id, function(f)
	while f.on do
		local obs = object.get_all_objects()
		for i=1, #obs do
			if obs[i] == 1043035044 or 862871082 or 3639322914 then
				ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(obs[i], math.random(0, 2))
			end
		end
		system.wait(30)
	end
end)

local trainOpt = func.add_feature("Train", "parent", miscOpt.id)

func.add_feature("Hijack Train", "action", trainOpt.id, function(f)
	local train = get_closest_train()
	if train ~= 0 and not ped.is_ped_in_any_vehicle(PLAYER.PLAYER_PED_ID()) then
		entity.delete_entity(vehicle.get_ped_in_vehicle_seat(train, -1))
		ped.set_ped_into_vehicle(player.get_player_ped(player.player_id()), train, -1)
	end
	if train == 0 then
		func.notification("Could not find any train nearby")
	end
end)

local trainSpeed = 10.0
local trainMaxSpeed = 300.0
local trainMax = func.add_feature("Train Max Speed", "autoaction_value_f", trainOpt.id, function(f)
	trainMaxSpeed = f.value
end)
trainMax.max = 9999.0
trainMax.min = 0
trainMax.mod = 2.0
trainMax.value = trainMaxSpeed

local trainSpeed = func.add_feature("Drive Train", "toggle", trainOpt.id, function(f)
	while f.on do

		local speed = entity.get_entity_speed(ped.get_vehicle_ped_is_using(PLAYER.PLAYER_PED_ID()))*2.236936
		ui.set_text_scale(0.35)
		ui.set_text_font(0)
		ui.set_text_centre(0)
		ui.set_text_color(255, 255, 255, 255)
		ui.set_text_outline(true)
		ui.draw_text(math.floor(speed).." mph", v2(0.5, 0.95)) 

		func.do_key(500, 0x57, true, function()
			if trainSpeed < trainMaxSpeed then
				trainSpeed = trainSpeed + 1.0
			end
		end)

		func.do_key(500, 0x53, true, function()
			if trainSpeed > -trainMaxSpeed then
				trainSpeed = trainSpeed - 1.0
			end
		end)
		
		VEHICLE.SET_TRAIN_SPEED(get_closest_train(), trainSpeed)
		VEHICLE.SET_TRAIN_CRUISE_SPEED(get_closest_train(), trainSpeed)
		system.wait(0)
	end
end)

local trainTrack = func.add_feature("Change Track", "value_i", trainOpt.id, function(f)
	while f.on do
		VEHICLE.SWITCH_TRAIN_TRACK(f.value, true)
		system.wait(0)
	end
end)
trainTrack.max = 12
trainTrack.min = 0
trainTrack.mod = 1
trainTrack.value = 0


func.add_feature("De-Rail Train", "toggle", trainOpt.id, function(f)
	local train = get_closest_train()
	if train ~= 0 then
		VEHICLE.SET_RENDER_TRAIN_AS_DERAILED(train, f.on)
	end
end)

func.add_feature("Delete Train", "action", trainOpt.id, function(f)
	local train = get_closest_train()
	if train ~= 0 then
		entity.delete_entity(train)
	end
end)

func.add_feature("Delete All Trains", "action", trainOpt.id, function(f)
	VEHICLE.DELETE_ALL_TRAINS()
end)

--Wallet
func.add_feature("Transfer All Bank Cash To Wallet", "action", walletOpt.id, function(feat)
	local walletCash = MONEY.NETWORK_GET_VC_WALLET_BALANCE(stats.stat_get_int(791613967, 0))
	local bankCash = MONEY.NETWORK_GET_VC_BANK_BALANCE()

	if bankCash > 0 then
		NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(stats.stat_get_int(791613967, 0), bankCash)
		func.notification("Transferred $"..bankCash.." to the wallet\nyour current wallet balance is now $"..walletCash)
	else
		menu.notify("Funds could not be transffered, your bank balance is $"..bankCash)
	end
end)

func.add_feature("Transfer All Cash To Bank", "action", walletOpt.id, function(feat)
	local walletCash = MONEY.NETWORK_GET_VC_WALLET_BALANCE(stats.stat_get_int(791613967, 0))
	local bankCash = MONEY.NETWORK_GET_VC_BANK_BALANCE()

	if walletCash > 0 then
		NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.stat_get_int(791613967, 0), walletCash)
		func.notification("Transferred $"..walletCash.." to the bank\nyour current bank balance is now $"..bankCash)
	else
		menu.notify("Funds could not be transffered, your wallet balance is $"..walletCash)
	end
end)

local bankCash = func.add_feature("Wallet Cash To Transfer", "autoaction_value_f", walletOpt.id, function(f)
	NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.stat_get_int(791613967, 0), f.value)
end)
bankCash.min = 0
bankCash.max = 922337203685775807
bankCash.mod = 1000
bankCash.value = MONEY.NETWORK_GET_VC_WALLET_BALANCE()	

func.add_feature("Convenience Store Transaction", "toggle", walletOpt.id, function(f)
	
	while f.on do
		if not network.is_session_started() then
			return
		end
	
		local max = 2000
		local amount = max * 1000000
		
		
		local transactionIDBuffer = native.ByteBuffer32()
		if NETSHOPPING.NET_GAMESERVER_BEGIN_SERVICE(transactionIDBuffer, 1474183246,  -1586170317, 1445302971, amount, 4) then
			local transactionID = transactionIDBuffer:__tointeger()
			func.notification(transactionID)
			NETSHOPPING.NET_GAMESERVER_CHECKOUT_START(transactionID)
		end
		
		system.wait(0)
	end
end)

-- Lobby Options
local lobbyMalic = func.add_feature("Malicious Options", "parent", lobbyOpt.id)
local lobbyTroll = func.add_feature("Trolling Options", "parent", lobbyOpt.id)

func.add_feature("Force Remove Lobby", "action", lobbyMalic.id, function()
	for i=0, 31 do
		network.force_remove_player(i)
	end
end)

func.add_feature("Force Lobby Into Cutscene", "action", lobbyMalic.id, function()
	for i=0, 31 do
		network.force_remove_player(i)
	end
end)

func.add_feature("SE Lobby Kick", "action", lobbyMalic.id, function()
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.kick.hash, i, {i, -1, -1, -1, -1})
		end
	end
end)

func.add_feature("SE Lobby Kick v2", "action", lobbyMalic.id, function()
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.kickv2.hash, i, {i, 420, 69})
		end
	end
end)

func.add_feature("Math Crash", "action", lobbyMalic.id, function()
		local Position = player.get_player_coords(player.player_id()) + v3(5, 0, 0)
		local Position2 = player.get_player_coords(player.player_id()) + v3(0, 0, 1)
	
		streaming.request_model(2132890591)
		while not streaming.has_model_loaded(2132890591) do
			system.yield(0)
		end
	
		local Vehicle = vehicle.create_vehicle(2132890591, Position, 0.0, true, false)
		streaming.set_model_as_no_longer_needed(2132890591)
	
	
		streaming.request_model(2727244247)
		while not streaming.has_model_loaded(2727244247) do
			system.yield(0)
		end
	
		local Dummy = ped.create_ped(26, 2727244247, Position2, 0.0, true, false)
		streaming.set_model_as_no_longer_needed(2727244247)
	
		entity.set_entity_god_mode(Dummy, true)
	
		local Rope = rope.add_rope(Position, v3(0,0,0), 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true)
	
		rope.attach_entities_to_rope(Rope, Vehicle, Dummy, entity.get_entity_coords(Vehicle), entity.get_entity_coords(Dummy), 2 , 0, 0, "Center", "Center")
end)

func.add_feature("Force Lobby Into Servere Weather", "action", lobbyTroll.id, function(feat, pid)
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.jobInvite.hash, i, {i, 0})
		end 
	end
end)

func.add_feature("Force Lobby Into Loading Screen", "action", lobbyTroll.id, function(feat)
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.loadingscreen.hash, i	, {i, 0, 32, network.network_hash_from_player(i),
			-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0})
		end 
	end
end)

func.add_feature("Force Lobby Into Cutscene", "action", lobbyTroll.id, function(feat)
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(1068259786, i, {i, 0, 1})
		end 
	end
end)

func.add_feature("Force Lobby To Cayo", "action", lobbyMalic.id, function(feat)
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.cayo.hash, i, {player.player_id(), 1})
		end 
	end
end)

func.add_feature("Destroy Lobbies Personal Vehicles", "action", lobbyTroll.id, function()
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.destroyPersonalVehicle.hash, i, {i, i}) --destroy personal
			script.trigger_script_event(scriptEvents.vehicleKick.hash, i, {i, 0, 0, 0, 0, 1, i, math.min(2147483647, gameplay.get_frame_count())}) --kickout
		end
	end
end)

func.add_feature("Fake Money Bag Drop Lobby", "toggle", lobbyTroll.id, function(feat)
	streaming.request_model(gameplay.get_hash_key("prop_money_bag_01"))
	if streaming.has_model_loaded(gameplay.get_hash_key("prop_money_bag_01")) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					bags = object.create_object(gameplay.get_hash_key("prop_money_bag_01"), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end)

func.add_feature("Fake Money Drop Lobby", "toggle", lobbyTroll.id, function(feat)
	streaming.request_model(gameplay.get_hash_key("prop_poly_bag_money"))
	if streaming.has_model_loaded(gameplay.get_hash_key("prop_poly_bag_money")) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					local bags = object.create_object(gameplay.get_hash_key("prop_poly_bag_money"), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end)

func.add_feature("Fake RP Drop Lobby", "toggle", lobbyTroll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("v_res_d_dildo_f"))
	if streaming.has_model_loaded(gameplay.get_hash_key("v_res_d_dildo_f")) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					local bags = object.create_object(gameplay.get_hash_key("v_res_d_dildo_f"), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end)

func.add_feature("Water Jet Lobby", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			createExplosion(13, player.get_player_coords(i))
		end
	end
end)

func.add_feature("Fire Jet Lobby", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			createExplosion(12, player.get_player_coords(i))
		end
	end
end)

func.add_feature("Steam Jet Lobby", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			createExplosion(11, player.get_player_coords(i))
		end
	end
end)

func.add_feature("Rain Object", "value_str", lobbyOpt.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key(objects[feat.value+1]))
	if streaming.has_model_loaded(gameplay.get_hash_key(objects[feat.value+1])) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					local bags = object.create_object(gameplay.get_hash_key(objects[feat.value+1]), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(40)
			end		
		end
	end	
end):set_str_data(objects)

func.add_feature("Go Ghosted To Lobby", "toggle", lobbyOpt.id, function(feat)
	while feat.on do
		for i=1, 31 do
			NETWORK.SET_RELATIONSHIP_TO_PLAYER(i, true)
			system.wait(0)
			if not feat.on then
				NETWORK.SET_RELATIONSHIP_TO_PLAYER(i, false)
			end
		end
	end
end)

--Player Options
local playerMalic = func.add_player_feature("Malicious Options", "parent", 0)
local playerMisc = func.add_player_feature("Misc Options", "parent", 0)
local playerEvents = func.add_player_feature("Script Events", "parent", 0)	
local playerTroll = func.add_player_feature("Trolling Options", "parent", 0)

func.add_player_feature("Send SMS", "action", 0, function(feat, pid)
	local status, msg = input.get("Input your sms", "", 100, 0)    

	script.trigger_script_event_2(1 << pid, 0x717ab445, player.player_id(), msg)
end)

func.add_player_feature("Force Remove", "action", playerMalic.id, function(feat, pid)
	if pid ~= player.player_id() then
		network.force_remove_player(pid)
	end
end)

func.add_player_feature("Script Kick", "action", playerMalic.id, function(feat, pid)
	if NETWORK.NETWORK_IS_HOST() then
		NETWORK.NETWORK_SESSION_KICK_PLAYER(pid)
	else	
		script.trigger_script_event_custom(scriptEvents.kick.hash, pid, {pid, -1, -1, -1, -1})
	end
end)

func.add_player_feature("SE Crash", "action", playerMalic.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.crash.hash, pid, {-1, -1})
end)

func.add_player_feature("Next Gen Crash", "action", playerMalic.id, function(feat, pid)
	local Position = player.get_player_coords(pid)
    Position.x = Position.x + 5
    Position.y = Position.y + 5
    streaming.request_model(3253274834)
    if streaming.has_model_loaded(3253274834) then
        local Vehicle = vehicle.create_vehicle(3253274834, Position, Position.z, true, false)
        vehicle.set_vehicle_mod_kit_type(Vehicle, 0)
        vehicle.set_vehicle_mod(Vehicle, 0, vehicle.get_num_vehicle_mods(Vehicle, 0)-1, true)
    end
end)

func.add_player_feature("Sound Crash", "action", playerMalic.id, function(feat, pid)
	local time = utils.time_ms() + 2000
	while time > utils.time_ms() do
		local netsoundpos = player.get_player_coords(pid)
		for i = 1, 10 do
			audio.play_sound_from_coord(-1, '5s', netsoundpos, 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 10000, false)
		end
		system.wait(0)
	end	
end)

func.add_player_feature("Task Crash", "action", playerMalic.id, function(feat, pid)
	for i=1, 3 do
		TASK.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 15, 10)
		TASK.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 16, 10)
		TASK.TASK_VEHICLE_TEMP_ACTION(player.get_player_ped(pid), player.get_player_vehicle(pid), 18, 10)
	end
end)

func.add_player_feature("Destroy Personal Vehicle", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.destroyPersonalVehicle.hash, pid, {pid, pid}) --destroy personal
	script.trigger_script_event(scriptEvents.vehicleKick.hash, pid, {pid, 0, 0, 0, 0, 1, pid, math.min(2147483647, gameplay.get_frame_count())}) --kickout
end)

func.add_player_feature("Vehicle Kick", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.vehicleKick.hash, pid, {pid, 0, 0, 0, 0, 1, pid, math.min(2147483647, gameplay.get_frame_count())}) --kickout
end)

func.add_player_feature("Force Into Data Breach", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.jobInvite.hash, pid, {pid, 6})
end)

func.add_player_feature("Force Into Severe Weather", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.jobInvite.hash, pid, {pid, 0})
end)

func.add_player_feature("Force Into Work Dispute", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.jobInvite.hash, pid, {pid, 7})
end)

func.add_player_feature("Force Into Loading Screen", "action", playerEvents.id, function(feat, pid)
	if pid ~= player.player_id() then
		script.trigger_script_event(scriptEvents.loadingscreen.hash, pid, {pid, 0, 32, network.network_hash_from_player(pid),
		-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0})
	end
end)

func.add_player_feature("Force Into Cayo", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.cayo.hash, pid, {player.player_id(), 1})
end)

func.add_player_feature("Force Into Cutscene", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.cutscene.hash, pid, {pid, 0, 1})
end)

func.add_player_feature("Penthouse Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.penthouse.hash, player.player_id(), {0, 124, pid})
end)

func.add_player_feature("Apartment Invite", "action", playerEvents.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.apartmentInivte.hash, pid, {pid, 0})
end)

local fakeInvites = func.add_player_feature("Fake Invites", "parent", playerEvents.id)

func.add_player_feature("Los Santos Customs Invite", "action", fakeInvites.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 124})
end)

func.add_player_feature("Los Santos GolfClub Invite", "action", fakeInvites.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 123})
end)

func.add_player_feature("Hookies Invite", "action", fakeInvites.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 122})
end)

func.add_player_feature("Pitchers Invite", "action", fakeInvites.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.fakeInvite.hash, pid, {0, 120})
end)

func.add_player_feature("Give vehicle godmode", "action", playerMisc.id, function(feat, pid)
	if ped.is_ped_in_any_vehicle(player.get_player_ped(pid)) then
		ENTITY.SET_ENTITY_PROOFS(ped.get_vehicle_ped_is_using(player.get_player_ped(pid)), true, true, true, true, true, true, true, true)
	else
		func.notification("Player is not in a vehicle")
	end
end)

func.add_player_feature("Create Vehicle", "action", playerMisc.id, function(feat, pid)    
	func.notification("Vehicle cannot be spawned with 2take1")
	streaming.request_model(3003014393)

	if streaming.has_model_loaded(3003014393) then
		local veh = vehicle.create_vehicle(3003014393, player.get_player_coords(pid), 1.0, true, false)
		AllowVehicleToBePlacedInGarage(pid, veh)
	end
end)

func.add_player_feature("Gift Vehicle", "action", playerMisc.id, function(feat, pid)    
	local veh = ped.get_vehicle_ped_is_using(pid)

	decorator.decor_set_int(veh, "Player_Vehicle", network.network_hash_from_player(pid))
	decorator.decor_set_int(veh, "PYV_Owner", network.network_hash_from_player(pid))
	decorator.decor_set_int(veh, "PYV_Vehicle", network.network_hash_from_player(pid))
end)

func.add_player_feature("Go Ghosted To Player", "toggle", playerMisc.id, function(feat, pid)
	while feat.on do
		NETWORK.SET_RELATIONSHIP_TO_PLAYER(pid, true)
		system.wait(0)
	end
	if not feat.on then
		NETWORK.SET_RELATIONSHIP_TO_PLAYER(pid, false)
	end
end)

func.add_player_feature("Spawn Ped", "action_value_str", playerMisc.id, function(feat, pid)
	SpawnPed(feat.value, 100, pid)
end):set_str_data(pedList)

func.add_player_feature("Rain Object", "value_str", playerMisc.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key(objects[feat.value+1]))
	if streaming.has_model_loaded(gameplay.get_hash_key(objects[feat.value+1])) then
		while feat.on do
				if player.is_player_valid(pid) then
					local bags = object.create_object(gameplay.get_hash_key(objects[feat.value+1]), player.get_player_coords(pid), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
					entity.set_entity_heading(bags, player.get_player_heading(pid))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
				end
			system.wait(40)
		end
	end	
end):set_str_data(objects)

func.add_player_feature("Create Pickup", "action_value_str", playerMisc.id, function(f, pid)
	local pos = player.get_player_coords(pid)
	OBJECT.CREATE_AMBIENT_PICKUP(gameplay.get_hash_key(pickups[f.value+1]), pos.x, pos.y, pos.z, 1, 1, 528555233, false, false)
end):set_str_data(pickups)

func.add_player_feature("Fake Money Bag Drop", "toggle", playerTroll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("prop_money_bag_01"))		
	while feat.on do
		local bags = object.create_object(gameplay.get_hash_key("prop_money_bag_01"), player.get_player_coords(pid), true, true)
		entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
			entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
			entity.set_entity_heading(bags, player.get_player_heading(pid))
		system.wait(40)
	end		
end)

func.add_player_feature("Fake Money Drop", "toggle", playerTroll.id, function(feat, pid)
	streaming.request_model(gameplay.get_hash_key("bkr_prop_scrunched_moneypage"))		
	local bags = object.create_object(gameplay.get_hash_key("bkr_prop_scrunched_moneypage"), player.get_player_coords(pid), true, true)
	entity.set_entity_no_collsion_entity(bags, player.get_player_ped(pid), false)
	while feat.on do
			entity.set_entity_coords_no_offset(bags, player.get_player_coords(pid))
			entity.set_entity_heading(bags, player.get_player_heading(pid))
		system.wait(10)
	end		
end)

func.add_player_feature("Fake RP Drop", "toggle", playerTroll.id, function(feat, pid)
	streaming.request_model(3030532197)
	while feat.on do
		local pos = player.get_player_coords(player.player_id())
	
		if streaming.has_model_loaded(3030532197) then
			local obj = OBJECT.CREATE_AMBIENT_PICKUP(2817147086, pos.x, pos.y, pos.z, 1, 10, 3030532197, true, true)
		end
		system.wait(5)
	end		
end)

func.add_player_feature("Cage", "action", playerTroll.id, function(feat, pid)
	if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
		if ped.is_ped_in_any_vehicle(player.get_player_ped(pid)) then
			ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
		end
		ped.clear_ped_tasks_immediately(player.get_player_ped(pid))
		object.create_object(2718056036, player.get_player_coords(pid), true, false)
	end
end)

func.add_player_feature("Water Jet", "action", playerTroll.id, function(feat, pid)
	createExplosion(13, player.get_player_coords(pid))
end)

func.add_player_feature("Fire Jet", "action", playerTroll.id, function(feat, pid)
	createExplosion(12, player.get_player_coords(pid))
end)

func.add_player_feature("Steam Jet", "action", playerTroll.id, function(feat, pid)
	createExplosion(11, player.get_player_coords(pid))
end)

func.add_player_feature("Cash Removed ", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.message.hash, pid, {pid, 689178114, 2147483647}) --cash removed
end)
  
func.add_player_feature("Cash banked", "action", playerTroll.id, function(feat, pid)
	script.trigger_script_event(scriptEvents.message.hash, pid, {pid, 1990572980, 2147483647}) --cash removed
end)
  
--changing menu functions to ui functions
if menuSaveToggles.embedScripts then
	func.notification("Embed Scripts is enabled\nThis feature is wip some script features may not work")
	menu.add_feature = func.add_feature
	menu.add_player_feature = func.add_player_feature
	menu.delete_feature = func.delete_feature
	menu.delete_player_feature = func.delete_player_feature
	menu.get_player_feature = func.get_player_feature
end
--

-- Settings
local settin = require("Rimuru.libs.settings")

Rimuru_menu = 1.5
