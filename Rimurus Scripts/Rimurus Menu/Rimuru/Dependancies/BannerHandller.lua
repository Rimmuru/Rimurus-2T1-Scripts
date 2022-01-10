bannerList = {}

local function loadBanners()
    local appdata = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\"
    bannerList = utils.get_all_files_in_directory(appdata.."scripts\\Rimuru\\Dependancies\\Banners", "png")
end
loadBanners()

local function readAllBanners()
    for i = 1, #bannerList do
        LuaUI.setUpBanner("scripts\\Rimuru\\Dependancies\\Banners\\" .. bannerList[i])
    end
end
readAllBanners()