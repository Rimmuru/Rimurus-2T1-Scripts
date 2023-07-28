-- Made by GhostOne
-- L00naMods "Even if you say L00na is a bitch just put my name in there somewhere"
-- Ghost's Lua Table Writer
--[[
table[] string	gltw.write(table, string name, string path|nil, table index exclusions, skip empty tables, compile)
example: gltw.write({name = "l00na", iq = -1, braincells = {}}, "something", "folder1\\", {"name"}, true) < this will not write 'name' (excluded) or 'braincells' (empty)

table[]	        gltw.read(string name, string path|nil(in same path as lua), table|nil, bool|nil, bool|nil)
-- if a table is the 3rd arg then whatever is read from the file will be added to it without overwriting stuff that isn't in the saved file
-- if the 4th arg is true it will compare types of entries in 3rd arg table and the read one, if they match or are nil it will write to 3rd arg table
-- if the 5th arg is true the function won't throw an error if the file doesn't exist and will return nil
]]

local gltw				<const>	= {}
local type				<const> = type
local l_next			<const> = next
local ipairs			<const> = ipairs
local tostring			<const> = tostring
local string_format		<const> = string.format
local string_match		<const> = string.match

local appdata_path		<const> = utils and utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\" or ""
local _loadfile			<const> = _loadfile or loadfile

local long_str_levels	<const> = {}
for i = 0, 100 do
	long_str_levels[i]			= string.rep("=", i+1)
end

local str_level_pattern <const> = "%](=*)%]"

-- Thanks to Proddy for tips on optimization
local write_table
function gltw.write_table(tableTW, indentation, exclusions, exclude_empty, string_lines, string_lines_count)
	for k, v in l_next, tableTW do
		if not exclusions[k] then
			local typeofv <const> = type(v)
			local index
			if type(k) == "number" then
				index = "["..k.."] = "
			else
				index = "["..string_format("%q", k).."] = "
			end

			if typeofv == "string" then
				string_lines_count = string_lines_count + 1

				local long_str_level = string_match(v, str_level_pattern)
				long_str_level = long_str_level and long_str_levels[#long_str_level] or ""
				string_lines[string_lines_count] = indentation..index.."["..long_str_level.."["..v.."]"..long_str_level.."],"

			elseif typeofv ~= "function" and typeofv ~= "table" then
				string_lines_count = string_lines_count + 1
				string_lines[string_lines_count] = indentation..index..tostring(v)..","

			elseif typeofv == "table" and (exclude_empty and l_next(v) or not exclude_empty) then
				string_lines_count = string_lines_count + 1
				string_lines[string_lines_count] = indentation..index.."{"
				string_lines_count = write_table(v, indentation.."	", exclusions, exclude_empty, string_lines, string_lines_count)

				string_lines_count = string_lines_count + 1
				string_lines[string_lines_count] = indentation.."},"
			end
		end
	end

	return string_lines_count
end
write_table = gltw.write_table

function gltw.write(tableTW, name, path, exclusions, exclude_empty, compiled)
	local convertedExclusions = {}
	if exclusions then
		for _, v in ipairs(exclusions) do
			convertedExclusions[v] = true
		end
	end
	assert(tableTW, "no table was provided"..(name and " to write for file '"..name.."'" or ""))

	if name then
		name = name:sub(-4) == ".lua" and name or name..".lua"
		path = path or ""
		assert(type(name) == "string" and type(path) == "string", "name or path isn't a string")
	end

	local string_lines = {}
	local string_lines_count = 1

	string_lines[string_lines_count] = "return {"
	gltw.write_table(tableTW, "	", convertedExclusions, exclude_empty, string_lines, string_lines_count)
	string_lines[#string_lines + 1] = "}"

	if name then
		local file = io.open(path..name, "wb")
		assert(file, "'"..name.."' was not created.")

		local stringified = table.concat(string_lines, "\n")

		file:write(compiled and string.dump(load(stringified), true) or stringified)

		file:flush()
		file:close()
	end

	return string_lines
end

function gltw.add_to_table(getTable, addToTable, typeMatched)
	assert(type(getTable) == "table" and type(addToTable) == "table", "args have to be tables")
	for k, v in l_next, getTable do
		if type(v) ~= "table" then
			if typeMatched and (type(getTable[k]) == type(addToTable[k]) or not addToTable[k]) or not typeMatched then
				addToTable[k] = getTable[k]
			end
		else
			if type(addToTable[k]) ~= "table" and not typeMatched then
				addToTable[k] = {}
			end
			if type(addToTable[k]) == "table" then
				gltw.add_to_table(getTable[k], addToTable[k])
			end
		end
	end
end

function gltw.read(name, path, addToTable, typeMatched, overrideError)
	name = name:sub(-4) == ".lua" and name or name..".lua"
	if overrideError and not utils.file_exists(path..name) then
		return
	end

	path = path or ""
	if not (path:sub(-1) == "\\" or path:sub(-1) == "/") then
		path = path .. "\\"
	end
	if not path:find("C:") then
		path = appdata_path..path
	end

	local readTable = _loadfile(path..name, "tb")
	if not readTable then
		error("File does not exist. use an absoulte path or a relative path from 2Take1Menu folder.\nFile: "..path..name)
	end
	readTable = readTable()

	if addToTable then
		gltw.add_to_table(readTable, addToTable, typeMatched)
	end

	return readTable
end

if menu then
	local default_properties <const> = {"on", "value"}

	local property_types <const> = {
		on = 1,
		value = 2,

		name = -1,
		hidden = -1,
		data = -1,
		hint = -1,

		min = 1 << 2 | 1 << 3 | 1 << 7,
		max = 1 << 2 | 1 << 3 | 1 << 7,
		mod = 1 << 2 | 1 << 3 | 1 << 7,
		str_data = 1 << 5,
	}

	---@param fmap table table containing key value pairs, where value is the feature
	---@param name string file containing saved data including or excluding .lua
	---@param path string absolute or relative (starts at 2Take1Menu) path of folder containing saved file
	---@param properties table|nil a table containing properties you want to save, ie `{"on", "value", "max"}`, if nil then it'll save `on` and `value`
	---@param compile bool|nil compile saved file
	function gltw.write_fmap(fmap, name, path, properties, compile)
		local tbl <const> = {}
		for k, feat in pairs(fmap) do
			local f <const> = {}
			for _, property in pairs(properties or default_properties) do
				if feat.type & property_types[property] ~= 0 then
					f[property] = feat[property]
				end
			end
			tbl[k] = next(f) and f or nil
		end

		gltw.write(tbl, name, path, nil, nil, compile)
	end

	---@param fmap table table containing key value pairs, where value is the feature
	---@param name string file containing saved data including or excluding .lua
	---@param path string absolute or relative (starts at 2Take1Menu) path of folder containing saved file
	function gltw.read_fmap(fmap, name, path)
		local tbl <const> = gltw.read(name, path)
		if not tbl then
			return
		end

		for k, saved_data in pairs(tbl) do
			local feat <const> = fmap[k]
			if feat then
				for property, value in pairs(saved_data) do
					if feat.type & property_types[property] ~= 0 then
						feat[property] = value
					end
				end
			end
		end
	end
end

return gltw
