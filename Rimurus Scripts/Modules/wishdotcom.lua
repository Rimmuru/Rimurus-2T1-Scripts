local main = menu.add_feature("wishdotcom", "parent", 0).id

local cash_manager = menu.add_feature("Cash Manager", "parent", main).id
local money_loop_750 = menu.add_feature("[!]Money Loop 750K + 500K", "parent", cash_manager).id

local casino_cashier = menu.add_feature("Casino Cashier Services", "parent", main).id

local character_manager = menu.add_feature("Character Manager", "parent", main).id

local character_change_manager = menu.add_feature("Character Change Manager", "parent", character_manager).id 
local related_to_names = menu.add_feature("Related To Names", "parent", character_change_manager).id
local related_to_vehicles = menu.add_feature("Related To Vehicles", "parent", character_change_manager).id
local character_date_manager = menu.add_feature("Character Date Manger", "parent", character_manager).id
local character_money_manager = menu.add_feature("Character Money Manager", "parent", character_manager).id
local earned_money = menu.add_feature("Earned Money (Total)", "parent", character_money_manager).id
local money_spent = menu.add_feature("Money Spent (Total)", "parent", character_money_manager).id
local money_gained_from_service_jobs = menu.add_feature("Money gained from service/jobs", "parent", character_money_manager).id
local money_gained_from_selling_vehicles = menu.add_feature("Money gained from selling vehicles", "parent", character_money_manager).id
local money_obtained_by_betting = menu.add_feature("Money obtained by betting", "parent", character_money_manager).id
local money_earned_from_good_sport_reward = menu.add_feature("Money earned from good sport reward", "parent", character_money_manager).id 
local money_collected = menu.add_feature("Money Collected", "parent", character_money_manager).id 
local shared_money = menu.add_feature("Shared Money", "parent", character_money_manager).id 
local money_earned_from_rockstar_reward = menu.add_feature("money earned from rockstar reward", "parent", character_money_manager).id 
local money_obtained_by_contraband = menu.add_feature("money obtained by contraband", "parent", character_money_manager).id 
local money_earned_from_exports = menu.add_feature("money earned from exports", "parent", character_money_manager).id 

local character_time_manager = menu.add_feature("Character Time Manager", "parent", character_manager).id
local time_spent_in_gta_online = menu.add_feature("Time spent in GTA Online", "parent", character_time_manager).id
local time_player_in_first_person = menu.add_feature("Time player in first person", "parent", character_time_manager).id 
local time_played_as_character = menu.add_feature("Time played as character", "parent", character_time_manager).id 
local longest_single_game_sessions = menu.add_feature("Longest single game session (limited)", "parent", character_time_manager).id 
local average_time_per_session = menu.add_feature("Average time per session (limited)", "parent", character_time_manager).id 
local time_spend_on_deathmatches = menu.add_feature("time spend on deathmatches", "parent", character_time_manager).id 
local time_spend_on_races = menu.add_feature("Time spend on races", "parent", character_time_manager).id 
local time_spend_on_creator = menu.add_feature("Time spend on creator", "parent", character_time_manager).id 
local time_on_a_heist_mission = menu.add_feature("Time spent on heist", "parent", character_time_manager).id 
local time_driving_cars = menu.add_feature("Time Driving Cars", "parent", character_time_manager).id 
local time_driving_bikes = menu.add_feature("Time Driving Bikes", "parent", character_time_manager).id 
local time_driving_helicopters = menu.add_feature("Time Driving Helicopters", "parent", character_time_manager).id 
local time_driving_planes = menu.add_feature("Time Driving Planes", "parent", character_time_manager).id 
local time_driving_boats = menu.add_feature("Time Driving Boats", "parent", character_time_manager).id 
local time_driving_quads = menu.add_feature("Time Driving Quads", "parent", character_time_manager).id 
local time_driving_bicycle = menu.add_feature("Time Driving Bicycle", "parent", character_time_manager).id 
local time_driving_submarine = menu.add_feature("Time Driving Submarine", "parent", character_time_manager).id 

local competitive_stats = menu.add_feature("Competitive Stats", "parent", character_manager).id
local bad_sport_manager = menu.add_feature("Bad Sport Manager", "parent", character_manager).id
local rp_multiplier = menu.add_feature("RP Mulitplier", "parent", character_manager).id

local colletibles = menu.add_feature("Collectibles", "parent", main).id

local maximize_options = menu.add_feature("Maximize Options", "parent", main).id

local services = menu.add_feature("Services", "parent", main).id
local disable_services = menu.add_feature("Disable Services", "parent", services).id

local tunables = menu.add_feature("Tunables", "parent", main).id
local snow = menu.add_feature("Snow", "parent", tunables).id

local unlocks = menu.add_feature("Unlocks", "parent", main).id

local dlc = menu.add_feature("DLCs", "parent", unlocks).id

local drug_war = menu.add_feature("Drug Wars DLC", "parent", dlc).id 
local drip_feed_event = menu.add_feature("Drip Feed Events", "parent", drug_war).id 
local gun_van = menu.add_feature("Gun Van", "parent", drip_feed_event).id
local g_cache = menu.add_feature("G's Cache", "parent", drip_feed_event).id
local stash_house = menu.add_feature("Stash House", "parent", drip_feed_event).id 
local street_dealer = menu.add_feature("Street Dealer", "parent", drip_feed_event).id

local criminal_ent = menu.add_feature("Criminal Enterpise DLC", "parent", dlc).id 
local contract_dlc = menu.add_feature("The Contract DLC", "parent", dlc).id 

local ls_tuner = menu.add_feature("LS Tuners DLC", "parent", dlc).id 
local ls_tuner_rp = menu.add_feature("LS Tuners MAX RP Unlocker", "parent", ls_tuner).id

local christmas_unlocks = menu.add_feature("Christmas Unlocks", "parent", dlc).id

local clothing = menu.add_feature("Clothing", "parent", unlocks).id
local special_tops = menu.add_feature("Special Tops", "parent", clothing).id
local vehicles = menu.add_feature("Vehicles", "parent", unlocks).id 
local weapons = menu.add_feature("Weapons", "parent", unlocks).id 
local others = menu.add_feature("Others", "parent", unlocks).id
local fast_run = menu.add_feature("Fast Run", "parent", others).id

local business_helper = menu.add_feature("VIP/CEO/MC (helper)", "parent", main).id
local acid_lab = menu.add_feature("Acid Lab", "parent", business_helper).id 

local air_freight_cargo = menu.add_feature("Air Freight Cargo", "parent", business_helper).id 
local air_cargo_mission = menu.add_feature("Airfrieght Cargo Mission Selector", "parent", air_freight_cargo).id 
local steal_cargo = menu.add_feature("Steal Cargo", "parent", air_cargo_mission).id 
local sell_cargo = menu.add_feature("Sell Cargo", "parent", air_cargo_mission).id
local air_cargo_manager = menu.add_feature("Air Cargo Extreme Manager", "parent", air_freight_cargo).id 
local air_custom_value = menu.add_feature("Custom Value", "parent", air_cargo_manager).id 

local bunker_manager = menu.add_feature("Bunker Manager", "parent", business_helper).id
local bunker_mission_selector = menu.add_feature("Mission Selector", "parent", bunker_manager).id 
local steal_missions = menu.add_feature("Steal Missions", "parent", bunker_mission_selector).id 
local sell_missions = menu.add_feature("Sell Missions", "parent", bunker_mission_selector).id 

local cooldown_disable = menu.add_feature("Cooldown Disablers", "parent", business_helper).id
local high_demand_bonus = menu.add_feature("High Demand Bonus Control", "parent", business_helper).id 
local mc_manager = menu.add_feature("MC Manager", "parent", business_helper).id 
local nightclub_modifiers = menu.add_feature("Nightclub Modifiers", "parent", business_helper).id
local remote_access = menu.add_feature("Remote Access", "parent", business_helper).id 
--local triggers_options = menu.add_feature("Triggers Options", "parent", business_helper).id 

local vehicle_cargo = menu.add_feature("Vehicle Cargo", "parent", business_helper).id 
local source_vehicle = menu.add_feature("Source Vehicle By Range", "parent", vehicle_cargo).id
local top_range = menu.add_feature("Top Range", "parent", source_vehicle).id
local mid_range = menu.add_feature("Mid Range", "parent", source_vehicle).id
local stand_range = menu.add_feature("Standard Range", "parent", source_vehicle).id
local unk_range = menu.add_feature("Unknown", "parent", source_vehicle).id

local warehouse = menu.add_feature("Warehouse (Special Cargo", "parent", business_helper).id 
local normal_crate = menu.add_feature("Choose Normal Crate To Buy", "parent", warehouse).id 
local special_crate = menu.add_feature("Choose Special Crate To Buy", "parent", warehouse).id 

local main_online = menu.add_player_feature("wishdotcom", "parent", 0).id 
local give_colletibles = menu.add_player_feature("Give Collectibles", "parent", main_online).id 
local drop_rp = menu.add_player_feature("Drop RP", "parent", main_online).id 

-- Cash manager
menu.add_feature("Wallet to Bank", "value_str", cash_manager, function(f)
    while f.on do
        native.call(0xC2F7FE5309181C7D, f.value, 2100000000)
        system.wait()
    end
end):set_str_data({"Slot 0", "Slot 1"})

menu.add_feature("Bank to Wallet", "value_str", cash_manager, function(f)
    while f.on do
        native.call(0xD47A2C1BA117471D, f.value, 2100000000)
        system.wait()
    end
end):set_str_data({"Slot 0", "Slot 1"})

menu.add_feature("[!] Sell Personal Vehicle (8M)", "toggle", cash_manager, function(f)
    while f.on do
        script.set_global_i(101745, 8000000)
        system.wait()
    end
end)

menu.add_feature("Remove Money w/ Ballistic Equipment Kit", "toggle", cash_manager, function()

    repeat
        rtn, value = input.get("Insert Money Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    menu.notify("Purchase the Ballistic Equipment Kit from the interaction menu and it will remove " .. value)
    script.set_global_i(282433, value)
end)

-- Money loop 750
menu.add_feature("# Start 750K", "toggle", money_loop_750, function(f)
    while f.on do
        script.set_global_i(0x1E08B9, 0)
        script.set_global_i(0x1E08B9, 2)
        system.wait(2000)
    end
end)

-- Casino Cashier Services
menu.add_feature("Disable Acquire Chips CD", "toggle", casino_cashier, function(f)
    while f.on do
        stats.stat_set_int(3167225000, 0, true) -- not sure if this will work
        stats.stat_set_int(67083818, 0, true) -- not sure if this will work
        script.set_global_i(1970466, 1000)
        system.wait()
    end
end)


menu.add_feature("Acquire Chips", "action", casino_cashier, function(f)

    repeat
        rtn, value = input.get("Insert Chip Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    scripts.set_global_i(289124, value)

end)

menu.add_feature("Max Chips To Acquire", "action", casino_cashier, function(f)

    repeat
        rtn, value = input.get("Insert Chip Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    scripts.set_global_i(289127, value)

end)

menu.add_feature("Trade Chips", "action", casino_cashier, function(f)

    repeat
        rtn, value = input.get("Insert Cip Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    scripts.set_global_i(289125, value)

end)

-- Character Manager
--- Character Change Manager
---- Related to names
menu.add_feature("Change Archenemy (Name)", "action", related_to_names, function()

    repeat
        rtn, str = input.get("Insert Name", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xA87B2335D12531D7, 185448860, str, true)

end)

menu.add_feature("Change Archenemy Kills", "action", related_to_names, function()

    repeat
        rtn, value = input.get("Insert Kills", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(1348579738, value, true)

end)

menu.add_feature("Change Victim (Name)", "action", related_to_names, function()
    
    repeat
        rtn, str = input.get("Insert Name", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xA87B2335D12531D7, 4171177635, str, true)

end)

menu.add_feature("Change Victim Kills", "action", related_to_names, function()

    repeat
        rtn, value = input.get("Insert Kills", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xA87B2335D12531D7, 4171177635, str, true)

end)

menu.add_feature("Change Motorcycle Club First Name", "action", related_to_names, function()

    repeat
        rtn, value = input.get("Insert Name", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xA87B2335D12531D7, 2180274112, str, true)

end)

menu.add_feature("Change Motorcycle Club 2nd Name", "action", related_to_names, function()

    repeat
        rtn, value = input.get("Insert Name", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xA87B2335D12531D7, 2195356922, str, true)

end)
menu.add_feature("Change CEO/Office First Name", "action", related_to_names, function()
    
    repeat
        rtn, value = input.get("Insert Name", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xA87B2335D12531D7, 2357525935, str, true)

end)

menu.add_feature("Change CEO/Office 2nd Name", "action", related_to_names, function()
    
    repeat
        rtn, value = input.get("Insert Name", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xA87B2335D12531D7, 1495012509, str, true)

end)
---- Related to vehicles

menu.add_feature("Change my favourite bike (Any Vehicle)", "action", related_to_vehicles, function()

    repeat
        rtn, value = input.get("Insert Vehicle Hash", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(176193834, value, true)
    stats.stat_set_int(812317398, value, true)
    stats.stat_set_int(278637761, value, true)
    stats.stat_set_int(3659743302, value, true)

end)

menu.add_feature("Fastest speed recorded in a vehicle", "action", related_to_vehicles, function() -- maybe works idk

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(1357928980, value, true)

end)

--

menu.add_feature("Change Community plays of your published content", "action", related_to_vehicles, function() -- maybe works idk

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(375887713, value, true)

end)

menu.add_feature("Change Thumbs up for your published content", "action", related_to_vehicles, function() -- maybe works idk

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(460181992, value, true)

end)

menu.add_feature("Change Races Published", "action", related_to_vehicles, function() -- maybe works idk

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(3587516317, value, true)

end)

menu.add_feature("Change Deathmatches Published", "action", related_to_vehicles, function() -- maybe works idk

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(2037198186, value, true)

end)

---- Character Date Manager
menu.add_feature("Modify Character Created Date", "action", character_date_manager) -- not sure how to do it

menu.add_feature("Modify Last ranked up Date", "action", character_date_manager) -- not sure how to do it

menu.add_feature("Show | First time in GTA Online", "action", character_date_manager) -- not sure how to do it

menu.add_feature("Edit  | First time in GTA Online", "action", character_date_manager) -- not sure how to do it

---- Character Money Manager
----- earned money 
menu.add_feature("AirCargo Total Earning", "action", earned_money, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(603950206, value, true)

end)

menu.add_feature("# Custom Value", "action", earned_money) -- not sure how to do it

menu.add_feature("Show money earned","action", earned_money,function() -- link it to aircargo thing above
    menu.notify("smd?")
end)

----- money spent
menu.add_feature("# Custom Value", "action", money_spent) -- not sure how to do it

menu.add_feature("Show money earned","action", earned_money, function() -- link it to thing above
    menu.notify("smd?")
end)

----- money gained service
menu.add_feature("# Custom Value", "action", money_gained_from_service_jobs, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(3926856056, value, true)

end)

menu.add_feature("Show money earned","action", money_gained_from_service_jobs, function() -- link it to thing above
    menu.notify("smd?")
end)

----- money gained vehicles 
menu.add_feature("# Custom Value", "action", money_gained_from_selling_vehicles, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(3926856056, value, true)

end)

menu.add_feature("Show money earned","action", money_gained_from_selling_vehicles, function() -- link it to thing above
    menu.notify("smd?")
end)

----- money from betting
menu.add_feature("# Custom Value", "action", money_obtained_by_betting, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(113209337, value, true)

end)

menu.add_feature("Show money earned","action", money_obtained_by_betting, function() -- link it to thing above
    menu.notify("smd?")
end)

----- money from good sports
menu.add_feature("# Custom Value", "action", money_earned_from_good_sport_reward, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(2604959615, value, true)

end)

menu.add_feature("Show money earned","action", money_earned_from_good_sport_reward, function() -- link it to thing above
    menu.notify("smd?")
end)

----- Money collected 
menu.add_feature("# Custom Value", "action", money_collected, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(674865647, value, true)

end)

menu.add_feature("Show money earned","action", money_collected, function() -- link it to thing above
    menu.notify("smd?")
end)

----- shared money
menu.add_feature("# Custom Value", "action", shared_money, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(2974474245, value, true)

end)

menu.add_feature("Show money earned","action", shared_money, function() -- link it to thing above
    menu.notify("smd?")
end)

----- money from rockstar reward
menu.add_feature("# Custom Value", "action", money_earned_from_rockstar_reward, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(293176067, value, true)

end)

menu.add_feature("Show money earned","action", money_earned_from_rockstar_reward, function() -- link it to thing above
    menu.notify("smd?")
end)

----- money from contraband
menu.add_feature("# Custom Value", "action", money_obtained_by_contraband, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(4274171149, value, true)

end)

menu.add_feature("Show money earned","action", money_obtained_by_contraband, function() -- link it to thing above
    menu.notify("smd?")
end)

----- money from exports
menu.add_feature("# Custom Value", "action", money_earned_from_exports, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(958445639, value, true)

end)

menu.add_feature("Show money earned","action", money_earned_from_exports, function() -- link it to thing above
    menu.notify("smd?")
end)

---- character time manager
----- time spent in gta online
----- time spent in first person
----- time spent as character
----- longest single game session 
menu.add_feature("Custom", "action", longest_single_game_sessions, function()

    repeat
        rtn, value = input.get("Insert time", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(526948626, value, true)

end)

menu.add_feature("6 Hours", "action", longest_single_game_sessions, function()
    stats.stat_set_int(526948626, 21600000, true)
end)

menu.add_feature("12 Hours", "action", longest_single_game_sessions, function()
    stats.stat_set_int(526948626, 43200000, true)
end)

menu.add_feature("24 Hours", "action", longest_single_game_sessions, function()
    stats.stat_set_int(526948626, 86400000, true)
end)

----- average time per session 
menu.add_feature("Custom", "action", longest_single_game_sessions, function()

    repeat
        rtn, value = input.get("Insert time", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(962396296, value, true)

end)

menu.add_feature("6 Hours", "action", longest_single_game_sessions, function()
    stats.stat_set_int(962396296, 21600000, true)
end)

menu.add_feature("12 Hours", "action", longest_single_game_sessions, function()
    stats.stat_set_int(962396296, 43200000, true)
end)

menu.add_feature("24 Hours", "action", longest_single_game_sessions, function()
    stats.stat_set_int(962396296, 86400000, true)
end)

----- time spend on deathmatches
----- time spend on races
----- time spend on creator
----- time spend on heist
----- time spend on missions
----- time driving cars 
----- time driving bike 
----- time driving Helicopters 
----- time driving Planes 
----- time driving boats 
----- time driving quad 
----- time driving Bicycle 
----- time driving Submarine

---- Competitive stats
menu.add_feature("Races Wins", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(3092986034, value, true)
end)

menu.add_feature("Races Losses", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(2286649582, value, true)
end)

menu.add_feature("Darts Wins", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(3450198067, value, true)
end)

menu.add_feature("Darts Losses", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(161254170, value, true)
end)

menu.add_feature("Deathmatches Wins", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(3196663588, value, true)
end)

menu.add_feature("Deathmatches Losses", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(208804787, value, true)
end)

menu.add_feature("Tennis Wins", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(149276373, value, true)
end)

menu.add_feature("Tennis Losses", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(4253715536, value, true)
end)

menu.add_feature("Parachuting Losses", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(420311390, value, true)
end)

menu.add_feature("Parachuting Losses", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(2500035644, value, true)
end)

menu.add_feature("Golf Wins", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(678858243, value, true)
end)

menu.add_feature("Golf Losses", "action", competitive_stats, function()
    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(1299513276, value, true)
end)

----- Bad sport manager
menu.add_feature("Become a bad sport", "action", bad_sport_manager, function()
    stats.stat_set_int(2829961636, 1, true)
    stats.stat_set_int(2301392608, 1, true)
end)

menu.add_feature("Remove bad sport", "action", bad_sport_manager, function()
    stats.stat_set_int(2301392608, 0, true)
end)

----- RP Multiplier
--
menu.add_feature("Bypasss SP Prologue", "action", character_manager, function()
    native.call(0xB475F27C6A994D65)
end)

menu.add_feature("Wipe/Reset stats and shit", "action", character_manager, function()
    menu.notify("sucks to be you")
    system.wait(5000)
    menu.notify("pranked")
end)

-- colletibles    
local action_figures = menu.add_feature("Action Figures", "action_value_i", colletibles, function(f)
    script.set_global_i(2765117,f.value)
end)
action_figures.min = 0
action_figures.max = 100
action_figures.mod = 1

local ld_organics = menu.add_feature("LD Organics Product", "action_value_i", colletibles, function(f)
    script.set_global_i(2765501,f.value)
end)
ld_organics.min = 0
ld_organics.max = 100
ld_organics.mod = 1

local playing_cards = menu.add_feature("Playing Cards", "action_value_i", colletibles, function(f)
    script.set_global_i(2765118,f.value)
end)
playing_cards.min = 0
playing_cards.max = 54
playing_cards.mod = 1

local signal_jammers = menu.add_feature("Signal Jammers", "action_value_i", colletibles, function(f)
    script.set_global_i(2765119,f.value)
end)
signal_jammers.min = 0
signal_jammers.max = 50
signal_jammers.mod = 1

local movie_props = menu.add_feature("Movie Props", "action_value_i", colletibles, function(f)
    script.set_global_i(2765402,f.value)
end)
movie_props.min = 0
movie_props.max = 10
movie_props.mod = 1

local buried_stashes = menu.add_feature("Buried Stashes (Daily)", "action_value_i", colletibles, function(f)
    script.set_global_i(2765461,f.value)
end)
buried_stashes.min = 0
buried_stashes.max = 50
buried_stashes.mod = 1

local hidden_cache = menu.add_feature("Hidden Cache (Daily)", "action_value_i", colletibles, function(f)
    script.set_global_i(2765412,f.value)
end)
hidden_cache.min = 0
hidden_cache.max = 10
hidden_cache.mod = 1

local treasure_chests = menu.add_feature("Treasure Chests (Daily)", "action_value_i", colletibles, function(f)
    script.set_global_i(2765414,f.value)
end)
treasure_chests.min = 0
treasure_chests.max = 10
treasure_chests.mod = 1

local shipwrecks = menu.add_feature("Shipwrecks (Daily)", "action_value_i", colletibles, function(f)
    script.set_global_i(2765455,f.value)
end)
shipwrecks.min = 0
shipwrecks.max = 10
shipwrecks.mod = 1

local trick_or_treat = menu.add_feature("Trick or Treat (halloween)", "action_value_i", colletibles, function(f)
    script.set_global_i(2765499,f.value)
end)
trick_or_treat.min = 0
trick_or_treat.max = 200
trick_or_treat.mod = 1

local snowmen = menu.add_feature("Snowmen", "action_value_i", colletibles, function(f)
    script.set_global_i(2765508,f.value)
end)
snowmen.min = 0
snowmen.max = 25
snowmen.mod = 1

menu.add_feature("Enable Trick Or Treat", "toggle", colletibles, function(f)
    while f.on do
        script.set_global_i(294905,1)
        system.wait()
    end
end)

menu.add_feature("Enable Snowmen", "toggle", colletibles, function(f)
    while f.on do
        script.set_global_i(295940,1)
        system.wait()
    end
end)

menu.add_feature("Stunt Jumps", "toggle", colletibles, function()
    stats.stat_set_int(3834231311, 50, true)
    stats.stat_set_int(319232911, 50, true)
    stats.stat_set_int(552036132, 50, true)
end)

---- maximize options
menu.add_feature("Maximize nightclub popularity", "action", maximize_options, function()
    stats.stat_set_int(2724973317, 1000, true)
    stats.stat_set_int(2295992369, 1000, true)
end)

menu.add_feature("Maximize Inventory", "action", maximize_options, function()
    stats.stat_set_int(3154358306, 30, true)
    stats.stat_set_int(2983015990, 15, true)
    stats.stat_set_int(2098164755, 5, true)
    stats.stat_set_int(3097587663, 10, true)
    stats.stat_set_int(853483879, 10, true)
    stats.stat_set_int(2022518763, 20, true)
    stats.stat_set_int(1031694059, 20, true)
    stats.stat_set_int(1734518001, 11, true)
    stats.stat_set_int(3689384104, 11, true)
end)

-- services
menu.add_feature("Back to story mode", "action", services, function(f)
    if native.call(0x580CE4438479CC61) then
        native.call(0x95914459A87EBA28, 0, 0, 0)
    end
end)

menu.add_feature("Enable Quick Respawn", "toggle", services, function(f)
    while f.on do 
        script.set_global_i(2674946,2)
        script.set_global_i(2674946,0)
        system.wait(100)
    end
end)

menu.add_feature("Force Cloud Save", "action", services, function(f)
    native.call(0xE07BCA305B82D2FD, 0, 0, 3, 0)
end)

menu.add_feature("Infinite Stone Hatchet Power", "action", services, function(f)
    script.set_global_i(287447,29999)
    script.set_global_i(287448,29999)
    script.set_global_i(287449,0)
end)

menu.add_feature("Request Acid Lab", "action", services, function(f)
    script.set_global_i(2793984,1)
end)

menu.add_feature("Request Avenger", "action", services, function(f)
    script.set_global_i(2793979,1)
end)

menu.add_feature("Request Ballistic Equipment", "action", services, function(f)
    script.set_global_i(2793942,1)
end)

menu.add_feature("Request Dinghy", "action", services, function()
    script.set_global_i(2794012,1)
end)

menu.add_feature("Request Kosatka", "action", services, function()
    script.set_global_i(2794000,1)
end)

menu.add_feature("Request Motorcycle", "action", services, function()
    script.set_global_i(2794034,1)
end)

menu.add_feature("Request MOC", "action", services, function()
    script.set_global_i(2793971,1)
end)

menu.add_feature("Request Mini Tank", "action", services, function()
    script.set_global_i(2799921,1)
end)

menu.add_feature("Request RC Bandito", "action", services, function()
    script.set_global_i(2799920,1)
end)

menu.add_feature("Request Terrobyte", "action", services, function()
    script.set_global_i(2793983,1)
end)

--- Disable Services 
menu.add_feature("Disable Orbital Cannon CD", "toggle", disable_services) -- dont know

menu.add_feature("Disable Transaction Error alert", "toggle", disable_services, function()
    if f.on then
        native.call(0xA8733668D1047B51, -1)
        native.call(0xA8733668D1047B51, 0, 0, 3, 0)
    end
end)

menu.add_feature("Disable Kosatka Missiles CD", "toggle", disable_services, function()
    while f.on do
        script.set_global_i(292332, 0)
        script.set_global_i(292333, 99999)
        system.wait()
    end
end)

menu.add_feature("Disable MK2 CD", "toggle", disable_services, function(f)
    while f.on do
        script.set_global_i(290553, 0)
        system.wait()
    end
end)

-- Tunables
--- Snow 
menu.add_feature("Enable", "toggle", snow, function(f)
    while f.on do
        script.set_global_i(266897, 1)
        system.wait(100)
    end
end)

menu.add_feature("Disable", "toggle", snow, function(f)
    while f.on do
        script.set_global_i(266897, 0)
        system.wait(100)
    end
end) 
-- 
menu.add_feature("Bypass Christmas Clothing", "toggle", tunables, function(f)
    while f.on do
        script.set_global_i(271538,0)
        script.set_global_i(271539,0)
        script.set_global_i(271540,0)
        script.set_global_i(271541,0)
        script.set_global_i(271542,0)
        script.set_global_i(271543,0)
        script.set_global_i(271544,0)
        script.set_global_i(271545,0)
        script.set_global_i(271546,7)
        script.set_global_i(271547,7)
        system.wait()
    end
end)

menu.add_feature("Halloween Unlocks", "toggle", tunables, function(f)
    while f.on do
        sript.set_global_i(274141,1)
        sript.set_global_i(274181,1)
        sript.set_global_i(274186,1)
        sript.set_global_i(274187,1)
        sript.set_global_i(274188,1)
        sript.set_global_i(274189,1)
        sript.set_global_i(274196,1)
        sript.set_global_i(274197,1)
        sript.set_global_i(274198,1)
        sript.set_global_i(274204,1)
        sript.set_global_i(274847,1)
        sript.set_global_i(279610,1)
        system.wait()
    end
end)

menu.add_feature("Independence Day Unlocks", "toggle", tunables, function(f)
    while f.on do
        script.set_global_i(270404,1)
        script.set_global_i(270413,1)
        script.set_global_i(270414,1)
        script.set_global_i(270417,0)
        script.set_global_i(270418,1)
        script.set_global_i(270419,1)
        script.set_global_i(270442,1)
        script.set_global_i(270443,1)
        script.set_global_i(270444,1)
        script.set_global_i(270445,1)
        script.set_global_i(270446,1)
        script.set_global_i(270447,1)
        script.set_global_i(270448,1)
        system.wait()
    end
end)

-- unlocks
--- DLCs
---- Drug Wars DLCs 
menu.add_feature("Unlock Drip Feed Eclipse Blvd Garage", "toggle", drug_war, function(f)
    while f.on do
        script.set_global_i(294847,1)
        script.set_global_i(294833,0)
        system.wait()
    end
end)

menu.add_feature("Unlock Drip Feed Vehicles", "toggle", drug_war, function(f)
    while f.on do
        script.set_global_i(296106,1)
        script.set_global_i(296107,1)
        script.set_global_i(296108,1)
        script.set_global_i(296109,1)
        script.set_global_i(296110,1)
        script.set_global_i(296111,1)
        script.set_global_i(296112,1)
        script.set_global_i(296113,1)
        script.set_global_i(296114,1)
        script.set_global_i(296115,1)
        script.set_global_i(296116,1)
        script.set_global_i(296117,1)
        system.wait()
    end
end)

menu.add_feature("Unlock Drip Feed Content", "action", drug_war)

menu.add_feature("Drug Wars Awards", "action", drug_war) -- needs stats

menu.add_feature("Unlock Dildodude Camo", "action", drug_war, function()
    native.call(0xDB8A58AEAA67CD07, 36787, 1, 0)
    native.call(0xDB8A58AEAA67CD07, 36788, 1, 0)
end)
----- Drip Feed Events
------ gun van 
menu.add_feature("Enable Gun Van", "toggle", gun_van, function(f)
    while f.on do
        script.set_global_i(295944,1)
        system.wait()
    end
end)

menu.add_feature("Enable Baseball & Knife Upgrades", "toggle", gun_van, function()
    while f.on do
        script.set_global_i(296022,0)
        system.wait()
    end
end)

menu.add_feature("Bring to me ","action", gun_van, function(feat)
    local pos = player.get_player_coords(player.player_id())

    script.set_global_f(1956117+0, pos.x)
    script.set_global_f(1956117+1, pos.y)
    script.set_global_f(1956117+2, pos.z)
end)
------ g cache 
menu.add_feature("Enable G's Cache", "toggle", g_cache, function(f)
    while f.on do
        script.set_global_i(295935,1)
        system.wait()
    end
end)

------ stash house
menu.add_feature("Enable Stash House", "toggle", stash_house, function(f)
    while f.on do
        script.set_global_i(296204,1)
        system.wait()
    end
end)

------ street dealer 
menu.add_feature("Enable Street Dealer", "toggle", street_dealer, function(f)
    while f.on do
        script.set_global_i(296207,1)
        system.wait()
    end
end)

-- 
menu.add_feature("Shop Robberies", "toggle", drip_feed_event, function(f)
    while f.on do
        script.set_global_i(295924,1)
        system.wait()
    end
end)

menu.add_feature("Merryweather Convoy", "toggle", drip_feed_event, function(f)
    while f.on do
        script.set_global_i(296206,1)
        system.wait()
    end
end)

--- Criminal 
menu.add_feature("Unlock Drip Feed Content", "action", criminal_ent, function()
    script.set_global_i(295052,1)
    script.set_global_i(295057,1)
    script.set_global_i(295062,1)
    script.set_global_i(295067,1)
    script.set_global_i(295072,1)
    script.set_global_i(295077,1)
    script.set_global_i(295082,1)
    script.set_global_i(295087,1)
    script.set_global_i(295092,1)
    script.set_global_i(295097,1)
    script.set_global_i(295102,1)
    script.set_global_i(295107,1)
    script.set_global_i(295112,1)
    script.set_global_i(295117,1)
    script.set_global_i(295122,1)
    script.set_global_i(295127,1)
    script.set_global_i(295132,1)
    script.set_global_i(295137,1)
    script.set_global_i(295142,1)
    script.set_global_i(295147,1)
    script.set_global_i(295152,1)
    script.set_global_i(295157,1)
    script.set_global_i(295162,1)
    script.set_global_i(295167,1)
    script.set_global_i(295172,1)
    script.set_global_i(295177,1)
    script.set_global_i(295182,1)
end)

menu.add_feature("Unlock Service Carbine", "action", criminal_ent, function()
    script.set_global_i(295010,1)
end)

--- The Contract
menu.add_feature("Unlock Awards + Clothes + Trophies", "action", contract_dlc, function()
    stats.stat_set_int(1328969910,100,true)
    stats.stat_set_int(3651418603,100,true)
    stats.stat_set_int(2904157397,26,true)
    stats.stat_set_int(3112492043,-259160457,true)
    stats.stat_set_int(3903387944,-259160457,true)
    stats.stat_set_int(3776399950,4095,true)
    stats.stat_set_int(1187096227,-1,true)
    stats.stat_set_int(1019888216,500,true)
    stats.stat_set_int(813219774,500,true)
    stats.stat_set_int(3681813933,500,true)
    stats.stat_set_int(3333835961,500,true)
    stats.stat_set_int(1206607307,500,true)
    stats.stat_set_int(3328280760,3000,true)
    stats.stat_set_int(1618076836,3000,true)
    stats.stat_set_int(803405498,20734860,true)
    stats.stat_set_int(3025055726,50,true)
    stats.stat_set_int(2440724346,60,true)
    stats.stat_set_int(3060440390,-1,true)
    stats.stat_set_int(2618026006,10,true)
    native.call(0xE07BCA305B82D2FD, 0, 0, 3, 0)
end)

menu.add_feature("Unlock The Contract Masks", "action", contract_dlc, function()
    script.set_global_i(294004,1)
    script.set_global_i(294005,1)
    script.set_global_i(294006,1)
    script.set_global_i(294007,1)
    script.set_global_i(294008,1)
    script.set_global_i(294009,1)
    script.set_global_i(294010,1)
    script.set_global_i(294011,1)
    script.set_global_i(294012,1)
    script.set_global_i(294013,1)
    script.set_global_i(294014,1)
    script.set_global_i(294015,1)
end)

--- LS Tuners
menu.add_feature("Unlock Drip Feed Outfits", "action", ls_tuner, function()
    script.set_global_i(293332,1)
    script.set_global_i(293333,1)
    script.set_global_i(293334,1)
    script.set_global_i(293335,1)
    script.set_global_i(293336,1)
    script.set_global_i(293337,1)
    script.set_global_i(293338,1)
    script.set_global_i(293339,1)
    script.set_global_i(293340,1)
    script.set_global_i(293341,1)
    script.set_global_i(293342,1)
    script.set_global_i(293343,1)
    script.set_global_i(293344,1)
    script.set_global_i(293345,1)
    script.set_global_i(293346,1)
    script.set_global_i(293347,1)
    script.set_global_i(293348,1)
    script.set_global_i(293349,1)
    script.set_global_i(293350,1)
    script.set_global_i(293351,1)
    script.set_global_i(293352,1)
    script.set_global_i(293353,1)
    script.set_global_i(293354,1)
    script.set_global_i(293355,1)
    script.set_global_i(293356,1)
    script.set_global_i(293357,1)
    script.set_global_i(293358,1)
    script.set_global_i(293359,1)
    script.set_global_i(293360,1)
    script.set_global_i(2851607,1)
end)

menu.add_feature("Unlock Awards", "action", ls_tuner, function()
    stats.stat_set_int(3843107580, 100, true)
    stats.stat_set_int(1846740678, 100, true)
    stats.stat_set_int(3580351448, 50, true)
    stats.stat_set_int(1665717478, 50, true)
    stats.stat_set_int(1976192042, 50, true)
    stats.stat_set_int(2503776687, 240, true)
    stats.stat_set_int(2359041070, 240, true)
    stats.stat_set_int(1359527698, 50, true)
    stats.stat_set_int(3740990036, 100, true)
    stats.stat_set_int(632472055, 40, true)
    stats.stat_set_int(2186953334, 100, true)
    stats.stat_set_int(793660415, 100, true)
end)
---- LS Tuners MAX RP Unlocker 
--- Christmas Unlocks
menu.add_feature("Unlock Christmas Content (2015 - 2022)", "action", christmas_unlocks, function()
    script.set_global_i(266897,1)
    script.set_global_i(266908,1)
    script.set_global_i(269269,1)
	native.call(0xDB8A58AEAA67CD07, 36821, false, -1)
	native.call(0xDB8A58AEAA67CD07, 36822, false, -1)
	native.call(0xDB8A58AEAA67CD07, 32292, false, -1)
	native.call(0xDB8A58AEAA67CD07, 32293, false, -1)
	native.call(0xDB8A58AEAA67CD07, 30695, false, -1)
	native.call(0xDB8A58AEAA67CD07, 28167, false, -1)
	native.call(0xDB8A58AEAA67CD07, 28168, false, -1)
	native.call(0xDB8A58AEAA67CD07, 28169, false, -1)
	native.call(0xDB8A58AEAA67CD07, 28170, false, -1)
	native.call(0xDB8A58AEAA67CD07, 25018, false, -1)
	native.call(0xDB8A58AEAA67CD07, 25019, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18133, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18130, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18131, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18132, false, -1)
	native.call(0xDB8A58AEAA67CD07, 3741, false, -1)
	native.call(0xDB8A58AEAA67CD07, 3751, false, -1)
	native.call(0xDB8A58AEAA67CD07, 3752, false, -1)
	native.call(0xDB8A58AEAA67CD07, 3753, false, -1)
	native.call(0xDB8A58AEAA67CD07, 4329, false, -1)
	native.call(0xDB8A58AEAA67CD07, 4330, false, -1)
	native.call(0xDB8A58AEAA67CD07, 4331, false, -1)
	native.call(0xDB8A58AEAA67CD07, 4332, false, -1)
    script.set_global_i(285552,1)
    script.set_global_i(285553,1)
    script.set_global_i(285554,1)
    script.set_global_i(285555,1)
    script.set_global_i(285556,1)
    script.set_global_i(287979,1)
    script.set_global_i(287980,1)
    script.set_global_i(287981,1)
    script.set_global_i(271330,1)
    script.set_global_i(271594,1)
    script.set_global_i(271595,1)
    script.set_global_i(271596,1)
    script.set_global_i(274855,1)
    script.set_global_i(285557,1)
    script.set_global_i(285558,1)
    script.set_global_i(285559,1)
    script.set_global_i(285560,1)
    script.set_global_i(286348,1)
    script.set_global_i(274856,1)
    script.set_global_i(274858,1)
    script.set_global_i(281401,1)
    script.set_global_i(285201,1)
    script.set_global_i(274961,1)
    script.set_global_i(274962,1)
    script.set_global_i(274963,1)
    script.set_global_i(274964,1)
    script.set_global_i(281260,1)
    script.set_global_i(281261,1)
    script.set_global_i(281262,1)
    script.set_global_i(281263,1)
    script.set_global_i(285579,1)
    script.set_global_i(285580,1)
    script.set_global_i(285581,1)
    script.set_global_i(285582,1)
    script.set_global_i(287983,1)
    script.set_global_i(287984,1)
    script.set_global_i(287985,1)
    script.set_global_i(287986,1)
    script.set_global_i(290835,1)
    script.set_global_i(290836,1)
    script.set_global_i(290837,1)
    script.set_global_i(290838,1)
    script.set_global_i(293047,1)
    script.set_global_i(293901,1)
    script.set_global_i(293902,1)
    script.set_global_i(296060,1)
    script.set_global_i(296061,1)
end)

-- 
menu.add_feature("Unlock ALL DLCs! (Requires LVL 120+)", "action", dlc, function()
    native.call(0xDB8A58AEAA67CD07, 7387, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7388, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7389, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7390, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7391, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7392, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7393, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7394, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7395, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7396, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7397, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7398, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7399, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7400, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7401, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7402, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7403, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7404, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7405, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7406, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7407, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7408, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7409, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7410, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7411, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7412, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7413, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7414, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7415, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7416, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7417, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7418, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7419, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7420, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7421, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7422, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7423, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7424, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7425, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7426, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7427, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7428, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7429, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7430, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7431, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7432, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7433, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7434, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7435, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7436, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7437, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7438, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7439, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7440, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7441, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7442, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7443, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7444, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7445, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7446, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7447, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7448, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7449, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7450, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7451, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7452, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7453, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7454, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7455, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7456, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7457, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7458, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7459, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7460, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7461, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7462, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7463, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7464, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7465, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7466, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7467, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7468, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7469, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7470, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7471, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7472, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7473, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7474, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7475, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7476, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7477, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7478, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7479, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7480, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7481, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7482, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7483, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7484, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7485, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7486, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7487, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7488, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7489, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7490, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7491, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7492, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7493, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7494, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7495, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7496, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7497, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7498, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7499, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7500, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7501, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7502, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7503, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7504, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7505, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7506, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7507, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7508, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7509, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7510, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7511, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7512, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7513, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7514, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7515, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7516, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7517, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7518, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7519, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7520, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7521, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7522, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7523, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7524, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7525, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7526, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7527, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7528, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7529, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7530, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7531, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7532, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7533, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7534, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7535, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7536, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7537, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7538, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7539, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7540, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7541, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7542, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7543, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7544, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7545, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7546, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7547, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7548, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7549, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7550, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7551, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7552, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7553, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7554, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7555, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7556, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7557, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7558, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7559, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7560, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7561, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7562, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7563, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7564, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7565, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7566, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7567, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7568, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7569, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7570, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7571, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7572, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7573, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7574, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7575, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7576, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7577, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7578, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7579, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7580, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7581, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7582, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7583, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7584, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7585, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7586, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7587, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7588, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7589, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7590, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7591, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7592, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7593, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7594, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7595, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7596, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7597, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7598, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7599, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7600, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7601, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7602, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7603, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7604, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7605, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7606, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7607, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7608, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7609, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7610, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7611, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7612, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7613, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7614, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7615, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7616, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7617, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7618, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7619, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7620, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7621, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7622, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7623, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7624, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7625, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7626, false, -1)
	native.call(0xDB8A58AEAA67CD07, 7627, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15441, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15442, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15443, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15444, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15445, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15446, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18100, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18101, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18102, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18103, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18104, false, -1)
	native.call(0xDB8A58AEAA67CD07, 18105, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15995, false, -1)
	native.call(0xDB8A58AEAA67CD07, 15548, false, -1)
	native.call(0xDB8A58AEAA67CD07, 25241, false, -1)
	native.call(0xDB8A58AEAA67CD07, 25242, false, -1)
	native.call(0xDB8A58AEAA67CD07, 25243, false, -1)
	native.call(0xDB8A58AEAA67CD07, 25518, false, -1)
	native.call(0xDB8A58AEAA67CD07, 25519, false, -1)
	native.call(0xDB8A58AEAA67CD07, 30321, false, -1)
	native.call(0xDB8A58AEAA67CD07, 30322, false, -1)
	native.call(0xDB8A58AEAA67CD07, 30323, false, -1)
	native.call(0xDB8A58AEAA67CD07, 28259, false, -1)
	native.call(0xDB8A58AEAA67CD07, 28260, false, -1)
	native.call(0xDB8A58AEAA67CD07, 28261, false, -1)
	native.call(0xDB8A58AEAA67CD07, 34376, false, -1)
	native.call(0xDB8A58AEAA67CD07, 34377, false, -1)
	native.call(0xDB8A58AEAA67CD07, 36670, false, -1)
	native.call(0xDB8A58AEAA67CD07, 36671, false, -1)
	native.call(0xDB8A58AEAA67CD07, 36672, false, -1)
	native.call(0xDB8A58AEAA67CD07, 22103, false, -1)
end)

menu.add_feature("Unlock NightClub Awards","action",dlc,function(f)
    stats.stat_set_int(1882276892,120,true)
    stats.stat_set_int(4005960674,120,true)
    stats.stat_set_int(3817914185,120,true)
    stats.stat_set_int(556969021,120,true)
    stats.stat_set_int(3725285157,200,true)
    stats.stat_set_int(2179076825,700,true)
    stats.stat_set_int(3727882927,700,true)
    stats.stat_set_int(715844912,700,true)
    stats.stat_set_int(2166641463,20721002,true)
    stats.stat_set_int(2838676931,20721002,true)
    stats.stat_set_int(3502827913,1001,true)
    stats.stat_set_int(2941546454,1001,true)
    stats.stat_set_int(2608113188,320721002,true)
    stats.stat_set_int(3302295497,320721002,true)
    stats.stat_set_int(2683416058,3600000,true)
    stats.stat_set_int(3124893133,9506,true)
    stats.stat_set_int(2796929570,9506,true)
    stats.stat_set_int(1860434945,784672,true)
    stats.stat_set_int(1470095006,784672,true)
    stats.stat_set_int(580038773,507822,true)
    stats.stat_set_int(4119176766,507822,true)
    stats.stat_set_int(1555223966,120,true)
    stats.stat_set_int(2584035848,120,true)
    stats.stat_set_int(45646250,4,true)
    stats.stat_set_int(2236741974,3600000,true)
    stats.stat_set_int(1415845392,20,true)
    stats.stat_set_int(1514625115,-1,true)
    stats.stat_set_int(2875499813,1000,true)
    stats.stat_set_int(854089892,1000,true)
    stats.stat_set_int(1644161209,1000,true)
    stats.stat_set_int(1638353626,1000,true)
end)

menu.add_feature("Unlock Arena Wars DLC","action",dlc,function(f)
    stats.stat_set_int(694666026,-1,true)
    stats.stat_set_int(2876962805,-1,true)
    stats.stat_set_int(9421889,50,true)
    stats.stat_set_int(1527323449,50,true)
    stats.stat_set_int(2283208880,50,true)
    stats.stat_set_int(2408011154,50,true)
    stats.stat_set_int(838455700,50,true)
    stats.stat_set_int(4208440115,50,true)
    stats.stat_set_int(1315334100,50,true)
    stats.stat_set_int(3129362935,50,true)
    stats.stat_set_int(3867913143,50,true)
    stats.stat_set_int(1218319234,50,true)
    stats.stat_set_int(3314883344,50,true)
    stats.stat_set_int(1794870664,200,true)
    stats.stat_set_int(2329077467,50,true)
    stats.stat_set_int(1614815855,1000000,true)
    stats.stat_set_int(1651679990,1000,true)
    stats.stat_set_int(3785159354,55000,true)
    stats.stat_set_int(2360377873,1000,true)
    stats.stat_set_int(1436695366,209,true)
    stats.stat_set_int(1248550613,20,true)
    stats.stat_set_int(1788549980,209,true)
    stats.stat_set_int(458091869,1000,true)
    stats.stat_set_int(1993028441,47551850,true)
    stats.stat_set_int(659141545,44,true)
    stats.stat_set_int(2923566916,1000,true)
    stats.stat_set_int(2911263222,1000,true)
    stats.stat_set_int(4034298726,1000,true)
    stats.stat_set_int(2205984000,1000,true)
    stats.stat_set_int(3964182227,1000,true)
    stats.stat_set_int(78534751,1000,true)
    stats.stat_set_int(4050324334,1000,true)
    stats.stat_set_int(3889830487,1000,true)
    stats.stat_set_int(1636806233,1000,true)
    stats.stat_set_int(1368307563,1000,true)
    stats.stat_set_int(4238354483,1000,true)
    stats.stat_set_int(3384284401,1000,true)
    stats.stat_set_int(1237842189,500,true)
    stats.stat_set_int(2749908773,500,true)
    stats.stat_set_int(1446837173,500,true)
    stats.stat_set_int(3713318155,500,true)
    stats.stat_set_int(4024822648,500,true)
    stats.stat_set_int(1811908695,500,true)
    stats.stat_set_int(3031706821,500,true)
    stats.stat_set_int(2128383160,500,true)
    stats.stat_set_int(3289397559,500,true)
    stats.stat_set_int(3907333658,1000,true)
    stats.stat_set_int(2045833655,1000,true)
    stats.stat_set_int(882326203,1000,true)
    stats.stat_set_int(1541192946,1000,true)
    stats.stat_set_int(171037643,500,true)
    stats.stat_set_int(2766015073,1000,true)
    stats.stat_set_int(1132283809,1000,true)
    stats.stat_set_int(3405802570,1000,true)
    stats.stat_set_int(569029491,1000,true)
    stats.stat_set_int(1680789422,86400000,true)
    stats.stat_set_int(2255581563,1000,true)
    stats.stat_set_int(295734680,1000,true)
    stats.stat_set_int(1026150425,1000,true)
    stats.stat_set_int(457834288,1000,true)
    stats.stat_set_int(770043222,31000,true)
    stats.stat_set_int(3402498596,31000,true)
    stats.stat_set_int(770043222,41000,true)
    stats.stat_set_int(3402498596,41000,true)
    stats.stat_set_int(770043222,51000,true)
    stats.stat_set_int(3402498596,51000,true)
    stats.stat_set_int(3017176261,1000,true)
    stats.stat_set_int(273073887,1000,true)
    stats.stat_set_int(3113556349,1000,true)
    stats.stat_set_int(2899682567,1000,true)
    stats.stat_set_int(2482138333,1000,true)
    stats.stat_set_int(910340479,1000,true)
    stats.stat_set_int(1989182704,1000,true)
    stats.stat_set_int(2295245164,1000,true)
    stats.stat_set_int(3538271637,1000,true)
    stats.stat_set_int(1408730446,1000,true)
    stats.stat_set_int(313450503,1000,true)
    stats.stat_set_int(84362424,1000,true)
    stats.stat_set_int(1496319860,1000,true)
    stats.stat_set_int(1869613715,1000,true)
    stats.stat_set_int(1042458617,1000,true)
    stats.stat_set_int(3118873558,1000,true)
    stats.stat_set_int(2805470842,1000,true)
    stats.stat_set_int(3044389633,1000,true)
    stats.stat_set_int(84845248,1000,true)
    stats.stat_set_int(3199374861,1000,true)
    stats.stat_set_int(3651390447,1000,true)
    stats.stat_set_int(3392853705,1000,true)
    stats.stat_set_int(3559975605,1000,true)
    stats.stat_set_int(1012045980,61000,true)
    stats.stat_set_int(4017329674,61000,true)
    stats.stat_set_int(416722077,1000,true)
    stats.stat_set_int(4077110520,1000,true)
    stats.stat_set_int(4027498254,1000,true)
    stats.stat_set_int(1606924047,1000,true)
    stats.stat_set_int(4256444278,1000,true)
    stats.stat_set_int(1316081904,1000,true)
    stats.stat_set_int(4056736043,1000,true)
    stats.stat_set_int(2739849560,1000,true)
    stats.stat_set_int(4255514117,1000,true)
end)

menu.add_feature("Unlock Casino Heist Outfits & Arcade Trophies/Toys","action",dlc,function(f)
    stats.stat_set_int(1257859869,40,true)
    stats.stat_set_int(141258075,20,true)
    stats.stat_set_int(2721869745,100000,true)
    stats.stat_set_int(604160874,40,true)
    stats.stat_set_int(2197544201,40,true)
    stats.stat_set_int(4116429586,40,true)
    stats.stat_set_int(2504977648,1000000,true)
    stats.stat_set_int(219094110,950000,true)
    stats.stat_set_int(2330749501,3000000,true)
    stats.stat_set_int(911798939,40000,true)
    stats.stat_set_int(1821504209,50,true)
    stats.stat_set_int(1657724747,50,true)
    stats.stat_set_int(1872427143,50,true)
    stats.stat_set_int(1634950200,50,true)
    stats.stat_set_int(2836652062,-1,true)
    stats.stat_set_int(2114984119,-1,true)
    stats.stat_set_int(1214747694,2147483647,true)
    stats.stat_set_int(2973179537,50,true)
    stats.stat_set_int(4219843373,50,true)
    stats.stat_set_int(3452164010,50,true)
    stats.stat_set_int(431583124,50,true)
    stats.stat_set_int(3957658604,50,true)
    stats.stat_set_int(848372035,50,true)
    stats.stat_set_int(72959188,50,true)
    stats.stat_set_int(2865762807,50,true)
    stats.stat_set_int(3700356468,50,true)
    stats.stat_set_int(2439012120,50,true)
    stats.stat_set_int(4012999477,50,true)
    stats.stat_set_int(3293261161,50,true)
    stats.stat_set_int(313412142,50,true)
    stats.stat_set_int(3515992054,50,true)
    stats.stat_set_int(3744293677,50,true)
    stats.stat_set_int(1961004697,50,true)
    stats.stat_set_int(2192124454,50,true)
    stats.stat_set_int(1183822332,50,true)
    stats.stat_set_int(2746117168,50,true)
    stats.stat_set_int(1788836379,50,true)
    stats.stat_set_int(3823802143,69644,true)
    stats.stat_set_int(4065932288,50333,true)
    stats.stat_set_int(3768553613,63512,true)
    stats.stat_set_int(3607002439,46136,true)
    stats.stat_set_int(3301431514,21638,true)
    stats.stat_set_int(2875827742,2133,true)
    stats.stat_set_int(2670431650,1215,true)
    stats.stat_set_int(2417160049,2444,true)
    stats.stat_set_int(2110802668,38023,true)
    stats.stat_set_int(1430223059,2233,true)
    stats.stat_set_int(3802188818,50,true)
    stats.stat_set_int(1024819458,50,true)
    stats.stat_set_int(3133176918,50,true)
    stats.stat_set_int(1605420600,50,true)
    stats.stat_set_int(1306665627,50,true)
    stats.stat_set_int(70225719,50,true)
    stats.stat_set_int(1918167936,50,true)
    stats.stat_set_int(918123594,50,true)
    stats.stat_set_int(618713241,50,true)
    stats.stat_set_int(3234300246,69644,true)
    stats.stat_set_int(3539084715,69644,true)
    stats.stat_set_int(3842329041,69644,true)
    stats.stat_set_int(4141542780,69644,true)
    stats.stat_set_int(153686552,69644,true)
    stats.stat_set_int(488061428,69644,true)
    stats.stat_set_int(765516551,69644,true)
    stats.stat_set_int(1066565354,69644,true)
    stats.stat_set_int(1408411562,69644,true)
    stats.stat_set_int(1705298702,69644,true)
    stats.stat_set_int(2042441573,50,true)
    stats.stat_set_int(324952741,50,true)
    stats.stat_set_int(3843327506,50,true)
    stats.stat_set_int(2965314920,50,true)
    stats.stat_set_int(42057964,50,true)
    stats.stat_set_int(1575876531,50,true)
    stats.stat_set_int(775329861,50,true)
    stats.stat_set_int(4187533082,50,true)
    stats.stat_set_int(1250775282,50,true)
    stats.stat_set_int(1692206481,50,true)
    stats.stat_set_int(3393910710,-1,true)
    stats.stat_set_int(3059448945,-1,true)
    stats.stat_set_int(2530218177,-1,true)
    stats.stat_set_int(2702266845,-1,true)
    stats.stat_set_int(611593231,-1,true)
    stats.stat_set_int(2463610218,-1,true)
    stats.stat_set_int(4069410884,-1,true)
    stats.stat_set_int(2030371269,-1,true)
    stats.stat_set_int(17327416,-1,true)
    stats.stat_set_int(1789486350,-1,true)
    stats.stat_set_int(3719962268,-1,true)
    stats.stat_set_int(1433418396,-1,true)
    stats.stat_set_int(1535089189,-1,true)
    stats.stat_set_int(1194040851,-1,true)
    stats.stat_set_int(1781839759,-1,true)
    stats.stat_set_int(839873495,-1,true)
    stats.stat_set_int(938595082,-1,true)
    stats.stat_set_int(544329884,-1,true)
    stats.stat_set_int(350325994,-1,true)
    stats.stat_set_int(304624649,-1,true)
    stats.stat_set_int(247558115,-1,true)
    stats.stat_set_int(2153948821,-1,true)
    stats.stat_set_int(3604611093,-1,true)
    stats.stat_set_int(2468858911,-1,true)
    stats.stat_set_int(3268597767,-1,true)
    stats.stat_set_int(2708039842,-1,true)
    stats.stat_set_int(3579411732,-1,true)
    stats.stat_set_int(3401726803,-1,true)
    stats.stat_set_int(2678002080,-1,true)
    stats.stat_set_int(420796407,-1,true)
    stats.stat_set_int(2951131695,-1,true)
    stats.stat_set_int(3471688618,-1,true)
    stats.stat_set_int(2079410761,-1,true)
    stats.stat_set_int(3162808024,-1,true)
    stats.stat_set_int(2385374914,-1,true)
    stats.stat_set_int(1756296990,-1,true)
    stats.stat_set_int(1487373238,-1,true)
    stats.stat_set_int(912593547,-1,true)
    stats.stat_set_int(1760109625,-1,true)
    stats.stat_set_int(205241913,-1,true)
    stats.stat_set_int(3968191528,69644,true)
    stats.stat_set_int(4206127237,69644,true)
    stats.stat_set_int(521318757,69644,true)
    stats.stat_set_int(291771912,69644,true)
    stats.stat_set_int(1117616250,69644,true)
    stats.stat_set_int(887872791,69644,true)
    stats.stat_set_int(1481253843,69644,true)
    stats.stat_set_int(1184858238,69644,true)
    stats.stat_set_int(2076895956,69644,true)
    stats.stat_set_int(1837452873,69644,true)
    stats.stat_set_int(1809130627,50,true)
    stats.stat_set_int(2996711960,50,true)
    stats.stat_set_int(2424303064,50,true)
    stats.stat_set_int(3572725442,50,true)
    stats.stat_set_int(2730136145,50,true)
    stats.stat_set_int(3920207918,50,true)
    stats.stat_set_int(3344391050,50,true)
    stats.stat_set_int(277704181,50,true)
    stats.stat_set_int(3736701518,50,true)
    stats.stat_set_int(601035908,50,true)
    stats.stat_set_int(2950474288,69644,true)
    stats.stat_set_int(3282358720,69644,true)
    stats.stat_set_int(3580589389,69644,true)
    stats.stat_set_int(3729721064,69644,true)
    stats.stat_set_int(1217977210,69644,true)
    stats.stat_set_int(17484895,69644,true)
    stats.stat_set_int(213705667,69644,true)
    stats.stat_set_int(716251095,69644,true)
    stats.stat_set_int(857419947,69644,true)
    stats.stat_set_int(3999278902,69644,true)
    stats.stat_set_int(500323768,50,true)
    stats.stat_set_int(3606267891,50,true)
    stats.stat_set_int(3835028280,50,true)
    stats.stat_set_int(2172132606,50,true)
    stats.stat_set_int(2402400369,50,true)
    stats.stat_set_int(1209379386,50,true)
    stats.stat_set_int(2530822080,50,true)
    stats.stat_set_int(1814590047,50,true)
    stats.stat_set_int(965610795,50,true)
    stats.stat_set_int(264386964,50,true)
    stats.stat_set_int(2755753577,69644,true)
    stats.stat_set_int(1902284972,69644,true)
    stats.stat_set_int(2160504692,69644,true)
    stats.stat_set_int(1306315169,69644,true)
    stats.stat_set_int(1528554527,69644,true)
    stats.stat_set_int(1211809373,69644,true)
    stats.stat_set_int(370727446,69644,true)
    stats.stat_set_int(675511915,69644,true)
    stats.stat_set_int(4144208876,69644,true)
    stats.stat_set_int(80066416,69644,true)
    stats.stat_set_int(3354248922,50,true)
    stats.stat_set_int(2377699953,50,true)
    stats.stat_set_int(2103783882,50,true)
    stats.stat_set_int(786240695,50,true)
    stats.stat_set_int(2641916400,50,true)
    stats.stat_set_int(1413996428,50,true)
    stats.stat_set_int(1089550559,50,true)
    stats.stat_set_int(3888219777,50,true)
    stats.stat_set_int(1444209446,50,true)
    stats.stat_set_int(494924285,50,true)    
end)

menu.add_feature("Unlock Gunrunning DLC + Bunker Research","action",dlc,function(f)
    stats.stat_set_int(3327767684,690,true)
    stats.stat_set_int(3636451664,1860,true)
    stats.stat_set_int(3936976163,2690,true)
    stats.stat_set_int(4005463381,2660,true)
    stats.stat_set_int(4287178474,2650,true)
    stats.stat_set_int(290146926,450,true)
    stats.stat_set_int(509592834,269,true)
    stats.stat_set_int(714854866,-1,true)
end)

--- Clothing
---- Special Tops
menu.add_feature("Unlock Rockstar V Neck","action",special_tops,function(f)
    stats.stat_set_int(912356891,4294967295,true)
    stats.stat_set_int(1413651269,4294967295,true)
    stats.stat_set_int(288369593,4294967295,true)
    stats.stat_set_int(134415007,4294967295,true)
    stats.stat_set_int(3863467473,4294967295,true)
    stats.stat_set_int(490089733,4294967295,true)
    stats.stat_set_int(3213920355,4294967295,true)
    stats.stat_set_int(853858402,4294967295,true)
    stats.stat_set_int(851046068,4294967295,true)
    stats.stat_set_int(952296478,4294967295,true)
    stats.stat_set_int(468959528,4294967295,true)
    stats.stat_set_int(3865657196,4294967295,true)
    stats.stat_set_int(2824002052,4294967295,true)
    stats.stat_set_int(3035651191,4294967295,true)
    stats.stat_set_int(2601074545,4294967295,true)
    stats.stat_set_int(35714779,4294967295,true)
    stats.stat_set_int(2314181950,4294967295,true)
    stats.stat_set_int(3488682620,4294967295,true)
    stats.stat_set_int(4144789338,4294967295,true)
    stats.stat_set_int(2580424243,4294967295,true)
    stats.stat_set_int(2550281576,4294967295,true)
    stats.stat_set_int(3487446550,4294967295,true)
    stats.stat_set_int(2990696936,4294967295,true)
    stats.stat_set_int(2895900598,4294967295,true)
    stats.stat_set_int(2759380565,4294967295,true)
    stats.stat_set_int(902890018,4294967295,true)
    stats.stat_set_int(1325474663,4294967295,true)
    stats.stat_set_int(2309827033,4294967295,true)
    stats.stat_set_int(731896993,4294967295,true)
    stats.stat_set_int(2608254316,4294967295,true)
    stats.stat_set_int(3587846423,4294967295,true)
    stats.stat_set_int(57154893,4294967295,true)
    stats.stat_set_int(3359872490,4294967295,true)
    stats.stat_set_int(237646545,4294967295,true)
    stats.stat_set_int(3795438038,4294967295,true)
    stats.stat_set_int(1207314028,4294967295,true)
    stats.stat_set_int(1697599423,4294967295,true)
    stats.stat_set_int(1922005918,4294967295,true)
    stats.stat_set_int(249275161,4294967295,true)
    stats.stat_set_int(448089059,4294967295,true)
    stats.stat_set_int(2867685407,4294967295,true)
    stats.stat_set_int(2495955213,4294967295,true)
    stats.stat_set_int(2107805066,4294967295,true)
    stats.stat_set_int(3798785143,4294967295,true)
    stats.stat_set_int(644243223,4294967295,true)
    stats.stat_set_int(4045896172,4294967295,true)
    stats.stat_set_int(790130811,4294967295,true)
    stats.stat_set_int(2837211607,4294967295,true)
    stats.stat_set_int(1782998738,4294967295,true)
    stats.stat_set_int(1055495539,4294967295,true)
    stats.stat_set_int(1410677360,4294967295,true)
    stats.stat_set_int(2342989549,4294967295,true)
    stats.stat_set_int(4254666105,4294967295,true)
    stats.stat_set_int(2577124054,4294967295,true)
    stats.stat_set_int(239513300,4294967295,true)
    stats.stat_set_int(1912404889,4294967295,true)
    stats.stat_set_int(551343104,4294967295,true)
    stats.stat_set_int(123086409,4294967295,true)
    stats.stat_set_int(735308270,4294967295,true)
    stats.stat_set_int(1282486402,4294967295,true)
    stats.stat_set_int(1402780383,4294967295,true)
    stats.stat_set_int(2104267664,4294967295,true)
    stats.stat_set_int(683959603,4294967295,true)
    stats.stat_set_int(702934144,4294967295,true)
    stats.stat_set_int(1878094728,4294967295,true)
    stats.stat_set_int(398215213,4294967295,true)
    stats.stat_set_int(1168908030,4294967295,true)
    stats.stat_set_int(3336218219,4294967295,true)
    stats.stat_set_int(4235136133,4294967295,true)
    stats.stat_set_int(3022520582,4294967295,true)
    stats.stat_set_int(297482013,4294967295,true)
    stats.stat_set_int(804452526,4294967295,true)
    stats.stat_set_int(421119450,4294967295,true)
    stats.stat_set_int(564485139,4294967295,true)
    stats.stat_set_int(643784805,4294967295,true)
    stats.stat_set_int(3434984005,4294967295,true)
    stats.stat_set_int(3309674035,4294967295,true)
    stats.stat_set_int(3196523992,4294967295,true)
    stats.stat_set_int(3542891008,4294967295,true)
    stats.stat_set_int(1767140216,4294967295,true)
    stats.stat_set_int(3253704823,4294967295,true)
    stats.stat_set_int(2287970990,4294967295,true)
    stats.stat_set_int(3482956747,4294967295,true)
    stats.stat_set_int(1363328117,4294967295,true)
    stats.stat_set_int(3612033838,4294967295,true)
    stats.stat_set_int(2765317013,4294967295,true)
    stats.stat_set_int(3910002355,4294967295,true)
    stats.stat_set_int(3720238442,4294967295,true)
    stats.stat_set_int(2064255657,4294967295,true)
    stats.stat_set_int(3481614584,4294967295,true)
    stats.stat_set_int(2361896484,4294967295,true)
    stats.stat_set_int(2018249351,4294967295,true)
    stats.stat_set_int(2958161204,4294967295,true)
    stats.stat_set_int(3926486528,4294967295,true)
    stats.stat_set_int(2316478646,4294967295,true)
    stats.stat_set_int(618128280,4294967295,true)    
end)

menu.add_feature("Unlock Elite Challenge & Asshole Shirts","action",special_tops) -- not sure 

menu.add_feature("Unlock R*/Crosswalk Tee","action",special_tops) -- not sure

menu.add_feature("Unlock I Heart LC Shirt","action",special_tops,function(f)
    native.call(0xDB8A58AEAA67CD07, 113, true, -1)
end)

menu.add_feature("Rockstar Logo Blacked Out Tee","action",special_tops,function(f)
    native.call(0xDB8A58AEAA67CD07, 15426, true, -1)
end)

menu.add_feature("Statue Of Happiness Top","action",special_tops,function(f)
    native.call(0xDB8A58AEAA67CD07, 3593, true, -1)
end)

menu.add_feature("Base5 T-Shirt","action",special_tops,function(f)
    native.call(0xDB8A58AEAA67CD07, 9426, true, -1)
end)

menu.add_feature("Open Wheel Sponsor Tee","action",special_tops,function(f)
    native.call(0xDB8A58AEAA67CD07, 30574, true, -1)
end)

--
menu.add_feature("Valentine Unlocks","action",clothing,function(f)
    script.set_global_i(269204,1)
    script.set_global_i(274175,1)
    script.set_global_i(274176,1)
    script.set_global_i(274177,1)
    script.set_global_i(274178,1)
    script.set_global_i(274179,1)
    script.set_global_i(275541,1)
    script.set_global_i(275542,1)
end)

menu.add_feature("Unlock Dont cross the line tee","action",clothing,function(f)
    stats.stat_set_int(1286372966,500,true)
    stats.stat_set_int(3128481053,500,true)
    stats.stat_set_int(1403870965,750,true)
    stats.stat_set_int(1354406940,750,true)
end)

menu.add_feature("Unlock Vanilla Unicorn Award","action",clothing,function(f)
    stats.stat_set_int(3389373180,5,true)
    stats.stat_set_int(3527034814,5,true)
    stats.stat_set_int(3389373180,10,true)
    stats.stat_set_int(3527034814,10,true)
    stats.stat_set_int(3389373180,15,true)
    stats.stat_set_int(3527034814,15,true)
    stats.stat_set_int(3389373180,25,true)
    stats.stat_set_int(3527034814,25,true)
    stats.stat_set_int(2276310540,1000,true)
    stats.stat_set_int(2664719594,1000,true)

end)

menu.add_feature("Unlock Strickler Hat","action",clothing,function(f)
    native.call(0xDB8A58AEAA67CD07, 34387, true, -1)
end)

menu.add_feature("Unlock Pacific Standard Sweater","action",clothing,function(f)
    native.call(0xDB8A58AEAA67CD07, 34382, true, -1)
end)

--- vehicles
menu.add_feature("Unlock Candy colour","action",vehicles,function(f)
    stats.stat_set_int(3242020666,50,true)
    stats.stat_set_int(242556695,50,true)
end)

menu.add_feature("Get BF Weevil 4Free", "action", vehicles)

menu.add_feature("Get Go Go Money Blista 4Free", "action", vehicles)

menu.add_feature("Unlock Shotaro", "action", vehicles, function()
    stats.stat_set_int(4104570448,-1,true)
    stats.stat_set_int(3762077721,-1,true)
end)

menu.add_feature("Unlock Vehicles trade price", "action", vehicles, function()
    stats.stat_set_int(1840387959,20,true)
    stats.stat_set_int(236561058,65535,true)
    stats.stat_set_int(1488257575,65535,true)
    stats.stat_set_int(3037785893,48,true)
    stats.stat_set_int(3803817143,48,true)
    stats.stat_set_int(3591169109,48,true)
    stats.stat_set_int(2817724708,48,true)
    stats.stat_set_int(3914583907,48,true)
    stats.stat_set_int(2560268979,48,true)
    stats.stat_set_int(458266029,48,true)
    stats.stat_set_int(4138114680,48,true)
    stats.stat_set_int(2467433633,48,true)
    stats.stat_set_int(3540758073,32,true)
    stats.stat_set_int(1572570883,32,true)
    stats.stat_set_int(3820155213,255,true)
    stats.stat_set_int(2103187252,255,true)
    stats.stat_set_int(4084741718,255,true)
    stats.stat_set_int(2605433233,255,true)
    stats.stat_set_int(1587544511,-1,true)
    stats.stat_set_int(2848245310,-1,true)
    stats.stat_set_int(1998433323,-1,true)
    stats.stat_set_int(2422072634,-1,true)
    stats.stat_set_int(3090440989,-1,true)
    stats.stat_set_int(1161742430,-1,true)
    stats.stat_set_int(3296546168,-1,true)
    stats.stat_set_int(2389315465,-1,true)
    stats.stat_set_int(2617904887,8388607,true)
    stats.stat_set_int(3305486469,8388607,true)
    stats.stat_set_int(4064576850,8388607,true)
    stats.stat_set_int(1527562823,-1,true)
    stats.stat_set_int(1646017533,-1,true)
    stats.stat_set_int(2956081704,127,true)
    stats.stat_set_int(3510324864,127,true)
    stats.stat_set_int(1986818418,127,true)
    stats.stat_set_int(542454610,8388576,true)
    stats.stat_set_int(2812264742,8388576,true)
    stats.stat_set_int(3762077721,5,true)
    stats.stat_set_int(3208705583,5,true)
    stats.stat_set_int(3502827913,10,true)
    stats.stat_set_int(2941546454,10,true)
    stats.stat_set_int(3820516274,10,true)
    stats.stat_set_int(3727882927,10,true)
    stats.stat_set_int(715844912,10,true)
    stats.stat_set_int(2183656009,10,true)
    native.call(0xDB8A58AEAA67CD07, 22063, 20, 0)
    native.call(0xDB8A58AEAA67CD07, 22063, 20, 0)
    native.call(0xDB8A58AEAA67CD07, 158, false, 0)
end)

menu.add_feature("Unlock Paragon R Armoured", "action", vehicles, function()
    stats.stat_set_int(610584482,-1,true)
    stats.stat_set_int(3236657427,-1,true)
end)

--- Weapons
menu.add_feature("Unlock Navy Revolver", "action", weapons, function()
    native.call(0xDB8A58AEAA67CD07, 28158, true, -1)
    native.call(0xDB8A58AEAA67CD07, 0, 0, 3, 0)
end)

menu.add_feature("Unlock Stone Hatchet", "action", weapons)

menu.add_feature("Unlock Returning Player Bonus","action",weapons,function(f)
    script.set_global_i(152523,2)
    script.set_global_i(103634,90)
    script.set_global_i(103635,1)
end)

--- Others
---- Fast Run and Reload
menu.add_feature("Set: ON","action",fast_run,function(f)
    stats.stat_set_int(3860087177,-1,true)
    stats.stat_set_int(3710609417,-1,true)
    stats.stat_set_int(3451590728,-1,true)
    stats.stat_set_int(737747541,-1,true)
    stats.stat_set_int(2502868809,-1,true)
    stats.stat_set_int(689568873,-1,true)
end)

menu.add_feature("Set: OFF","action",fast_run,function(f)
    stats.stat_set_int(3140238014,0,true)
    stats.stat_set_int(1111425851,0,true)
    stats.stat_set_int(722427520,0,true)
    stats.stat_set_int(3577063022,0,true)
    stats.stat_set_int(1560239065,0,true)
    stats.stat_set_int(1298945047,0,true)
end)

menu.add_feature("Unlock High Flyer Parachute Bag","action",others,function(f)
    native.call(0xDB8A58AEAA67CD07, 28158, true, -1)
end)

menu.add_feature("Unlock all Accomplishments", "action", others, function(f)
    for i = 1,77 do 
        native.call(0xDB8A58AEAA67CD07, i, true, 0)
    end
end)

menu.add_feature("CEO | MC Office > Clutter", "action", others, function(f)
    stats.stat_set_int(2228416883,5000,true)
    stats.stat_set_int(1139387290,5000,true)
    stats.stat_set_int(3288868955,5000,true)
    stats.stat_set_int(3054869491,5000,true)
    stats.stat_set_int(3414143726,5000,true)
    stats.stat_set_int(1725697301,5000,true)
    stats.stat_set_int(1495279467,5000,true)
    stats.stat_set_int(841027155,5000,true)
    stats.stat_set_int(1419605991,5000,true)
    stats.stat_set_int(3342625631,5000,true)
    stats.stat_set_int(1149255693,80000000,true)
    stats.stat_set_int(3846122032,80000000,true)
    stats.stat_set_int(2736202610,5000,true)
    stats.stat_set_int(321155136,5000,true)
    stats.stat_set_int(587721693,5000,true)
    stats.stat_set_int(1771048351,5000,true)
    stats.stat_set_int(997825782,5000,true)
    stats.stat_set_int(1716508919,5000,true)
    stats.stat_set_int(618732796,5000,true)
    stats.stat_set_int(3928621753,5000,true)
    stats.stat_set_int(2060443977,5000,true)
    stats.stat_set_int(1373817606,5000,true)
    stats.stat_set_int(2299038266,5000,true)
    stats.stat_set_int(2780542918,5000,true)
    stats.stat_set_int(675538529,5000,true)
    stats.stat_set_int(4081314202,5000,true)
    stats.stat_set_int(1549010828,5000,true)
    stats.stat_set_int(1627245411,5000,true)
    stats.stat_set_int(1830110676,5000,true)
    stats.stat_set_int(2619465611,5000,true)
    stats.stat_set_int(3488454659,5000,true)
    stats.stat_set_int(634468335,5000,true)
    stats.stat_set_int(437570051,5000,true)
    stats.stat_set_int(3263301663,5000,true)
    stats.stat_set_int(3761508170,5000,true)
    stats.stat_set_int(114366215,5000,true)
    stats.stat_set_int(2837167584,5000,true)
    stats.stat_set_int(2757750791,5000,true)
    stats.stat_set_int(3819650942,5000,true)
    stats.stat_set_int(262736799,5000,true)
    stats.stat_set_int(1669323992,5000,true)
    stats.stat_set_int(3502449825,5000,true)
    stats.stat_set_int(50025688,5000,true)
    stats.stat_set_int(1025115036,5000,true)
    stats.stat_set_int(2570722845,5000,true)
    stats.stat_set_int(4235862070,5000,true)
    stats.stat_set_int(748081492,5000,true)
    stats.stat_set_int(1081011498,5000,true)
    stats.stat_set_int(4123984248,5000,true)
    stats.stat_set_int(385888538,5000,true)
    stats.stat_set_int(348813430,5000,true)
    stats.stat_set_int(1388130018,5000,true)
    stats.stat_set_int(3289871319,5000,true)
    stats.stat_set_int(246990003,5000,true)
    stats.stat_set_int(1053390265,5000,true)
    stats.stat_set_int(707510436,5000,true)
    stats.stat_set_int(2608876760,5000,true)
    stats.stat_set_int(4119719478,5000,true)
    stats.stat_set_int(655957267,5000,true)
    stats.stat_set_int(973503857,5000,true)
    stats.stat_set_int(2550663726,80000000,true)
    stats.stat_set_int(2664732419,80000000,true)
    stats.stat_set_int(3420287448,80000000,true)
    stats.stat_set_int(4156311761,80000000,true)
    stats.stat_set_int(3181172055,80000000,true)
    stats.stat_set_int(3917917286,80000000,true)
    stats.stat_set_int(1839838578,80000000,true)
    stats.stat_set_int(790378396,80000000,true)
    stats.stat_set_int(1594660920,80000000,true)
    stats.stat_set_int(1001771215,80000000,true)
    stats.stat_set_int(2461499277,80000000,true)
    stats.stat_set_int(2056867477,80000000,true)
end)

menu.add_feature("Unlock Alien Tattoo Illuminati","action",others,function(f)
    native.call(0xDB8A58AEAA67CD07, 15737, 1, 0)
    native.call(0xDB8A58AEAA67CD07, 15748, 1, 0)
end)

menu.add_feature("Unlock all contracts","action",others,function(f)
    stats.stat_set_int(1271343810,-1,true)
    stats.stat_set_int(3753923238,-1,true)
    stats.stat_set_int(899350106,-1,true)
    stats.stat_set_int(72489929,-1,true)
    stats.stat_set_int(358044308,-1,true)
    stats.stat_set_int(1243064151,-1,true)
    stats.stat_set_int(2351515779,-1,true)
    stats.stat_set_int(376815632,-1,true)
    stats.stat_set_int(1832021388,-1,true)
    stats.stat_set_int(1272851172,-1,true)
    stats.stat_set_int(2702693714,-1,true)
    stats.stat_set_int(2388318819,-1,true)
    stats.stat_set_int(381476738,-1,true)
end)

menu.add_feature("Unlock All Daily Objective Awards","action",others,function(f)
    stats.stat_set_int(3432705447,10,true)
    stats.stat_set_int(1705770773,10,true)
    stats.stat_set_int(3432705447,25,true)
    stats.stat_set_int(1705770773,25,true)
    stats.stat_set_int(3432705447,50,true)
    stats.stat_set_int(1705770773,50,true)
    stats.stat_set_int(3432705447,100,true)
    stats.stat_set_int(1705770773,100,true)
    stats.stat_set_int(3413445611,7,true)
    stats.stat_set_int(805267403,7,true)
    stats.stat_set_int(3413445611,28,true)
    stats.stat_set_int(805267403,28,true)    
end)

-- VIP/CEO/MC 
--- Acid Lab
menu.add_feature("Acid Lab Product Capacity", "action", acid_lab, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    native.call(0xE07BCA305B82D2FD, 0, 0, 3, 0)
    script.set_global_i(281094, value)

end)

menu.add_feature("Acid Lab Money Multiplier", "action", acid_lab, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(279570, value)

end)

menu.add_feature("Acid Lab Money Multiplier (Updgraded)", "action", acid_lab, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(279576, value)

end)

menu.add_feature("Resupply Crate Value", "action", acid_lab, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(294845, value)

end)

menu.add_feature("Boost Limit", "action", acid_lab, function()

    repeat
        rtn, value = input.get("Insert amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284017, value)

end)

menu.add_feature("TP to Acid Lab", "action", acid_lab) -- todo

menu.add_feature("Bypass Boost daily limit", "toggle", acid_lab, function(f)
    while f.on do
        native.call(0xDB8A58AEAA67CD07, 36689, false, -1)
        system.wait(3000)
    end
end)

menu.add_feature("Source Assistant", "toggle", acid_lab, function(f)
    while f.on do
        script.set_global_i(2798615,0)
        script.set_local_i(1880879099,8655,-1)
        system.wait(1000)
    end
end)

menu.add_feature("Force Mission compatible w/ instant sell", "toggle", acid_lab, function(f)
    while f.on do
        script.set_global_i(2798615,0)
        system.wait()
    end
end)

menu.add_feature("Instant Sell", "action", acid_lab, function(f)
    script.set_local_i(2457283359,6551,10)
    script.set_local_i(2457283359,6552,10)
    script.set_local_i(2457283359,6485,2)
end)

--- Air Freight Cargo
---- Airfrieght cargo mission
menu.add_feature("[Prep/Steal] Get Mogul", "toggle", air_cargo_mission, function(f)
    while f.on do
        script.set_global_i(2798615,26)
        system.wait()
    end
end)

----- Steal Cargo
menu.add_feature("Brickade (signal jammers)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,0)
        system.wait()
    end
end)

menu.add_feature("Buzzard (crashed maverick)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,1)
        system.wait()
    end
end)

menu.add_feature("LF-22 Starling (terminal base)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,2)
        system.wait()
    end
end)

menu.add_feature("Seabreeze (seebreeze bombing)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,3)
        system.wait()
    end
end)

menu.add_feature("V-65 Molotok (cargo planes)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,4)
        system.wait()
    end
end)

menu.add_feature("Rogue (rooftops bombing)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,5)
        system.wait()
    end
end)

menu.add_feature("P-45 Nokota (merryweather jets)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,7)
        system.wait()
    end
end)

menu.add_feature("Mogul (titan rendezvous)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,8)
        system.wait()
    end
end)

menu.add_feature("Cargobob (cargobob infiltration)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,9)
        system.wait()
    end
end)

menu.add_feature("Buzzard (rooftop crates)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,10)
        system.wait()
    end
end)

menu.add_feature("Tula (salvage site)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,11)
        system.wait()
    end
end)

menu.add_feature("Pyro | Buzzard | Rogue", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,12)
        system.wait()
    end
end)

menu.add_feature("Howard NX-25 (stunts)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,13)
        system.wait()
    end
end)

menu.add_feature("V-65 Molotok (Air Ambulance)", "toggle", steal_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,14)
        system.wait()
    end
end)

----- Sell Cargo
menu.add_feature("Havok", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,15)
        system.wait()
    end
end)

menu.add_feature("Seabreeze", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,16)
        system.wait()
    end
end)

menu.add_feature("Mogul", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,17)
        system.wait()
    end
end)

menu.add_feature("FH-1 Hunter", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,20)
        system.wait()
    end
end)

menu.add_feature("RM-10 Bombushka", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,21)
        system.wait()
    end
end)

menu.add_feature("Alpha-Z1", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,22)
        system.wait()
    end
end)

menu.add_feature("Skylift", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,23)
        system.wait()
    end
end)

menu.add_feature("Cargobob", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,24)
        system.wait()
    end
end)

menu.add_feature("Ultralight", "toggle", sell_cargo, function(f)
    while f.on do
        script.set_global_i(2798615,25)
        system.wait()
    end
end)

---- Air cargo extreme 
----- custom value 
menu.add_feature("Animal Materials", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284956,value)

end)

menu.add_feature("Art & Antiques", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284957,value)
    
end)

menu.add_feature("Chemicals", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284958,value)
    
end)

menu.add_feature("Counterfeit Goods", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284959,value)
    
end)

menu.add_feature("Jewelry & Gemstones", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284960,value)
    
end)

menu.add_feature("Medical Supplies", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284961,value)
    
end)

menu.add_feature("Narcotics", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284962,value)
    
end)

menu.add_feature("Tobacco & Alcohol", "action", air_custom_value, function()

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    script.set_global_i(284963,value)
    
end)

--
menu.add_feature("[!] Set Air Cargo = 8M", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_global_i(284955,8000000)
        script.set_global_i(284956,8000000)
        script.set_global_i(284957,8000000)
        script.set_global_i(284958,8000000)
        script.set_global_i(284959,8000000)
        script.set_global_i(284960,8000000)
        script.set_global_i(284961,8000000)
        script.set_global_i(284962,8000000)
        script.set_global_i(284963,8000000)
        system.wait()
    end
end)

menu.add_feature("[!] Set Air Cargo = 500k", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_global_i(284955,500000)
        script.set_global_i(284956,500000)
        script.set_global_i(284957,500000)
        script.set_global_i(284958,500000)
        script.set_global_i(284959,500000)
        script.set_global_i(284960,500000)
        script.set_global_i(284961,500000)
        script.set_global_i(284962,500000)
        script.set_global_i(284963,500000)
        system.wait()
    end
end)

menu.add_feature("[!] Set Air Cargo = 2B", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_global_i(284955,1147483647)
        script.set_global_i(284956,1147483647)
        script.set_global_i(284957,1147483647)
        script.set_global_i(284958,1147483647)
        script.set_global_i(284959,1147483647)
        script.set_global_i(284960,1147483647)
        script.set_global_i(284961,1147483647)
        script.set_global_i(284962,1147483647)
        script.set_global_i(284963,1147483647)
        system.wait()
    end
end)

menu.add_feature("[!] Set Air Cargo = 2B", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_global_i(284955,2147483647)
        script.set_global_i(284956,2147483647)
        script.set_global_i(284957,2147483647)
        script.set_global_i(284958,2147483647)
        script.set_global_i(284959,2147483647)
        script.set_global_i(284960,2147483647)
        script.set_global_i(284961,2147483647)
        script.set_global_i(284962,2147483647)
        script.set_global_i(284963,2147483647)
        system.wait()
    end
end)

menu.add_feature("Open AirFrieght App", "action", air_cargo_manager, function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "appsmuggler") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "appsmuggler") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "appsmuggler", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

menu.add_feature("Instant Sell", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_local_i(2882788887,2963,0)
        system.wait(1500)
    end
end)

menu.add_feature("Instant Source", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_local_i(2882788887,1999,-1)
        system.wait(1500)
    end
end)

menu.add_feature("Source Assistant", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_local_i(2882788887,2698,15)
        script.set_global_i(2798615,25)
        system.wait(1500)
    end
end)

menu.add_feature("Remove Ron's Cut", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_global_i(284938,0)
        system.wait(0)
    end
end)

menu.add_feature("Remove Sell Cooldown", "toggle", air_cargo_manager, function(f)
    while f.on do
        script.set_global_i(2766148,0)
        script.set_global_i(284896,0)
        script.set_global_i(284897,0)
        script.set_global_i(284898,0)
        script.set_global_i(284899,0)
        script.set_global_i(284900,0)
        system.wait(0)
    end
end)

menu.add_feature("AirCargo Total Earning","action", air_cargo_manager,function(f)

    repeat
        rtn, value = input.get("Insert Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    stats.stat_set_int(26708994, value, true)
end)

--- Bunker Manager
---- Mission selector 
----- steal missions
menu.add_feature("[Resupply] Alien Egg (rare)", "toggle", steal_missions, function(f)
    while f.on do
        stats.stat_set_int(3550228704, 1200, true)
        stats.stat_set_int(2531035799, 1200, true)
        stats.stat_set_int(723574901, 1200, true)
        stats.stat_set_int(295142111, 1200, true)
        script.set_global_i(2798615, 2, true)
        system.wait()
    end
end)

menu.add_feature("Altruist Camp", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,1)
        system.wait()
    end
end)

menu.add_feature("The Dune Buggy", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,2)
        system.wait()
    end
end)

menu.add_feature("Police Riot", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,3)
        system.wait()
    end
end)

menu.add_feature("Mine", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,4)
        system.wait()
    end
end)

menu.add_feature("The Technical Aqua", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,5)
        system.wait()
    end
end)

menu.add_feature("Rival Operation", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,6)
        system.wait()
    end
end)

menu.add_feature("Zancudo River", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,7)
        system.wait()
    end
end)

menu.add_feature("LSIA", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,8)
        system.wait()
    end
end)

menu.add_feature("Merryweather HQ", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,9)
        system.wait()
    end
end)

menu.add_feature("Training Ground", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,10)
        system.wait()
    end
end)

menu.add_feature("Del Perro Beach", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,11)
        system.wait()
    end
end)

menu.add_feature("Cholla Springs Avenue", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,12)
        system.wait()
    end
end)

menu.add_feature("Chupacabra Street", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,13)
        system.wait()
    end
end)

----- sell missions
menu.add_feature("HVY Insurgent Pick Up", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,14)
        system.wait()
    end
end)

menu.add_feature("HVY Insurgent (normal)", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,15)
        system.wait()
    end
end)

menu.add_feature("Marshall", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,16)
        system.wait()
    end
end)

menu.add_feature("HVY Insurgent Pick Up (custom)", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,17)
        system.wait()
    end
end)

menu.add_feature("Phantom Wedge", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,18)
        system.wait()
    end
end)

menu.add_feature("Dune FAV", "toggle", steal_missions, function(f)
    while f.on do 
        script.set_global_i(2798615,19)
        system.wait()
    end
end)

-- 
menu.add_feature("Open Bunker App","action", bunker_manager,function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "appbunkerbusiness") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "appbunkerbusiness") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "appbunkerbusiness", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

menu.add_feature("Instant Sell", "toggle", bunker_manager, function(f)
    while f.on do 
        script.set_local_i(2362490864,1979,0)
        system.wait(1500)
    end
end)

menu.add_feature("Instant Delivery for Ammu-Nation Mission", "toggle", bunker_manager, function(f)
    while f.on do
        script.set_local_i(1161290954,229,0)
        system.wait(1500)
    end
end)

menu.add_feature("Disable Cooldown for Ammu-Nation Mission", "toggle", bunker_manager, function(f)
    while f.on do
        stats.stat_set_int(240433318,-1,true)
        system.wait(100)
    end
end)

menu.add_feature("Instant Win Shooting Range", "action", bunker_manager, function()
    script.set_local_i(2855495932,1659,9000)
end)

--- Cooldown Disablers
menu.add_feature("Dax Job", "toggle", cooldown_disable, function(f)
    while f.on do
        stats.stat_set_int(588366157,-1,true)
        stats.stat_set_int(1323335159,-1,true)
        system.wait(100)
    end
end)

menu.add_feature("Yohan Nightclub Mission", "toggle", cooldown_disable, function(f)
    while f.on do
        stats.stat_set_int(2419099058,-1,true)
        stats.stat_set_int(962330003,-1,true)
        system.wait(100)
    end
end)

menu.add_feature("Biker Bar Mission", "toggle", cooldown_disable, function(f)
    while f.on do
        stats.stat_set_int(1798659711,-1,true)
        system.wait(100)
    end
end)

menu.add_feature("Export Mixed Goods Mission", "toggle", cooldown_disable, function(f)
    while f.on do
        script.set_global_i(294716,0)
        system.wait(100)
    end
end)

--- High Demand
menu.add_feature("Disable High Demand Bonus", "toggle", high_demand_bonus) -- none of these are done

--- mc manager
menu.add_feature("MC Sell - Single Big Truck","toggle",mc_manager,function(f)
    while f.on do 
        script.set_local_i(3757852771,715,0)
        system.wait()
    end
end)

--- nc Modifiers
menu.add_feature("Instant Sell","toggle",nightclub_modifiers,function(f)
    while f.on do
        script.set_local_i(4093145562,2507,15)
        script.set_local_i(4093145562,2508,15)
        script.set_local_i(4093145562,2336,0)
        system.wait(2500)
    end
end)

menu.add_feature("Modify NightClub Sell to 4M","toggle",nightclub_modifiers,function(f)
    while f.on do
        script.set_local_i(3518909077,148,3870000)
        system.wait()
    end
end)

menu.add_feature("Modify NightClub Sell to 4M","toggle",nightclub_modifiers,function(f)

    repeat
        rtn, value = input.get("Insert Money Amount", "", 10, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0

    while f.on do
        script.set_local_i(3518909077,148,value)
        system.wait()
    end
end)

menu.add_feature("Remove Nightclub Sell Cooldown","toggle",nightclub_modifiers,function(f)
    while f.on do
        script.set_global_i(1962972,-1)
        system.wait()
    end
end)

--- Remote Access
menu.add_feature("Start CEO", "action", remote_access, function()
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
end)

menu.add_feature("Open Airfreight App","action", remote_access,function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "appsmuggler") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "appsmuggler") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "appsmuggler", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

menu.add_feature("Open Bunker App","action", remote_access,function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "appbunkerbusiness") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "appbunkerbusiness") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "appbunkerbusiness", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

menu.add_feature("Franklin's Agency","action", remote_access,function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "appfixersecurity") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "appfixersecurity") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "appfixersecurity", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

menu.add_feature("Master Control Terminal","action", remote_access,function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "apparcadebusinesshub") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "apparcadebusinesshub") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "apparcadebusinesshub", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

menu.add_feature("Nightclub App","action", remote_access,function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "appbusinesshub") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "appbusinesshub") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "appbusinesshub", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

menu.add_feature("Terrobyte Touchscreen Terminal","action", remote_access,function()
    script.set_global_i(1854376,-1)
    script.set_global_i(1894584,0)
    script.set_global_i(274986,32)
    script.set_global_i(274984,32)
    native.call(0x6EB5F71AA68F2E8E, "apphackertruck") -- VOID REQUEST_SCRIPT(const char* scriptName)
    native.call(0xE6CC9F3BA0FB9EF1, "apphackertruck") -- BOOL HAS_SCRIPT_LOADED(const char* scriptName)
    native.call(0xE81651AD79516E48, "apphackertruck", 54000) -- INT START_NEW_SCRIPT(const char* stackSize)
end)

--- triggers options
-- fuck this one with it's transaction errors

--- vehicle cargo
menu.add_feature("Disable Sell Cooldown", "toggle", vehicle_cargo, function(f)
    while f.on do
        script.set_global_i(281830,-1)
        script.set_global_i(2766116,-1)
        script.set_global_i(2766118,-1)
        system.wait()
    end
end)

menu.add_feature("Disable Vehicle Source Cooldown", "toggle", vehicle_cargo, function(f)
    while f.on do
        script.set_global_i(281459,0)
        script.set_global_i(281827,0)
        script.set_global_i(281828,0)
        script.set_global_i(281829,0)
        script.set_global_i(281830,0)
        system.wait()
    end
end)

---- source vehicle
----- Top Range
menu.add_feature("Roosevelt Valor - [L4WLE55]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,37)
        system.wait(300)
    end
end)

menu.add_feature("Stirling GT - [M4J3ST1C]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,40)
        system.wait(300)
    end
end)

menu.add_feature("FMJ - [C4TCHM3]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,19)
        system.wait(300)
    end
end)

menu.add_feature("Osiris - [OH3LL0]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,16)
        system.wait(300)
    end
end)

menu.add_feature("Pfister 811 - [M1DL1F3]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,25)
        system.wait(300)
    end
end)

menu.add_feature("X80 Prototype - [FUTUR3]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,1)
        system.wait(300)
    end
end)

menu.add_feature("Reaper - [2FA5T4U]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,22)
        system.wait(300)
    end
end)

menu.add_feature("ETR1 - [B1GB0Y]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,13)
        system.wait(300)
    end
end)

menu.add_feature("T20 - [CAR4M3L]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,10)
        system.wait(300)
    end
end)

menu.add_feature("Tyrus - [C1TRUS]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,4)
        system.wait(300)
    end
end)

menu.add_feature("Z-Type - [B1GMON3Y]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,43)
        system.wait(300)
    end
end)

menu.add_feature("Roosevelt Valor - [0LDT1M3R]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,38)
        system.wait(300)
    end
end)

menu.add_feature("Stirling GT - [T0UR3R]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,41)
        system.wait(300)
    end
end)

menu.add_feature("FMJ - [J0K3R]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,20)
        system.wait(300)
    end
end)

menu.add_feature("Mamba - [BLKM4MB4]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,32)
        system.wait(300)
    end
end)

menu.add_feature("Osiris - [PH4R40H]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,17)
        system.wait(300)
    end
end)

menu.add_feature("Pfister 811 - [R3G4L]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,26)
        system.wait(300)
    end
end)

menu.add_feature("X80 Prototype - [M4K3B4NK]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,2)
        system.wait(300)
    end
end)

menu.add_feature("Reaper - [D34TH4U]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,23)
        system.wait(300)
    end
end)

menu.add_feature("ETR1 - [M0N4RCH]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,14)
        system.wait(300)
    end
end)

menu.add_feature("T20 - [T0PSP33D]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,11)
        system.wait(300)
    end
end)

menu.add_feature("Z-Type - [K1NGP1N]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,44)
        system.wait(300)
    end
end)

menu.add_feature("Stirling GT - [R4LLY]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,42)
        system.wait(300)
    end
end)

menu.add_feature("FMJ - [H0T4U]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,21)
        system.wait(300)
    end
end)

menu.add_feature("Mamba - [V1P]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,33)
        system.wait(300)
    end
end)

menu.add_feature("Osiris - [SL33K]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,18)
        system.wait(300)
    end
end)

menu.add_feature("Pfister 811 - [SL1CK]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,27)
        system.wait(300)
    end
end)

menu.add_feature("X80 Prototype - [TURB0]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,3)
        system.wait(300)
    end
end)

menu.add_feature("Reaper - [GR1M]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,24)
        system.wait(300)
    end
end)

menu.add_feature("T20 - [D3V1L]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,12)
        system.wait(300)
    end
end)

menu.add_feature("Tyrus - [TR3X]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,6)
        system.wait(300)
    end
end)

menu.add_feature("Z-Type - [CE0]","toggle",top_range,function(f)
    while f.on do
        script.set_global_i(1894772,45)
        system.wait(300)
    end
end)

----- Mid Range
menu.add_feature("Cheetah - [BUZZ3D]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,76)
        system.wait(300)
    end
end)

menu.add_feature("Coquette Classic - [T0PL3SS]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,73)
        system.wait(300)
    end
end)

menu.add_feature("Coquette BlackFin- [V1NT4G3]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,61)
        system.wait(300)
    end
end)

menu.add_feature("Entity XF - [IML4TE]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,49)
        system.wait(300)
    end
end)

menu.add_feature("Omnis - [0BEYM3]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,58)
        system.wait(300)
    end
end)

menu.add_feature("Seven-70 - [FRU1TY]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,64)
        system.wait(300)
    end
end)

menu.add_feature("Sultan RS - [SN0WFLK3]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,52)
        system.wait(300)
    end
end)

menu.add_feature("Tropos - [1MS0RAD]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,46)
        system.wait(300)
    end
end)

menu.add_feature("Verlierer - [PR3C1OUS]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,67)
        system.wait(300)
    end
end)

menu.add_feature("Zentorno - [W1NN1NG]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,55)
        system.wait(300)
    end
end)

menu.add_feature("Cheetah - [M1DN1GHT]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,77)
        system.wait(300)
    end
end)

menu.add_feature("Coquette Classic - [T0FF33]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,74)
        system.wait(300)
    end
end)

menu.add_feature("Coquette  BlackFin - [W1P30UT]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,62)
        system.wait(300)
    end
end)

menu.add_feature("Entity XF - [0V3RFL0D]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,50)
        system.wait(300)
    end
end)

menu.add_feature("Omnis - [W1D3B0D]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,59)
        system.wait(300)
    end
end)

menu.add_feature("Seven 70 - [4LL0Y5]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,65)
        system.wait(300)
    end
end)

menu.add_feature("Sultan RS - [F1D3L1TY]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,53)
        system.wait(300)
    end
end)

menu.add_feature("Tropos Rallye - [31GHT135]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,47)
        system.wait(300)
    end
end)

menu.add_feature("Verlierer - [0UTFR0NT]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,68)
        system.wait(300)
    end
end)

menu.add_feature("Zentorno - [0LDN3W5]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,56)
        system.wait(300)
    end
end)

menu.add_feature("Cheetah - [B1GC4T]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,78)
        system.wait(300)
    end
end)

menu.add_feature("Coquette Classic - [CL45SY]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,75)
        system.wait(300)
    end
end)

menu.add_feature("Coquette BlackFin - [BLKF1N]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,63)
        system.wait(300)
    end
end)

menu.add_feature("Entity XF - [W1DEB0Y]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,51)
        system.wait(300)
    end
end)

menu.add_feature("Omnis - [D1RTY]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,60)
        system.wait(300)
    end
end)

menu.add_feature("Seven 70 - [SP33DY]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,66)
        system.wait(300)
    end
end)

menu.add_feature("Sultan RS - [5H0W0FF]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,54)
        system.wait(300)
    end
end)

menu.add_feature("Tropos Rallye - [1985]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,48)
        system.wait(300)
    end
end)

menu.add_feature("Verlierer - [CURV35]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,69)
        system.wait(300)
    end
end)

menu.add_feature("Zentorno - [H3R0]","toggle",mid_range,function(f)
    while f.on do
        script.set_global_i(1894772,57)
        system.wait(300)
    end
end)

----- Standard Range
menu.add_feature("Alpha- [V1S1ONRY]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,28)
        system.wait(300)
    end
end)

menu.add_feature("Banshee 900R - [DR1FT3R]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,82)
        system.wait(300)
    end
end)

menu.add_feature("Bestia GTS - [BE4STY]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,7)
        system.wait(300)
    end
end)

menu.add_feature("Feltzer - [P0W3RFUL]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,70)
        system.wait(300)
    end
end)

menu.add_feature("Jester - [H0TP1NK]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,94)
        system.wait(300)
    end
end)

menu.add_feature("Massacro - [TR0P1CAL]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,88)
        system.wait(300)
    end
end)

menu.add_feature("Nightshade - [DE4DLY]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,79)
        system.wait(300)
    end
end)

menu.add_feature("Sabre Turbo Custom - [GUNZ0UT]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,91)
        system.wait(300)
    end
end)

menu.add_feature("Tampa - [CH4RG3D]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,34)
        system.wait(300)
    end
end)

menu.add_feature("Alpha - [L0NG80Y]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,29)
        system.wait(300)
    end
end)

menu.add_feature("Banshee 900R - [DOM1NO]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,83)
        system.wait(300)
    end
end)

menu.add_feature("Bestia GTS - [5T34LTH]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,8)
        system.wait(300)
    end
end)

menu.add_feature("Feltzer - [K3YL1M3]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,71)
        system.wait(300)
    end
end)

menu.add_feature("Jester - [T0PCL0WN]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,95)
        system.wait(300)
    end
end)

menu.add_feature("Massacro - [B4N4N4]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,89)
        system.wait(300)
    end
end)

menu.add_feature("Nightshade - [TH37OS]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,80)
        system.wait(300)
    end
end)

menu.add_feature("Sabre Turbo Custom - [0R1G1N4L]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,92)
        system.wait(300)
    end
end)

menu.add_feature("Tampa - [CRU151N]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,35)
        system.wait(300)
    end
end)

menu.add_feature("Turismo R - [M1LKYW4Y]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,86)
        system.wait(300)
    end
end)

menu.add_feature("Alpha - [R31GN]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,30)
        system.wait(300)
    end
end)

menu.add_feature("Banshee 900R - [H0WL3R]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,84)
        system.wait(300)
    end
end)

menu.add_feature("Bestia GTS - [5M00TH]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,9)
        system.wait(300)
    end
end)

menu.add_feature("Feltzer - [R4C3R]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,72)
        system.wait(300)
    end
end)

menu.add_feature("Jester - [NOF00L]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,96)
        system.wait(300)
    end
end)

menu.add_feature("Massacro - [B055]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,90)
        system.wait(300)
    end
end)

menu.add_feature("Nightshade - [E4TM3]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,81)
        system.wait(300)
    end
end)

menu.add_feature("Sabre Turbo Custom - [B0UNC3]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,93)
        system.wait(300)
    end
end)

menu.add_feature("Tampa - [MU5CL3]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,36)
        system.wait(300)
    end
end)

menu.add_feature("Turismo R - [TPD4WG]","toggle",stand_range,function(f)
    while f.on do
        script.set_global_i(1894772,87)
        system.wait(300)
    end
end)

----- Unknown Range
menu.add_feature("Mamba - [0LDBLU3]","toggle",unk_range,function(f)
    while f.on do
        script.set_global_i(1894772,31)
        system.wait(300)
    end
end)

menu.add_feature("Turismo R - [IN4H4ZE]","toggle",unk_range,function(f)
    while f.on do
        script.set_global_i(1894772,85)
        system.wait(300)
    end
end)

menu.add_feature("Tyrus - [B35TL4P]","toggle",unk_range,function(f)
    while f.on do
        script.set_global_i(1894772,5)
        system.wait(300)
    end
end)

menu.add_feature("Roosevelt Valor - [V4L0R]","toggle",unk_range,function(f)
    while f.on do
        script.set_global_i(1894772,39)
        system.wait(300)
    end
end)

menu.add_feature("ETR1 - [PR3TTY]","toggle",unk_range,function(f)
    while f.on do
        script.set_global_i(1894772,15)
        system.wait(300)
    end
end)

--- warehouse
---- choose crate to buy
menu.add_feature("Medical Supplies","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,0)
        system.wait()
    end
end)

menu.add_feature("Tobacco & Alcohol","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,1)
        system.wait()
    end
end)

menu.add_feature("Art & Antiques","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,2)
        system.wait()
    end
end)

menu.add_feature("Electronic Goods","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,3)
        system.wait()
    end
end)

menu.add_feature("Weapons & Ammo","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,4)
        system.wait()
    end
end)

menu.add_feature("Narcotics","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,5)
        system.wait()
    end
end)

menu.add_feature("Gemstones","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,6)
        system.wait()
    end
end)

menu.add_feature("Animal Materials","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,7)
        system.wait()
    end
end)

menu.add_feature("Counterfeit Goods","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,8)
        system.wait()
    end
end)

menu.add_feature("Jewelry","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,9)
        system.wait()
    end
end)

menu.add_feature("Bullion","toggle",normal_crate,function(f)
    while f.on do
        script.set_global_i(1949968,0)
        script.set_global_i(1949814,10)
        system.wait()
    end
end)
---- choose special to buy
menu.add_feature("Ornamental Egg","toggle",special_crate,function(f)
    while f.on do
        script.set_global_i(1949968,1)
        script.set_global_i(1949814,2)
        system.wait()
    end
end)

menu.add_feature("Golden Minigun","toggle",special_crate,function(f)
    while f.on do
        script.set_global_i(1949968,1)
        script.set_global_i(1949814,4)
        system.wait()
    end
end)

menu.add_feature("Large Diamond","toggle",special_crate,function(f)
    while f.on do
        script.set_global_i(1949968,1)
        script.set_global_i(1949814,6)
        system.wait()
    end
end)

menu.add_feature("Rare Hide","toggle",special_crate,function(f)
    while f.on do
        script.set_global_i(1949968,1)
        script.set_global_i(1949814,7)
        system.wait()
    end
end)

menu.add_feature("Film Reel","toggle",special_crate,function(f)
    while f.on do
        script.set_global_i(1949968,1)
        script.set_global_i(1949814,8)
        system.wait()
    end
end)

menu.add_feature("Rare Pocket Watch","toggle",special_crate,function(f)
    while f.on do
        script.set_global_i(1949968,1)
        script.set_global_i(1949814,9)
        system.wait()
    end
end)

--
menu.add_feature("Auto Resupply Warehouse", "toggle", warehouse) -- todo

menu.add_feature("Special Cargo - Sell for 5.9M", "toggle", warehouse, function(f)
    while f.on do
        script.set_global_i(278133,5780000)
        script.set_global_i(278131,5780000)
        script.set_global_i(278135,5780000)
        script.set_global_i(278129,5780000)
        script.set_global_i(278127,5780000)
        script.set_global_i(278137,5780000)
        script.set_global_i(277933,5791000)
        script.set_global_i(277934,2895500)
        script.set_global_i(277935,1930333)
        script.set_global_i(277936,1158200)
        script.set_global_i(277937,827285)
        script.set_global_i(277938,643444)
        script.set_global_i(277939,413642)
        script.set_global_i(277940,304789)
        script.set_global_i(277941,241291)
        script.set_global_i(277942,199689)
        script.set_global_i(277943,170323)
        script.set_global_i(277944,148487)
        script.set_global_i(277945,131613)
        script.set_global_i(277946,118183)
        script.set_global_i(277947,98152)
        script.set_global_i(277948,83927)
        script.set_global_i(277949,73303)
        script.set_global_i(277950,65067)
        script.set_global_i(277951,58494)
        script.set_global_i(277952,52645)
        script.set_global_i(277953,52171)
        system.wait()
    end
end)

menu.add_feature("Instant Buy","toggle",warehouse,function(f)
    while f.on do
        script.set_local_i(3942964741,603,1)
        script.set_local_i(3942964741,789,6)
        script.set_local_i(3942964741,790,4)
        system.wait(2500)
    end
end)

menu.add_feature("Instant Sell","toggle",warehouse,function(f)
    while f.on do
        script.set_local_i(2067673554,541,99999)
        system.wait(2500)
    end
end)

menu.add_feature("Get Max Crates by a single purchase","toggle",warehouse,function(f)
    while f.on do
        script.set_local_i(3942964741,599,111)
        system.wait(2500)
    end
end)

menu.add_feature("Get Custom Crates by a single purchase","toggle",warehouse,function(f)
    
    repeat
        rtn, value = input.get("Insert Amount", "", 3, eInputType.IT_ASCII)
        if rtn == 2 then return end
        system.wait(0)
    until rtn == 0
    
    while f.on do
        script.set_local_i(3942964741,599,value)
        system.wait(2500)
    end
end)

menu.add_feature("Ignore Special Cargo Cooldown","toggle",warehouse,function(f)
    while f.on do
        script.set_global_i(277698,0)
        script.set_global_i(277699,0)        
        system.wait(2500)
    end
end)

--
menu.add_feature("Allow Jobs/Missions in a private session","toggle",business_helper,function(f)
    while f.on do
        script.set_global_i(2684606,0)
        system.wait()
    end
end)

-- online
--- give Collectibles
--- drop rp
menu.add_player_feature("Alien", "toggle", drop_rp, function(f, pid)
    streaming.request_model(1298470051)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 1298470051, 0, 1)
        system.wait(5)
    end
end)

menu.add_player_feature("Beast", "toggle", drop_rp, function(f, pid)
    streaming.request_model(1955543594)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 1955543594, 0, 1)
        system.wait(5)
    end
end)

menu.add_player_feature("Impotent Rage", "toggle", drop_rp, function(f, pid)
    streaming.request_model(446117594)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 446117594, 0, 1)
        system.wait(5)
    end
end)

menu.add_player_feature("Pogo", "toggle", drop_rp, function(f, pid)
    streaming.request_model(1025210927)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 1025210927, 0, 1)
        system.wait(5)
    end
end)

menu.add_player_feature("Bubble", "toggle", drop_rp, function(f, pid)
    streaming.request_model(437412629)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 437412629, 0, 1)
        system.wait(5)
    end
end)

menu.add_player_feature("Republic space ranger", "toggle", drop_rp, function(f, pid)
    streaming.request_model(3644302825)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 3644302825, 0, 1)
        system.wait(5)
    end
end)

menu.add_player_feature("Republic space ranger 2", "toggle", drop_rp, function(f, pid)
    streaming.request_model(601745115)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 601745115, 0, 1)
        system.wait(5)
    end
end)

menu.add_player_feature("Sasquatch", "toggle", drop_rp, function(f, pid)
    streaming.request_model(2568981558)
    while f.on do
        local coords = player.get_player_coords(pid)
        native.call(0x673966A0C0FD7171, 738282662, coords, 0, 1, 2568981558, 0, 1)
        system.wait(5)
    end
end)