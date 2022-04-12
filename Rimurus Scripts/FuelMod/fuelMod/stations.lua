Stations = {
    GroveStreet = v3(-67.300, -1761.404, 28.314),
    Strawberry = v3(-720.801, -934.966, 18.017),
    Davis = v3(172.266, -1563.212, 27.623),
    SandyShores = v3(2007.918, 3772.873, 30.533),
    Paleto = v3(174.811, 6601.134, 30.334)
}

local function drawMarker(pos)
    graphics.draw_marker(1, pos, v3(0,0,0), v3(0,0,0), v3(2,2,2), 255, 25, 25, 200, false, true, 2, false, nil, "MarkerTypeVerticalCylinder", false)       
end

local function drawFuelBlips()
    ui.add_blip_for_coord(Stations.SandyShores)
    ui.add_blip_for_coord(Stations.GroveStreet)
    ui.add_blip_for_coord(Stations.Strawberry)
    ui.add_blip_for_coord(Stations.Davis)
    ui.add_blip_for_coord(Stations.Paleto)
end
drawFuelBlips()

function drawFuelMarkers()
    drawMarker(Stations.SandyShores)
    drawMarker(Stations.GroveStreet)
    drawMarker(Stations.Strawberry)
    drawMarker(Stations.Davis)
    drawMarker(Stations.Paleto)
end