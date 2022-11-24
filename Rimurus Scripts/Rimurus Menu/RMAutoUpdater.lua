local status = true
local appdata_path = utils.get_appdata_path("PopstarDevs", "2Take1Menu")

local filePaths = {
	RimuruMenu = appdata_path.."\\scripts\\RimuruMenu.luac",

	--libs
	gltw = appdata_path.."\\scripts\\cheesemenu\\libs\\GLTW.lua",
	getinput = appdata_path.."\\scripts\\cheesemenu\\libs\\Get Input.lua",
	functionsLib = appdata_path.."\\scripts\\Rimmuru\\libs\\Functionslib.luac",
	moduleInstaller = appdata_path.."\\scripts\\Rimmuru\\libs\\moduleInstaller.luac",
	settings = appdata_path.."\\scripts\\Rimmuru\\libs\\settings.luac",
	
	--feats
	playerOptions = appdata_path.."\\scripts\\Rimmuru\\libs\\feats\\playerOptions.luac",
	Aimbot = appdata_path.."\\scripts\\Rimmuru\\libs\\feats\\Aimbot.luac",
	Drone = appdata_path.."\\scripts\\Rimmuru\\libs\\feats\\Drone.luac",
	World = appdata_path.."\\scripts\\Rimmuru\\libs\\feats\\World.luac",
	editor = appdata_path.."\\scripts\\Rimmuru\\libs\\feats\\editor.luac",
	
}
local files = {
	RimuruMenu = [[https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Rimurus%20Menu/RimurusMenu.luac]],
	
	--libs
	gltw = [[https://raw.githubusercontent.com/GhustOne/CheeseMenu/main/cheesemenu/libs/GLTW.lua]],
	getinput = [[https://raw.githubusercontent.com/GhustOne/CheeseMenu/main/cheesemenu/libs/Get%20Input.lua]],
	functionsLib = [[https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/Functionslib.luac]],
	moduleInstaller = [[https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/moduleInstaller.luac]],
	settings = [[https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/settings.luac]],

	-- feats
	playerOptions = [[https://raw.githubusercontent.com/Rimmuru/Rimurus-2T1-Scripts/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/feats/playerOptions.luac]],
	Aimbot = [[https://raw.githubusercontent.com/Rimurus-2T1-Scripts/tree/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/feats/Aimbot.luac]],
	Drone = [[https://raw.githubusercontent.com/Rimurus-2T1-Scripts/tree/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/feats/Drone.luac]],
	World = [[https://raw.githubusercontent.com/Rimurus-2T1-Scripts/tree/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/feats/World.luac]],
	editor = [[https://raw.githubusercontent.com/Rimurus-2T1-Scripts/tree/main/Rimurus%20Scripts/Rimurus%20Menu/Rimuru/libs/feats/editor.luac]]
}

local all_files = 0
local downloaded_files = 0
for k, v in pairs(files) do
	all_files = all_files + 1
	menu.create_thread(function()
		local responseCode, file = web.get(v)
		if responseCode == 200 then
			files[k] = file
			downloaded_files = downloaded_files + 1
		else
			print("Failed to download: "..v)
			status = false
		end
	end)
end
while downloaded_files < all_files and status do
	system.wait(0)
end

if status then
	for k, v in pairs(files) do
		local currentFile = io.open(filePaths[k], "a+")
		if not currentFile then
			status = "ERROR REPLACING"
			break
		end
        currentFile:close()
	end
	if status ~= "ERROR REPLACING" then
		for k, v in pairs(files) do
			local currentFile = io.open(filePaths[k], "w+b")
			if currentFile then
				currentFile:write(v)
				currentFile:flush()
				currentFile:close()
			else
				status = "ERROR REPLACING"
			end
		end
	end
end

return status
