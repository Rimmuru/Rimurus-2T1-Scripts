local testParent = menu.add_feature("Rimurus Hospital Module", "parent", 0)

menu.add_feature("Disable Health Regen", "toggle", testParent.id, function(f)
    if f.on then
        native.call(0x5DB660B38DD98A31, player.player_id(), 0.0)
    else
        native.call(0x5DB660B38DD98A31, player.player_id(), 1.0)
    end
end)
