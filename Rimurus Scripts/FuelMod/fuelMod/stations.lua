Stations = {
    GroveStreet = v3(-67.300, -1761.404, 28.314),
    LindsayCircus = v3(-720.801, -934.966, 18.017),
    Davis = v3(172.266, -1563.212, 27.623),
    SandyShores = v3(2007.918, 3772.873, 30.533),
    Paleto = v3(174.811, 6601.134, 30.334),
    SenoraFreeway = v3(1702.809, 6418.350, 31.125),
    LittleSeoul = v3(-527.469, -1208.325, 16.671),
    PopularStreet = v3(821.748, -1028.274, 24.871),
    Harmony = v3(263.967, 2608.679, 44.269),
    MirrorPark = v3(1181.554, -332.793, 67.596),
    Morningwood = v3(-1430.680, -280.017, 44.627),
    Vinewood = v3(614.969, 264.504, 101.509),
    PacificBluffs = v3(-2099.512, -320.867, 11.523),
    LagoZancudo = v3(-2558.103, 2331.768, 31.558),
    SandyShoresAirfield = v3(1784.108, 3329.823, 39.769),
    SandyShoresMotel = v3(1043.171, 2670.477, 38.046),
    SandyShoresLSC = v3(1209.234, 2662.301, 36.306),
    PalominoFreeway = v3(2578.465, 361.363, 106.955),
    Grapeseed = v3(1688.766, 4929.291, 40.575),
    RichmanGlen = v3(-1802.732, 797.043, 137.010),
    Strawberry = v3(267.748, -1263.358, 27.640),
    ElBurroHeights = v3(1210.197, -1404.031, 33.721),
    LaPuerta = v3(-320.708, -1466.867, 29.043)
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
    local BlipsCount = 0;
    for name, coords in pairs(Stations) do
        blips[BlipsCount] = drawBlip(coords)
        BlipsCount = BlipsCount + 1
    end
end 
drawFuelBlips()

function drawFuelMarkers()
    for name, coords in pairs(Stations) do
        drawMarker(coords)
    end
end

local function clearblips()
    event.add_event_listener("exit", function()
       for i=0, #blips do
            ui.remove_blip(blips[i])
       end 
    end)
end 
clearblips()