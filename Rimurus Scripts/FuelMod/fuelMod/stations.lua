require("fuelMod\\LuaUI")

Stations = {
    GroveStreet = v3(-67.300, -1761.404, 28.314),
    Strawberry = v3(-720.801, -934.966, 18.017),
    Davis = v3(172.266, -1563.212, 27.623),
    SandyShores = v3(2007.918, 3772.873, 30.533),
    Paleto = v3(174.811, 6601.134, 30.334),
    Chilliad = v3(1702.809, 6418.350, 31.125),
    LittleSeoul = v3(-527.469, -1208.325, 16.671),
    PopularStreet = v3(821.748, -1028.274, 24.871),
    Harmony = v3(263.967, 2608.679, 44.269),
    MirrorPark = v3(1181.554, -332.793, 67.596),
    Morningwood = v3(-1430.680, -280.017, 44.627),
    Vinewood = v3(614.969, 264.504, 101.509)
}

local function drawMarker(pos)
    graphics.draw_marker(1, pos, v3(0,0,0), v3(0,0,0), v3(2,2,2), 240, 200, 80, 200, false, true, 2, false, nil, "MarkerTypeVerticalCylinder", false)       
end

local function drawBlip(pos)
    local blip = ui.add_blip_for_coord(pos)
    ui.set_blip_sprite(blip, 361)
    ui.set_blip_colour(blip, 23)
    return blip
end

local blips = {}
local function drawFuelBlips()
    blips[0] = drawBlip(Stations.SandyShores)
    blips[1] = drawBlip(Stations.GroveStreet)
    blips[2] = drawBlip(Stations.Strawberry)
    blips[3] = drawBlip(Stations.Davis)
    blips[4] = drawBlip(Stations.Paleto)
    blips[5] = drawBlip(Stations.Chilliad)
    blips[6] = drawBlip(Stations.LittleSeoul)
    blips[7] = drawBlip(Stations.PopularStreet)
    blips[8] = drawBlip(Stations.Harmony)
    blips[9] = drawBlip(Stations.MirrorPark)
    blips[10] = drawBlip(Stations.Morningwood)
    blips[11] = drawBlip(Stations.Vinewood)
end
drawFuelBlips()

function drawFuelMarkers()
    drawMarker(Stations.SandyShores)
    drawMarker(Stations.GroveStreet)
    drawMarker(Stations.Strawberry)
    drawMarker(Stations.Davis)
    drawMarker(Stations.Paleto)
    drawMarker(Stations.Chilliad)
    drawMarker(Stations.LittleSeoul)
    drawMarker(Stations.PopularStreet)
    drawMarker(Stations.Harmony)
    drawMarker(Stations.MirrorPark)
    drawMarker(Stations.Morningwood)
    drawMarker(Stations.Vinewood)
end

local function clearblips()
    event.add_event_listener("exit", function()
       for i=0, #blips do
            ui.remove_blip(blips[i])
       end 
    end)
end clearblips()