--Made by GhostOne
---@diagnostic disable: undefined-global, lowercase-global, undefined-field

local version = "3.2.0"
local loadCurrentMenu --forward declaration
local httpTrustedOff

if not utils.dir_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\scripts\\Rimuru") then
	menu.notify("Please install the rimuru folder", "Rimurus Menu", 10, 0xFF0000FF)
	return
	menu.exit()
end

if menu.is_trusted_mode_enabled(1 << 2) then
	if not utils.file_exists(utils.get_appdata_path("PopstarDevs", "2Take1Menu") .. "\\scripts\\lib\\natives2845.lua") then
        menu.notify("natives2845 is missing, download it from the repository", "Rimurus Menu", 10, 0xFF0000FF)
        return
		menu.exit()
    end

	menu.create_thread(function()
		loadCurrentMenu()
	end)
else
	menu.notify("Trusted mode > Natives has to be on.", "Rimurus Menu", 5, 0x0000FF)
end

globals = require("Rimuru.tables.globals")
natives = require("lib.natives2845")
require("Rimuru.libs.generalLibs")
local visions <const> = require("Rimuru.tables.visions")
local translations <const> = require("Rimuru.libs.languageMapper")

local function get_all_files_in_directory(dir, ext)
	local get_all_files <const> = utils.get_all_files_in_directory

	if not utils.dir_exists(dir) then
		menu.notify("Rimurus menu encountered an error, please create a ticket in the support server", "Rimuru", 10, 0xFF0000FF)
		return 
		menu.exit()
	else
		return get_all_files(dir, ext)
	end
end

func = {}
local stuff = {}
local features
local currentMenu
local menu_configuration_features
function loadCurrentMenu()
	features = {OnlinePlayers = {}}
	currentMenu = features
	stuff = {
		pid = -1,
		player_info = {
			{"Player ID", "0"},
			{"God", "false"},
			{"Proofs (God)", "false"},
			{"Vehicle God", "false"},
			{"Flagged as Modder", "false"},
			{"Host", "false"},
			{"Wanted", "0"},
			{"Health", "327/327"},
			{"Armor", "50"},
			{"IP", "0.0.0.0"},
			{"SCID", "133769420"},
			{"Modder Flags", "Test"},
			{"Host Token", "0xdeadbeef"},
			{"Host Priority", "0"},
			max_health = "/327",
			name = "cheesemenu"
		},
		proofs = {
			bulletProof = native.ByteBuffer8(),
			fireProof = native.ByteBuffer8(),
			explosionProof = native.ByteBuffer8(),
			collisionProof = native.ByteBuffer8(),
			meleeProof = native.ByteBuffer8(),
			steamProof = native.ByteBuffer8(),
			p7 = native.ByteBuffer8(),
			drownProof = native.ByteBuffer8(),
		},
		scroll = 1,
		scrollHiddenOffset = 0,
		drawHiddenOffset = 0,
		trusted_mode = 0,
		old_selected = 0,
		player_submenu_sort = 0,
		previousMenus = {},
		threads = {},
		feature_by_id = {},
		player_feature_by_id = {},
		feature_hints = {},
		player_feature_hints = {},
		path = {
			scripts = utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\"
		},
		hotkeys = {},
		hotkey_cooldowns = {},
		hotkeys_to_vk = {},
		table_sort_functions = {
			[0] = function(a, b) return a.pid < b.pid end,
			function(a, b) return a.pid > b.pid end,
			function(a, b) return a.name:lower() < b.name:lower() end,
			function(a, b) return a.name:lower() > b.name:lower() end,
			function(a, b) return player.get_player_host_priority(a.pid) < player.get_player_host_priority(b.pid) end,
			function(a, b) return player.get_player_host_priority(a.pid) > player.get_player_host_priority(b.pid) end
		},
		char_codes = {
			["ENTER"] = 0x0D,
			["0"] = 0x30,
			["1"] = 0x31,
			["2"] = 0x32,
			["3"] = 0x33,
			["4"] = 0x34,
			["5"] = 0x35,
			["6"] = 0x36,
			["7"] = 0x37,
			["8"] = 0x38,
			["9"] = 0x39,
			["A"] = 0x41,
			["B"] = 0x42,
			["C"] = 0x43,
			["D"] = 0x44,
			["E"] = 0x45,
			["F"] = 0x46,
			["G"] = 0x47,
			["H"] = 0x48,
			["I"] = 0x49,
			["J"] = 0x4A,
			["K"] = 0x4B,
			["L"] = 0x4C,
			["M"] = 0x4D,
			["N"] = 0x4E,
			["O"] = 0x4F,
			["P"] = 0x50,
			["Q"] = 0x51,
			["R"] = 0x52,
			["S"] = 0x53,
			["T"] = 0x54,
			["U"] = 0x55,
			["V"] = 0x56,
			["W"] = 0x57,
			["X"] = 0x58,
			["Y"] = 0x59,
			["Z"] = 0x5A,
			["NUM0"] = 0x60,
			["NUM1"] = 0x61,
			["NUM2"] = 0x62,
			["NUM3"] = 0x63,
			["NUM4"] = 0x64,
			["NUM5"] = 0x65,
			["NUM6"] = 0x66,
			["NUM7"] = 0x67,
			["NUM8"] = 0x68,
			["NUM9"] = 0x69,
			["Space"] = 0x20,
			[";"] = 0xBA,
			["PLUS"] = 0xBB,
			[","] = 0xBC,
			["-"] = 0xBD,
			["DOT"] = 0xBE,
			["/"] = 0xBF,
			["`"] = 0xC0,
			["LSQREBRACKET"] = 0xDB,
			["\\"] = 0xDC,
			["RSQREBRACKET"] = 0xDD,
			["QUOTE"] = 0xDE,
			["NUM*"] = 0x6A,
			["NUMPLUS"] = 0x6B,
			["NUM-"] = 0x6D,
			["NUMDEL"] = 0x6E,
			["NUM/"] = 0x6F,
			["PAGEUP"] = 0x21,
			["PAGEDOWN"] = 0x22,
			["END"] = 0x23,
			["HOME"] = 0x24,
			["SCROLLLOCK"] = 0x91,
			["LEFTARROW"] = 0x25,
			["UPARROW"] = 0x26,
			["RIGHTARROW"] = 0x27,
			["DOWNARROW"] = 0x28,
			["SELECT"] = 0x29,
			["INS"] = 0x2D,
			["DEL"] = 0x2E,
			["PAUSE"] = 0x13,
			["CAPSLOCK"] = 0x14,
			["BACKSPACE"] = 0x08,
			["LSHIFT"] = 0xA0,
			["RSHIFT"] = 0xA1,
			["LCONTROL"] = 0xA2,
			["RCONTROL"] = 0xA3,
			["LALT"] = 0xA4,
			["RALT"] = 0xA5,
			["F1"] = 0x70,
			["F2"] = 0x71,
			["F3"] = 0x72,
			["F4"] = 0x73,
			["F5"] = 0x74,
			["F6"] = 0x75,
			["F7"] = 0x76,
			["F8"] = 0x77,
			["F9"] = 0x78,
			["F10"] = 0x79,
			["F11"] = 0x7A,
			["F12"] = 0x7B,
			["F13"] = 0x7C,
			["F14"] = 0x7D,
			["F15"] = 0x7E,
			["F16"] = 0x7F,
			["F17"] = 0x80,
			["F18"] = 0x81,
			["F19"] = 0x82,
			["F20"] = 0x83,
			["F21"] = 0x84,
			["F22"] = 0x85,
			["F23"] = 0x86,
			["F24"] = 0x87,
		},
		hotkey_notifications = {toggle = true, action = false},
		controls = {
			left = "LEFTARROW",
			up = "UPARROW",
			right =  "RIGHTARROW",
			down = "DOWNARROW",
			select = "ENTER",
			back = "BACKSPACE",
			open = "F4",
			setHotkey = "F11",
			specialKey = "LCONTROL",
		},
		vkcontrols = {
			left = 0x25,
			up = 0x26,
			right = 0x27,
			down = 0x28,
			select = 0x0D,
			back = 0x08,
			open = 0x73,
			setHotkey = 0x7A,
			specialKey = 0xA2,
		},
		drawScroll = 0,
		maxDrawScroll = 0,
		menuData = {
			menuToggle = false,
			menuNav = true,
			inputBoxOpen = false,
			pos_x = 0.5,
			pos_y = 0.44652777777,
			width = 0.2,
			height = 0.305,
			border = 0.0013888,
			selector_speed = 1,
			slider = {
				width = 0.2,
				height = 0.01,
				heightActive = 0.025,
			},
			footer = {
				footer_y_offset = 0,
				padding = 0.0078125,
				footer_size = 0.019444444,
				draw_footer = true,
				footer_pos_related_to_background = false,
				footer_text = version,
			},
			fonts = {
				text = 0,
				footer = 0,
				hint = 0
			},
			side_window = {
				on = true,
				offset = {x = 0, y = 0},
				spacing = 0.0547222,
				width = 0.3,
				padding = 0.01
			},
			header = "cheese_menu.png",
			language = "",
			feature_offset = 0.025,
			feature_scale = {x = 0.2, y = 0.025},
			padding = {
				name = 0.003125,
				parent = 0.003125,
				value = 0.048125,
				slider = 0.003125,
			},
			text_size = (((graphics.get_screen_width()*graphics.get_screen_height())/3686400)*0.45+0.25),
			text_size_modifier = 1,
			footer_size_modifier = 1,
			hint_size_modifier = 1,
			text_y_offset = -0.0055555555,
			color = {},
			files = {},
			background_sprite = {
				sprite = nil,
				size = 1,
				loaded_sprites = {},
				offset = {x = 0, y = 0}
			},
			max_features = 12,
			set_max_features = function(self, int)
				int = math.floor(int+0.5)
				self.height = int * self.feature_offset
				self.max_features = int
			end
		},
		disable_all_controls = function()
			while true do
				for i = 0, 360 do
					controls.disable_control_action(0, i, true)
				end
				system.wait(0)
			end
		end

	}

	cheeseUIdata = stuff.menuData
	stuff.input = require("Rimuru.libs.Get Input")
	cheeseUtils = require("Rimuru.libs.CheeseUtilities")


	stuff.menuData.color = {
		background = {r = 0, g = 0, b = 0, a = 0},
		sprite = 0xE6FFFFFF,
		slider_active = {r = 255, g = 200, b = 0, a = 255},
		slider_background = {r = 0, g = 0, b = 0, a = 160},
		slider_text = {r = 0, g = 0, b = 0, a = 255},
		slider_selectedActive = {r = 255, g = 255, b = 255, a = 160},
		slider_selectedBackground = {r = 255, g = 160, b = 0, a = 180},
		feature_bottomLeft = {r = 255, g = 160, b = 0, a = 170},
		feature_topLeft = {r = 255, g = 160, b = 0, a = 170},
		feature_topRight = {r = 255, g = 160, b = 0, a = 170},
		feature_bottomRight = {r = 255, g = 160, b = 0, a = 170},
		feature_selected_bottomLeft = {r = 0, g = 0, b = 0, a = 200},
		feature_selected_topLeft = {r = 0, g = 0, b = 0, a = 200},
		feature_selected_topRight = {r = 0, g = 0, b = 0, a = 200},
		feature_selected_bottomRight = {r = 0, g = 0, b = 0, a = 200},
		text_selected = {r = 255, g = 200, b = 0, a = 180},
		text = {r = 0, g = 0, b = 0, a = 180},
		border = {r = 0, g = 0, b = 0, a = 180},
		footer = {r = 255, g = 160, b = 0, a = 170},
		footer_text = {r = 0, g = 0, b = 0, a = 180},
		notifications = {r = 255, g = 200, b = 0, a = 255},
		side_window_background = {r = 0, g = 0, b = 0, a = 150},
		side_window_text = {r = 255, g = 255, b = 255, a = 220}
	}


	stuff.path.cheesemenu = stuff.path.scripts.."Rimuru\\"
	for k, v in pairs(utils.get_all_sub_directories_in_directory(stuff.path.cheesemenu)) do
		stuff.path[v] = stuff.path.cheesemenu..v.."\\"
	end

	stuff.menuData.background_sprite.fit_size_to_width = function(self)
		self.size = stuff.menuData.width*graphics.get_screen_width()/scriptdraw.get_sprite_size(func.load_sprite(stuff.path.background..(self.sprite or ""), stuff.menuData.background_sprite.loaded_sprites)).x
	end
	stuff.menuData.background_sprite.fit_size_to_height = function(self)
		self.size = stuff.menuData.height*graphics.get_screen_height()/scriptdraw.get_sprite_size(func.load_sprite(stuff.path.background..(self.sprite or ""), stuff.menuData.background_sprite.loaded_sprites)).y
	end

	stuff.image_ext = {"gif", "bmp", "jpg", "jpeg", "png", "2t1", "dds"}
	stuff.menuData.files.headers = {}
	for _, ext in pairs(stuff.image_ext) do
		if utils.file_exists(stuff.path.header.."default."..ext) then
			
			for _, image in pairs(get_all_files_in_directory(stuff.path.header, ext)) do
				stuff.menuData.files.headers[#stuff.menuData.files.headers + 1] = image
			end
		end
	end
	for k, v in pairs(utils.get_all_sub_directories_in_directory(stuff.path.header)) do
		stuff.menuData.files.headers[#stuff.menuData.files.headers + 1] = v..".ogif"
	end

	stuff.menuData.files.ui = {}
	for k, v in pairs(get_all_files_in_directory(stuff.path.ui, "lua")) do
		stuff.menuData.files.ui[k] = v:sub(1, #v - 4)
	end

	stuff.menuData.files.langs = {}
	for k, v in pairs(get_all_files_in_directory(stuff.path.scripts.."\\Rimuru\\langs", "lua")) do
		stuff.menuData.files.langs[#stuff.menuData.files.langs + 1] = v
	end

	stuff.menuData.files.background = {}
	for _, ext in pairs(stuff.image_ext) do
		for k, v in pairs(get_all_files_in_directory(stuff.path.background, "png")) do
			stuff.menuData.files.background[k] = v
		end
	end

	stuff.menuData_methods = {
		set_color = function(self, colorName, r, g, b, a)
			assert(self[colorName], "field "..colorName.." does not exist")
			local colors = {r = r or false, g = g or false, b = b or false, a = a or false}

			for k, v in pairs(colors) do
				if not v then
					if type(self[colorName]) == "table" then
						colors[k] = self[colorName][k]
					else
						colors[k] = cheeseUtils.convert_int_to_rgba(self[colorName], k)
					end
				end
			end

			for k, v in pairs(colors) do
				assert(v <= 255 and v >= 0, "attempted to set invalid "..k.." value to field "..colorName)
			end

			if type(self[colorName]) == "table" then
				self[colorName] = colors
			else
				self[colorName] = (colors.a << 24) + (colors.b << 16) + (colors.g << 8) + colors.r
			end
		end
	}

	setmetatable(stuff.menuData.color, {__index = stuff.menuData_methods})

	function convertVKToKey(vk)
		for i=1, #stuff.char_codes do
		  local key = stuff.char_codes[i]
		  if key.vk == vk then
			return tostring(key.key)
		  end
		end
	end

	function func.convert_int_ip(ip)
		local ipTable = {}
		ipTable[1] = ip >> 24 & 255
		ipTable[2] = ip >> 16 & 255
		ipTable[3] = ip >> 8 & 255
		ipTable[4] = ip & 255

		return table.concat(ipTable, ".")
	end

	local function loadLanguage(file)
		local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
	
		gltw.read(removeExtensions(file, "lua"), appdata.."scripts\\Rimuru\\langs\\", translations, false, true)
		return file
	end

	local settings = gltw.read("Settings", stuff.path.cheesemenu, nil, nil, true)
	loadLanguage(settings.language)

	for k, v in pairs(stuff.controls) do
		stuff.vkcontrols[k] = stuff.char_codes[v]
	end

	gltw.read("hotkey notifications", stuff.path.hotkeys, stuff.hotkey_notifications, false, true)
	stuff.hotkeys = gltw.read("hotkeys", stuff.path.hotkeys, nil, false, true) or {}
	stuff.hierarchy_key_to_hotkey = {}
	for k, v in pairs(stuff.hotkeys) do
		stuff.hotkey_cooldowns[k] = 0

		local string_to_vk = {}
		for char in k:gmatch("%|*([^%|]+)%|*") do
			string_to_vk[#string_to_vk+1] = stuff.char_codes[char]
		end
		stuff.hotkeys_to_vk[k] = string_to_vk

		if type(v) == "table" then
			for i, e in pairs(v) do
				stuff.hierarchy_key_to_hotkey[i] = k
			end
		end
	end

	--local originalGetInput = input.get
	if stuff.input then
		function input.get(title, default, len, Type)
			local originalmenuToggle = stuff.menuData.menuToggle
			stuff.menuData.menuToggle = false
			stuff.menuData.inputBoxOpen = true
			local status, gottenInput = stuff.input.get_input(title, default, len, Type)

			func.toggle_menu(originalmenuToggle)
			stuff.menuData.inputBoxOpen = false
			return status, gottenInput
		end
	end

	-- Credit to kektram for these functions
	do
		local _ENV <const> = {
			getmetatable = debug.getmetatable
		}
		function stuff.rawset(Table, index, value) -- Matches performance of normal rawset.
			local metatable <const> = getmetatable(Table)
			local __newindex
			if metatable then
				__newindex = metatable.__newindex
				metatable.__newindex = nil
			end
			Table[index] = value
			if __newindex then
				metatable.__newindex = __newindex
			end
			return Table
		end
	end
	do
		local _ENV <const> = {
			getmetatable = debug.getmetatable
		}
		function stuff.rawget(Table, index, value) -- Matches performance of normal rawget.
			local metatable <const> = getmetatable(Table)
			local __index
			if metatable then
				__index = metatable.__index
				metatable.__index = nil
			end
			local value <const> = Table[index]
			if __index then
				metatable.__index = __index
			end
			return value
		end
	end
	--

	stuff.playerSpecialValues = {value = true, min = true, max = true, mod = true, on = true, real_value = true, real_max = true, real_min = true, real_mod = true, real_on = true}

	stuff.featMetaTable = {
		__index = function(t, k)
			if k == "is_highlighted" then
				return t == currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
			elseif k == "parent" then
				return t.type >> 15 & 1 == 0 and func.get_feature(t.parent_id) or func.get_player_feature(t.parent_id)
			elseif k == "value" or k == "min" or k == "mod" or k == "max" or k == "str_data" or k == "type" or k == "id" or k == "on" or k == "hidden" or k == "data" then
				if t.playerFeat and k ~= "str_data" and k ~= "type" and k ~= "id" and k ~= "hidden" and k ~= "data" then
					return stuff.rawget(t, "table_"..k)
				else
					return stuff.rawget(t, "real_"..k)
				end
			elseif k == "children" and t.type >> 11 & 1 ~= 0 then
				return t:get_children()
			elseif k == "hint" then
				local hintTable = t.type >> 15 & 1 ~= 0 and stuff.player_feature_hints or stuff.feature_hints
				return hintTable[t.id].str
			--[[ else
				return stuff.rawget(t, k) ]]
			end
		end,

		__newindex = function(t, k, v)
			assert(k ~= "id" and k ~= "children" and k ~= "type" and k ~= "str_data" and k ~= "is_highlighted", "'"..k.."' is read only")
			if k == "on" and type(v) == "boolean" then
				if t.real_on == v then
					return
				end
				--[[ if t.type >> 11 & 1 ~= 0 and t.real_on ~= nil then
					func.check_scroll(t.index, (t.parent_id > 0 and t.parent or features), not v)
				end ]]
				stuff.rawset(t, "real_on", v)

				if t.feats then
					for pid, feat in pairs(t.feats) do
						if player.is_player_valid(pid) then
							feat.on = v
							--[[ if feat.type >> 11 & 1 ~= 0 then
								func.check_scroll(feat.index, (feat.parent_id > 0 and stuff.feature_by_id[feat.ps_parent_id] or stuff.PlayerParent), not v)
							end ]]
						end
					end
				else
					if v then
						t:activate_feat_func()
					end
				end
			elseif k == "value" or k == "min" or k == "mod" or k == "max" then
				if k ~= "value" and t.type >> 5 & 1 ~= 0 then -- value_str
					error("max, min and mod are readonly for value_str features")
				end
				v = tonumber(v)

				assert(t.type >> 1 & 1 ~= 0, "feat type not supported: "..t.type) -- value_[if], value_str
				assert(v, "tried to set "..k.." property to a non-number value")

				if t.type >> 5 & 1 ~= 0 then -- value_str
					if v < 0 then
						v = 0
					elseif t.real_str_data then
						if v+1 > #t.real_str_data and #t.real_str_data ~= 0 then
							v = #t.real_str_data-1
						end
					end
				end

				if t.type >> 1 & 1 ~= 0 then
					if t.type >> 3 & 1 ~= 0 or t.type >> 5 & 1 ~= 0 then -- value_str
						v = math.floor(v)
					end

					stuff.rawset(t, "real_"..k, v)
					if t.type & 140 ~= 0 then -- i|f|slider
						if not t.real_max then
							t.real_max = 0
						end
						if not t.real_min then
							t.real_min = 0
						end
						if not t.real_mod then
							t.real_mod = 1
						end
						if not t.real_value then
							t.real_value = 0
						end

						stuff.rawset(t, "real_value", t.real_value >= t.real_max and t.real_max or t.real_value <= t.real_min and t.real_min or t.real_value)
					end

					if t["table_"..k] then
						local is_num = t.type & 140 ~= 0
						for i = 0, 31 do
							t["table_"..k][i] = v
							if is_num then
								t["table_value"][i] = t["table_value"][i] >= t["table_max"][i] and t["table_max"][i] or t["table_value"][i] <= t["table_min"][i] and t["table_min"][i] or t["table_value"][i]
							end
						end
					end
				end
			elseif k == "hidden" then
				assert(type(v) == "boolean", "hidden only accepts booleans")
				if t.real_hidden == v then
					return
				end

				--[[ if t.real_hidden ~= nil then
					func.check_scroll(t.index, (t.parent_id > 0 and t.parent or features), v)
				end ]]

				t.real_hidden = v
				if t.feats then
					for _, feat in ipairs(t.feats) do
						feat.hidden = v
					end
				end
				if v then
					func.deleted_or_hidden_parent_check(t)
				end
			elseif k == "data" then
				stuff.rawset(t, "real_data", v)
				if t.feats then
					for i, e in pairs(t.feats) do
						t.feats[i].real_data = v
					end
				end
			elseif k == "hint" then
				local hintTable = t.type >> 15 & 1 ~= 0 and stuff.player_feature_hints or stuff.feature_hints
				if not v then
					hintTable[t.id] = nil
					return
				end
				assert(type(v) == "string", "Feat.hint only supports strings")
				local str = cheeseUtils.wrap_text(v, stuff.menuData.fonts.hint, stuff.menuData.text_size * stuff.menuData.hint_size_modifier, stuff.menuData.width*2-scriptdraw.size_pixel_to_rel_x(25))
				hintTable[t.id] = {str = str, size = scriptdraw.get_text_size(str, 1, stuff.menuData.fonts.hint), original = v}
			else
				stuff.rawset(t, k, v)
			end
		end
	}

	stuff.playerfeatMetaTable = {
		__index = function(t, k)
			if k == "is_highlighted" then
				return t == currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
			elseif k == "parent" then
				return func.get_player_feature(t.parent_id)
			elseif k == "str_data" or k == "type" or k == "id" or k == "data" or k == "hidden" then
				return stuff.rawget(t, "real_"..k)
			elseif stuff.playerSpecialValues[k] then
				if t["table_"..k:gsub("real_", "")] then
					return t["table_"..k:gsub("real_", "")][t.pid]
				end
			elseif k == "children" and t.type >> 11 & 1 ~= 0 then
				return t:get_children()
			else
				return stuff.rawget(t, k)
			end
		end,

		__newindex = function(t, k, v)
			assert(k ~= "id" and k ~= "children" and k ~= "type" and k ~= "str_data" and k ~= "is_highlighted", "'"..k.."' is read only")
			if (k == "on" or k == "real_on") and type(v) == "boolean" then
				t["table_on"][t.pid] = v
				if v then
					t:activate_feat_func()
				end
			elseif stuff.playerSpecialValues[k] then
				k = k:gsub("real_", "")
				if k ~= "value" and t.type >> 5 & 1 ~= 0 then
					error("max, min and mod are readonly for value_str features")
				end
				v = tonumber(v)

				assert(t.type >> 1 & 1 ~= 0, "feat type not supported")
				assert(v, "tried to set "..k.." property to a non-number value")

				if t.type >> 5 & 1 ~= 0 then
					if v < 0 then
						v = 0
					elseif t.real_str_data then
						if v+1 > #t.real_str_data and #t.real_str_data ~= 0 then
							v = #t.real_str_data-1
						end
					end
				end

				if t.type >> 1 & 1 ~= 0 then
					if t.type >> 3 & 1 ~= 0 or t.type >> 5 & 1 ~= 0 then -- value_i|str
						v = math.floor(v)
					end

					t["table_"..k][t.pid] = v
					if t.type & 140 ~= 0 then -- i|f|slider
						if not t.real_max then
							t.real_max = 0
						end
						if not t.real_min then
							t.real_min = 0
						end
						if not t.real_mod then
							t.real_mod = 1
						end
						if not t.real_value then
							t.real_value = 0
						end

						t["table_value"][t.pid] = t["table_value"][t.pid] >= t["table_max"][t.pid] and t["table_max"][t.pid] or t["table_value"][t.pid] <= t["table_min"][t.pid] and t["table_min"][t.pid] or t["table_value"][t.pid]
					end
				end
			elseif k == "data" then
				t.real_data = v
			else
				stuff.rawset(t, k, v)
			end
		end
	}

	-- featMethods

	-- dogshit dont use
	--[[ stuff.set_val = function(self, valueType, val, dont_set_all)
		assert(stuff.type_id.id_to_name[self.type]:match("value_[if]") or stuff.type_id.id_to_name[self.type]:match("value_str"), "feat type not supported")
		assert(tonumber(val), "tried to set "..valueType.." to a non-number value")
		if stuff.type_id.id_to_name[self.type]:match("value_i") then
			val = tonumber(math.floor(val))
		else
			val = tonumber(val)
		end

		if valueType == "value" then
			if self.real_min then
				if val < self.real_min then
					val = self.real_min
				end
			else
				if val < 0 then
					val = 0
				end
			end
			if self.real_max then
				if val > self.real_max then
					val = self.real_max
				end
			elseif self.real_str_data then
				if val+1 > #self.real_str_data then
					val = #self.real_str_data-1
				end
			end
		end

		self[valueType] = val
		if self["table_"..valueType] and not dont_set_all then
			for i = 0, 31 do
				self["table_"..valueType][i] = val
			end
		end
	end

	stuff.set_value = function(self, val, dont_set_all)
		stuff.set_val(self, "value", val, dont_set_all)
	end
	stuff.set_max = function(self, val, dont_set_all)
		stuff.set_val(self, "max", val, dont_set_all)
	end
	stuff.set_min = function(self, val, dont_set_all)
		stuff.set_val(self, "min", val, dont_set_all)
	end
	stuff.set_mod = function(self, val, dont_set_all)
		stuff.set_val(self, "mod", val, dont_set_all)
	end ]]

	stuff.get_str_data = function(self)
		assert(self.type >> 5 & 1 ~= 0, "used get_str_data on a feature that isn't value_str")
		return self.str_data
	end

	stuff.set_str_data = function(self, stringTable)
		assert(type(stringTable) == "table", "tried to set str_data property to a non-table value")
		local numberedTable
		for k, v in pairs(stringTable) do
			if type(k) ~= "number" then
				numberedTable = {}
				for k, v in pairs(stringTable) do
					numberedTable[#numberedTable + 1] = v
				end
				break
			end
		end
		self.real_str_data = numberedTable or stringTable
		if self.real_value+1 > #self.real_str_data then
			self.real_value = #self.real_str_data-1 >= 0 and #self.real_str_data-1 or 0
		end
		if self.feats then
			for k, v in pairs(self.table_value) do
				if v+1 > #self.real_str_data then
					self.table_value[k] = #self.real_str_data-1
				end
			end
			for k, v in pairs(self.feats) do
				v.real_str_data = stringTable
			end
		end
	end

	stuff.toggle = function(self, bool)
		if self.type & 1 ~= 0 then
			if bool ~= nil then
				self.real_on = bool
				self:activate_feat_func()
			else
				self.real_on = not self.real_on
				self:activate_feat_func()
			end
		else
			self:activate_feat_func()
		end
	end

	stuff.get_children = function(self)
		local children = {}
		for k, v in ipairs(self) do
			if type(k) == "number" then
				children[k] = v
			end
		end
		return children
	end

	-- function callback ~Thanks to Proddy for telling me that doing function() every time creates a new one and providing examples on how to use menu.create_thread with the function below
	function stuff.feature_callback(self)
		local pidordata = self.pid or self.data
		if self.on ~= nil and self.type & 2049 == 0 then -- not toggle or parent
			self.on = true
		end
		local continue = self:func(pidordata, self.data)
		while continue == HANDLER_CONTINUE do
			system.wait(0)
			continue = self:func(pidordata, self.data)
		end
		if self.on ~= nil and self.type & 2049 == 0 then -- not toggle or parent
			self.on = false
		end
	end

	function stuff.highlight_callback(self)
		local pidordata = self.pid or self.data
		self:hl_func(pidordata, self.data)
	end

	stuff.activate_feat_func = function(self)
		if not (self.thread) then
			self.thread = 0
		end
		if self.func and menu.has_thread_finished(self.thread) then
			self.thread = menu.create_thread(stuff.feature_callback, self)
		end
	end

	stuff.activate_hl_func = function(self)
		if self.hl_func then
			if not self.hl_thread then
				self.hl_thread = 0
			end
			if menu.has_thread_finished(self.hl_thread) then
				self.hl_thread = menu.create_thread(stuff.highlight_callback, self)
			end
		end
	end

	stuff.select = function(self)
		local parent_of_feat_wanted = stuff.feature_by_id[self.parent_id] or features

		if not (parent_of_feat_wanted == currentMenu) then
			stuff.previousMenus[#stuff.previousMenus + 1] = {menu = currentMenu, scroll = stuff.scroll, drawScroll = stuff.drawScroll, scrollHiddenOffset = stuff.scrollHiddenOffset}
			currentMenu = parent_of_feat_wanted
		end

		if not self.hidden then
			local hiddenOffset = 0
			for k, v in ipairs(parent_of_feat_wanted) do
				if type(k) == "number" then
					if v.hidden and not (k > self.index) then
						hiddenOffset = hiddenOffset + 1
					end
				end
			end
			stuff.scroll = self.index - hiddenOffset
			stuff.drawScroll = (stuff.maxDrawScroll >= self.index) and self.index-1 or stuff.maxDrawScroll
		end

		stuff.scrollHiddenOffset = 0
	end
	--

	stuff.hotkey_feature_hierarchy_keys = {}

	stuff.type_id = {
		name_to_id = {
			toggle = 1 << 0,
			slider = 1 << 2 | 1 << 1 | 1 << 0,
			value_i = 1 << 3 | 1 << 1 | 1 << 0,
			value_str = 1 << 5 | 1 << 1 | 1 << 0,
			value_f = 1 << 7 | 1 << 1 | 1 << 0,
			action = 1 << 9,
			action_slider = 1 << 9 | 1 << 2 | 1 << 1,
			action_value_i = 1 << 9 | 1 << 3 | 1 << 1,
			action_value_str = 1 << 9 | 1 << 5 | 1 << 1,
			action_value_f = 1 << 9 | 1 << 7 | 1 << 1,
			autoaction_slider = 1 << 10 | 1 << 2 | 1 << 1,
			autoaction_value_i = 1 << 10 | 1 << 3 | 1 << 1,
			autoaction_value_str = 1 << 10 | 1 << 5 | 1 << 1,
			autoaction_value_f = 1 << 10 | 1 << 7 | 1 << 1,
			parent = 1 << 11
		},
	}

	menu.create_thread(function()
		local alert_screen = graphics.request_scaleform_movie("MP_BIG_MESSAGE_FREEMODE")
    	local i = 0
    	while i < 180 do
    	    graphics.begin_scaleform_movie_method(alert_screen, "SHOW_SHARD_WASTED_MP_MESSAGE")
    	    graphics.draw_scaleform_movie_fullscreen(alert_screen, 255, 255, 255, 255, 0)
    	    graphics.scaleform_movie_method_add_param_texture_name_string("~p~"..translations.welcome.."\nRimurus Menu~p~")
			graphics.scaleform_movie_method_add_param_texture_name_string(string.format("%s to open %s to select\n%s/%s to scroll", stuff.controls.open, stuff.controls.select, stuff.controls.up, stuff.controls.down))
			graphics.end_scaleform_movie_method(alert_screen)
    	    i = i+1
    	    system.wait(0)
    	end
		menu.notify("Rimurus Menu is discotinued and will not get any major updates.", "Rimurus Menu", 10)
	end,nil)

	--Functions

	function func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionCallback, highlightCallback, playerFeat)
		assert((type(nameOfFeat) == "string"), "invalid name in add_feature")
		assert((type(TypeOfFeat) == "string") and stuff.type_id.name_to_id[TypeOfFeat], "invalid type in add_feature")
		assert((type(parentOfFeat) == "number") or not parentOfFeat, "invalid parent id in add_feature")
		assert((type(functionCallback) == "function") or not functionCallback, "invalid function in add_feature")
		playerFeat = playerFeat or false
		parentOfFeat = parentOfFeat or 0
		--TypeOfFeat = TypeOfFeat:gsub("slider", "value_f")
		local currentParent = playerFeat and features["OnlinePlayers"] or features

		local hierarchy_key
		if parentOfFeat ~= 0 and parentOfFeat then
			currentParent = playerFeat and stuff.player_feature_by_id[parentOfFeat] or stuff.feature_by_id[parentOfFeat]
			if currentParent then
				assert(currentParent.type >> 11 & 1 ~= 0, "parent is not a parent feature")
				assert(currentParent.type >> 15 & 1 ~= 0 == playerFeat, "parent is not valid "..((currentParent.type >> 15 & 1 ~= 0 and not playerFeat) and "using player feature as parent for a local feature" or (currentParent.type >> 15 & 1 == 0 and playerFeat and "using local parent for player feature") or "unknown"))
			else
				error("parent does not exist")
			end
		end
		if currentParent.hierarchy_key then
			hierarchy_key = currentParent.hierarchy_key.."."..nameOfFeat:gsub("[ %.]", "_")
		else
			hierarchy_key = nameOfFeat:gsub("[ %.]", "_")
		end

		currentParent[#currentParent + 1] = {name = nameOfFeat, real_type = stuff.type_id.name_to_id[TypeOfFeat] | (playerFeat and 1 << 15 or 0), real_id = 0, --[[parent = {id = currentParent.id or 0},]] parent_id = currentParent.id or 0, playerFeat = playerFeat, index = #currentParent + 1}
		local feat = currentParent[#currentParent]
		feat.activate_feat_func = stuff.activate_feat_func
		feat.activate_hl_func = stuff.activate_hl_func
		feat.set_str_data = stuff.set_str_data
		feat.toggle = stuff.toggle
		feat.get_children = stuff.get_children
		feat.get_str_data = stuff.get_str_data
		feat.select = stuff.select
		setmetatable(feat, stuff.featMetaTable)
		feat.thread = 0
		--if feat.real_type & 1 ~= 0 or feat.real_type >> 9 & 1 ~= 0 then -- toggle
			if playerFeat then
				feat.table_on = {}
				for i = 0, 31 do
					feat.table_on[i] = feat.type >> 11 & 1 ~= 0
				end
			end
			feat.on = feat.type >> 11 & 1 ~= 0
		--end
		if feat.real_type >> 5 & 1 ~= 0 then -- value_str
			feat.real_str_data = {}
			if playerFeat then
				feat.table_value = {}
				for i = 0, 31 do
					feat.table_value[i] = 0
				end
			end
			feat.value = 0
		elseif feat.real_type >> 1 & 1 ~= 0 then --value any
			if playerFeat then
				feat.table_max = {}
				feat.table_min = {}
				feat.table_mod = {}
				feat.table_value = {}
				for i = 0, 31 do
					feat.table_max[i] = 0
					feat.table_min[i] = 0
					feat.table_mod[i] = 1
					feat.table_value[i] = 0
				end
			end
			feat.max = 0
			feat.min = 0
			feat.mod = 1
			feat.value = 0
		end
		feat.hidden = false
		feat["func"] = functionCallback
		feat["hl_func"] = highlightCallback
		if TypeOfFeat == "parent" then
			feat.child_count = 0
		end
		currentParent.child_count = 0
		for k, v in pairs(currentParent) do
			if type(k) == "number" then
				currentParent.child_count = currentParent.child_count + 1
			end
		end
		feat.hotkey = stuff.hierarchy_key_to_hotkey[hierarchy_key]
		feat.hierarchy_key = hierarchy_key
		if stuff.hotkey_feature_hierarchy_keys[hierarchy_key] then
			stuff.hotkey_feature_hierarchy_keys[hierarchy_key][#stuff.hotkey_feature_hierarchy_keys[hierarchy_key] + 1] = feat
	 	else
			stuff.hotkey_feature_hierarchy_keys[hierarchy_key] = {feat}
		end
		feat.hierarchy_id = #stuff.hotkey_feature_hierarchy_keys[hierarchy_key]
		if playerFeat then
			stuff.player_feature_by_id[#stuff.player_feature_by_id+1] = feat
			feat.real_id = #stuff.player_feature_by_id
		else
			stuff.feature_by_id[#stuff.feature_by_id+1] = feat
			feat.real_id = #stuff.feature_by_id
		end
		return feat
	end

	local add_feature <const> = func.add_feature
	function func.add_feature(...)
	   local vars = {...}
	   local name = translations[vars[1]] or vars[1]
	   translations[vars[1]] = name
	   table.remove(vars, 1)
	   return add_feature(name, table.unpack(vars))
	end

	--player feature functions

	-- if you set a toggle player feature to on it'll enable for any valid players/joining players but if a player leaves functions like player.get_player_name will return nil before the feature is turned off
	function func.add_player_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionCallback, highlightCallback)
		parentOfFeat = parentOfFeat or 0
		assert(stuff.PlayerParent, "you need to use set_player_feat_parent before adding player features")
		local pfeat = func.add_feature(nameOfFeat, TypeOfFeat, parentOfFeat, functionCallback, highlightCallback, true)
		pfeat.feats = {}

		if parentOfFeat == 0 then
			for k = 0, 31 do
				stuff.playerIds[k][#stuff.playerIds[k]+1] = {}
				local currentFeat = stuff.playerIds[k][#stuff.playerIds[k]]
				func.add_to_table(pfeat, currentFeat, k, nil, true)
				stuff.feature_by_id[#stuff.feature_by_id+1] = currentFeat
				currentFeat.ps_id = #stuff.feature_by_id
				currentFeat.ps_parent_id = stuff.playerIds[k].id
				currentFeat.pid = k
				pfeat.feats[k] = currentFeat
			end
		else
			local playerParent = stuff.player_feature_by_id[parentOfFeat]
			if playerParent then
				for k = 0, 31 do
					playerParent.feats[k][#playerParent.feats[k]+1] = {}
					local currentFeat = playerParent.feats[k][#playerParent.feats[k]]

					func.add_to_table(pfeat, currentFeat, k, nil, true)
					stuff.feature_by_id[#stuff.feature_by_id+1] = currentFeat
					currentFeat.ps_id = #stuff.feature_by_id
					currentFeat.ps_parent_id = playerParent.feats[k].ps_id
					currentFeat.pid = k
					pfeat.feats[k] = currentFeat
				end
			end
		end

		return pfeat
	end

	function func.add_to_table(getTable, addToTable, playerid, override, setmeta)
		local isPlayerFeatValues
		for k, v in pairs(getTable) do
			if tostring(k):match("table_") or stuff.playerSpecialValues[k] then
				isPlayerFeatValues = true
			elseif type(v) == "table" then
				if type(addToTable[k]) ~= "table" then
					addToTable[k] = {}
				end
				if addToTable[k].real_on then
					addToTable[k].real_on = false
				end
				if (v.type or 0) >> 11 & 1 ~= 0 then
					func.add_to_table(getTable[k], addToTable[k], playerid, override)
				else
					for i, e in pairs(getTable[k]) do
						if type(e) ~= "table" then
							if not addToTable[k][i] or override then
								addToTable[k][i] = e
							end
						end
					end
				end
				setmetatable(addToTable[k], stuff.playerfeatMetaTable)
				if v.name then
					if not getTable[k].feats then
						getTable[k].feats = {}
					end
					getTable[k].feats[playerid] = addToTable[k]
				end
			else
				if not addToTable[k] or override then
					addToTable[k] = v
				end
			end
		end
		if setmeta or isPlayerFeatValues then
			addToTable.table_value = getTable.table_value
			addToTable.table_min = getTable.table_min
			addToTable.table_max = getTable.table_max
			addToTable.table_mod = getTable.table_mod
			addToTable.table_on = getTable.table_on
			for i, e in pairs(stuff.playerSpecialValues) do
				if addToTable[i] then
					stuff.rawset(addToTable, i, nil)
				end
			end
			setmetatable(addToTable, stuff.playerfeatMetaTable)
		end
	end

	function func.set_player_feat_parent(nameOfFeat, parentOfFeat, functionToDo)
		stuff.PlayerParent = func.add_feature(nameOfFeat, "parent", parentOfFeat, functionToDo)
		local hierarchy_pattern = stuff.PlayerParent.hierarchy_key..".player_"

		stuff.playerIds = {}
		for i = 0, 31 do
			stuff.playerIds[i] = func.add_feature(tostring(player.get_player_name(i)), "parent", stuff.PlayerParent.id)
			stuff.playerIds[i].pid = i
			stuff.playerIds[i].hidden = not player.is_player_valid(i)
			stuff.playerIds[i].hierarchy_key = hierarchy_pattern..i
			stuff.playerIds[i].real_type = 1 << 15 | stuff.playerIds[i].type
		end

		event.add_event_listener("player_join", function(listener)
			system.wait(100)
			stuff.playerIds[listener.player].hidden = false
			stuff.playerIds[listener.player].name = player.get_player_name(listener.player)
			func.reset_player_submenu(listener.player)
			table.sort(stuff.PlayerParent, stuff.table_sort_functions[stuff.player_submenu_sort])
		end)
		event.add_event_listener("player_leave", function(listener)
			func.reset_player_submenu(listener.player)
			if not player.is_player_valid(listener.player) then
				stuff.playerIds[listener.player].hidden = true
				stuff.playerIds[listener.player].name = "nil"
			end
			table.sort(stuff.PlayerParent, stuff.table_sort_functions[stuff.player_submenu_sort])
		end)

		return stuff.PlayerParent
	end

	function func.reset_player_submenu(pid, currentParent)
		local currentParent = currentParent or features.OnlinePlayers
		for k, v in pairs(currentParent) do
			if type(v) == "table" then
				local feat_type = v.type
				if feat_type then
					if feat_type >> 1 & 1 ~= 0 then -- toggle
						v.table_value[pid] = v.real_value
						if feat_type & 136 ~= 0 then -- value if
							v.table_min[pid] = v.real_min
							v.table_max[pid] = v.real_max
							v.table_mod[pid] = v.real_mod
						end
					end
					if feat_type & 1 ~= 0 then -- toggle
						if player.is_player_valid(pid) then
							v.feats[pid].on = v.real_on
						else
							v.feats[pid].on = false
							v.table_on[pid] = false
						end
					end
					if feat_type >> 11 & 1 ~= 0 then -- parent
						func.reset_player_submenu(pid, v)
					end
				end
			end
		end
	end
	--end of player feature functions

	function func.check_scroll(index, parent, bool)
		if index <= stuff.scroll + stuff.scrollHiddenOffset and currentMenu == parent then
			if bool then
				--stuff.scroll = stuff.scroll - 1
				--stuff.scroll = stuff.scroll > 0 and stuff.scroll or 0
				if #currentMenu - stuff.drawHiddenOffset > 1 and stuff.scroll - 1 > 0 then
					stuff.scroll = stuff.scroll - 1
					if stuff.scroll - stuff.drawScroll <= 2 and stuff.drawScroll > 0 then
						stuff.drawScroll = stuff.drawScroll - 1
					end
				end
			else
				if #currentMenu - stuff.drawHiddenOffset > 1 then
					stuff.scroll = stuff.scroll + 1
					if stuff.scroll - stuff.drawScroll >= (stuff.menuData.max_features - 1) and stuff.drawScroll < stuff.maxDrawScroll then
						stuff.drawScroll = stuff.drawScroll + 1
					end
				end
				--stuff.scroll = stuff.scroll + 1
			end
		end
	end

	function func.deleted_or_hidden_parent_check(parent, check_hidden_only)
		if next(stuff.previousMenus) then
			local parentBeforeDHparent = false
			if parent ~= currentMenu then
				for k, v in ipairs(stuff.previousMenus) do
					if parentBeforeDHparent then
						stuff.previousMenus[k] = nil
					else
						if (v.menu == parent and not check_hidden_only) or (v.menu.hidden and check_hidden_only) then
							parentBeforeDHparent = true
							currentMenu = stuff.previousMenus[k-1].menu
							stuff.scroll = stuff.previousMenus[k-1].scroll
							stuff.drawScroll = stuff.previousMenus[k-1].drawScroll
							stuff.scrollHiddenOffset = stuff.previousMenus[k-1].scrollHiddenOffset
							stuff.previousMenus[k-1] = nil
							stuff.previousMenus[k] = nil
						end
					end
				end
			elseif not check_hidden_only then
				currentMenu = stuff.previousMenus[#stuff.previousMenus].menu
				stuff.scroll = stuff.previousMenus[#stuff.previousMenus].scroll
				stuff.drawScroll = stuff.previousMenus[#stuff.previousMenus].drawScroll
				stuff.scrollHiddenOffset = stuff.previousMenus[#stuff.previousMenus].scrollHiddenOffset
				stuff.previousMenus[#stuff.previousMenus] = nil
			end
		end
	end

	function func.get_feature_by_hierarchy_key(hierarchy_key)
		local feat = stuff.hotkey_feature_hierarchy_keys[hierarchy_key]
		if feat then
			if feat[2] and not feat.name then
				return feat, true
			else
				return feat[1]
			end
		end
	end

	function func.get_feature(id)
		assert(type(id) == "number" and id ~= 0, "invalid id in get_feature")
		return stuff.feature_by_id[id]
	end

	function func.delete_feature(id, bool_ps)
		if type(id) == "table" then
			id = id.id
		end

		local feat = stuff.feature_by_id[id]
		if not feat then
			return false
		end

		stuff.hotkey_feature_hierarchy_keys[feat.hierarchy_key][feat.hierarchy_id] = nil

		if stuff.old_selected == stuff.feature_by_id[id] then
			stuff.old_selected = nil
		end
		stuff.feature_by_id[id] = nil

		if feat.thread then
			if not menu.has_thread_finished(feat.thread) then
				menu.delete_thread(feat.thread)
			end
		end
		if feat.hl_thread then
			if not menu.has_thread_finished(feat.hl_thread) then
				menu.delete_thread(feat.hl_thread)
			end
		end

		local parent
		if feat.parent_id ~= 0 or bool_ps then
			parent = bool_ps and stuff.feature_by_id[feat.ps_parent_id] or stuff.feature_by_id[feat.parent_id]
		else
			parent = features
		end

		if feat.type >> 11 & 1 ~= 0 then
			func.deleted_or_hidden_parent_check(feat)
		end

		local index = feat.index
		if not bool_ps then
			stuff.feature_hints[index] = nil
		end
		table.remove(parent, tonumber(feat.index))

		--func.check_scroll(index, parent, true)

		for i = index, #parent do
			parent[i].index = i
		end

		return true
	end

	function func.delete_player_feature(id)
		if type(id) == "table" then
			id = id.id
		end

		stuff.player_feature_hints[id] = nil

		local feat = stuff.player_feature_by_id[id]
		if not feat then
			return false
		end

		stuff.player_feature_by_id[id] = nil

		local parent
		if feat.parent_id ~= 0 then
			parent = stuff.player_feature_by_id[feat.parent_id]
		else
			parent = features["OnlinePlayers"]
		end

		for k, v in pairs(feat.feats) do
			func.delete_feature(v.ps_id, true)
		end

		local index = feat.index
		table.remove(parent, tonumber(index))
		for i = index, #parent do
			parent[i].index = i
			for pid = 0, 31 do
				parent[i].feats[pid].index = i
			end
		end
	end

	function func.get_player_feature(id)
		assert(type(id) == "number" and id ~= 0, "invalid id in get_player_feature")
		return stuff.player_feature_by_id[id]
	end

	function func.do_key(time, key, doLoopedFunction, functionToDo)
		if cheeseUtils.get_key(key):is_down() then
			functionToDo()
			local timer = utils.time_ms() + time
			while timer > utils.time_ms() and cheeseUtils.get_key(key):is_down() do
				system.wait(0)
			end
			while timer < utils.time_ms() and cheeseUtils.get_key(key):is_down() do
				if doLoopedFunction then
					functionToDo()
				end
				local timer = utils.time_ms() + 50
				while timer > utils.time_ms() do
					system.wait(0)
				end
			end
		end
	end

	stuff.header_ids = {}
	function func.load_sprite(path_to_file, id_table)
		--path = path or stuff.path.header
		id_table = id_table or stuff.header_ids
		path_to_file = tostring(path_to_file)
		assert(path_to_file, "invalid name")

		--name = name:gsub("%.[a-z]+$", "")

		if not id_table[path_to_file] then
			if utils.dir_exists(path_to_file:gsub("%.ogif", "")) and path_to_file:find("%.ogif") then
				local path = path_to_file:gsub("%.ogif", "").."\\"
				local images

				for _, v in pairs(stuff.image_ext) do
					images = get_all_files_in_directory(path, v)
					if images[1] then break end
				end
				if not images[1] then
					menu.notify("No frames found.", "Rimurus Menu", 5, 0x0000FF)
					return
				end

				id_table[path_to_file] = {}
				for i, e in pairs(images) do
					id_table[path_to_file][i] = {}
					id_table[path_to_file][i].sprite = scriptdraw.register_sprite(path..e)
					id_table[path_to_file][i].delay = e:match("%d+_(%d+)")
				end

				id_table[path_to_file].constant_delay = get_all_files_in_directory(path, "txt")[1]
				if not id_table[path_to_file].constant_delay then
					for k, v in pairs(images) do
						if not v:match("%d+_(%d+)") then
							menu.notify("FPS file not found and frames are not in format, create a txt file with the framerate of the gif.\nExample: '25 fps.txt'", "Rimurus Menu", 5, 0x0000FF)
							break
						end
					end
				else
					id_table[path_to_file].constant_delay = math.floor(1000 / tonumber(id_table[path_to_file].constant_delay:match("(%d*%.*%d+)%s+fps")))
				end

			elseif utils.file_exists(path_to_file) then
				id_table[path_to_file] = scriptdraw.register_sprite(path_to_file)
			end
		end

		return id_table[path_to_file]
	end

	function func.toggle_menu(bool)
		stuff.menuData.menuToggle = bool
		if stuff.menuData.menuToggle then
			if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
				currentMenu[stuff.scroll + stuff.scrollHiddenOffset]:activate_hl_func()
			end
		end
	end

	function func.selector(feat)
		local originalmenuToggle = stuff.menuData.menuToggle
		stuff.menuData.menuToggle = false
		if feat.str_data then
			local index, _ = cheeseUtils.selector(nil, stuff.menuData.selector_speed, feat.real_value + 1, feat.str_data)
			if index then
				feat.real_value = index - 1
			end
			if feat.type >> 10 & 1 ~= 0 then
				feat:activate_feat_func()
			end
		end
		func.toggle_menu(originalmenuToggle)
	end

	function func.rewrap_hint(hintTable, font, padding)
		hintTable.str = cheeseUtils.wrap_text(hintTable.original, font, stuff.menuData.text_size * stuff.menuData.hint_size_modifier, stuff.menuData.width*2-padding)
		hintTable.size = scriptdraw.get_text_size(hintTable.str, 1, font)
	end

	function func.rewrap_hints(font)
		local padding = scriptdraw.size_pixel_to_rel_x(25)
		for _, hintTable in pairs(stuff.feature_hints) do
			func.rewrap_hint(hintTable, font, padding)
		end
		for _, hintTable in pairs(stuff.player_feature_hints) do
			func.rewrap_hint(hintTable, font, padding)
		end
	end

	function func.save_settings()
		gltw.write({
			x = stuff.menuData.pos_x,
			y = stuff.menuData.pos_y,
			side_window = stuff.menuData.side_window,
			controls = stuff.controls,
			language = stuff.menuData.language,
			states = GStates,
			hotkey_notifications = stuff.hotkey_notifications,
			player_submenu_sort = stuff.player_submenu_sort,
			selector_speed = stuff.menuData.selector_speed
		}, "Settings", stuff.path.cheesemenu)
	end

	function func.load_settings()
		local settings = gltw.read("Settings", stuff.path.cheesemenu, nil, nil, true)
		if settings then
			stuff.menuData.pos_x = settings.x
			stuff.menuData.pos_y = settings.y
			stuff.menuData.language = settings.language
			GStates = settings.states	
			stuff.menuData.selector_speed = settings.selector_speed
			stuff.player_submenu_sort = settings.player_submenu_sort

			for k, v in pairs(settings.side_window) do
				stuff.menuData.side_window[k] = v
			end
			for k, v in pairs(settings.hotkey_notifications) do
				stuff.hotkey_notifications[k] = v
			end
			for k, v in pairs(settings.controls) do
				stuff.controls[k] = v
				menu_configuration_features.control_features[k]:set_str_data({v})
			end
			for k, v in pairs(stuff.controls) do
				stuff.vkcontrols[k] = stuff.char_codes[v]
			end

			menu_configuration_features.menuXfeat.value = math.floor(stuff.menuData.pos_x*graphics.get_screen_width())
			menu_configuration_features.menuYfeat.value = math.floor(stuff.menuData.pos_y*graphics.get_screen_height())
			menu_configuration_features.player_submenu_sort.value = stuff.player_submenu_sort
			menu_configuration_features.player_submenu_sort:toggle()
			menu_configuration_features.side_window_offsetx.value = math.floor(stuff.menuData.side_window.offset.x*graphics.get_screen_width())
			menu_configuration_features.side_window_offsety.value = math.floor(stuff.menuData.side_window.offset.y*graphics.get_screen_height())
			menu_configuration_features.side_window_spacing.value = math.floor(stuff.menuData.side_window.spacing*graphics.get_screen_height())
			menu_configuration_features.side_window_padding.value = math.floor(stuff.menuData.side_window.padding*graphics.get_screen_width())
			menu_configuration_features.side_window_width.value = math.floor(stuff.menuData.side_window.width*graphics.get_screen_width())
			menu_configuration_features.side_window_on.on = stuff.menuData.side_window.on
			menu_configuration_features.selector_speed.value = stuff.menuData.selector_speed
		end
	end

	function func.save_ui(name)
		gltw.write(stuff.menuData, name, stuff.path.ui, {"menuToggle", "menuNav", "loaded_sprites", "files", "pos_x", "pos_y", "side_window", "selector_speed", "inputBoxOpen"})
	end

	function func.load_ui(name)
		local uiTable = gltw.read(name, stuff.path.ui, stuff.menuData, true, true)
		if not uiTable then
			return
		end
		if menu_configuration_features then
			local header, bgSprite = uiTable.header, uiTable.background_sprite and uiTable.background_sprite.sprite or nil
			if not header then
				menu_configuration_features.headerfeat.value = 0
				menu_configuration_features.headerfeat:toggle()
			end
			if not bgSprite then
				menu_configuration_features.backgroundfeat.value = 0
				menu_configuration_features.backgroundfeat:toggle()
			end

			--[[ menu_configuration_features.menuXfeat.value = math.floor(stuff.menuData.pos_x*graphics.get_screen_width())
			menu_configuration_features.menuYfeat.value = math.floor(stuff.menuData.pos_y*graphics.get_screen_height()) ]]
			menu_configuration_features.maxfeats.value = math.floor(stuff.menuData.max_features)
			menu_configuration_features.menuWidth.value = math.floor(stuff.menuData.width*graphics.get_screen_width())
			menu_configuration_features.featXfeat.value = math.floor(stuff.menuData.feature_scale.x*graphics.get_screen_width())
			menu_configuration_features.featYfeat.value = math.floor(stuff.menuData.feature_scale.y*graphics.get_screen_height())
			menu_configuration_features.feature_offset.value = math.floor(stuff.menuData.feature_offset*graphics.get_screen_height())
			menu_configuration_features.namePadding.value = math.floor(stuff.menuData.padding.name*graphics.get_screen_width())
			menu_configuration_features.parentPadding.value = math.floor(stuff.menuData.padding.parent*graphics.get_screen_width())
			menu_configuration_features.valuePadding.value = math.floor(stuff.menuData.padding.value*graphics.get_screen_width())
			menu_configuration_features.sliderPadding.value = math.floor(stuff.menuData.padding.slider*graphics.get_screen_width())
			menu_configuration_features.sliderWidth.value = math.floor(stuff.menuData.slider.width*graphics.get_screen_width())
			menu_configuration_features.sliderHeight.value = math.floor(stuff.menuData.slider.height*graphics.get_screen_height())
			menu_configuration_features.sliderheightActive.value = math.floor(stuff.menuData.slider.heightActive*graphics.get_screen_height())
			menu_configuration_features.text_size.value = stuff.menuData.text_size_modifier
			menu_configuration_features.footer_size.value = stuff.menuData.footer_size_modifier
			menu_configuration_features.hint_size.value = stuff.menuData.hint_size_modifier
			menu_configuration_features.text_y_offset.value = -math.floor(stuff.menuData.text_y_offset*graphics.get_screen_height())
			stuff.drawFeatParams.textOffset.y = stuff.menuData.text_y_offset
			menu_configuration_features.footer_y_offset.value = math.floor(stuff.menuData.footer.footer_y_offset*graphics.get_screen_height())
			menu_configuration_features.border.value = math.floor(stuff.menuData.border*graphics.get_screen_height())
			menu_configuration_features.backgroundsize.value = stuff.menuData.background_sprite.size
			menu_configuration_features.backgroundoffsetx.value = math.floor(stuff.menuData.background_sprite.offset.x*graphics.get_screen_width())
			menu_configuration_features.backgroundoffsety.value = math.floor(stuff.menuData.background_sprite.offset.y*graphics.get_screen_height())
			menu_configuration_features.footer_size.value = math.floor(stuff.menuData.footer.footer_size*graphics.get_screen_height())
			menu_configuration_features.footerPadding.value = math.floor(stuff.menuData.footer.padding*graphics.get_screen_width())
			menu_configuration_features.draw_footer.on = stuff.menuData.footer.draw_footer
			menu_configuration_features.footer_pos_related_to_background.on = stuff.menuData.footer.footer_pos_related_to_background
			--[[ menu_configuration_features.side_window_offsetx.value = math.floor(stuff.menuData.side_window.offset.x*graphics.get_screen_width())
			menu_configuration_features.side_window_offsety.value = math.floor(stuff.menuData.side_window.offset.y*graphics.get_screen_height())
			menu_configuration_features.side_window_spacing.value = math.floor(stuff.menuData.side_window.spacing*graphics.get_screen_height())
			menu_configuration_features.side_window_padding.value = math.floor(stuff.menuData.side_window.padding*graphics.get_screen_width())
			menu_configuration_features.side_window_width.value = math.floor(stuff.menuData.side_window.width*graphics.get_screen_width())
			menu_configuration_features.side_window_on.on = stuff.menuData.side_window.on ]]
			menu_configuration_features.text_font.value = stuff.menuData.fonts.text
			menu_configuration_features.footer_font.value = stuff.menuData.fonts.footer
			menu_configuration_features.hint_font.value = stuff.menuData.fonts.hint

			menu_configuration_features.hint_font:toggle()

			for k, v in pairs(stuff.menuData.color) do
				if menu_configuration_features[k] then
					if type(v) == "table" then
						menu_configuration_features[k].r.value = v.r
						menu_configuration_features[k].g.value = v.g
						menu_configuration_features[k].b.value = v.b
						menu_configuration_features[k].a.value = v.a
					else
						menu_configuration_features[k].r.value = cheeseUtils.convert_int_to_rgba(v, "r")
						menu_configuration_features[k].g.value = cheeseUtils.convert_int_to_rgba(v, "g")
						menu_configuration_features[k].b.value = cheeseUtils.convert_int_to_rgba(v, "b")
						menu_configuration_features[k].a.value = cheeseUtils.convert_int_to_rgba(v, "a")
					end
				end
			end

			for k, v in pairs(menu_configuration_features.headerfeat.str_data) do
				if v == stuff.menuData.header then
					menu_configuration_features.headerfeat.value = k - 1
				end
			end

			if uiTable.background_sprite then
				for k, v in pairs(menu_configuration_features.backgroundfeat.str_data) do
					if v == uiTable.background_sprite.sprite then
						menu_configuration_features.backgroundfeat.value = k - 1
					end
				end
			end
		end
	end

	stuff.drawFeatParams = {
		rectPos = v2(stuff.menuData.pos_x, stuff.menuData.pos_y - stuff.menuData.feature_offset/2 + stuff.menuData.border),
		textOffset = v2(stuff.menuData.feature_scale.x/2, -0.0055555555),
		colorText = stuff.menuData.color.text,
		textSize = 0,
	}
	function func.draw_feat(k, v, offset, hiddenOffset)
		--[[ stuff.drawFeatParams.rectPos.x = stuff.menuData.pos_x
		stuff.drawFeatParams.rectPos.y = stuff.menuData.pos_y - stuff.menuData.feature_offset/2 + stuff.menuData.border
		stuff.drawFeatParams.textOffset.x = stuff.menuData.feature_scale.x/2
		stuff.drawFeatParams.textSize = textSize ]]
		stuff.drawFeatParams.colorText = stuff.menuData.color.text
		stuff.drawFeatParams.bottomLeft = stuff.menuData.color.feature_bottomLeft
		stuff.drawFeatParams.topLeft = stuff.menuData.color.feature_topLeft
		stuff.drawFeatParams.topRight = stuff.menuData.color.feature_topRight
		stuff.drawFeatParams.bottomRight = stuff.menuData.color.feature_bottomRight
		local posY = (stuff.drawFeatParams.rectPos.y + (stuff.menuData.feature_offset * k))*-2+1

		local is_selected
		if stuff.scroll == k + stuff.drawScroll then
			stuff.scrollHiddenOffset = hiddenOffset or stuff.scrollHiddenOffset
			stuff.drawFeatParams.colorText = stuff.menuData.color.text_selected
			stuff.drawFeatParams.bottomLeft = stuff.menuData.color.feature_selected_bottomLeft
			stuff.drawFeatParams.topLeft = stuff.menuData.color.feature_selected_topLeft
			stuff.drawFeatParams.topRight = stuff.menuData.color.feature_selected_topRight
			stuff.drawFeatParams.bottomRight = stuff.menuData.color.feature_selected_bottomRight
			is_selected = true
		end
		if offset == 0 then
			local memv2 = cheeseUtils.memoize.v2
			local posX = stuff.drawFeatParams.rectPos.x*2-1
			--[[ scriptdraw.draw_rect(
				cheeseUtils.memoize.v2(posX, posY),
				cheeseUtils.memoize.v2(stuff.menuData.feature_scale.x*2, stuff.menuData.feature_scale.y*2),
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.colorFeature.r, stuff.drawFeatParams.colorFeature.g, stuff.drawFeatParams.colorFeature.b, stuff.drawFeatParams.colorFeature.a)
			) ]]
			local Left = posX - stuff.menuData.feature_scale.x
			local Right = posX + stuff.menuData.feature_scale.x
			local Top = posY + stuff.menuData.feature_scale.y
			local Bottom = posY - stuff.menuData.feature_scale.y
			scriptdraw.draw_rect_ext(
				memv2(Left, Bottom),
				memv2(Left, Top),
				memv2(Right, Top),
				memv2(Right, Bottom),
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.bottomLeft.r, stuff.drawFeatParams.bottomLeft.g, stuff.drawFeatParams.bottomLeft.b, stuff.drawFeatParams.bottomLeft.a),
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.topLeft.r, stuff.drawFeatParams.topLeft.g, stuff.drawFeatParams.topLeft.b, stuff.drawFeatParams.topLeft.a),
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.topRight.r, stuff.drawFeatParams.topRight.g, stuff.drawFeatParams.topRight.b, stuff.drawFeatParams.topRight.a),
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.bottomRight.r, stuff.drawFeatParams.bottomRight.g, stuff.drawFeatParams.bottomRight.b, stuff.drawFeatParams.bottomRight.a)
			)
		end

		local font = stuff.menuData.fonts.text
		if v.type & 1 == 0 then
			scriptdraw.draw_text(
				v["name"],
				cheeseUtils.memoize.v2((stuff.drawFeatParams.rectPos.x - (stuff.drawFeatParams.textOffset.x - stuff.menuData.padding.name))*2-1, (stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.menuData.feature_offset * k))*-2+1),
				cheeseUtils.memoize.v2(10, 10),
				stuff.drawFeatParams.textSize,
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.colorText.r, stuff.drawFeatParams.colorText.g, stuff.drawFeatParams.colorText.b, stuff.drawFeatParams.colorText.a),
				0, font
			)
			if v.type >> 11 & 1 ~= 0 then
				scriptdraw.draw_text(
					">>",
					cheeseUtils.memoize.v2((stuff.drawFeatParams.rectPos.x + (stuff.drawFeatParams.textOffset.x - stuff.menuData.padding.parent))*2-1, (stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.menuData.feature_offset * k))*-2+1),
					cheeseUtils.memoize.v2(10, 10),
					stuff.drawFeatParams.textSize,
					cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.colorText.r, stuff.drawFeatParams.colorText.g, stuff.drawFeatParams.colorText.b, stuff.drawFeatParams.colorText.a),
					16, font
				)
			end
		elseif v.type & 1 ~= 0 then -- toggle
			cheeseUtils.draw_outline(
				cheeseUtils.memoize.v2((stuff.drawFeatParams.rectPos.x - (stuff.drawFeatParams.textOffset.x - stuff.menuData.padding.name) + 0.00390625)*2-1, posY),
				cheeseUtils.memoize.v2(0.015625, 0.0277777777778),
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.colorText.r, stuff.drawFeatParams.colorText.g, stuff.drawFeatParams.colorText.b, stuff.drawFeatParams.colorText.a),
				2
			)
			if v.real_on then
				scriptdraw.draw_rect(
					cheeseUtils.memoize.v2((stuff.drawFeatParams.rectPos.x - (stuff.drawFeatParams.textOffset.x - stuff.menuData.padding.name) + 0.00390625)*2-1, posY),
					cheeseUtils.memoize.v2(0.0140625, 0.025),
					cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.colorText.r, stuff.drawFeatParams.colorText.g, stuff.drawFeatParams.colorText.b, stuff.drawFeatParams.colorText.a)
				)
			end

			scriptdraw.draw_text(
				v.name,
				cheeseUtils.memoize.v2((stuff.drawFeatParams.rectPos.x - (stuff.drawFeatParams.textOffset.x - stuff.menuData.padding.name) + 0.011328125)*2-1, (stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.menuData.feature_offset * k))*-2+1),
				cheeseUtils.memoize.v2(10, 10),
				stuff.drawFeatParams.textSize,
				cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.colorText.r, stuff.drawFeatParams.colorText.g, stuff.drawFeatParams.colorText.b, stuff.drawFeatParams.colorText.a),
				0, font
			)
		end

		if v.type >> 1 & 1 ~= 0 then -- value_i_f_str
			local rounded_value = v.str_data and v.str_data[v.real_value + 1] or v.real_value
			if v.type >> 7 & 1 ~= 0 or v.type >> 2 & 1 ~= 0 then
				rounded_value = (rounded_value * 10000) + 0.5
				rounded_value = math.floor(rounded_value)
				rounded_value = rounded_value / 10000
			end
			if v.type >> 2 & 1 ~= 0 then
				cheeseUtils.draw_slider(
					cheeseUtils.memoize.v2(
						(stuff.drawFeatParams.rectPos.x + stuff.menuData.feature_scale.x/2 - stuff.menuData.slider.width/4 - stuff.menuData.padding.slider)*2-1,
						posY
					),
					cheeseUtils.memoize.v2(stuff.menuData.slider.width, is_selected and stuff.menuData.slider.heightActive or stuff.menuData.slider.height),
					v.min, v.max, v.value,
					is_selected and cheeseUtils.convert_rgba_to_int(stuff.menuData.color.slider_selectedBackground) or cheeseUtils.convert_rgba_to_int(stuff.menuData.color.slider_background),
					is_selected and cheeseUtils.convert_rgba_to_int(stuff.menuData.color.slider_selectedActive) or cheeseUtils.convert_rgba_to_int(stuff.menuData.color.slider_active),
					is_selected and cheeseUtils.convert_rgba_to_int(stuff.menuData.color.slider_text) or 0,
					is_selected)
			else
				local value_str = "< "..tostring(rounded_value).." >"
				if v.str_data then
					local pixel_size = scriptdraw.get_text_size(value_str, 1, font).x
					local screenWidth = graphics.get_screen_width()
					if pixel_size/screenWidth > 370/screenWidth then
						local original_size = stuff.drawFeatParams.textSize
						stuff.drawFeatParams.textSize = stuff.drawFeatParams.textSize * (370 / pixel_size * 0.8)
						stuff.drawFeatParams.textSize = math.min(stuff.drawFeatParams.textSize + 0.2, original_size)
					end
				end

				scriptdraw.draw_text(
					value_str,
					cheeseUtils.memoize.v2((stuff.drawFeatParams.rectPos.x + (stuff.drawFeatParams.textOffset.x - stuff.menuData.padding.value) - scriptdraw.size_pixel_to_rel_x(scriptdraw.get_text_size(value_str, stuff.drawFeatParams.textSize, font).x)/4)*2-1, (stuff.drawFeatParams.rectPos.y + stuff.drawFeatParams.textOffset.y + (stuff.menuData.feature_offset * k))*-2+1),
					cheeseUtils.memoize.v2(10, 10),
					stuff.drawFeatParams.textSize,
					cheeseUtils.convert_rgba_to_int(stuff.drawFeatParams.colorText.r, stuff.drawFeatParams.colorText.g, stuff.drawFeatParams.colorText.b, stuff.drawFeatParams.colorText.a),
					0, font
				)
			end
		end
	end

	stuff.draw_current_menu = {frameCounter = 1, time = utils.time_ms() + 33, currentSprite = stuff.menuData.header}
	function func.draw_current_menu()
		local sprite = func.load_sprite(stuff.path.header..(stuff.menuData.header or ""))
		if stuff.draw_current_menu.currentSprite ~= stuff.menuData.header then
			stuff.draw_current_menu.currentSprite = stuff.menuData.header
			stuff.draw_current_menu.time = 0
			stuff.draw_current_menu.frameCounter = 1
			if type(sprite) == "table" then
				stuff.draw_current_menu.time = utils.time_ms() + (sprite[stuff.draw_current_menu.frameCounter].delay or sprite.constant_delay or 33)
			end
		end
		stuff.drawHiddenOffset = 0
		for k, v in pairs(currentMenu) do
			if type(k) == "number" then
				if v.hidden or (v.type >> 11 & 1 ~= 0 and not v.on) then
					stuff.drawHiddenOffset = stuff.drawHiddenOffset + 1
				end
			end
		end
		local background_sprite_path = stuff.path.background..(stuff.menuData.background_sprite.sprite or "")
		if stuff.menuData.background_sprite.sprite and func.load_sprite(background_sprite_path) then
			scriptdraw.draw_sprite(
				func.load_sprite(background_sprite_path),
				cheeseUtils.memoize.v2((stuff.menuData.pos_x + stuff.menuData.background_sprite.offset.x)*2-1, (stuff.menuData.pos_y+stuff.menuData.background_sprite.offset.y+stuff.menuData.height/2+0.01458)*-2+1),
				stuff.menuData.background_sprite.size,
				0,
				cheeseUtils.convert_rgba_to_int(255, 255, 255, stuff.menuData.color.background.a)
			)
		else
			scriptdraw.draw_rect(
				cheeseUtils.memoize.v2(stuff.menuData.pos_x*2-1, (stuff.menuData.pos_y+stuff.menuData.border+stuff.menuData.height/2)*-2+1),
				cheeseUtils.memoize.v2(stuff.menuData.width*2, stuff.menuData.height*2),
				cheeseUtils.convert_rgba_to_int(stuff.menuData.color.background.r, stuff.menuData.color.background.g, stuff.menuData.color.background.b, stuff.menuData.color.background.a)
			)
		end
		if #currentMenu - stuff.drawHiddenOffset >= stuff.menuData.max_features  then
			stuff.maxDrawScroll = #currentMenu - stuff.drawHiddenOffset - stuff.menuData.max_features
		else
			stuff.maxDrawScroll = 0
		end
		if stuff.drawScroll > stuff.maxDrawScroll then
			stuff.drawScroll = stuff.maxDrawScroll
		end
		if stuff.scroll > #currentMenu - stuff.drawHiddenOffset then
			stuff.scroll = #currentMenu - stuff.drawHiddenOffset
		elseif stuff.scroll < 1 and #currentMenu > 0 then
			stuff.scroll = 1
		end

		-- header border
		scriptdraw.draw_rect(cheeseUtils.memoize.v2(stuff.menuData.pos_x*2-1, (stuff.menuData.pos_y + stuff.menuData.border/2)*-2+1), cheeseUtils.memoize.v2(stuff.menuData.width*2, stuff.menuData.border*2), cheeseUtils.convert_rgba_to_int(stuff.menuData.color.border.r, stuff.menuData.color.border.g, stuff.menuData.color.border.b, stuff.menuData.color.border.a))

		local hiddenOffset = 0
		local drawnfeats = 0
		stuff.menuData.text_size = (((graphics.get_screen_width()*graphics.get_screen_height())/3686400)*0.45+0.25) -- * stuff.menuData.text_size_modifier

		stuff.drawFeatParams.rectPos.x = stuff.menuData.pos_x
		stuff.drawFeatParams.rectPos.y = stuff.menuData.pos_y - stuff.menuData.feature_offset/2 + stuff.menuData.border
		stuff.drawFeatParams.textOffset.x = stuff.menuData.feature_scale.x/2
		stuff.drawFeatParams.colorText = stuff.menuData.color.text
		stuff.drawFeatParams.colorFeature = stuff.menuData.color.feature
		stuff.drawFeatParams.textSize = stuff.menuData.text_size * stuff.menuData.text_size_modifier

		for k, v in ipairs(currentMenu) do
			if type(k) == "number" then
				if v.hidden or (v.type >> 11 & 1 ~= 0 and not v.on) then
					hiddenOffset = hiddenOffset + 1
				elseif k <= stuff.drawScroll + hiddenOffset + stuff.menuData.max_features and k >= stuff.drawScroll + hiddenOffset + 1 then
					func.draw_feat(k - stuff.drawScroll - hiddenOffset, v, 0, hiddenOffset)
					drawnfeats = drawnfeats + 1
				end
			end
		end

		if stuff.menuData.footer.draw_footer then
			-- footer border
			local footer_border_y_pos
			if stuff.menuData.footer.footer_pos_related_to_background then
				footer_border_y_pos = (stuff.menuData.pos_y + stuff.menuData.height + stuff.menuData.border*1.5)*-2+1
			else
				footer_border_y_pos = (stuff.menuData.pos_y + (drawnfeats*stuff.menuData.feature_offset) + stuff.menuData.border*1.5)*-2+1
			end
			scriptdraw.draw_rect(cheeseUtils.memoize.v2(stuff.menuData.pos_x*2-1, footer_border_y_pos), cheeseUtils.memoize.v2(stuff.menuData.width*2, stuff.menuData.border*2), cheeseUtils.convert_rgba_to_int(stuff.menuData.color.border.r, stuff.menuData.color.border.g, stuff.menuData.color.border.b, stuff.menuData.color.border.a))

			-- footer and text/scroll
			local footerColor = cheeseUtils.convert_rgba_to_int(stuff.menuData.color.footer.r, stuff.menuData.color.footer.g, stuff.menuData.color.footer.b, stuff.menuData.color.footer.a)
			local footer_y_pos
			if stuff.menuData.footer.footer_pos_related_to_background then
				footer_y_pos = (stuff.menuData.pos_y + stuff.menuData.height + stuff.menuData.border*2 + stuff.menuData.footer.footer_size/2)*-2+1
			else
				footer_y_pos = (stuff.menuData.pos_y + (drawnfeats*stuff.menuData.feature_offset) + stuff.menuData.border*2 + stuff.menuData.footer.footer_size/2)*-2+1
			end
			scriptdraw.draw_rect(cheeseUtils.memoize.v2(stuff.menuData.pos_x*2-1, footer_y_pos), cheeseUtils.memoize.v2(stuff.menuData.width*2, stuff.menuData.footer.footer_size*2), footerColor)

			local footerTextColor = cheeseUtils.convert_rgba_to_int(stuff.menuData.color.footer_text.r, stuff.menuData.color.footer_text.g, stuff.menuData.color.footer_text.b, stuff.menuData.color.footer_text.a)
			local feat = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
			local featHint = feat and (feat.type >> 15 & 1 ~= 0 and stuff.player_feature_hints[feat.id] or stuff.feature_hints[feat.id])
			if featHint then
				local padding = scriptdraw.size_pixel_to_rel_y(5)
				local hintStrSize = scriptdraw.size_pixel_to_rel_y(featHint.size.y) * (stuff.menuData.text_size * stuff.menuData.hint_size_modifier)
				local posY = footer_y_pos - stuff.menuData.border*2 - stuff.menuData.footer.footer_size - padding
				local textY = posY - padding
				posY = posY - hintStrSize/2

				local rectHeight = hintStrSize+padding*4
				--scriptdraw.draw_rect(cheeseUtils.memoize.v2(stuff.menuData.pos_x*2-1, posY+rectHalfHeight/2), cheeseUtils.memoize.v2(stuff.menuData.width*2, rectHalfHeight), cheeseUtils.convert_rgba_to_int(stuff.menuData.color.footer.r, stuff.menuData.color.footer.g, stuff.menuData.color.footer.b, stuff.menuData.color.footer.a))
				cheeseUtils.draw_rect_ext_wh(cheeseUtils.memoize.v2(stuff.menuData.pos_x*2-1, posY-padding), cheeseUtils.memoize.v2(stuff.menuData.width*2, rectHeight), (footerColor & 0xffffff) | 50 << 24, footerColor, footerColor, (footerColor & 0xffffff) | 50 << 24)
				scriptdraw.draw_text(
					featHint.str,
					cheeseUtils.memoize.v2(stuff.menuData.pos_x*2-1 - stuff.menuData.width + padding, textY),
					cheeseUtils.memoize.v2(stuff.menuData.width+padding*2, 2),
					stuff.menuData.text_size * stuff.menuData.hint_size_modifier,
					footerTextColor,
					0,
					stuff.menuData.fonts.hint
				)
			end

			local footer_size = stuff.menuData.text_size * stuff.menuData.footer_size_modifier
			local text_y_pos = footer_y_pos + 0.011111111 + stuff.menuData.footer.footer_y_offset
			scriptdraw.draw_text(
				tostring(version),
				cheeseUtils.memoize.v2((stuff.menuData.pos_x - stuff.menuData.width/2 + stuff.menuData.footer.padding)*2-1, text_y_pos),
				cheeseUtils.memoize.v2(2, 2),
				footer_size,
				footerTextColor,
				0,
				stuff.menuData.fonts.footer
			)

			scriptdraw.draw_text(
				tostring(stuff.scroll.." / "..(#currentMenu - stuff.drawHiddenOffset)),
				cheeseUtils.memoize.v2((stuff.menuData.pos_x + stuff.menuData.width/2 - stuff.menuData.footer.padding)*2-1, text_y_pos),
				cheeseUtils.memoize.v2(2, 2),
				footer_size,
				footerTextColor,
				16,
				stuff.menuData.fonts.footer
			)
		end

		if type(sprite) == "table" then
			if not sprite[stuff.draw_current_menu.frameCounter] then
				stuff.draw_current_menu.frameCounter = 1
			end
			if utils.time_ms() > stuff.draw_current_menu.time then
				if stuff.draw_current_menu.frameCounter < #sprite then
					stuff.draw_current_menu.frameCounter = stuff.draw_current_menu.frameCounter + 1
				else
					stuff.draw_current_menu.frameCounter = 1
				end
				stuff.draw_current_menu.time = utils.time_ms() + (sprite[stuff.draw_current_menu.frameCounter].delay or sprite.constant_delay or 33)
			end
			sprite = sprite[stuff.draw_current_menu.frameCounter].sprite
		end
		if sprite then
			local size = ((2.56 * stuff.menuData.width) * (1000 / scriptdraw.get_sprite_size(sprite).x)) / (2560 / graphics.get_screen_width())
			scriptdraw.draw_sprite(sprite, cheeseUtils.memoize.v2(stuff.menuData.pos_x * 2 - 1, ((stuff.menuData.pos_y+stuff.menuData.height/2) - (stuff.menuData.height/2 + ((scriptdraw.get_sprite_size(sprite).y*size)/2)/graphics.get_screen_height()))*-2+1), size, 0, stuff.menuData.color.sprite)
		end
		system.wait(0)
	end

	--[[
		example of table_of_lines:
		{
			{"leftside", "rightside"},
			{"IP", "ddosing u rn"},
			{"Cheesus", "Christ"}
		}
		has to be in this structure, you can add more than three
	]]
	function func.draw_side_window(header_text, table_of_lines, v2pos, rect_color, rect_width, text_spacing, text_padding, text_color)
		text_color = text_color or 0xFFFFFFFF
		assert(
			type(header_text) == "string"
			and type(table_of_lines) == "table"
			and type(v2pos) == "userdata"
			and type(rect_color) == "number"
			and type(rect_width) == "number"
			and type(text_spacing) == "number"
			and type(text_padding) == "number"
			and type(text_color) == "number",
			"one or more draw_side_window args were invalid"
		)
		local rect_height = #table_of_lines*text_spacing+0.07125
		v2pos.y = v2pos.y-(rect_height/2)


		scriptdraw.draw_rect(v2pos, cheeseUtils.memoize.v2(rect_width, rect_height), rect_color)

		local text_size = graphics.get_screen_width()*graphics.get_screen_height()/3686400*0.75+0.25
		-- Header text
		scriptdraw.draw_text(header_text, cheeseUtils.memoize.v2(v2pos.x - scriptdraw.get_text_size(header_text, text_size, 0).x/graphics.get_screen_width(), v2pos.y+(rect_height/2)-0.015), cheeseUtils.memoize.v2(2, 2), text_size, text_color, 0, 0)
		-- table_of_lines
		for k, v in ipairs(table_of_lines) do
			v[1] = tostring(v[1])
			v[2] = tostring(v[2])
			local pos_y = v2pos.y-k*text_spacing+rect_height/2-0.03
			scriptdraw.draw_text(v[1], cheeseUtils.memoize.v2(v2pos.x-rect_width/2+text_padding, pos_y), cheeseUtils.memoize.v2(2, 2), text_size, text_color, 0, 2)
			scriptdraw.draw_text(v[2], cheeseUtils.memoize.v2(v2pos.x+rect_width/2-text_padding, pos_y), cheeseUtils.memoize.v2(2, 2), text_size, text_color, 16, 2)
		end
	end

	--Hotkey functions
	function func.get_hotkey(keyTable, vkTable, singlekey)
		local current_key
		local excludedkeys = {}
		while not keyTable[1] do
			if cheeseUtils.get_key(0x1B):is_down() then
				return "escaped"
			end
			for k, v in pairs(stuff.char_codes) do
				if cheeseUtils.get_key(v):is_down() then
					if v ~= 0x0D or singlekey  then
						if v ~= 0xA0 and v ~= 0xA1 and v ~= 0xA2 and v ~= 0xA3 and v ~= 0xA4 and v ~= 0xA5 and not singlekey then
							keyTable[1] = "NOMOD"
						end
						if singlekey then
							return k, v
						else
							keyTable[#keyTable + 1] = k
							vkTable[#vkTable+1] = v
							current_key = v
							excludedkeys[v] = true
						end
					end
				end
			end
			system.wait(0)
		end

		if not singlekey then
			while cheeseUtils.get_key(current_key):is_down() do
				for k, v in pairs(stuff.char_codes) do
					if cheeseUtils.get_key(v):is_down() and not excludedkeys[v] and v ~= 0xA0 and v ~= 0xA1 and v ~= 0xA2 and v ~= 0xA3 and v ~= 0xA4 and v ~= 0xA5 then
						excludedkeys[v] = true
						keyTable[#keyTable + 1] = k
						vkTable[#vkTable+1] = v
					end
				end
				system.wait(0)
			end

			while not cheeseUtils.get_key(0x1B):is_down() and not cheeseUtils.get_key(0x0D):is_down() do
				for k, v in pairs(stuff.char_codes) do
					if cheeseUtils.get_key(v):is_down() then
						return false
					end
				end
				system.wait(0)
			end

			return cheeseUtils.get_key(0x0D):is_down() or "escaped"
		end
	end

	function func.draw_hotkey(keyTable)
		while true do
			for i = 0, 360 do
				controls.disable_control_action(0, i, true)
			end
			local concatenated = table.concat(keyTable, "+")
			scriptdraw.draw_rect(cheeseUtils.memoize.v2(0, 0), cheeseUtils.memoize.v2(2, 2), 0x7D000000)
			scriptdraw.draw_text(concatenated, cheeseUtils.memoize.v2(-(scriptdraw.get_text_size(concatenated, 1, 0).x/graphics.get_screen_width())), cheeseUtils.memoize.v2(2, 2), 1, 0xffffffff, 1 << 1, 0)
			system.wait(0)
		end
	end


	function func.start_hotkey_process(feat)
		stuff.menuData.menuToggle = false
		local keyTable = {}
		local vkTable = {}

		local drawThread = menu.create_thread(func.draw_hotkey, keyTable)

		while cheeseUtils.get_key(stuff.vkcontrols.setHotkey):is_down() do
			system.wait(0)
		end

		local response
		repeat
			response = func.get_hotkey(keyTable, vkTable)
			if not response then
				for k, v in pairs(keyTable) do
					keyTable[k] = nil
				end
				for k, v in pairs(vkTable) do
					vkTable[k] = nil
				end
			end
		until response

		local keyString = table.concat(keyTable, "|")

		if response ~= "escaped" then
			stuff.hotkeys_to_vk[keyString] = vkTable
			if not stuff.hotkeys[keyString] then
				stuff.hotkeys[keyString] = {}
			end
			stuff.hotkeys[keyString][feat.hierarchy_key] = true
			feat.hotkey = keyString
			gltw.write(stuff.hotkeys, "hotkeys", stuff.path.hotkeys, nil, true)
		end

		menu.delete_thread(drawThread)
		while cheeseUtils.get_key(0x0D):is_down() or cheeseUtils.get_key(0x1B):is_down() do -- enter and esc
			controls.disable_control_action(0, 200, true)
			system.wait(0)
		end
		controls.disable_control_action(0, 200, true)
		func.toggle_menu(true)
		return response ~= "escaped" and response
	end

	--End of functions

	--threads
	menu.create_thread(function()
		local side_window_pos = v2((stuff.menuData.pos_x + stuff.menuData.width + stuff.menuData.side_window.offset.x)*2-1, (stuff.menuData.pos_y + stuff.menuData.side_window.offset.y)*-2+1)
		while true do
			if stuff.menuData.menuToggle then
				func.draw_current_menu()
				if currentMenu and stuff.menuData.side_window.on then
					local pid = currentMenu.pid
					if not pid and currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
						pid = currentMenu[stuff.scroll + stuff.scrollHiddenOffset].pid
					end
					if pid and pid ~= stuff.pid then
						if not stuff.playerIds[pid].hidden then
							stuff.player_info[1][2] = tostring(pid)
							stuff.player_info[10][2] = func.convert_int_ip(player.get_player_ip(pid))
							stuff.player_info[11][2] = tostring(player.get_player_scid(pid))
							stuff.player_info[13][2] = string.format("%X", player.get_player_host_token(pid))
							stuff.player_info.max_health = "/"..math.floor(player.get_player_max_health(pid))
							stuff.player_info.name = tostring(player.get_player_name(pid))
							stuff.pid = pid
						end
					end
					if pid then
						side_window_pos.x, side_window_pos.y = (stuff.menuData.pos_x + stuff.menuData.width + stuff.menuData.side_window.offset.x)*2-1, (stuff.menuData.pos_y + stuff.menuData.side_window.offset.y)*-2+1
						native.call(0xBE8CD9BE829BBEBF, player.get_player_ped(stuff.pid), stuff.proofs.bulletProof, stuff.proofs.fireProof, stuff.proofs.explosionProof, stuff.proofs.collisionProof, stuff.proofs.meleeProof, stuff.proofs.steamProof, stuff.proofs.p7, stuff.proofs.drownProof)
						stuff.player_info[2][2] = player.is_player_god(stuff.pid) and "Yes" or "No"
						stuff.player_info[3][2] = (stuff.proofs.bulletProof:__tointeger()|stuff.proofs.fireProof:__tointeger()|stuff.proofs.explosionProof:__tointeger()|stuff.proofs.collisionProof:__tointeger()|stuff.proofs.meleeProof:__tointeger()|stuff.proofs.steamProof:__tointeger()|stuff.proofs.p7:__tointeger()|stuff.proofs.drownProof:__tointeger()) == 1 and "Yes" or "No"
						stuff.player_info[4][2] = player.is_player_vehicle_god(stuff.pid) and "Yes" or "No"
						stuff.player_info[5][2] = player.is_player_modder(stuff.pid, -1) and "Yes" or "No"
						stuff.player_info[6][2] = player.is_player_host(stuff.pid) and "Yes" or "No"
						stuff.player_info[7][2] = player.get_player_wanted_level(stuff.pid)
						stuff.player_info[8][2] = math.floor(player.get_player_health(stuff.pid))..stuff.player_info.max_health
						stuff.player_info[9][2] = math.floor(player.get_player_armour(stuff.pid)).."/50"
						stuff.player_info[12][2] = player.get_modder_flag_text(player.get_player_modder_flags(stuff.pid))
						stuff.player_info[14][2] = player.get_player_host_priority(stuff.pid)
						func.draw_side_window(
							stuff.player_info.name,
							stuff.player_info,
							side_window_pos,
							cheeseUtils.convert_rgba_to_int(stuff.menuData.color.side_window_background.r, stuff.menuData.color.side_window_background.g, stuff.menuData.color.side_window_background.b, stuff.menuData.color.side_window_background.a),
							stuff.menuData.side_window.width, stuff.menuData.side_window.spacing, stuff.menuData.side_window.padding,
							cheeseUtils.convert_rgba_to_int(stuff.menuData.color.side_window_text.r, stuff.menuData.color.side_window_text.g, stuff.menuData.color.side_window_text.b, stuff.menuData.color.side_window_text.a)
						)
					end
				end
				if stuff.old_selected ~= currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
					if type(stuff.old_selected) == "table" then
						stuff.old_selected:activate_hl_func()
					end
					if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
						currentMenu[stuff.scroll + stuff.scrollHiddenOffset]:activate_hl_func()
					end
					stuff.old_selected = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
				end
				controls.disable_control_action(0, 172, true)
				controls.disable_control_action(0, 27, true)
			else
				system.wait(0)
			end
		end
	end, nil)

	menu.create_thread(function()
		while true do
			stuff.menuData.menuNav = native.call(0x5FCF4D7069B09026):__tointeger() ~= 1 and not (stuff.menuData.inputBoxOpen or input.is_open() --[[or console.on]])
			if stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.open, false, function() -- F4
					func.toggle_menu(not stuff.menuData.menuToggle)
				end)
			end
			if currentMenu.hidden or not currentMenu then
				currentMenu = stuff.previousMenus[#stuff.previousMenus].menu
				stuff.scroll = stuff.previousMenus[#stuff.previousMenus].scroll
				stuff.drawScroll = stuff.previousMenus[#stuff.previousMenus].drawScroll
				stuff.scrollHiddenOffset = stuff.previousMenus[#stuff.previousMenus].scrollHiddenOffset
				stuff.previousMenus[#stuff.previousMenus] = nil
			end
			
			local pid = player.player_id()
			stuff.playerIds[pid].name = player.get_player_name(pid).." #DEFAULT#[#FF4DEB4D#Y#DEFAULT#]"
			if stuff.playerIds[pid].hidden then
				stuff.playerIds[pid].hidden = false
				func.reset_player_submenu(pid)
			end

			
			system.wait(0)
		end
	end, nil)

	menu.create_thread(function()
		while true do
			system.wait(0)
			if stuff.menuData.menuToggle and stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.setHotkey, false, function() -- F11
					local feat = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
					if cheeseUtils.get_key(0x10):is_down() and stuff.hotkeys[feat.hotkey] then
						stuff.hotkeys[feat.hotkey][feat.hierarchy_key] = nil
						if not next(stuff.hotkeys[feat.hotkey]) then
							stuff.hotkeys[feat.hotkey] = nil
						end
						feat.hotkey = nil
						gltw.write(stuff.hotkeys, "hotkeys", stuff.path.hotkeys, nil, true)
						menu.notify("Removed "..feat.name.."'s hotkey")
					elseif cheeseUtils.get_key(0x11):is_down() then
						menu.notify(feat.name.."'s hotkey is "..(feat.hotkey or "none"))
					elseif not cheeseUtils.get_key(0x10):is_down() and not cheeseUtils.get_key(0x11):is_down() then
						if stuff.hotkeys[feat.hotkey] then
							stuff.hotkeys[feat.hotkey][feat.hierarchy_key] = nil
						end
						if func.start_hotkey_process(feat) then
							menu.notify("Set "..feat.name.."'s hotkey to "..feat.hotkey)
						end
					end
				end)
			end
		end
	end,nil)
	menu.create_thread(function()
		while true do
			system.wait(0)
			if stuff.menuData.menuToggle and stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.down, true, function() -- downKey
					--[[ local old_scroll = stuff.scroll + stuff.scrollHiddenOffset ]]
					if stuff.scroll + stuff.drawHiddenOffset >= #currentMenu and #currentMenu - stuff.drawHiddenOffset > 1 then
						stuff.scroll = 1
						stuff.drawScroll = 0
					elseif #currentMenu - stuff.drawHiddenOffset > 1 then
						stuff.scroll = stuff.scroll + 1
						if stuff.scroll - stuff.drawScroll >= (stuff.menuData.max_features - 1) and stuff.drawScroll < stuff.maxDrawScroll then
							stuff.drawScroll = stuff.drawScroll + 1
						end
					end
					--[[ if old_scroll ~= (stuff.scroll + stuff.scrollHiddenOffset) then
						currentMenu[old_scroll]:activate_hl_func()
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
							currentMenu[stuff.scroll + stuff.scrollHiddenOffset]:activate_hl_func()
						end
					end ]]
				end)
			end
		end
	end, nil)
	menu.create_thread(function()
		while true do
			system.wait(0)
			if stuff.menuData.menuToggle and stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.up, true, function() -- upKey
					--[[ local old_scroll = stuff.scroll + stuff.scrollHiddenOffset ]]
					if stuff.scroll <= 1 and #currentMenu - stuff.drawHiddenOffset > 1 then
						stuff.scroll = #currentMenu
						stuff.drawScroll = stuff.maxDrawScroll
					elseif #currentMenu - stuff.drawHiddenOffset > 1 then
						stuff.scroll = stuff.scroll - 1
						if stuff.scroll - stuff.drawScroll <= 2 and stuff.drawScroll > 0 then
							stuff.drawScroll = stuff.drawScroll - 1
						end
					end
					--[[ if old_scroll ~= (stuff.scroll + stuff.scrollHiddenOffset) then
						currentMenu[old_scroll]:activate_hl_func()
						if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
							currentMenu[stuff.scroll + stuff.scrollHiddenOffset]:activate_hl_func()
						end
					end ]]
				end)
			end
		end
	end,nil)
	menu.create_thread(function()
		while true do
			system.wait(0)
			if stuff.menuData.menuToggle and stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.select, true, function() --enter
					local feat = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
					if feat then
						if cheeseUtils.get_key(stuff.vkcontrols.specialKey):is_down() and feat.type >> 5 & 1 ~= 0 then
							menu.create_thread(func.selector, feat)
						elseif feat.type >> 11 & 1 ~= 0 and not feat.hidden then
							--feat:activate_hl_func()
							stuff.previousMenus[#stuff.previousMenus + 1] = {menu = currentMenu, scroll = stuff.scroll, drawScroll = stuff.drawScroll, scrollHiddenOffset = stuff.scrollHiddenOffset}
							currentMenu = feat
							currentMenu:activate_feat_func()
							stuff.scroll = 1
							system.wait(0)
							stuff.drawScroll = 0
							stuff.scrollHiddenOffset = 0
							--[[ if feat then
								feat:activate_hl_func()
							end ]]
							while cheeseUtils.get_key(stuff.vkcontrols.select):is_down() do
								system.wait(0)
							end
						elseif feat.type & 1536 ~= 0 and not feat.hidden then
							feat:activate_feat_func()
						elseif feat.type & 1 ~= 0 and not feat.hidden then
							feat.real_on = not feat.real_on
							feat:activate_feat_func()
						end
					else
						system.wait(100)
					end
				end)
			end
		end
	end, nil)
	menu.create_thread(function()
		while true do
			system.wait(0)
			if stuff.menuData.menuToggle and stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.back, false, function() --backspace
					if stuff.previousMenus[#stuff.previousMenus] then
						--[[ if currentMenu[stuff.scroll + stuff.scrollHiddenOffset] then
							currentMenu[stuff.scroll + stuff.scrollHiddenOffset]:activate_hl_func()
						end ]]
						currentMenu = stuff.previousMenus[#stuff.previousMenus].menu
						stuff.scroll = stuff.previousMenus[#stuff.previousMenus].scroll
						stuff.drawScroll = stuff.previousMenus[#stuff.previousMenus].drawScroll
						stuff.scrollHiddenOffset = stuff.previousMenus[#stuff.previousMenus].scrollHiddenOffset
						stuff.previousMenus[#stuff.previousMenus] = nil
						--currentMenu[stuff.scroll + stuff.scrollHiddenOffset]:activate_hl_func()
					end
				end)
			end
		end
	end, nil)
	menu.create_thread(function()
		while true do
			system.wait(0)
			if stuff.menuData.menuToggle and stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.left, true, function() -- left
					local feat = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
					if feat then
						if feat.value then
							if feat.str_data then
								if feat.value <= 0 then
									feat.value = #feat.str_data - 1
								else
									feat.value = feat.value - 1
								end
							else
								if tonumber(feat.value) <= feat.min and feat.type >> 2 & 1 == 0 then
									feat.value = feat.max
								else
									feat.value = tonumber(feat.value) - feat.mod
								end
							end
						end
						if feat.type then
							if feat.type >> 10 & 1 ~= 0 or (feat.type & 3 == 3 and feat.on) then
								feat:activate_feat_func()
							end
						end
					end
				end)
			end
		end
	end, nil)
	menu.create_thread(function()
		while true do
			if stuff.menuData.menuToggle and stuff.menuData.menuNav then
				func.do_key(500, stuff.vkcontrols.right, true, function() -- right
					local feat = currentMenu[stuff.scroll + stuff.scrollHiddenOffset]
					if feat then
						if feat.value then
							if feat.str_data then
								if tonumber(feat.value) >= tonumber(#feat.str_data) - 1 then
									feat.value = 0
								else
									feat.value = feat.value + 1
								end
							else
								if tonumber(feat.value) >= feat.max and feat.type >> 2 & 1 == 0 then
									feat.value = feat.min
								else
									feat.value = tonumber(feat.value) + feat.mod
								end
							end
						end
						if feat.type then
							if feat.type >> 10 & 1 ~= 0 or (feat.type & 3 == 3 and feat.on) then
								feat:activate_feat_func()
							end
						end
					end
				end)
			end
			system.wait(0)
		end
	end, nil)


	--Hotkey thread
	menu.create_thread(function()
		while true do
			if stuff.menuData.menuNav then
				for k, v in pairs(stuff.hotkeys) do
					local hotkey = cheeseUtils.get_key(table.unpack(stuff.hotkeys_to_vk[k]))
					if hotkey:is_down() and (not (cheeseUtils.get_key(0x10):is_down() or cheeseUtils.get_key(0x11):is_down() or cheeseUtils.get_key(0x12):is_down()) or not (k:match("NOMOD"))) and utils.time_ms() > stuff.hotkey_cooldowns[k] then
						for k, v in pairs(stuff.hotkeys[k]) do
							if stuff.hotkey_feature_hierarchy_keys[k] then
								for k, v in pairs(stuff.hotkey_feature_hierarchy_keys[k]) do
									if v.type & 1 ~= 0 then
										v.on = not v.on
										if stuff.hotkey_notifications.toggle then
											menu.notify("Turned "..v.name.." "..(v.on and "on" or "off"), "Rimurus Menu", 3, cheeseUtils.convert_rgba_to_int(stuff.menuData.color.notifications.r, stuff.menuData.color.notifications.g, stuff.menuData.color.notifications.b, stuff.menuData.color.notifications.a))
										end
									else
										v:activate_feat_func()
										if stuff.hotkey_notifications.action then
											menu.notify("Activated "..v.name, "Rimurus Menu", 3, cheeseUtils.convert_rgba_to_int(stuff.menuData.color.notifications.r, stuff.menuData.color.notifications.g, stuff.menuData.color.notifications.b, stuff.menuData.color.notifications.a))
										end
									end
								end
							end
						end
						if stuff.hotkey_cooldowns[k] == 0 then
							stuff.hotkey_cooldowns[k] = utils.time_ms() + 500
						else
							stuff.hotkey_cooldowns[k] = utils.time_ms() + 100
						end
					elseif not hotkey:is_down() then
						stuff.hotkey_cooldowns[k] = 0
					end
				end
			end
			system.wait(0)
		end
	end, nil)
	--End of threads

	local downloadedModules = {}

	local function downloadModule(moduleName, moduleLink)
		if downloadedModules[moduleName] then
			return
		end
		
		local responseCode, list = web.get(moduleLink)
		
		if responseCode == 200 then
			local file = io.open(stuff.path.scripts.."Rimuru\\libs\\modules\\"..moduleName..".lua", "wb")
			file:write(""..list)
			file:close()
			downloadedModules[moduleName] = true
		end
	end
	
	-- parents 
	menu_configuration_features = {}
	menu_configuration_features.PlayerParent = func.add_feature("Self", "parent")
    menu_configuration_features.WeaponParent = func.add_feature("Weapon", "parent")
    menu_configuration_features.VehicleParent = func.add_feature("Vehicle", "parent")
    menu_configuration_features.OnlineParent = func.add_feature("Online", "parent")
	func.set_player_feat_parent("Online Players", menu_configuration_features.OnlineParent.id)
	local lobbyOpt = func.add_feature("All Players", "parent", menu_configuration_features.OnlineParent.id)
	
	local hostO = func.add_feature(translations.onlineSub.host, "parent", menu_configuration_features.OnlineParent.id)
	local walletOpt = func.add_feature(translations.onlineSub.mmanager, "parent", menu_configuration_features.OnlineParent.id)
	local recoverytOpt = func.add_feature(translations.onlineSub.recovery, "parent", menu_configuration_features.OnlineParent.id)
	local reactionOpt = func.add_feature(translations.onlineSub.reactions, "parent", menu_configuration_features.OnlineParent.id)
	local friendOpt = func.add_feature(translations.onlineSub.friends, "parent", menu_configuration_features.OnlineParent.id)
	local phoneRequests = func.add_feature(translations.onlineSub.requests, "parent", menu_configuration_features.OnlineParent.id)
    
	menu_configuration_features.MiscellaniousParent = func.add_feature("Miscellanious", "parent", 0)
    menu_configuration_features.WorldParent = func.add_feature("World", "parent", 0)
    menu_configuration_features.SpawnerParent = func.add_feature("Spawner", "parent", menu_configuration_features.WorldParent.id)
    --local modulesParent = func.add_feature("Script Repository", "parent", 0, function(f)
    --    if not menu.is_trusted_mode_enabled(eTrustedFlags.LUA_TRUST_HTTP) then
    --        menu.notify("Scripts could not be loaded due to HTTP trusted being disabled", "Rimurus Menu", 5, 0xFF0000EE)
    --    end 
    --end)

	require("Rimuru.libs.embedScripts")
	moduleFeaturesParent = func.add_feature("Script Features", "parent", 0)
	modulePlayerFeaturesParent = func.add_player_feature("Script Features", "parent", 0)

    menu_configuration_features.cheesemenuparent = func.add_feature("Settings", "parent")
	---

	func.add_feature("Save Settings", "action", menu_configuration_features.cheesemenuparent.id, function()
		func.save_settings()
		menu.notify("Settings Saved Successfully", "Rimurus Menu", 6, 0x00ff00)
	end)

	--func.add_feature("save translation file", "action", 0, function()
	--	gltw.write(translations, "ghostTranslate")
	--end)

	func.add_feature("Save UI", "action", menu_configuration_features.cheesemenuparent.id, function()
		local status, name = input.get("name of ui", "", 25, 0)
		if status == 0 then
			func.save_ui(name)
			menu.notify("UI Saved Successfully", "Rimurus Menu", 6, 0x00ff00)
			for _, v in pairs(stuff.menuData.files.ui) do
				if v == name then
					return
				end
			end
			stuff.menuData.files.ui[#stuff.menuData.files.ui+1] = name
			menu_configuration_features.load_ui:set_str_data(stuff.menuData.files.ui)
		end
	end)

	menu_configuration_features.load_ui = func.add_feature("Load UI", "action_value_str", menu_configuration_features.cheesemenuparent.id, function(f)
		func.load_ui(f.str_data[f.value + 1])
	end)
	menu_configuration_features.load_ui:set_str_data(stuff.menuData.files.ui)

	menu_configuration_features.menuXfeat = func.add_feature("Menu pos X", "autoaction_value_i", menu_configuration_features.cheesemenuparent.id, function(f)
		if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
			local stat, num = input.get("num", "", 10, 3)
			if stat == 0 and tonumber(num) then
				stuff.menuData.pos_x = num/graphics.get_screen_height()
				f.value = num
			end
		end
		stuff.menuData.pos_x = f.value/graphics.get_screen_width()
	end)
	menu_configuration_features.menuXfeat.max = graphics.get_screen_width()
	menu_configuration_features.menuXfeat.mod = 1
	menu_configuration_features.menuXfeat.min = -graphics.get_screen_width()
	menu_configuration_features.menuXfeat.value = math.floor(stuff.menuData.pos_x*graphics.get_screen_width())

	menu_configuration_features.menuYfeat = func.add_feature("Menu pos Y", "autoaction_value_i", menu_configuration_features.cheesemenuparent.id, function(f)
		if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
			local stat, num = input.get("num", "", 10, 3)
			if stat == 0 and tonumber(num) then
				stuff.menuData.pos_y = num/graphics.get_screen_height()
				f.value = num
			end
		end
		stuff.menuData.pos_y = f.value/graphics.get_screen_height()
	end)
	menu_configuration_features.menuYfeat.max = graphics.get_screen_height()
	menu_configuration_features.menuYfeat.mod = 1
	menu_configuration_features.menuYfeat.min = -graphics.get_screen_height()
	menu_configuration_features.menuYfeat.value = math.floor(stuff.menuData.pos_y*graphics.get_screen_height())

	menu_configuration_features.headerfeat = func.add_feature("Header", "autoaction_value_str", menu_configuration_features.cheesemenuparent.id, function(f)
		if f.str_data[f.value + 1] == "NONE" then
			stuff.menuData.header = nil
		else
			stuff.menuData.header = f.str_data[f.value + 1]
		end
	end)
	menu_configuration_features.headerfeat:set_str_data({"NONE", table.unpack(stuff.menuData.files.headers)})

	menu_configuration_features.layoutParent = func.add_feature("Layout", "parent", menu_configuration_features.cheesemenuparent.id)

	menu_configuration_features.maxfeats = func.add_feature("Max features", "autoaction_value_i", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData:set_max_features(f.value)
	end)
	menu_configuration_features.maxfeats.max = 50
	menu_configuration_features.maxfeats.mod = 1
	menu_configuration_features.maxfeats.min = 1
	menu_configuration_features.maxfeats.value = math.floor(stuff.menuData.max_features)

	menu_configuration_features.menuWidth = func.add_feature("Menu width", "autoaction_value_i", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.width = f.value/graphics.get_screen_width()
	end)
	menu_configuration_features.menuWidth.max = graphics.get_screen_width()
	menu_configuration_features.menuWidth.mod = 1
	menu_configuration_features.menuWidth.min = -graphics.get_screen_width()
	menu_configuration_features.menuWidth.value = math.floor(stuff.menuData.width*graphics.get_screen_width())

	menu_configuration_features.featXfeat = func.add_feature("Feature dimensions X", "autoaction_value_i", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.feature_scale.x = f.value/graphics.get_screen_width()
	end)
	menu_configuration_features.featXfeat.max = graphics.get_screen_width()
	menu_configuration_features.featXfeat.mod = 1
	menu_configuration_features.featXfeat.min = -graphics.get_screen_width()
	menu_configuration_features.featXfeat.value = math.floor(stuff.menuData.feature_scale.x*graphics.get_screen_width())

	menu_configuration_features.featYfeat = func.add_feature("Feature dimensions Y", "autoaction_value_i", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.feature_scale.y = f.value/graphics.get_screen_height()
	end)
	menu_configuration_features.featYfeat.max = graphics.get_screen_height()
	menu_configuration_features.featYfeat.mod = 1
	menu_configuration_features.featYfeat.min = -graphics.get_screen_height()
	menu_configuration_features.featYfeat.value = math.floor(stuff.menuData.feature_scale.y*graphics.get_screen_height())

	menu_configuration_features.feature_offset = func.add_feature("Feature spacing", "autoaction_value_i", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.feature_offset = f.value/graphics.get_screen_height()
		menu_configuration_features.maxfeats:toggle()
	end)
	menu_configuration_features.feature_offset.max = graphics.get_screen_height()
	menu_configuration_features.feature_offset.mod = 1
	menu_configuration_features.feature_offset.min = -graphics.get_screen_height()
	menu_configuration_features.feature_offset.value = math.floor(stuff.menuData.feature_offset*graphics.get_screen_height())

	menu_configuration_features.text_size = func.add_feature("Text Size", "autoaction_value_f", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.text_size_modifier = f.value
	end)
	menu_configuration_features.text_size.max = 5
	menu_configuration_features.text_size.mod = 0.01
	menu_configuration_features.text_size.min = 0.1
	menu_configuration_features.text_size.value = stuff.menuData.text_size_modifier

	menu_configuration_features.footer_size = func.add_feature("Footer Text Size", "autoaction_value_f", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.footer_size_modifier = f.value
	end)
	menu_configuration_features.footer_size.max = 5
	menu_configuration_features.footer_size.mod = 0.01
	menu_configuration_features.footer_size.min = 0.1
	menu_configuration_features.footer_size.value = stuff.menuData.footer_size_modifier

	menu_configuration_features.hint_size = func.add_feature("Hint Text Size", "autoaction_value_f", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.hint_size_modifier = f.value
		func.rewrap_hints(stuff.menuData.fonts.hint)
	end)
	menu_configuration_features.hint_size.max = 5
	menu_configuration_features.hint_size.mod = 0.01
	menu_configuration_features.hint_size.min = 0.1
	menu_configuration_features.hint_size.value = stuff.menuData.hint_size_modifier

	menu_configuration_features.text_y_offset = func.add_feature("Text Y Offset", "autoaction_value_i", menu_configuration_features.layoutParent.id, function(f)
		stuff.drawFeatParams.textOffset.y = -(f.value/graphics.get_screen_height())
		stuff.menuData.text_y_offset = -(f.value/graphics.get_screen_height())
	end)
	menu_configuration_features.text_y_offset.max = 100
	menu_configuration_features.text_y_offset.mod = 1
	menu_configuration_features.text_y_offset.min = -100
	menu_configuration_features.text_y_offset.value = -math.floor(stuff.menuData.text_y_offset*graphics.get_screen_height())

	menu_configuration_features.border = func.add_feature("Border", "autoaction_value_i", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.border = f.value/graphics.get_screen_height()
	end)
	menu_configuration_features.border.max = graphics.get_screen_height()
	menu_configuration_features.border.mod = 1
	menu_configuration_features.border.min = -graphics.get_screen_height()
	menu_configuration_features.border.value = math.floor(stuff.menuData.border*graphics.get_screen_height())

	menu_configuration_features.selector_speed = func.add_feature("Selector Speed", "autoaction_value_f", menu_configuration_features.layoutParent.id, function(f)
		stuff.menuData.selector_speed = f.value
	end)
	menu_configuration_features.selector_speed.max = 10
	menu_configuration_features.selector_speed.mod = 0.1
	menu_configuration_features.selector_speed.min = 0.2
	menu_configuration_features.selector_speed.value = stuff.menuData.selector_speed

	-- Online Player Submenu Sorting
		menu_configuration_features.player_submenu_sort = func.add_feature("Online Players Sort:", "autoaction_value_str", menu_configuration_features.layoutParent.id, function(f)
			table.sort(stuff.PlayerParent, stuff.table_sort_functions[f.value])
			stuff.player_submenu_sort = f.value
		end)
		menu_configuration_features.player_submenu_sort:set_str_data({'PID', 'PID Reversed', 'Alphabetically', 'Alphabetically Reversed', 'Host Priority', 'Host Priority Reversed'})
		menu_configuration_features.player_submenu_sort.value = stuff.player_submenu_sort

	-- Padding
		menu_configuration_features.padding_parent = func.add_feature("Padding", "parent", menu_configuration_features.layoutParent.id)

			menu_configuration_features.namePadding = func.add_feature("Name Padding", "autoaction_value_i", menu_configuration_features.padding_parent.id, function(f)
				stuff.menuData.padding.name = f.value/graphics.get_screen_width()
			end)
			menu_configuration_features.namePadding.max = graphics.get_screen_width()
			menu_configuration_features.namePadding.mod = 1
			menu_configuration_features.namePadding.min = -graphics.get_screen_width()
			menu_configuration_features.namePadding.value = math.floor(stuff.menuData.padding.name*graphics.get_screen_width())

			menu_configuration_features.parentPadding = func.add_feature("Parent Padding", "autoaction_value_i", menu_configuration_features.padding_parent.id, function(f)
				stuff.menuData.padding.parent = f.value/graphics.get_screen_width()
			end)
			menu_configuration_features.parentPadding.max = graphics.get_screen_width()
			menu_configuration_features.parentPadding.mod = 1
			menu_configuration_features.parentPadding.min = -graphics.get_screen_width()
			menu_configuration_features.parentPadding.value = math.floor(stuff.menuData.padding.parent*graphics.get_screen_width())

			menu_configuration_features.valuePadding = func.add_feature("Value Padding", "autoaction_value_i", menu_configuration_features.padding_parent.id, function(f)
				stuff.menuData.padding.value = f.value/graphics.get_screen_width()
			end)
			menu_configuration_features.valuePadding.max = graphics.get_screen_width()
			menu_configuration_features.valuePadding.mod = 1
			menu_configuration_features.valuePadding.min = -graphics.get_screen_width()
			menu_configuration_features.valuePadding.value = math.floor(stuff.menuData.padding.value*graphics.get_screen_width())

			menu_configuration_features.sliderPadding = func.add_feature("Slider Padding", "autoaction_value_i", menu_configuration_features.padding_parent.id, function(f)
				stuff.menuData.padding.slider = f.value/graphics.get_screen_width()
			end)
			menu_configuration_features.sliderPadding.max = graphics.get_screen_width()
			menu_configuration_features.sliderPadding.mod = 1
			menu_configuration_features.sliderPadding.min = -graphics.get_screen_width()
			menu_configuration_features.sliderPadding.value = math.floor(stuff.menuData.padding.slider*graphics.get_screen_width())

	-- Slider dimensions
		menu_configuration_features.slider_parent = func.add_feature("Slider", "parent", menu_configuration_features.layoutParent.id)

			menu_configuration_features.sliderWidth = func.add_feature("Slider Width", "autoaction_value_i", menu_configuration_features.slider_parent.id, function(f)
				stuff.menuData.slider.width = f.value/graphics.get_screen_width()
			end)
			menu_configuration_features.sliderWidth.max = graphics.get_screen_width()
			menu_configuration_features.sliderWidth.mod = 1
			menu_configuration_features.sliderWidth.min = -graphics.get_screen_width()
			menu_configuration_features.sliderWidth.value = math.floor(stuff.menuData.slider.width*graphics.get_screen_width())

			menu_configuration_features.sliderHeight = func.add_feature("Slider Height", "autoaction_value_i", menu_configuration_features.slider_parent.id, function(f)
				stuff.menuData.slider.height = f.value/graphics.get_screen_height()
			end)
			menu_configuration_features.sliderHeight.max = graphics.get_screen_height()
			menu_configuration_features.sliderHeight.mod = 1
			menu_configuration_features.sliderHeight.min = -graphics.get_screen_height()
			menu_configuration_features.sliderHeight.value = math.floor(stuff.menuData.slider.height*graphics.get_screen_height())

			menu_configuration_features.sliderheightActive = func.add_feature("Slider Height Active", "autoaction_value_i", menu_configuration_features.slider_parent.id, function(f)
				stuff.menuData.slider.heightActive = f.value/graphics.get_screen_height()
			end)
			menu_configuration_features.sliderheightActive.max = graphics.get_screen_height()
			menu_configuration_features.sliderheightActive.mod = 1
			menu_configuration_features.sliderheightActive.min = -graphics.get_screen_height()
			menu_configuration_features.sliderheightActive.value = math.floor(stuff.menuData.slider.heightActive*graphics.get_screen_height())

	-- Controls
	menu_configuration_features.controls = func.add_feature("Controls", "parent", menu_configuration_features.cheesemenuparent.id)

	do
		local control_handler <const> = function(f, k)
			for k, v in pairs(stuff.char_codes) do
				while cheeseUtils.get_key(v):is_down() do
					system.wait(0)
				end
			end
			menu.notify("Press any button\nESC to cancel", "Rimurus Menu", 3, cheeseUtils.convert_rgba_to_int(stuff.menuData.color.notifications.r, stuff.menuData.color.notifications.g, stuff.menuData.color.notifications.b, stuff.menuData.color.notifications.a))
			local disablethread = menu.create_thread(stuff.disable_all_controls, nil)
			local stringkey, vk = func.get_hotkey({}, {}, true)
			if stringkey ~= "escaped" then
				stuff.controls[k] = stringkey
				stuff.vkcontrols[k] = vk
				f:set_str_data({stringkey})
			end
			menu.delete_thread(disablethread)
		end
		local proper_names <const> = {
			left = "Left",
			up = "Up",
			right = "Right",
			down = "Down",
			select = "Select",
			back = "Back",
			open = "Open",
			setHotkey = "Set Hotkey",
			specialKey = "Special Key",
			revealMouse = "Reveal Mouse",
		}
		menu_configuration_features.control_features = {}
		for k, v in pairs(stuff.controls) do
			local feat <const> = func.add_feature(proper_names[k], "action_value_str", menu_configuration_features.controls.id, control_handler)
			feat:set_str_data({v})
			feat.data = k
			menu_configuration_features.control_features[k] = feat
		end
	end

	-- Player Info
	menu_configuration_features.side_window = func.add_feature("Player Info Window", "parent", menu_configuration_features.cheesemenuparent.id)

		-- On
		menu_configuration_features.side_window_on = func.add_feature("Draw", "toggle", menu_configuration_features.side_window.id, function(f)
			stuff.menuData.side_window.on = f.on
		end)
		menu_configuration_features.side_window_on.on = stuff.menuData.side_window.on

		-- Offset
		menu_configuration_features.side_window_offsetx = func.add_feature("X Offset", "autoaction_value_i", menu_configuration_features.side_window.id, function(f)
			if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
				local stat, num = input.get("num", "", 10, 3)
				if stat == 0 and tonumber(num) then
					stuff.menuData.side_window.offset.x = num/graphics.get_screen_height()
					f.value = num
				end
			end
			stuff.menuData.side_window.offset.x = f.value/graphics.get_screen_width()
		end)
		menu_configuration_features.side_window_offsetx.max = graphics.get_screen_width()
		menu_configuration_features.side_window_offsetx.mod = 1
		menu_configuration_features.side_window_offsetx.min = -graphics.get_screen_width()
		menu_configuration_features.side_window_offsetx.value = math.floor(stuff.menuData.side_window.offset.x*graphics.get_screen_width())

		menu_configuration_features.side_window_offsety = func.add_feature("Y Offset", "autoaction_value_i", menu_configuration_features.side_window.id, function(f)
			if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
				local stat, num = input.get("num", "", 10, 3)
				if stat == 0 and tonumber(num) then
					stuff.menuData.side_window.offset.y = num/graphics.get_screen_height()
					f.value = num
				end
			end
			stuff.menuData.side_window.offset.y = f.value/graphics.get_screen_height()
		end)
		menu_configuration_features.side_window_offsety.max = graphics.get_screen_height()
		menu_configuration_features.side_window_offsety.mod = 1
		menu_configuration_features.side_window_offsety.min = -graphics.get_screen_height()
		menu_configuration_features.side_window_offsety.value = math.floor(stuff.menuData.side_window.offset.y*graphics.get_screen_height())

		-- Spacing
		menu_configuration_features.side_window_spacing = func.add_feature("Spacing", "autoaction_value_i", menu_configuration_features.side_window.id, function(f)
			if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
				local stat, num = input.get("num", "", 10, 3)
				if stat == 0 and tonumber(num) then
					stuff.menuData.side_window.spacing = num/graphics.get_screen_height()
					f.value = num
				end
			end
			stuff.menuData.side_window.spacing = f.value/graphics.get_screen_height()
		end)
		menu_configuration_features.side_window_spacing.max = graphics.get_screen_height()
		menu_configuration_features.side_window_spacing.mod = 1
		menu_configuration_features.side_window_spacing.min = -graphics.get_screen_height()
		menu_configuration_features.side_window_spacing.value = math.floor(stuff.menuData.side_window.spacing*graphics.get_screen_height())

		-- Padding
		menu_configuration_features.side_window_padding = func.add_feature("Padding", "autoaction_value_i", menu_configuration_features.side_window.id, function(f)
			if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
				local stat, num = input.get("num", "", 10, 3)
				if stat == 0 and tonumber(num) then
					stuff.menuData.side_window.padding = num/graphics.get_screen_height()
					f.value = num
				end
			end
			stuff.menuData.side_window.padding = f.value/graphics.get_screen_width()
		end)
		menu_configuration_features.side_window_padding.max = graphics.get_screen_width()
		menu_configuration_features.side_window_padding.mod = 1
		menu_configuration_features.side_window_padding.min = -graphics.get_screen_width()
		menu_configuration_features.side_window_padding.value = math.floor(stuff.menuData.side_window.padding*graphics.get_screen_width())

		-- Width
		menu_configuration_features.side_window_width = func.add_feature("Width", "autoaction_value_i", menu_configuration_features.side_window.id, function(f)
			if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
				local stat, num = input.get("num", "", 10, 3)
				if stat == 0 and tonumber(num) then
					stuff.menuData.side_window.width = num/graphics.get_screen_height()
					f.value = num
				end
			end
			stuff.menuData.side_window.width = f.value/graphics.get_screen_width()
		end)
		menu_configuration_features.side_window_width.max = graphics.get_screen_width()
		menu_configuration_features.side_window_width.mod = 1
		menu_configuration_features.side_window_width.min = -graphics.get_screen_width()
		menu_configuration_features.side_window_width.value = math.floor(stuff.menuData.side_window.width*graphics.get_screen_width())

	-- End of Player Info


	-- Background
		menu_configuration_features.backgroundparent = func.add_feature("Background", "parent", menu_configuration_features.cheesemenuparent.id)

			menu_configuration_features.backgroundfeat = func.add_feature("Background", "autoaction_value_str", menu_configuration_features.backgroundparent.id, function(f)
				if f.str_data[f.value + 1] == "NONE" then
					stuff.menuData.background_sprite.sprite = nil
				else
					stuff.menuData.background_sprite.sprite = f.str_data[f.value + 1]
				end
			end)
			menu_configuration_features.backgroundfeat:set_str_data({"NONE", table.unpack(stuff.menuData.files.background)})

			func.add_feature("Fit background to width", "action", menu_configuration_features.backgroundparent.id, function()
				if stuff.menuData.background_sprite.sprite then
					stuff.menuData.background_sprite:fit_size_to_width()
				end
			end)

			menu_configuration_features.backgroundoffsetx = func.add_feature("Background pos X", "autoaction_value_i", menu_configuration_features.backgroundparent.id, function(f)
				if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
					local stat, num = input.get("num", "", 10, 3)
					if stat == 0 and tonumber(num) then
						stuff.menuData.background_sprite.offset.x = num/graphics.get_screen_width()
						f.value = num
					end
				end
				stuff.menuData.background_sprite.offset.x = f.value/graphics.get_screen_width()
			end)
			menu_configuration_features.backgroundoffsetx.max = graphics.get_screen_width()
			menu_configuration_features.backgroundoffsetx.mod = 1
			menu_configuration_features.backgroundoffsetx.min = -graphics.get_screen_width()
			menu_configuration_features.backgroundoffsetx.value = math.floor(stuff.menuData.background_sprite.offset.x*graphics.get_screen_width())

			menu_configuration_features.backgroundoffsety = func.add_feature("Background pos Y", "autoaction_value_i", menu_configuration_features.backgroundparent.id, function(f)
				if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
					local stat, num = input.get("num", "", 10, 3)
					if stat == 0 and tonumber(num) then
						stuff.menuData.background_sprite.offset.y = num/graphics.get_screen_height()
						f.value = num
					end
				end
				stuff.menuData.background_sprite.offset.y = f.value/graphics.get_screen_height()
			end)
			menu_configuration_features.backgroundoffsety.max = graphics.get_screen_height()
			menu_configuration_features.backgroundoffsety.mod = 1
			menu_configuration_features.backgroundoffsety.min = -graphics.get_screen_height()
			menu_configuration_features.backgroundoffsety.value = math.floor(stuff.menuData.background_sprite.offset.y*graphics.get_screen_height())

			menu_configuration_features.backgroundsize = func.add_feature("Background Size", "autoaction_value_f", menu_configuration_features.backgroundparent.id, function(f)
				stuff.menuData.background_sprite.size = f.value
			end)
			menu_configuration_features.backgroundsize.max = 1
			menu_configuration_features.backgroundsize.mod = 0.01
			menu_configuration_features.backgroundsize.value = stuff.menuData.background_sprite.size

	-- Footer
		menu_configuration_features.footer = func.add_feature("Footer", "parent", menu_configuration_features.cheesemenuparent.id)

			menu_configuration_features.footer_size = func.add_feature("Footer Size", "autoaction_value_i", menu_configuration_features.footer.id, function(f)
				if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
					local stat, num = input.get("num", "", 10, 3)
					if stat == 0 and tonumber(num) then
						stuff.menuData.footer.footer_size = num/graphics.get_screen_height()
						f.value = num
					end
				end
				stuff.menuData.footer.footer_size = f.value/graphics.get_screen_height()
			end)
			menu_configuration_features.footer_size.max = graphics.get_screen_height()
			menu_configuration_features.footer_size.mod = 1
			menu_configuration_features.footer_size.min = 0
			menu_configuration_features.footer_size.value = math.floor(stuff.menuData.footer.footer_size*graphics.get_screen_height())

			menu_configuration_features.footer_y_offset = func.add_feature("Footer Y Offset", "autoaction_value_i", menu_configuration_features.footer.id, function(f)
				stuff.menuData.footer.footer_y_offset = (f.value/graphics.get_screen_height())
			end)
			menu_configuration_features.footer_y_offset.max = 100
			menu_configuration_features.footer_y_offset.mod = 1
			menu_configuration_features.footer_y_offset.min = -100
			menu_configuration_features.footer_y_offset.value = math.floor(stuff.menuData.footer.footer_y_offset*graphics.get_screen_height())

			menu_configuration_features.footerPadding = func.add_feature("Padding", "autoaction_value_i", menu_configuration_features.footer.id, function(f)
				if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
					local stat, num = input.get("num", "", 10, 3)
					if stat == 0 and tonumber(num) then
						stuff.menuData.footer.padding = num/graphics.get_screen_width()
						f.value = num
					end
				end
				stuff.menuData.footer.padding = f.value/graphics.get_screen_width()
			end)
			menu_configuration_features.footerPadding.max = graphics.get_screen_width()
			menu_configuration_features.footerPadding.mod = 1
			menu_configuration_features.footerPadding.min = -graphics.get_screen_width()
			menu_configuration_features.footerPadding.value = math.floor(stuff.menuData.footer.padding*graphics.get_screen_width())

			menu_configuration_features.draw_footer = func.add_feature("Draw footer", "toggle", menu_configuration_features.footer.id, function(f)
				stuff.menuData.footer.draw_footer = f.on
			end)
			menu_configuration_features.draw_footer.on = stuff.menuData.footer.draw_footer

			menu_configuration_features.footer_pos_related_to_background = func.add_feature("Footer position based on background", "toggle", menu_configuration_features.footer.id, function(f)
				stuff.menuData.footer.footer_pos_related_to_background = f.on
			end)
			menu_configuration_features.footer_pos_related_to_background.on = stuff.menuData.footer.footer_pos_related_to_background

		
			menu_configuration_features.States = func.add_feature("Game States", "parent", menu_configuration_features.cheesemenuparent.id)

			local typingF = func.add_feature("Typing", "toggle", menu_configuration_features.States.id, function(f)
				GStates.typing = f.on
			end)
			typingF.on = GStates.typing

			local pausedF = func.add_feature("Paused", "toggle", menu_configuration_features.States.id, function(f)
				GStates.paused = f.on
			end)
			pausedF.on = GStates.paused

			local ceoF = func.add_feature("CEO", "toggle", menu_configuration_features.States.id, function(f)
				GStates.ceo = f.on
			end)
			ceoF.on = GStates.ceo


	-- Fonts
		local fontStrData = {
			"Menu Head",
			"Menu Tab",
			"Menu Entry",
			"Menu Foot",
			"Script 1",
			"Script 2",
			"Script 3",
			"Script 4",
			"Script 5",
		}
		menu_configuration_features.fonts = func.add_feature("Fonts", "parent", menu_configuration_features.cheesemenuparent.id)

			menu_configuration_features.text_font = func.add_feature("Text Font", "autoaction_value_str", menu_configuration_features.fonts.id, function(f)
				stuff.menuData.fonts.text = f.value
			end)
			menu_configuration_features.text_font:set_str_data(fontStrData)
			menu_configuration_features.text_font.value = stuff.menuData.fonts.text

			menu_configuration_features.footer_font = func.add_feature("Footer Font", "autoaction_value_str", menu_configuration_features.fonts.id, function(f)
				stuff.menuData.fonts.footer = f.value
			end)
			menu_configuration_features.footer_font:set_str_data(fontStrData)
			menu_configuration_features.footer_font.value = stuff.menuData.fonts.footer

			menu_configuration_features.hint_font = func.add_feature("Hint Font", "autoaction_value_str", menu_configuration_features.fonts.id, function(f)
				stuff.menuData.fonts.hint = f.value
				func.rewrap_hints(f.value)
			end)
			menu_configuration_features.hint_font:set_str_data(fontStrData)
			menu_configuration_features.hint_font.value = stuff.menuData.fonts.hint

	-- Hotkeys
		menu_configuration_features.hotkeyparent = func.add_feature("Hotkey notifications", "parent", menu_configuration_features.cheesemenuparent.id)

			func.add_feature("Toggle notification", "toggle", menu_configuration_features.hotkeyparent.id, function(f)
				stuff.hotkey_notifications.toggle = f.on
			end).on = stuff.hotkey_notifications.toggle
			func.add_feature("Action notification", "toggle", menu_configuration_features.hotkeyparent.id, function(f)
				stuff.hotkey_notifications.action = f.on
			end).on = stuff.hotkey_notifications.action

	-- Colors
		local colorParent = func.add_feature("Colours", "parent", menu_configuration_features.cheesemenuparent.id)
			do
				local function input_num(f)
					if cheeseUtils.get_key(0x65):is_down() or cheeseUtils.get_key(0x0D):is_down() then
						local stat, num = input.get("num", "", 10, 3)
						if stat == 0 and tonumber(num) then
							f.value = num
						end
					end
				end

				local function pick_color(f, data)
					while cheeseUtils.get_key(0x0D):is_down() or cheeseUtils.get_key(0x08):is_down() or cheeseUtils.get_key(0x1B):is_down() do
						system.wait(0)
					end
					local original_colors = {
						r = data.feats.r.value,
						g = data.feats.g.value,
						b = data.feats.b.value,
						a = data.feats.a.value,
					}

					local menu_color = stuff.menuData.color[data.color_key]
					local is_table = type(menu_color) == "table"

					local status, ABGR, r, g, b, a
					repeat
						status, ABGR, r, g, b, a = cheeseUtils.pick_color(original_colors.r, original_colors.g, original_colors.b, original_colors.a)

						if status == 2 then
							menu.notify("Cancelled", "Rimurus Menu", 2, cheeseUtils.convert_rgba_to_int(stuff.menuData.color.notifications.r, stuff.menuData.color.notifications.g, stuff.menuData.color.notifications.b, stuff.menuData.color.notifications.a))

							for color, val in pairs(original_colors) do
								data.feats[color].value = val
								if is_table then
									menu_color[color] = val
								end
							end

							if not is_table then
								stuff.menuData.color[data.color_key] = cheeseUtils.convert_rgba_to_int(original_colors.r, original_colors.g, original_colors.b, original_colors.a)
							end

							break	
						end

						data.feats.r.value = r
						data.feats.g.value = g
						data.feats.b.value = b
						data.feats.a.value = a

						if is_table then
							menu_color.r = r
							menu_color.g = g
							menu_color.b = b
							menu_color.a = a
						else
							stuff.menuData.color[data.color_key] = ABGR
						end

						system.wait(0)
					until status == 0
				end

				local tempColor = {}
				for k, v in pairs(stuff.menuData.color) do
					tempColor[#tempColor+1] = {k, v, sortname = k:gsub("feature_([^s])", "feature_a%1")}
				end
				table.sort(tempColor, function(a, b) return a["sortname"] < b["sortname"] end)

				for _, v in pairs(tempColor) do
					local is_table = type(v[2]) == "table"

					menu_configuration_features[v[1]] = {}
					local vParent = func.add_feature(v[1], "parent", colorParent.id)

					func.add_feature("Pick Color", "action", vParent.id, pick_color).data = {
						feats = menu_configuration_features[v[1]],
						color_key = v[1]
					}

					menu_configuration_features[v[1]].r = func.add_feature("Red", "autoaction_value_i", vParent.id, function(f)
						input_num(f)
						stuff.menuData.color:set_color(v[1], f.value)
					end)
					menu_configuration_features[v[1]].r.max = 255
					menu_configuration_features[v[1]].r.value = is_table and v[2].r or cheeseUtils.convert_int_to_rgba(v[2], "r")

					menu_configuration_features[v[1]].g = func.add_feature("Green", "autoaction_value_i", vParent.id, function(f)
						input_num(f)
						stuff.menuData.color:set_color(v[1], nil, f.value)
					end)
					menu_configuration_features[v[1]].g.max = 255
					menu_configuration_features[v[1]].g.value = is_table and v[2].g or cheeseUtils.convert_int_to_rgba(v[2], "g")

					menu_configuration_features[v[1]].b = func.add_feature("Blue", "autoaction_value_i", vParent.id, function(f)
						input_num(f)
						stuff.menuData.color:set_color(v[1], nil, nil, f.value)
					end)
					menu_configuration_features[v[1]].b.max = 255
					menu_configuration_features[v[1]].b.value = is_table and v[2].b or cheeseUtils.convert_int_to_rgba(v[2], "b")

					menu_configuration_features[v[1]].a = func.add_feature("Alpha", "autoaction_value_i", vParent.id, function(f)
						input_num(f)
						stuff.menuData.color:set_color(v[1], nil, nil, nil, f.value)
					end)
					menu_configuration_features[v[1]].a.max = 255
					menu_configuration_features[v[1]].a.value = is_table and v[2].a or cheeseUtils.convert_int_to_rgba(v[2], "a")
				end
			end

			menu_configuration_features.load_langs = func.add_feature("Languages", "autoaction_value_str", menu_configuration_features.cheesemenuparent.id, function(f)
				loadLanguage(f.str_data[f.value + 1])
				stuff.menuData.language = f.str_data[f.value + 1]
			end)
			menu_configuration_features.load_langs:set_str_data(stuff.menuData.files.langs)


	-- loading default ui & settings
	func.load_ui("default")
	func.load_settings()

	--changing menu functions to ui functions
	local menu_get_feature_by_hierarchy_key <const> = menu.get_feature_by_hierarchy_key
	menu_originals = setmetatable({
		--get_feature_by_hierarchy_key = menu.get_feature_by_hierarchy_key,
		add_feature = menu.add_feature,
		add_player_feature = menu.add_player_feature,
		delete_feature = menu.delete_feature,
		delete_player_feature = menu.delete_player_feature,
		get_player_feature = menu.get_player_feature,
	}, {__newindex = function() end})
	menu.add_feature = func.add_feature
	menu.add_player_feature = func.add_player_feature
	menu.delete_feature = func.delete_feature
	menu.delete_player_feature = func.delete_player_feature
	menu.get_player_feature = func.get_player_feature
	menu.get_feature_by_hierarchy_key = function(hierarchy_key)
		if string.find(hierarchy_key:lower(), "trusted") or string.find(hierarchy_key:lower(), "Proddy's Script Manager") then
			return
		end
		local feat, duplicate
		feat = menu_get_feature_by_hierarchy_key(hierarchy_key)
		if feat then
			return feat
		else
			feat, duplicate = func.get_feature_by_hierarchy_key(hierarchy_key)
			if duplicate then
				return feat[1]
			else
				return feat
			end
		end
	end

	local visionsOpt = func.add_feature(translations.selfSub.visions, "parent", menu_configuration_features.PlayerParent.id)

	local idleCam = func.add_feature(translations.selfSub.idle, "toggle", visionsOpt.id, function(f)
		while f.on do
			natives.CAM.IS_CINEMATIC_IDLE_CAM_RENDERING()
			natives.CAM.INVALIDATE_IDLE_CAM()
			system.wait(0)
		end
	end)
	
	func.add_feature(translations.selfSub.nightvision, "toggle", visionsOpt.id, function(f)
		natives.GRAPHICS.SET_NIGHTVISION(f.on)
		script.set_global_i(globals["visionBypass"], f.on and 1 or 0)
	end)
	
	func.add_feature(translations.selfSub.heatvision, "toggle", visionsOpt.id, function(f)
		natives.GRAPHICS.SET_SEETHROUGH(f.on)
		script.set_global_i(globals["visionBypass"], f.on and 1 or 0)
	end)
	
	menu.create_thread(function()
		for i=1, #visions do
			func.add_feature(visions[i], "toggle", visionsOpt.id, function(f)
				if f.on then
					natives.GRAPHICS.SET_TIMECYCLE_MODIFIER(visions[i])
				else
					natives.GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
				end
			end)
		end
	end)
	
	local fovVariable = menu.get_feature_by_hierarchy_key("local.misc.fov_changer.third_person")
	local fov = func.add_feature(translations.selfSub.fov, "value_i", menu_configuration_features.PlayerParent.id, function(f)
		if f.on then
			fovVariable = menu.get_feature_by_hierarchy_key("local.misc.fov_changer.third_person")
			fovVariable.value = f.value
			f.value = fovVariable.value
				fovVariable:toggle()
			fovVariable:toggle()
		end
	end)
	fov.min = 1
	fov.mod = 2
	fov.max = 130
	fov.hint = "Change your FOV"
	
	local pAlpha = func.add_feature(translations.selfSub.opacity, "autoaction_value_i",  menu_configuration_features.PlayerParent.id, function(f)
		natives.ENTITY.SET_ENTITY_ALPHA(player.player_ped(), f.value, false)
	end)
	pAlpha.min = 0
	pAlpha.mod = 20
	pAlpha.max = 255
	pAlpha.value = 255
	pAlpha.hint = "Change your Opacity"

	func.add_feature(translations.selfSub.resetOpacity, "action",  menu_configuration_features.PlayerParent.id, function()
		natives.ENTITY.RESET_ENTITY_ALPHA(player.player_ped())
		menu.notify("Reset Player Opacity")
	end)
	
	local cop = func.add_feature(translations.selfSub.becomeCop, "toggle", menu_configuration_features.PlayerParent.id, function(f)
		if f.on then
			natives.PED.SET_PED_AS_COP(player.player_ped(), true)
		else
			if player.is_player_female(player.player_id()) then
				streaming.request_model(1885233650)
				if streaming.has_model_loaded(1885233650) then
					player.set_player_model(1885233650)
				end
			else
				streaming.request_model(2627665880)
				if streaming.has_model_loaded(2627665880) then
					player.set_player_model(2627665880)
				end
			end
		end
	end)
	cop.hint = "Become a cop"
	
	local tiny = func.add_feature(translations.selfSub.tinyPlayer, "toggle", menu_configuration_features.PlayerParent.id, function(f)
		native.call(0x1913FE4CBF41C463, player.player_ped(), 223, f.on)
	end)
	
	local reduced = func.add_feature(translations.selfSub.reduced, "toggle", menu_configuration_features.PlayerParent.id, function(f)
		while f.on do
			local objects = object.get_all_objects() 
			local vehs = vehicle.get_all_vehicles()
			for i = 1, #objects do
				if natives.INTERIOR.GET_INTERIOR_FROM_ENTITY(player.player_ped()) == 0 then
					entity.set_entity_no_collision_entity(objects[i], player.player_ped(), true)
				end
			end
			
			for i = 1, #vehs do
				if natives.INTERIOR.GET_INTERIOR_FROM_ENTITY(player.player_ped()) == 0 then
					entity.set_entity_no_collision_entity(vehs[i], player.player_ped(), true)
				end
			end
			system.wait(0)
		end
	end)
	reduced.hint = "Reduce collision to all objects and vehicles"

	local moneyDrop = func.add_feature(translations.selfSub.moneyDrops, "toggle", menu_configuration_features.PlayerParent.id, function(f)
		while f.on do
			local peds = ped.get_all_peds()
			for i=1, #peds do
				if peds[i] ~= player.player_ped() then
					local pos = player.get_player_coords(player.player_id())
					pos.z = pos.z + 6
		
					entity.set_entity_visible(peds[i], false)
					
					natives.PED.SET_PED_MONEY(peds[i], 2000)
					
					entity.set_entity_coords_no_offset((peds[i]), pos)
					ped.set_ped_health(peds[i], 0)
					
					system.wait(100)
					entity.set_entity_as_no_longer_needed(peds[i])
					entity.delete_entity(peds[i])
				end
			end
			system.wait(0)
		end
	end)
	moneyDrop.hint = "Drop money on self"
	--

-- 
--local silentPed = add_savable_feature_t("Silent Aimbot", menu_configuration_features.WeaponParent.id, function(f)
--	while f.on do
--		silent_aimbot_ped()
--		system.wait(0)
--	end
--end)

local crosshair = func.add_feature(translations.weaponSub.crosshair, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		natives.HUD.SHOW_HUD_COMPONENT_THIS_FRAME(14)
		system.wait(0)
	end
end)
crosshair.hint = "Show a crosshair"

local cartoon = func.add_feature(translations.weaponSub.cartoon, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		graphics.set_next_ptfx_asset('scr_rcbarry2')
    
        if not graphics.has_named_ptfx_asset_loaded('scr_rcbarry2') then
            graphics.request_named_ptfx_asset('scr_rcbarry2')
        end

        if ped.is_ped_shooting(player.player_ped()) then
            local rtrn, pos = ped.get_ped_bone_coords(player.player_ped(), 0x67f2, v3(0.01, 0, 0))
			if rtrn then
				graphics.start_networked_ptfx_looped_at_coord("muz_clown", pos, v3(0,0,0), 1, true, true, true)
			end
        end
		system.wait(0)
	end
end)
cartoon.hint = "Cartoon effect bullets"

local dildo = func.add_feature(translations.weaponSub.dildo, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		local boolrtn, impact = ped.get_ped_last_weapon_impact(player.player_ped())
	
		if boolrtn then
			object.create_world_object(gameplay.get_hash_key("prop_cs_dildo_01"), impact, true, false)
			streaming.set_model_as_no_longer_needed(gameplay.get_hash_key("prop_cs_dildo_01"))

		end
		system.wait(0)
	end
end)
dildo.hint = "Shoot Dildos"

local pedGun = func.add_feature(translations.weaponSub.ped, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		local val = math.random(1, #pedList)
		local boolrtn, impact = ped.get_ped_last_weapon_impact(player.player_ped())
	
		if boolrtn then
			streaming.request_model(gameplay.get_hash_key(pedList[val]))
			while not streaming.has_model_loaded(gameplay.get_hash_key(pedList[val])) do
				system.yield(0)
			end
			
			ped.create_ped(26, gameplay.get_hash_key(pedList[val]), impact, 0.0, true, false)
			streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(pedList[val]))

		end
		system.wait(0)
	end
end)
pedGun.hint = "Shoot peds"

local objectGun = func.add_feature(translations.weaponSub.object, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		local val = math.random(1, #objects)
		local boolrtn, impact = ped.get_ped_last_weapon_impact(player.player_ped())
	
		if boolrtn then
			object.create_object(gameplay.get_hash_key(objects[val]), impact, true, false)
			streaming.set_model_as_no_longer_needed(gameplay.get_hash_key(objects[val]))
		end
		system.wait(0)
	end
end)
objectGun.hint = "Shoot objects"

local deleteGun = func.add_feature(translations.weaponSub.delete, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		entity.delete_entity(player.get_entity_player_is_aiming_at(player.player_id()))
		system.wait(0)
	end
end)
deleteGun.hint = "Delete objects you aim at"

local grapple = func.add_feature(translations.weaponSub.grapple, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		if controls.is_disabled_control_pressed(0, 24) then
			local camDir = GetCamDirFromScreenCenter()
			local camPos = cam.get_gameplay_cam_pos()
			local targetPos = camPos + (camDir * 200.0)
			targetPos.z = targetPos.z + 10

			ai.task_sky_dive(player.player_ped(), true)
			entity.set_entity_velocity(player.player_ped(), targetPos)
		end	
		system.wait(0)
	end
end)
grapple.hint = "Grapple gun just cause 2 style"

local dust = func.add_feature(translations.weaponSub.dust, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		ExplosionTypeGun(80)
        ExplosionTypeGun(42)
		system.wait(0)
	end
end)
dust.hint = "Dust explosion"

local money = func.add_feature(translations.weaponSub.moneyGun, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		streaming.request_model(gameplay.get_hash_key("prop_cash_pile_01"))

		if streaming.has_model_loaded(gameplay.get_hash_key("prop_cash_pile_01")) then
			local boolrtn, impact = ped.get_ped_last_weapon_impact(player.player_ped())
			natives.OBJECT.CREATE_MONEY_PICKUPS(impact.x, impact.y, impact.z, 2000, 20, gameplay.get_hash_key("prop_cash_pile_01"))
		end
		system.wait(0)
	end
end)
money.hint = "Shoot money"

local teleport = func.add_feature(translations.weaponSub.teleportGun, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		if ped.is_ped_shooting(player.player_ped()) then
			local boolrtn, impact = ped.get_ped_last_weapon_impact(player.player_ped())
			local rt, z = gameplay.get_ground_z(impact)
			
			if impact.z >= z and rt then
				entity.set_entity_coords_no_offset(player.player_ped(), impact)		
			end
		end
		system.wait(0)
	end
end)
teleport.hint = "Teleport to where you shoot"

local rapid = func.add_feature(translations.weaponSub.rapidFire, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		if controls.is_disabled_control_pressed(0, 24) and not player.is_player_in_any_vehicle(player.player_id()) then
			local weapon = ped.get_current_ped_weapon(player.player_ped())
			local wepent = natives.WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(player.player_ped(), 0)
			local camDir = GetCamDirFromScreenCenter()
			local camPos = cam.get_gameplay_cam_pos()
			local launchPos = entity.get_entity_coords(wepent)
			local targetPos = camPos + (camDir * 200.0)
			
			gameplay.shoot_single_bullet_between_coords(launchPos, targetPos, 5, weapon, player.player_ped(), true, false, 24000.0)
		end
		system.wait(0)
	end
end)
rapid.hint = "Rapid fire as you know it"

func.add_feature(translations.weaponSub.deadEye, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		if player.is_player_free_aiming(player.player_id()) then
			natives.MISC.SET_TIME_SCALE(0.4)
        else
            natives.MISC.SET_TIME_SCALE(1.0)
        end
		system.wait(0)
	end
end)

local tracers = func.add_feature(translations.weaponSub.bulletTracer, "toggle", menu_configuration_features.WeaponParent.id, function(f)
	while f.on do
		local rgb = RGBRainbow(natives.MISC.GET_GAME_TIMER(), 1)

		local wepent = natives.WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(player.player_ped(), 0)
		local camDir = GetCamDirFromScreenCenter()
		local camPos = cam.get_gameplay_cam_pos()
		local launchPos = entity.get_entity_coords(wepent)
		local targetPos = camPos + (camDir * 200.0)
		
		local b, s = graphics.project_3d_coord_rel(launchPos)
		local b1, s1 = graphics.project_3d_coord_rel(targetPos)

		if controls.is_disabled_control_pressed(0, 24) and not player.is_player_in_any_vehicle(player.player_id()) and b and b1 then
			scriptdraw.draw_line(s, s1, 2, RGBAToInt(rgb.r, rgb.g, rgb.b, 255))
		end

		system.wait(0)
	end
end)
tracers.hint = "Bullet tracers like in COD"

local damageMilt = func.add_feature(translations.weaponSub.damageMulti, "autoaction_value_f", menu_configuration_features.WeaponParent.id, function(f)
	natives.WEAPON.SET_WEAPON_DAMAGE_MODIFIER(ped.get_current_ped_weapon(player.player_ped()), f.value)
end)
damageMilt.min = 1.0
damageMilt.value = 1.0
damageMilt.max = 9999.0
	
local meleeWeps = {
	"weapon_unarmed",
	"weapon_dagger",
	"weapon_bat",
	"weapon_crowbar",
	"weapon_hammer"
}
local damageMilt = func.add_feature(translations.weaponSub.meleeDamage, "autoaction_value_f", menu_configuration_features.WeaponParent.id, function(f)
	for i=1, #meleeWeps do
		natives.WEAPON.SET_WEAPON_DAMAGE_MODIFIER(gameplay.get_hash_key(meleeWeps[i]), f.value)
	end
end)
damageMilt.min = 1.0
damageMilt.value = 1.0
damageMilt.max = 9999.0
--

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

func.add_feature(translations.vehicleSub.hexVehicle, "action", menu_configuration_features.VehicleParent.id, function()
	local status, inpt = input.get("Input A Hex Value", "", 100, 0) 
	if status == eInputResponse.IR_SUCCESS then
		local r, g, b = HexToRGB(inpt)
		setVehicleColour({red= r, green = g, blue = b}, {red= r, green = g, blue= b})
	end
end)

local colVeh = func.add_feature(translations.vehicleSub.moddedColours, "parent", menu_configuration_features.VehicleParent.id)

local colourList = {}
local function parseModdedcolours()
	local colour = {}
	local parse = gltw.read(removeExtensions(colourList[stuff.scroll], "lua"), stuff.path.scripts.."lib\\Rimuru\\moddedColours\\", colour, true, true)
	
	if parse and player.is_player_in_any_vehicle(player.player_id()) then
		menu.notify("Loaded "..colourList[stuff.scroll]:gsub(".lua", ""), "", 6, 4284808960)
		setVehicleColour(colour, colour)
	else
		menu.notify("Unable to load "..colourList[stuff.scroll]:gsub(".lua", ""), "", 6, 0xFF0000FF)
	end
end

local function loadModdedColours()
	local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"

	if not utils.dir_exists(appdata.."scripts\\lib\\Rimuru\\moddedColours\\") then
		menu.notify("ModdedColours are not installed", "Rimuru", 8, 0xFF0000FF)
		return
	end

	colourList = get_all_files_in_directory(appdata.."scripts\\lib\\Rimuru\\moddedColours\\", "lua")
	for i=1, #colourList do
		func.add_feature(colourList[i]:gsub(".lua", ""), "action", colVeh.id, function()
			parseModdedcolours()
		end)
	end
end
loadModdedColours()

func.add_feature(translations.vehicleSub.saveColour, "action", menu_configuration_features.VehicleParent.id, function()
	local status, inputString = input.get("Give your colour a name", "", 100, 0)  
	
	if ped.is_ped_in_any_vehicle(player.player_ped()) then
		if status == eInputResponse.IR_SUCCESS then
			local red = native.ByteBuffer32()
			local green = native.ByteBuffer32()
			local blue = native.ByteBuffer32()
			
			natives.VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(player.get_player_vehicle(player.player_id()), red, green, blue)

			local rgb = {r = red:__tointeger(), b = blue:__tointeger(), g = green:__tointeger()}

			gltw.write(rgb, inputString, stuff.path.scripts.."\\Rimuru\\modded colours\\", {""})
			menu.notify("Saved Current Vehicle Colour")
		end
	else
        menu.notify("You must be in a vehicle to save a colour")
	end
end)

--local garageVeh = func.add_feature("Garage Vehicles", "parent", menu_configuration_features.VehicleParent.id)

--for k,v in pairs(Slots) do
--	func.add_feature(v[2], "action", garageVeh.id, function()
--		script.set_global_i(globals["mechanicDeliver"], 1) --mechanic deliver
--		script.set_global_i(globals["findLocation"], 0) --find location near road
--		script.set_global_i(globals["vehicleIndex"], stuff.scroll) --veh index
--	end)
--end

func.add_feature(translations.vehicleSub.vehGod, "value_str", menu_configuration_features.VehicleParent.id, function(feat)
	while feat.on do
		local veh = ped.get_vehicle_ped_is_using(player.player_ped())

		if veh ~= 0 then
			if feat.value == 0 then
				natives.ENTITY.SET_ENTITY_PROOFS(ped.get_vehicle_ped_is_using(player.player_ped()), true, true, true, true, true, true, true, true)
			end
			if feat.value == 1 then
				natives.ENTITY.SET_ENTITY_PROOFS(ped.get_vehicle_ped_is_using(player.player_ped()), false, false, false, false, false, false, false, false)
			end
		end

		system.wait(0)
	end
end):set_str_data({"Give", "Remove"})

local pAlpha = func.add_feature(translations.vehicleSub.vehOpacity, "autoaction_value_i", menu_configuration_features.VehicleParent.id, function(f)
	natives.ENTITY.SET_ENTITY_ALPHA(ped.get_vehicle_ped_is_using(player.player_ped()), f.value, false)
end)
pAlpha.min = 0
pAlpha.mod = 1
pAlpha.max = 255
pAlpha.value = 255

local gravMult = func.add_feature(translations.vehicleSub.vehGravity, "value_f", menu_configuration_features.VehicleParent.id, function(f)
	if f.on then
		vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), f.value)
	else
		vehicle.set_vehicle_gravity_amount(player.get_player_vehicle(player.player_id()), 9.8)
	end
end)
gravMult.min = -10.00
gravMult.max = 100.00
gravMult.mod = 1.00

local topSpeed = func.add_feature(translations.vehicleSub.modifySpeed, "value_f", menu_configuration_features.VehicleParent.id, function(f)
    local veh = player.get_player_vehicle(player.player_id())
    network.request_control_of_entity(veh)
    if f.on then
        natives.ENTITY.SET_ENTITY_MAX_SPEED(veh, f.value)
    end
    natives.ENTITY.SET_ENTITY_MAX_SPEED(veh, 155.0)
end)
topSpeed.min = 00.00
topSpeed.max = 9999.00
topSpeed.mod = 10.00

local dirtLevel = func.add_feature(translations.vehicleSub.dirtLevel, "autoaction_value_f", menu_configuration_features.VehicleParent.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    while feat.value do
        natives.VEHICLE.SET_VEHICLE_DIRT_LEVEL(veh, feat.value)
        system.wait(0)
    end
end)
dirtLevel.min = 0.0
dirtLevel.max = 15.0
dirtLevel.mod = 1.0

func.add_feature(translations.vehicleSub.destroy, "action", menu_configuration_features.VehicleParent.id, function()
	script.trigger_script_event(scriptEvents.destroyPersonalVehicle.hash, player.player_id(), {player.player_id(), player.player_id()}) --destroy personal
	script.trigger_script_event(scriptEvents.vehicleKick.hash, player.player_id(), {player.player_id(), 0, 0, 0, 0, 1, player.player_id(), math.min(2147483647, gameplay.get_frame_count())}) --kickout
end)

func.add_feature(translations.vehicleSub.tpPersonal, "action", menu_configuration_features.VehicleParent.id, function()
	local vehicle = player.get_personal_vehicle()
    while(not network.request_control_of_entity(vehicle) and utils.time_ms() + 450 > utils.time_ms() and streaming.is_model_valid(vehicle)) do
        system.wait(0)
    end
	ped.set_ped_into_vehicle(player.player_ped(), vehicle, -1)
end)

func.add_feature(translations.vehicleSub.garage, "action", menu_configuration_features.VehicleParent.id, function()
	vehicleBypass()
	menu.notify("Made by err_net_array")
end)

--func.add_feature("Auto Claim", "toggle", menu_configuration_features.VehicleParent.id, function(f)
--	while f.on do
--		
--
--		system.wait(8000)
--	end
--end)

--eature["Claim All Destroyed Vehicles"] = menu.add_feature("Auto Claim Destroyed Vehicles", "toggle", localparents["Vehicle Options Veh"].id, function(f)
--	while f.on do
--	  local active_index, count = Personal_Veh.get_global(offsets.pv_active_slot), 0
--	  for i = 0, Personal_Veh.get_global(offsets.pv_slots) do
--		local info = Personal_Veh.get_vehicle_slot_info(i)
--		if info and info.insured and Personal_Veh.test_bit(offsets.pv_slot_flags, 2, i) then
--		  Personal_Veh.clear_bit(offsets.pv_slot_flags, 65602, i)
--		  if i == active_index and 3 ~= info.type then
--			Personal_Veh.set_bit(offsets.pv_slot_flags, 2049, i)
--		  end
--		  count = count + 1
--		end
--	  end
--	  if count > 0 then
--		menu.notify("Claimed " .. count .. " destroyed personal vehicle" .. (count > 1 and "s." or "."), "Morpheus Mutual Insurance", 7, NotifyColours.yellow)
--	  end
--	  system.yield(7500)
--	end
-- end)

func.add_feature(translations.vehicleSub.gtaNeon, "toggle", menu_configuration_features.VehicleParent.id, function(feat)
	if feat.on then
		Gta4Neons()
	else
		RemoveGtaNeons()
	end
end)

func.add_feature(translations.vehicleSub.rgbNeon, "toggle", menu_configuration_features.VehicleParent.id, function(feat)
    while feat.on do
		local veh = player.get_player_vehicle(player.player_id())       
		for i=0, 3 do
			natives.VEHICLE.SET_VEHICLE_NEON_ENABLED(veh, i, true)
		end
		local rgb = RGBRainbow(natives.MISC.GET_GAME_TIMER(), 2)
        natives.VEHICLE.SET_VEHICLE_NEON_COLOUR(veh, rgb.r, rgb.g, rgb.b)

		system.wait(0)
	end
end)

local rgbX = func.add_feature(translations.vehicleSub.rgbXenon, "value_i", menu_configuration_features.VehicleParent.id, function(feat)
    menu.notify("Xenon Lights Added, BEGIN THE RAVE")
    local veh = player.get_player_vehicle(player.player_id())
    natives.VEHICLE.TOGGLE_VEHICLE_MOD(veh, 22, feat.on)
    while feat.on do
        for i=1,12 do
            natives.VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(veh, i)
            if not feat.on then
                break
            end
            system.wait(feat.value)
        end
        system.wait(0)
    end
end)
rgbX.min = 0
rgbX.max = 2500
rgbX.mod = 100

func.add_feature(translations.vehicleSub.exhaust, "toggle", menu_configuration_features.VehicleParent.id, function(feat)
	while feat.on do
		if ped.is_ped_in_any_vehicle(player.player_ped()) then
			local veh = ped.get_vehicle_ped_is_using(player.player_ped())
			local bone = natives.ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(veh, "exhaust")
			local bone_pos = natives.ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(veh, bone);
			local entity_pitch = natives.ENTITY.GET_ENTITY_PITCH(veh)

			graphics.set_next_ptfx_asset('scr_carsteal4')

			while not graphics.has_named_ptfx_asset_loaded('scr_carsteal4') do
				graphics.request_named_ptfx_asset('scr_carsteal4')
				system.wait(0)
			end

			graphics.start_networked_ptfx_non_looped_at_coord('scr_carsteal4_wheel_burnout', bone_pos, v3(60, 0, 0), 1.33, true, true, true)
			natives.GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(144,245,99)
		end
		system.wait(0)
		
	end
end)

func.add_feature(translations.vehicleSub.noGrip, "toggle", menu_configuration_features.VehicleParent.id, function(feat)
    local veh = player.get_player_vehicle(player.player_id())
    if feat.on then
        natives.VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, true)
		natives.VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(veh, 50)
    else
        natives.VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, false)
		natives.VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(veh, 100)
    end
end)

func.add_feature(translations.vehicleSub.instantly, "toggle", menu_configuration_features.VehicleParent.id, function(f)
    while f.on do
        if controls.is_control_just_pressed(2, 75) then
			local veh = get_closest_vehicle()
			local seat = vehicle.get_ped_in_vehicle_seat(veh, -1)
            if veh ~= 0 and seat == 0 and not ped.is_ped_in_any_vehicle(player.player_ped()) then
               ped.set_ped_into_vehicle(player.player_ped(), veh, -1)
			else
				natives.TASK.CLEAR_PED_TASKS_IMMEDIATELY(player.player_ped())
            end
        end
        system.wait(0)
    end
end)

func.add_feature(translations.vehicleSub.reduced, "toggle", menu_configuration_features.VehicleParent.id, function(toggle)
    while toggle.on do
        local veh = player.get_player_vehicle(player.player_id())
        local nearbyvehicles = vehicle.get_all_vehicles()
		local objects = object.get_all_objects() 

        for i = 1, #nearbyvehicles do
			if objects[i] ~= nil and nearbyvehicles[i] ~= nil then
				entity.set_entity_no_collision_entity(nearbyvehicles[i], veh, true)
				entity.set_entity_no_collision_entity(objects[i], veh, true)
			end
        end
        system.wait(0)
    end
end)

func.add_feature(translations.vehicleSub.speedo, "value_str", menu_configuration_features.VehicleParent.id, function(f)
	while f.on do
		local speed = entity.get_entity_speed(player.get_player_vehicle(player.player_id()))

		ui.set_text_scale(0.35)
		ui.set_text_font(0)
		ui.set_text_centre(0)
		ui.set_text_color(255, 255, 255, 255)
		ui.set_text_outline(true)

		if f.value == 0 then
			ui.draw_text(math.floor(speed * 2.236936) .. " MPH", v2(0.5, 0.95))
		end
		if f.value == 1 then
			ui.draw_text(math.floor(speed * 3.6) .. " KPH", v2(0.5, 0.95))
		end
		if f.value == 2 then
			ui.draw_text(math.floor(speed * 1.943844) .. " kt", v2(0.5, 0.95))
		end
		if f.value == 3 then
			ui.draw_text(string.format("%.2f", speed * 0.00291545) .. " Mach", v2(0.5, 0.95))
		end
		if f.value == 4 then
			ui.draw_text(math.floor(speed) .. " mps", v2(0.5, 0.95))
		end
		system.wait(0)
	end
end):set_str_data({ "Mph", "Kph", "Knots", "Mach", "Metres per second" })
---

-- online stuff

func.add_feature("Request heli pickup", "action", phoneRequests.id, function()
	script.set_global_i(globals["heli"], 1)
end)

func.add_feature("Request boat pickup", "action", phoneRequests.id, function()
	script.set_global_i(globals["boat"], 1)
end)

func.add_feature("Request ammo drop", "action", phoneRequests.id, function()
	script.set_global_i(globals["ammo"], 1)
end)

func.add_feature("Request backup heli", "action", phoneRequests.id, function()
	script.set_global_i(globals["AM_backup_heli"] , 1)
end)

func.add_feature("Remove suicide cooldown", "action", phoneRequests.id, function()
	if script.get_global_i(globals["suicide"]) ~= -1 then
		script.set_global_i(globals["suicide"], -1)
	end
end)

func.add_feature("Remove passive mode cooldown", "action", phoneRequests.id, function()
	if script.get_global_i(globals["passive"]) ~= 0 then
		script.set_global_i(globals["passive"], 0)
	end
end)

func.add_feature("Request Taxi", "action", phoneRequests.id, function()
	script.set_global_i(globals["taxi"] , 1)
end)

func.add_feature("Request MOC", "action", phoneRequests.id, function()
	script.set_global_i(globals["MOC"] , 1)
end)

func.add_feature("Request Avenger", "action", phoneRequests.id, function()
	script.set_global_i(globals["avenger"], 1)
end)

func.add_feature("Request Terrorbyte", "action", phoneRequests.id, function()
	script.set_global_i(globals["terrorbyte"] , 1)
end)

func.add_feature("Request Acid Lab", "action", phoneRequests.id, function()
	script.set_global_i(2793982 , 1)
end)

func.add_feature("Request MiniTank", "action", phoneRequests.id, function()
	script.set_global_i(2799919 , 1)
end)

local feat = func.add_feature("Session Size Limit", "autoaction_value_i", hostO.id, function(f)
	if player.is_player_host(player.player_id()) then
		natives.NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(0, f.value)
	end
end)
feat.mod = 1
feat.min = 0
feat.max = 31
feat.value = 31

local feat = func.add_feature("Spectator Limit", "autoaction_value_i", hostO.id, function(f)
	if player.is_player_host(player.player_id()) then
		natives.NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(4, f.value)
	end
end)
feat.mod = 1
feat.min = 0
feat.max = 4
feat.value = 31

func.add_feature("Hide Session", "toggle", hostO.id, function(f)
	if f.on then
		while f.on do
			if network.is_session_started() and network.network_is_host() then
				if  natives.NETWORK.NETWORK_SESSION_IS_VISIBLE() then
					natives.NETWORK.NETWORK_SESSION_MARK_VISIBLE(false)
				end
			end
			system.yield(6000)
		end
	end
	if not f.on then
		if network.is_session_started() and network.network_is_host() then
			if not  natives.NETWORK.NETWORK_SESSION_IS_VISIBLE() then
				natives.NETWORK.NETWORK_SESSION_MARK_VISIBLE(true)
			end
		end
	end
end)

func.add_feature("Block Migration", "toggle", hostO.id, function(f)
	while f.on do
		if network.is_session_started() and network.network_is_host() then
			natives.NETWORK.NETWORK_PREVENT_SCRIPT_HOST_MIGRATION()
		end
		system.yield(0)
	end
end)


--Wallet
func.add_feature("Transfer All Bank Cash To Wallet", "action", walletOpt.id, function(feat)
    local walletCash = natives.MONEY.NETWORK_GET_VC_WALLET_BALANCE(stats.stat_get_int(791613967, 0))
    local bankCash = natives.MONEY.NETWORK_GET_VC_BANK_BALANCE()

    if bankCash > 0 then
        natives.NETSHOPPING.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(stats.stat_get_int(791613967, 0), bankCash)
        walletCash = bankCash
        menu.notify("Transferred $"..bankCash.." to the wallet\nyour current wallet balance is now $"..walletCash)
        walletCash = nil 
    else
        menu.notify("Funds could not be transfered, your bank balance is $"..bankCash)
    end
end)

func.add_feature("Transfer All Cash To Bank", "action", walletOpt.id, function(feat)
    local walletCash = natives.MONEY.NETWORK_GET_VC_WALLET_BALANCE(stats.stat_get_int(791613967, 0))
    local bankCash = natives.MONEY.NETWORK_GET_VC_BANK_BALANCE()

    if walletCash > 0 then
        natives.NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.stat_get_int(791613967, 0), walletCash)
        bankCash = walletCash
        menu.notify("Transfered $"..walletCash.." to the bank\nyour current bank balance is now $"..bankCash)
        bankCash = nil
    else
        menu.notify("Funds could not be transfered, your wallet balance is $"..walletCash)
    end
end)

local bankCash = func.add_feature("Wallet Cash To Transfer", "value_i", walletOpt.id, function(f)
	while f.on do
		natives.NETSHOPPING.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(stats.stat_get_int(791613967, 0), f.value)
		system.wait(0)
	end
end)
bankCash.min = 0
bankCash.max = 922337203685
bankCash.mod = 1000

local TradeCasinoChip = func.add_feature("Trade Casino Chips", "autoaction_value_i", walletOpt.id, function(f)
	script.set_global_i(globals["TradeinChips"], f.value)
	script.set_global_i(globals["chipMax"], 922337203685)
end)
TradeCasinoChip.min = 0
TradeCasinoChip.max = 922337203685
TradeCasinoChip.mod = 10000

local AquireCasinoChip = func.add_feature("Acquire Casino Chips", "autoaction_value_i", walletOpt.id, function(f)
	script.set_global_i(globals["AquireChips"], f.value)
	script.set_global_i(globals["chipMax"], 922337203685)
end)
AquireCasinoChip.min = 0
AquireCasinoChip.max = 922337203685
AquireCasinoChip.mod = 10000

func.add_feature("Remove Money", "action", walletOpt.id, function()
	local rtrn, input = input.get("Input Amount To Remove", "", 50, eInputType.IT_NUM)
	
	if rtrn == eInputResponse.IR_SUCCESS then
		script.set_global_i(globals["ballisticValue"], tonumber(input))
		menu.notify("Success, now request the ballistic armour")
	end
end)
------

local eModderDetectionFlags = {
    MDF_MANUAL                  = 1 << 0x00,
    MDF_PLAYER_MODEL            = 1 << 0x01,
    MDF_SCID_SPOOF              = 1 << 0x02,
    MDF_INVALID_OBJECT          = 1 << 0x03,
    MDF_INVALID_PED_CRASH       = 1 << 0x04,
    MDF_MODEL_CHANGE_CRASH      = 1 << 0x05,
    MDF_PLAYER_MODEL_CHANGE     = 1 << 0x06,
    MDF_RAC                     = 1 << 0x07,
    MDF_MONEY_DROP              = 1 << 0x08,
    MDF_SEP                     = 1 << 0x09,
    MDF_ATTACH_OBJECT           = 1 << 0x0A,
    MDF_ATTACH_PED              = 1 << 0x0B,
    MDF_NET_ARRAY_CRASH         = 1 << 0x0C,
    MDF_SYNC_CRASH              = 1 << 0x0D,
    MDF_NET_EVENT_CRASH         = 1 << 0x0E,
    MDF_HOST_TOKEN              = 1 << 0x0F,
    MDF_SE_SPAM                 = 1 << 0x10,
    MDF_INVALID_VEHICLE         = 1 << 0x11,
    MDF_FRAME_FLAGS             = 1 << 0x12,
    MDF_IP_SPOOF                = 1 << 0x13,
    MDF_KAREN                   = 1 << 0x14,
    MDF_SESSION_MISMATCH        = 1 << 0x15,
    MDF_SOUND_SPAM              = 1 << 0x16,
    MDF_SEP_INT                 = 1 << 0x17,
    MDF_SUSPICIOUS_ACTIVITY     = 1 << 0x18,
    MDF_CHAT_SPOOF              = 1 << 0x19,

    MDF_ENDS                    = 1 << 0x1A,
}

local modderReactions = {
	{name = "Manual",  toggle = false, flag = eModderDetectionFlags.MDF_MANUAL},
	{name = "Player Model", toggle = false, flag = eModderDetectionFlags.MDF_PLAYER_MODEL},
	{name = "Scid Spoof", toggle = false, flag = eModderDetectionFlags.MDF_SCID_SPOOF},
	{name = "Invalid Ped", toggle = false, flag = eModderDetectionFlags.MDF_INVALID_PED_CRASH},
	{name = "Model Change", toggle = false, flag = eModderDetectionFlags.MDF_MODEL_CHANGE_CRASH},
	{name = "Sync Crash", toggle = false, flag = eModderDetectionFlags.MDF_SYNC_CRASH},
	{name = "Net Crash", toggle = false, flag = eModderDetectionFlags.MDF_NET_EVENT_CRASH},
	{name = "Host Token", toggle = false, flag = eModderDetectionFlags.MDF_HOST_TOKEN},
	{name = "IP Spoof", toggle = false, flag = eModderDetectionFlags.MDF_IP_SPOOF},
	{name = "Karen", toggle = false, flag = eModderDetectionFlags.MDF_KAREN}
}

for _, v in ipairs(modderReactions) do
	func.add_feature(v.name, "toggle", reactionOpt.id ,function(f)
		v.toggle = f.on
	end)
end

stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
	while true do
		for _, v in ipairs(modderReactions) do
			for i = 0, player.player_count() do
				if v.toggle and player.is_player_modder(i, v.flag) then
					script.trigger_script_event_2(1 << i, scriptEvents.fakeBan.hash, player.player_id(), "HUD_BAIL_REVOKED")
					network.force_remove_player(i)
					menu.notify("Removed "..player.get_player_name(i).." for "..v.name)
				end
			end
		end
		system.wait(0)
	end
end)

---------
menu.create_thread(function ()
    for i=1, network.get_friend_count()-1 do
        local friends = func.add_feature(tostring(natives.NETWORK.NETWORK_GET_FRIEND_NAME(i)), "parent", friendOpt.id)
        friends.hl_func = function(feat, data)
            while feat.is_highlighted and stuff.menuToggle do
                local featData = {
                    {"Online:", tostring(network.is_friend_index_online(i))},
                    {"SCID:", tostring(network.get_friend_scid(natives.NETWORK.NETWORK_GET_FRIEND_NAME(i)))} 
                }
                func.draw_side_window(
                    tostring(tostring(natives.NETWORK.NETWORK_GET_FRIEND_NAME(i))),
                                featData,
                                v2((stuff.menuData.x + stuff.menuData.width + stuff.menuData.side_window.offset.x)*2-1, (stuff.menuData.y + stuff.menuData.side_window.offset.y)*-2+1),
                                0x96000000,
                                stuff.menuData.side_window.width, stuff.menuData.side_window.spacing, stuff.menuData.side_window.padding,
                                0xDCFFFFFF,
                                v2()
                            )
                system.wait(0)
            end
        end
        func.add_feature("Join "..natives.NETWORK.NETWORK_GET_FRIEND_NAME(i), "action", friends.id, function(f)
            network.join_scid(network.get_friend_scid(natives.NETWORK.NETWORK_GET_FRIEND_NAME(i)))
        end)
         func.add_feature("Add "..natives.NETWORK.NETWORK_GET_FRIEND_NAME(i).." to fakefriends", "action", friends.id, function(f)
            io.output(io.open(stuff.appdata.."\\cfg\\scid.cfg", "w+"))
            io.write(natives.NETWORK.NETWORK_GET_FRIEND_NAME(i)..":"..network.get_friend_scid(natives.NETWORK.NETWORK_GET_FRIEND_NAME(i)))
            io.close()
        end)
		func.add_feature("Refresh", "action", friends.id, function(f)
            -- Update the displayed information in the side window
            f.parent:hl_func(f.parent)
        end)
    end
end)

-----
func.add_feature("Give Unlimited Snacks", "action", recoverytOpt.id, function(f)
	local pid <const> = script.get_global_i(1574918)

	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_NO_BOUGHT_YUM_SNACKS"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_NO_BOUGHT_HEALTH_SNACKS"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_NO_BOUGHT_EPIC_SNACKS"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_NUMBER_OF_ORANGE_BOUGHT"), 999999, true)
	menu.notify("- #FF11BBEE#999999#DEFAULT# P's & Q's Given\n- #FF11BBEE#999999#DEFAULT# EgoChaser's given\n- #FF11BBEE#999999#DEFAULT# Meteorite's given\n- #FF11BBEE#999999#DEFAULT# eCola's given", "Rimurus Menu", 5, 0xFF00EE00)
end)

func.add_feature("Give Unlimited Fireworks", "action", recoverytOpt.id, function(f)
	local pid <const> = script.get_global_i(1574918)

	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_1_RED"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_1_WHITE"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_1_BLUE"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_2_RED"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_2_WHITE"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_3_WHITE"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_2_BLUE"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_3_RED"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_3_BLUE"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_4_RED"), 999999, true)
	stats.stat_set_int(gameplay.get_hash_key("MP"..pid.."_FIREWORK_TYPE_4_BLUE"), 999999, true)
	menu.notify("Max fireworks given", "Rimurus Menu", 5, 0xFF00EE00)
end)

func.add_feature("Unlock Xmas Gifts", "action", recoverytOpt.id, function(f)
	script.set_global_i(262145+34170, 1) --1.67
	script.set_global_i(262145+34171, 1) --1.67
	script.set_global_i(262145+31964, 1) --1.67
	script.set_global_i(262145+31965, 1) --1.67
	script.set_global_i(262145+23593, 1) --1.67
	script.set_global_i(262145+26023, 1) --1.67
	menu.notify("Xmas Gift Awarded", "Rimurus Menu", 5, 0xFF00EE00)
end)

func.add_feature("Unlock Taxi Livery", "action", recoverytOpt.id, function(f)
	stats.stat_set_int(gameplay.get_hash_key("AWD_TAXIDRIVER"), 100, true)
	menu.notify("Taxi livery for the Broadway unlocked", "Rimurus Menu", 5, 0xFF00EE00)
end)

func.add_feature("Nightclub Loop", "toggle", recoverytOpt.id, function(f)
	while f.on do
		set_global_i(262145 + 24227, amount) --1.67
		set_global_i(262145 + 24223, amount) 
		local pid <const> = script.get_global_i(1574918)
  
		stat_set_int(get_hash_key("MP"..pid.."_CLUB_POPULARITY"), 10000, true)
		stat_set_int(get_hash_key("MP"..pid.."_CLUB_PAY_TIME_LEFT"), -1, true)
		stat_set_int(get_hash_key("MP"..pid.."_CLUB_POPULARITY"), 100000, true)
		system.wait(600)

		if stats.stat_get_int(gameplay.get_hash_key("MP1_CLUB_POPULARITY"), 0) > 0 then
			menu.get_feature_by_hierarchy_key("online.business.manual_actions.cash_out_nightclub_safe"):toggle()
		end
	end
end)

local collectableIds = func.add_feature("Collectables","parent", recoverytOpt.id)

local collectables = {
	{name = "Action Figures", global = globals["actionFigures"], amount = 100},
	{name = "Organics", global = globals["Organics"], amount = 100},
	{name = "Snowmen", global = globals["Snowmen"], amount = 25},
}

for key, value in pairs(collectables) do
	func.add_feature(value.name, "action", collectableIds.id ,function(feat)
		script.set_global_i(value.global, value.amount)
		menu.notify("All "..value.name.. " given", "Rimurus Menu", 5, 0xFF00EE00)
	end)
end

----
-- Lobby Options
local lobbyMalic = func.add_feature("Malicious", "parent", lobbyOpt.id)
local lobbyTroll = func.add_feature("Trolling", "parent", lobbyOpt.id)
local miscLobby = func.add_feature("Miscellaneous", "parent", lobbyOpt.id)
local vehicleLobby = func.add_feature("Vehicle", "parent", lobbyOpt.id)


func.add_feature("SE Kick", "action", lobbyMalic.id, function()
	for i=0, 31 do
		if i ~= player.player_id() and player.is_player_valid(i) then
			script.trigger_script_event(scriptEvents.kick.hash, i, {i, -1, -1, -1, -1})
		end
	end
end)

func.add_feature("Crash", "action", lobbyMalic.id, function()
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

func.add_feature("Fake Money Bag Drop", "toggle", lobbyTroll.id, function(feat)
	streaming.request_model(gameplay.get_hash_key("prop_money_bag_01"))
	if streaming.has_model_loaded(gameplay.get_hash_key("prop_money_bag_01")) then
		while feat.on do
			for i=0, 31 do	
				if player.is_player_valid(i) then
					local bags = object.create_object(gameplay.get_hash_key("prop_money_bag_01"), player.get_player_coords(i), true, true)
					entity.set_entity_no_collsion_entity(bags, player.get_player_ped(i), false)
					entity.set_entity_heading(bags, player.get_player_heading(i))
					entity.set_entity_coords_no_offset(bags, player.get_player_coords(i))
				end
				system.wait(10)
			end		
		end
	end	
end)

func.add_feature("Fake Money Drop", "toggle", lobbyTroll.id, function(feat)
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

func.add_feature("Destroy Personal Vehicles", "action", lobbyTroll.id, function()
	for i=0, 31 do
		if i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.destroyPersonalVehicle.hash, i, {i, i}) --destroy personal
			script.trigger_script_event(scriptEvents.vehicleKick.hash, i, {i, 0, 0, 0, 0, 1, i, math.min(2147483647, gameplay.get_frame_count())}) --kickout
		end
	end
end)

func.add_feature("Water Jet", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) and i ~= player.player_id() then
			createExplosion(13, player.get_player_coords(i))
		end
	end
end)

func.add_feature("Fire Jet", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) and i ~= player.player_id() then
			createExplosion(12, player.get_player_coords(i))
		end
	end
end)

func.add_feature("Steam Jet", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) and i ~= player.player_id() then
			createExplosion(11, player.get_player_coords(i))
		end
	end
end)

func.add_feature("Fake Suspend", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			script.trigger_script_event_2(1 << i, 1075676399, player.player_id(), "HUD_ROSBANX")
		end
	end
end)

func.add_feature("Fake Ban", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			script.trigger_script_event_2(1 << i, 1075676399, player.player_id(), "HUD_ROSBANX")
		end
	end
end)

func.add_feature("Cash Removed", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			script.trigger_script_event(scriptEvents.message.hash, i, {i, -1197151915, 2147483647}) --cash removed
		end
	end
end)

func.add_feature("Cash Dropped", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			script.trigger_script_event(scriptEvents.message.hash, i, {i, 414496857, 2147483647}) --cash banked
		end
	end
end)

func.add_feature("Cash Stolen", "action", lobbyTroll.id, function()
	for i=0, 31 do	
		if player.is_player_valid(i) then
			script.trigger_script_event(scriptEvents.message.hash, i, {i, -28878294, 2147483647}) --cash removed
		end
	end
end)
-------
func.add_feature("RP Drop", "toggle", miscLobby.id, function(feat)
	streaming.request_model(1025210927)
	while feat.on do	
		for i=0, 31 do
			if player.is_player_valid(i) then
				if streaming.has_model_loaded(1025210927) then
					native.call(0x673966A0C0FD7171, 0x2C014CA6, player.get_player_coords(i), 0, 1, 1025210927, 0, 1)
				end
			end
		end
		system.wait(5)
	end		
end)

func.add_feature("Rank up", "action", miscLobby.id, function(feat)
		for i=0, 31 do
			if player.is_player_valid(i) then
				for i = 0, 9 do
					script.trigger_script_event(scriptEvents.peyote.hash, i, {i, 0, i, 1, 1, 1})
					script.trigger_script_event(scriptEvents.peyote.hash, i, {i, 1, i, 1, 1, 1})
					script.trigger_script_event(scriptEvents.peyote.hash, i, {i, 3, i, 1, 1, 1})
					script.trigger_script_event(scriptEvents.peyote.hash, i, {i, 10, i, 1, 1, 1})
					system.yield()
				end		
			end
		end
end)

func.add_feature("Bounty", "action", miscLobby.id, function(f)
	for i=0, 31 do
		if player.is_player_valid(i) and i ~= player.player_id() then
			script.trigger_script_event(scriptEvents.bounty.hash, i, {69, i, 1, 10000, 0, 1,  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, script.get_global_i(1923597 + 9), script.get_global_i(1923597 + 10)})
		end
	end
end)

func.add_feature("Boost Vehicles", "action", vehicleLobby.id, function(f)
	for i=0, 31 do
		if player.is_player_in_any_vehicle(i) then
			menu.create_thread(function()
				natives.VEHICLE.SET_VEHICLE_FORWARD_SPEED(player.get_player_vehicle(i), 2000.0)
			end)
		end
	end
end)

func.add_feature("Repair Vehicles", "action", vehicleLobby.id, function(f)
	for i=0, 31 do
		if player.is_player_valid(i) then
			if player.is_player_in_any_vehicle(i) then
				natives.VEHICLE.SET_VEHICLE_FIXED(player.get_player_vehicle(i))
			end
		end
	end
end)

func.add_feature("Upgrade Vehicles", "action", vehicleLobby.id, function(f)
	for i=0, 31 do
		if player.is_player_valid(i) then
			if player.is_player_in_any_vehicle(i) then
				menu.create_thread(function()
					local veh = player.get_player_vehicle(i)
					natives.VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 0, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 0) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 1, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 1) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 2, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 2) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 3, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 3) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 4, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 4) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 5, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 5) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 6, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 6) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 7, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 7) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 8, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 8) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 9, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 9) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 10, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 10) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 11, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 11) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 12, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 12) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 13, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 13) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 14, 10, false)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 15, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 15) - 1, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 16, natives.VEHICLE.GET_NUM_VEHICLE_MODS(veh, 16) - 1, true)
					natives.VEHICLE.SET_VEHICLE_WHEEL_TYPE(veh, 7)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 23, 19, true)
					natives.VEHICLE.SET_VEHICLE_MOD(veh, 24, 30, true)
					natives.VEHICLE.TOGGLE_VEHICLE_MOD(veh, 18, true)
					natives.VEHICLE.TOGGLE_VEHICLE_MOD(veh, 20, true)
					natives.VEHICLE.TOGGLE_VEHICLE_MOD(veh, 22, true)
					natives.VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(veh, 255, 105, 180)
					natives.VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
					natives.VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
					natives.VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, "Rimuru")
					natives.VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(veh, 25, 25, 112)
					natives.VEHICLE.SET_VEHICLE_MOD_COLOR_1(veh, 3, 0, 0)
					natives.VEHICLE.SET_VEHICLE_MOD_COLOR_2(veh, 3, 0)
					natives.VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(veh, 255, 255, 255)
				end)
			end
		end
	end
end)

------------

func.add_feature("Go Ghosted To Lobby", "toggle", lobbyOpt.id, function(feat)
	while feat.on do
		for i=1, 31 do
			natives.NETWORK.SET_RELATIONSHIP_TO_PLAYER(i, true)
			if not feat.on then
				natives.NETWORK.SET_RELATIONSHIP_TO_PLAYER(i, false)
			end
		end
		system.wait(0)
	end
end)

func.add_feature("Discord", "action", lobbyOpt.id, function(feat)
	for i=0, 31 do
		if player.is_player_valid(i)  then
			script.trigger_script_event_2(1 << i, -647821994, player.player_id(), "~b~discord.gg/rimurus")
		end
	end
end)

func.add_feature("Job Text", "action", lobbyOpt.id, function(feat)
	local status, msg = input.get("Input your text", "", 70, 0)    
	if status == 0 then
		for i=0, 31 do
			if player.is_player_valid(i)  then
				script.trigger_script_event_2(1 << i, -647821994, player.player_id(), "<font size='30'>~g~~h~"..msg)
			end
		end
	end
end)

---
func.add_feature(translations.miscSub.riot, "toggle", menu_configuration_features.MiscellaniousParent.id, function(f)
	while f.on do
		natives.MISC.SET_RIOT_MODE_ENABLED(true)
		system.wait(0)
	end
	if not f.on then
		natives.MISC.SET_RIOT_MODE_ENABLED(false)		
	end
end)

func.add_feature(translations.miscSub.flash, "toggle", menu_configuration_features.MiscellaniousParent.id, function(toggle)
	while toggle.on do
		graphics.set_next_ptfx_asset('scr_powerplay')

		while not graphics.has_named_ptfx_asset_loaded('scr_powerplay') do
			graphics.request_named_ptfx_asset('scr_powerplay')
			system.wait(0)
		end

		graphics.start_networked_ptfx_looped_at_coord("sp_powerplay_beast_appear_trails", player.get_player_coords(player.player_id()), v3(0,0,0), 1, true, true, true)
		system.wait(0)
	end
end)

local drone = func.add_feature("Recon Drone", "toggle", menu_configuration_features.MiscellaniousParent.id, function(feat)
	menu.notify("Press E To Fire", "Made By Err_Net_Array", 6, RGBAToInt(144, 151, 245, 255))
	droneMode(feat)
end)

local parade = func.add_feature(translations.miscSub.parade, "toggle", menu_configuration_features.MiscellaniousParent.id, function(toggle)
	while toggle.on do
		BlackParade()
		system.wait(0)
	end
end)

local respawn = func.add_feature(translations.miscSub.respawn, "toggle", menu_configuration_features.MiscellaniousParent.id, function(f)
	while f.on do
		if ped.get_ped_health(player.player_ped()) == 0 then
			local pos = player.get_player_coords(player.player_id())
			system.wait(4000)
			entity.set_entity_coords_no_offset(player.player_ped(), pos)
		end
		system.wait(0)
	end
end)

func.add_feature(translations.miscSub.noTarget, "toggle", menu_configuration_features.MiscellaniousParent.id, function(f)
	while f.on do
		native.call(0x8EEDA153AD141BA4, player.player_id(), f.on)
		system.wait(0)
	end
end)

local fcrouch = func.add_feature(translations.miscSub.crouch, "toggle", menu_configuration_features.MiscellaniousParent.id, function(f)
	local crouch = false
	while f.on do
		natives.PAD.DISABLE_CONTROL_ACTION(0, 36, true)
		if controls.is_disabled_control_just_pressed(0, 36) and not crouch and not player.is_player_in_any_vehicle(player.player_id()) then
			crouch = true
			natives.PED.RESET_PED_MOVEMENT_CLIPSET(player.player_ped(), 0.0)
			natives.CAM.DISABLE_AIM_CAM_THIS_UPDATE()
			natives.PED.SET_PED_CAN_PLAY_AMBIENT_ANIMS(player.player_ped(), false)
			natives.PED.SET_PED_CAN_PLAY_AMBIENT_BASE_ANIMS(player.player_ped(), false)
			natives.CAM.SET_THIRD_PERSON_AIM_CAM_NEAR_CLIP_THIS_UPDATE(-10.0)
			streaming.request_anim_set("move_ped_crouched")
			natives.PED.SET_PED_MOVEMENT_CLIPSET(player.player_ped(), "move_ped_crouched", 1.0)
			streaming.request_anim_set("move_ped_crouched_strafing")
			natives.PED.SET_PED_STRAFE_CLIPSET(player.player_ped(), "move_ped_crouched_strafing")
		elseif controls.is_disabled_control_just_pressed(0, 36) and crouch and not player.is_player_in_any_vehicle(player.player_id()) then
			crouch = false
			natives.PED.SET_PED_CAN_PLAY_AMBIENT_ANIMS(player.player_ped(), true)
			natives.PED.SET_PED_CAN_PLAY_AMBIENT_BASE_ANIMS(player.player_ped(), true)
			streaming.remove_anim_set("move_ped_crouched")
			streaming.remove_anim_set("move_ped_crouched_strafing")
			natives.PED.RESET_PED_MOVEMENT_CLIPSET(player.player_ped(),1.0)
			natives.PED.RESET_PED_STRAFE_CLIPSET(player.player_ped())
		end
		system.yield(0)
	end
	natives.PED.SET_PED_CAN_PLAY_AMBIENT_ANIMS(player.player_ped(), true)
	natives.PED.SET_PED_CAN_PLAY_AMBIENT_BASE_ANIMS(player.player_ped(), true)
	streaming.remove_anim_set("move_ped_crouched")
	streaming.remove_anim_set("move_ped_crouched_strafing")
	natives.PED.RESET_PED_MOVEMENT_CLIPSET(player.player_ped(),1.0)
	natives.PED.RESET_PED_STRAFE_CLIPSET(player.player_ped())
	natives.PAD.ENABLE_CONTROL_ACTION(0, 36, true)
end)

func.add_feature(translations.miscSub.rockstar, "action", menu_configuration_features.MiscellaniousParent.id, function()
	local status, msg = input.get("Input A Message", "", 100, 0)    
	if status == eInputResponse.IR_SUCCESS then
		network.send_chat_message(string.format("¦ %s", msg), false)
	end
end)

func.add_feature(translations.miscSub.locked, "action", menu_configuration_features.MiscellaniousParent.id, function()
	local status, msg = input.get("Input A Message", "", 100, 0)    
	if status == eInputResponse.IR_SUCCESS then
		network.send_chat_message(string.format("Ω %s", msg), false)
	end
end)

func.add_feature(translations.miscSub.gWings, "action", menu_configuration_features.MiscellaniousParent.id, function()
	local wingsHash = gameplay.get_hash_key("vw_prop_art_wings_01a")

    if streaming.is_model_valid(wingsHash) then
	    streaming.request_model(wingsHash)
	    while not streaming.has_model_loaded(wingsHash) and utils.time_ms() + 450 > utils.time_ms() do
		    system.wait(0)
	    end

	    local wings = object.create_object(wingsHash, entity.get_entity_coords(player.player_id(), true), true, true)

	    entity.attach_entity_to_entity(wings, player.player_ped(), ped.get_ped_bone_index(player.player_ped(), 0x5c01), v3(-1,0,0), v3(00,90,0), true, false, true, 0, true)
	    streaming.set_model_as_no_longer_needed(wingsHash)
    end
end)

func.add_feature(translations.miscSub.rWings, "action", menu_configuration_features.MiscellaniousParent.id, function()
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

func.add_feature(translations.miscSub.bail, "action", menu_configuration_features.MiscellaniousParent.id, function()
	natives.NETWORK.NETWORK_BAIL(0,0,0)
end)

local hudSub = func.add_feature(translations.miscSub.hud, "parent", menu_configuration_features.MiscellaniousParent.id)

menu.create_thread(function()
	local hud = require("Rimuru.tables.hud")

	for _, v in ipairs(hud) do
		func.add_feature(v.name, "action", hudSub.id, function()
			local status, ABGR, red, green, blue
		repeat
			status, ABGR, red, green, blue = cheeseUtils.pick_color()
			if status == 2 then
				return
			end
			natives.HUD.REPLACE_HUD_COLOUR_WITH_RGBA(v.index, math.floor(red), math.floor(green), math.floor(blue), 255)
			system.wait(0)
		until status == 0
		end)
	end
end)
---

local weatherTypes <const> = require("Rimuru.tables.weatherTypes")

local weather = func.add_feature(translations.worldSub.timeCycle, "parent", menu_configuration_features.WorldParent.id)

local weatherSettins = {}

menu.create_thread(function()
	local weatherHash = native.call(0x711327CD09C8F162):__tointeger()--GET_NEXT_WEATHER_TYPE_HASH_NAME
  for index, var in ipairs(weatherTypes) do 
	menu.create_thread(function()
		local feat = func.add_feature(var, "value_f", weather.id, function(f)
			while f.on do
				
				for region=0, 1 do
					for frame=0,12 do
						timecycle.set_timecycle_keyframe_var(weatherHash, region, frame, var, f.value);
					end
				end
				system.wait(0)
			end
		end)
		feat.mod = 1.0
		feat.min = 0.0
		feat.max = 10.0
	end)

	for region=0, 1 do
		for frame=0,12 do
			weatherSettins[#weatherSettins+1] = timecycle.get_timecycle_keyframe_var(weatherHash, region, frame, var);
		end
	end
  end
end)

local trainOpt = func.add_feature(translations.worldSub.train, "parent", menu_configuration_features.WorldParent.id)

func.add_feature(translations.worldSub.trainSub.Hijack, "action", trainOpt.id, function(f)
	local train = get_closest_train()
	if train ~= 0 and not ped.is_ped_in_any_vehicle(player.player_ped()) then
		entity.delete_entity(vehicle.get_ped_in_vehicle_seat(train, -1))
		ped.set_ped_into_vehicle(player.player_ped(), train, -1)
	end
	if train == 0 then
		menu.notify("Could not find any train nearby")
	end
end)

local trainSpeed = 10.0
local trainMaxSpeed = 300.0
local trainMax = func.add_feature(translations.worldSub.trainSub.speed, "autoaction_value_f", trainOpt.id, function(f)
	trainMaxSpeed = f.value
end)
trainMax.max = 9999.0
trainMax.min = 0
trainMax.mod = 2.0
trainMax.value = trainMaxSpeed

func.add_feature(translations.worldSub.trainSub.drive, "toggle", trainOpt.id, function(f)
	while f.on do

		local speed = entity.get_entity_speed(ped.get_vehicle_ped_is_using(player.player_ped()))*2.236936
		
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
		
		natives.VEHICLE.SET_TRAIN_SPEED(get_closest_train(), trainSpeed)
		natives.VEHICLE.SET_TRAIN_CRUISE_SPEED(get_closest_train(), trainSpeed)
		system.wait(0)
	end
end)

local trainTrack = func.add_feature(translations.worldSub.trainSub.change, "value_i", trainOpt.id, function(f)
	while f.on do
		VEHICLE.SWITCH_TRAIN_TRACK(f.value, true)
		system.wait(0)
	end
end)
trainTrack.max = 12
trainTrack.min = 0
trainTrack.mod = 1
trainTrack.value = 0


func.add_feature(translations.worldSub.trainSub.derail, "toggle", trainOpt.id, function(f)
	local train = get_closest_train()
	if train ~= 0 then
		natives.VEHICLE.SET_RENDER_TRAIN_AS_DERAILED(train, f.on)
	end
end)

func.add_feature(translations.worldSub.trainSub.delete, "action", trainOpt.id, function(f)
	local train = get_closest_train()
	if train ~= 0 then
		entity.delete_entity(train)
	end
end)

func.add_feature(translations.worldSub.trainSub.deleteAll, "action", trainOpt.id, function(f)
	natives.VEHICLE.DELETE_ALL_TRAINS()
end)
----------
local espSub = func.add_feature(translations.worldSub.esp, "parent", menu_configuration_features.WorldParent.id)
local espPlayer = func.add_feature(translations.worldSub.espSub.player, "parent", espSub.id)
local espEntity = func.add_feature(translations.worldSub.espSub.entity, "parent", espSub.id)

local espColour = {r=0, g=0, b=0, a=255}

local feat = func.add_feature("ESP Colour", "action", espSub.id, function(f)
	local status, ABGR, red, green, blue
	repeat
		status, ABGR, red, green, blue = cheeseUtils.pick_color()
		if status == 2 then
			return
		end
		espColour.r = red
		espColour.g = green
		espColour.b = blue
		system.wait(0)
	until status == 0
end)


func.add_feature("ESP Snaplines", "toggle", espEntity.id, function(f)
	while f.on do
		local vehs = vehicle.get_all_vehicles()
		for i=1, #vehs do
    	    ui.draw_line(player.get_player_coords(player.player_id()), entity.get_entity_coords(vehs[i]), espColour.r, espColour.g, espColour.b, 255)
		end
		system.wait(0)
	end
end)

func.add_feature("ESP box", "toggle", espEntity.id, function(f)
	while f.on do
		local vehs = vehicle.get_all_vehicles()

		for i=1, #vehs do
			draw_box_esp(vehs[i], RGBAToInt(espColour.r, espColour.g, espColour.b, 255))
		end
		system.wait(0)
	end
	if f.on then
		menu.notify("Esp Math by sub1to")
	end
end)

func.add_feature("ESP Snaplines", "toggle", espPlayer.id, function(f)
	while f.on do
		for i=0, 32 do
    	    if i ~= player.player_id() then
    	        if player.is_player_valid(i) and player.get_player_health(i) > 0 and i ~= player.player_id() then                
				
    	            ui.draw_line(player.get_player_coords(player.player_id()), player.get_player_coords(i), espColour.r, espColour.g, espColour.b, 255)
				end
			end
		end
		system.wait(0)
	end
end)

func.add_feature("ESP box", "toggle", espPlayer.id, function(f)
	while f.on do
		for i=0, 31 do 
			if player.is_player_valid(i) and player.get_player_health(i) > 0 and i ~= player.player_id() then                
				draw_box_esp(player.get_player_ped(i), RGBAToInt(espColour.r, espColour.g, espColour.b, 255))
			end
		end
		system.wait(0)
	end
	if f.on then
		menu.notify("Made by sub1to")
	end
end)

local f = func.add_feature(translations.worldSub.party, "toggle", menu_configuration_features.WorldParent.id, function(f)
	while f.on do
		local obs = object.get_all_objects()
		for i=1, #obs do
			if obs[i] == 1043035044 or 862871082 or 3639322914 then
				natives.ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(obs[i], math.random(0, 2))
			end
		end
		system.wait(30)
	end
end)

local function getPedFromHash(hash)
    for i=1, #pedList do
        if hash == gameplay.get_hash_key(pedList[i]) then
            return pedList[i]
        end
    end
end

local function getObjectFromHash(hash)
    for i=1, #objects do
        if hash == gameplay.get_hash_key(objects[i]) then
            return objects[i]
        end
    end
end


local spawnedEditor ={objects = {}, worldObjects = {},
props = {}, peds = {}, animals = {}}


--
--objectFeat.hl_func = function(feat, data)
--	if feat.is_highlighted then
--        local ob = SpawnObj(feat.value)
--        entity.set_entity_alpha(ob, 60, false)
--	end
--end


func.add_feature(translations.worldSub.spawnerSub.namePed, "action", menu_configuration_features.SpawnerParent.id, function(feat)
	spawnedEditor.peds[#spawnedEditor.peds+1] = SpawnPedFromName()
end)


func.add_feature(translations.worldSub.spawnerSub.peds, "action_value_str", menu_configuration_features.SpawnerParent.id, function(feat)
	spawnedEditor.peds[#spawnedEditor.peds+1] = SpawnPed(feat.value)
end):set_str_data(pedList)

func.add_feature(translations.worldSub.spawnerSub.animals, "action_value_str", menu_configuration_features.SpawnerParent.id, function(feat)
	spawnedEditor.peds[#spawnedEditor.peds+1] = SpawnAnimal(feat.value)
end):set_str_data(animalsPeds)

local spawnedEnts = func.add_feature(translations.worldSub.spawnerSub.spawned, "parent", menu_configuration_features.SpawnerParent.id)
local spawnedObjs = func.add_feature("Spawned Objects", "parent", spawnedEnts.id)
local spawnedPeds = func.add_feature("Spawned Peds", "parent", spawnedEnts.id)

local spawnedObjFeats = {}

local function createObjectOptions()
    for i=1, #spawnedEditor.objects do
        local obj = spawnedEditor.objects[i]
        if obj ~= nil then
            if not spawnedObjFeats[obj] then
                spawnedObjFeats[obj] = func.add_feature(tostring(getObjectFromHash(entity.get_entity_model_hash(obj))), "parent", spawnedObjs.id)
                          
                func.add_feature("Teleport to me", "action", spawnedObjFeats[obj].id, teleportToMeCallback).data = obj
                func.add_feature("Teleport to entity", "action", spawnedObjFeats[obj].id, teleportToEntityCallback).data = obj
               
                local sSens = func.add_feature("Scroll Sensitivity", "autoaction_value_f", spawnedObjFeats[obj].id, moveXCallback)
                sSens.data = obj
                sSens.mod = 0.5
                sSens.min = 0.0
                sSens.max = 1.0
                sSens.value = 0.1
               
                local pAlpha = func.add_feature("Move x", "autoaction_value_f", spawnedObjFeats[obj].id, moveXCallback)
                pAlpha.data = obj
                pAlpha.mod = sSens.value
                pAlpha.min = -214748364.0
                pAlpha.max = 214748364.0
                pAlpha.value = getPos(obj).x

                local entY = func.add_feature("Move y", "autoaction_value_f", spawnedObjFeats[obj].id, moveYCallback)
                entY.data = obj
                entY.mod = sSens.value
                entY.min = -214748364.0
                entY.max = 214748364.0
                entY.value = getPos(obj).y
                
                local moveZ = func.add_feature("Move z", "autoaction_value_f", spawnedObjFeats[obj].id, moveZCallback)
                moveZ.data = obj
                moveZ.mod = sSens.value
                moveZ.min = -214748364.0
                moveZ.max = 214748364.0
                moveZ.value = getPos(obj).z

                local pitch = func.add_feature("Pitch", "autoaction_value_f", spawnedObjFeats[obj].id, PitchCallback)
                pitch.data = obj
                pitch.mod = sSens.value
                pitch.min = -214748364.0
                pitch.max = 214748364.0
                pitch.value = getRot(obj).x
                
                local yaw = func.add_feature("Yaw", "autoaction_value_f", spawnedObjFeats[obj].id, YawCallback)
                yaw.data = obj
                yaw.mod = sSens.value
                yaw.min = -214748364.0
                yaw.max = 214748364.0
                yaw.value = getRot(obj).y
                
                local entZ = func.add_feature("Roll", "autoaction_value_f", spawnedObjFeats[obj].id, RollCallback)
                entZ.data = obj
                entZ.mod = sSens.value
                entZ.min = -214748364.0
                entZ.max = 214748364.0
                entZ.value = getRot(obj).z

                func.add_feature("Freeze", "toggle", spawnedObjFeats[obj].id, freezeEntCallback).data = obj
                func.add_feature("Delete", "action", spawnedObjFeats[obj].id, deleteCallback).data = obj
            end
        end 
    end
end

local spawnedPedFeats = {}

local function createPedOptions()
    for i=1, #spawnedEditor.peds do
        local ped = spawnedEditor.peds[i]
        if ped ~= nil then
            if not spawnedPedFeats[ped] then
                spawnedPedFeats[ped] = func.add_feature(tostring(getPedFromHash(entity.get_entity_model_hash(ped))), "parent", spawnedPeds.id)

                func.add_feature("Teleport to me", "action", spawnedPedFeats[ped].id, teleportToMeCallback).data = ped
                func.add_feature("Teleport to entity", "action", spawnedPedFeats[ped].id, teleportToEntityCallback).data = ped

                local pAlpha = func.add_feature("Move x", "autoaction_value_f", spawnedPedFeats[ped].id, moveXCallback)
                pAlpha.data = ped
                pAlpha.mod = 1.0
                pAlpha.min = -214748364.0
                pAlpha.max = 214748364.0
                pAlpha.value = getPos(ped).x      
                
                local entY = func.add_feature("Move y", "autoaction_value_f", spawnedPedFeats[ped].id, moveYCallback)
                entY.data = ped
                entY.mod = 0.5
                entY.min = -214748364.0
                entY.max = 214748364.0
                entY.value = getPos(ped).y
                
                local entZ = func.add_feature("Move z", "autoaction_value_f", spawnedPedFeats[ped].id, moveZCallback)
                entZ.data = ped
                entZ.mod = 1.0
                entZ.min = -214748364.0
                entZ.max = 214748364.0
                entZ.value = getPos(ped).z
                
                func.add_feature("Apply random outfit", "action", spawnedPedFeats[ped].id, outfitCallback).data = ped
                func.add_feature("Freeze", "toggle", spawnedPedFeats[ped].id, freezeEntCallback).data = ped
                func.add_feature("Delete", "action", spawnedPedFeats[ped].id, deleteCallback).data = ped
            end
        end 
    end
end

-- Create a table to keep track of loaded scripts
--local loadedScripts = {}
--
--menu.create_thread(function()
--    local responseCode, list = web.get("https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Modules/moduleList.lua")
--    
--    if responseCode == 200 then
--        local chunk, err = load(list, "https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Modules/moduleList.lua")
--        assert(chunk, string.format("Failed to load GitHub file: %s", err))
--        local success, result = pcall(chunk)
--        assert(success, string.format("Failed to exec GitHub file: %s", result))
--
--        if success then
--            for key, scriptName in pairs(result) do
--                -- Check if the script is already loaded before adding a new feature
--                if not loadedScripts[scriptName.name] then
--                    menu.create_thread(function ()
--                        func.add_feature(scriptName.name, "action", modulesParent.id, function()
--                            downloadModule(scriptName.name, scriptName.link)
--                            executeModule(scriptName.name)
--                            menu.notify("Loaded "..scriptName.name.."\nAuthor: "..scriptName.author)
--                        end)
--                    end)
--                    -- Mark the script as loaded in the table
--                    loadedScripts[scriptName.name] = true
--                end
--            end
--        end
--    end
--end)


require("Rimuru.libs.Drone")
require("Rimuru.libs.playerOptions")


stuff.threads[#stuff.threads + 1] = menu.create_thread(function()
    while true do
        createObjectOptions()
        createPedOptions()
        coroutine.yield(600)
    end
end)

end
if httpTrustedOff then
	loadCurrentMenu()
end