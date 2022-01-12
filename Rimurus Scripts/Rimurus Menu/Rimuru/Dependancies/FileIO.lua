require("Rimuru\\Tables\\Models")
require("Rimuru\\Tables\\Peds")
require("Rimuru\\Tables\\Weapons")
require("Rimuru\\Tables\\Vehicles")

function LoadFaves()
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"

    objfile = io.open(appdata.."scripts\\Rimuru\\FavouriteObj.txt", "r+")
    pedfile = io.open(appdata.."scripts\\Rimuru\\FavouritePed.txt", "r+")

    for line in objfile:lines() do
       table.insert(favouriteModels, line);
    end
  
    for line in pedfile:lines() do
       table.insert(favouritePeds, line);
    end
end

function SaveFaves(obj_id, ped_id)
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
    objfile = io.open(appdata.."scripts\\Rimuru\\FavouriteObj.txt", "r+")
    pedfile = io.open(appdata.."scripts\\Rimuru\\FavouritePed.txt", "r+")
   
    io.output(objfile)  
    io.write((Objs[obj_id.value+1].."\n"))
    io.close(objfile)

    io.output(pedfile)  
    io.write((pedList[ped_id.value+1].."\n"))
    io.close(pedfile)
end