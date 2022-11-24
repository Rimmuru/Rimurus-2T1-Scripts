-- Made by GhostOne
-- L00naMods "Even if you say L00na is a bitch just put my name in there somewhere"
-- Ghost's Lua Table Writer
--[[
nil			gltw.write(table table, string name, string path|nil, table index exclusions, skip empty tables)
-- example gltw.write({name = "l00na", iq = -1, braincells = {}}, "something", "folder1\\", {"name"}, true) < this will not write 'name' (excluded) or 'braincells' (empty)

table[]		gltw.read(string name, string path|nil(in same path as lua), table|nil, bool|nil)
-- if a table is the 3rd arg then whatever is read from the file will be added to it without overwriting stuff that isn't in the saved file
-- if the 4th arg is true the function won't throw an error if the file doesn't exist and will return nil
]]

gltw = {}
local type <const> = type
local l_next <const> = next
local l_pairs <const> = function(t)
	return l_next, t, nil
end
local ipairs <const> = ipairs

function gltw.write_table(tableTW, indentation, exclusions, exclude_empty, string_lines)
	for k, v in l_pairs(tableTW) do
		if not exclusions[k] then
			local typeofv = type(v)
			local index
			if type(k) == "number" then
				index = "["..k.."] = "
			else
				index = "[\""..k.."\"] = "
			end

			if typeofv == "string" then
				string_lines[#string_lines + 1] = indentation..index.."[=["..v.."]=],"
			elseif typeofv ~= "function" and typeofv ~= "table" then
				string_lines[#string_lines + 1] = indentation..index..tostring(v)..","
			elseif typeofv == "table" and (l_next(v) or not exclude_empty) then
				string_lines[#string_lines + 1] = indentation..index.."{"
				gltw.write_table(v, indentation.."	", exclusions, exclude_empty, string_lines)
				string_lines[#string_lines + 1] = indentation.."},"
			end
		end
	end
end

function gltw.write(tableTW, name, path, exclusions, exclude_empty, compiled)
	local convertedExclusions = {}
	if exclusions then
		for _, v in ipairs(exclusions) do
			convertedExclusions[v] = true
		end
	end
	assert(tableTW, "no table was provided"..(name and " to write for file '"..name.."'" or ""))

	if name then
		path = path or ""
		assert(type(name) == "string" and type(path) == "string", "name or path isn't a string")
	end

	local string_lines = {}

	string_lines[#string_lines + 1] = "return {"
	gltw.write_table(tableTW, "	", convertedExclusions, exclude_empty, string_lines)
	string_lines[#string_lines + 1] = "}"

	if name then
		local file = io.open(path..name..".lua", "wb")
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
	for k, v in l_pairs(getTable) do
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

function gltw.read(name, path, addToTable, overrideError, typeMatched)
	if overrideError and not utils.file_exists(path..name..".lua") then
		return
	end

	path = path or ""
	if type(tableRT) == "string" then
		name, path = tableRT, name or path
		tableRT = nil
	end

	if addToTable then
		local readTable = assert(loadfile(path..name..".lua", "tb"))()
		gltw.add_to_table(readTable, addToTable, typeMatched)
		return readTable
	else
		return loadfile(path..name..".lua", "tb")()
	end
end