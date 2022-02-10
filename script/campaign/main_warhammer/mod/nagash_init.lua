---@class bdsm
local bdsm = get_bdsm()

local mct
local vlib = get_vlib()

local log,logf,err,errf = vlib:get_log_functions("[nag_init]")

if is_function(get_mct) then
    mct = get_mct()
end

local faction_key = bdsm._faction_key

local function init_listeners()
    --- TODO test that this prevents ogre camp spawning!
    Ogre_Camp.ogre_camp_cooldowns[faction_key] = 999
    
    --- Whenever a settlement is occupied by Nagash, auto-set the level to 1.
    core:add_listener(
        "NagashWimp",
        "RegionFactionChangeEvent",
        function(context)
            local reg = context:region()
            local daddy = reg:owning_faction()
            return not reg:is_abandoned() and not daddy:is_null_interface() and daddy:name() == faction_key --and reg:settlement():primary_slot():building():building_level() > 1
        end,
        function (context)
            local reg = context:region()
            cm:instantly_set_settlement_primary_slot_level(reg:settlement(), 1)
        end,
        true
    )

    ---@param context BuildingCompleted
    local function is_warpstone_mine(context)
        local mines = {
            nag_outpost_special_nagashizzar_2 = true,
            nag_outpost_special_nagashizzar_4 = true,
            nag_outpost_primary_warpstone_1 = true,
        }
        local name = context:building():name()
        return mines[name]
    end

    --- TODO make it chance-based?
    --- Add in Warpstone from Warpstone Mines
    core:add_listener(
        "NagashWarpstone",
        "BuildingCompleted",
        function(context)
            return is_warpstone_mine(context)
        end,
        function(context)
            local amount = 1
            cm:faction_add_pooled_resource(bdsm:get_faction_key(), "nag_warpstone", "nag_warpstone_buildings", amount)
        end,
        true
    )

    --- BETA temp compat
    if not cm:get_saved_value("warpstone_check") then
        local f = bdsm:get_faction()
        local r_list = f:region_list()
        
        local a = 0
        for i = 0, r_list:num_items() -1 do
            local r = r_list:item_at(i)
            logf("Checking %s for warpstone mines", r:name())
            --- izzar landmark
            if r:building_exists("nag_outpost_special_nagashizzar_2") then a = a + 1 end
            if r:building_exists("nag_outpost_special_nagashizzar_3") then a = a + 1 end
            if r:building_exists("nag_outpost_special_nagashizzar_4") then a = a + 2 end
            if r:building_exists("nag_outpost_special_nagashizzar_5") then a = a + 2 end

            --- regular ass mines
            if r:building_exists("nag_outpost_primary_warpstone_1") then a = a + 1 end
        end

        cm:faction_add_pooled_resource(bdsm:get_faction_key(), "nag_warpstone", "nag_warpstone_buildings", a)
        cm:set_saved_value("warpstone_check", true)
    end

    --- TODO find a better way of doing this.
    --- disable negative vampire traits
    core:add_listener(
        "NagRemoveBadTraits",
        "CharacterTurnStart",
        function(context)
           local c = context:character()
           return c:faction():name() == bdsm:get_faction_key() and c:has_trait("wh2_main_trait_corrupted_vampire")
        end,
        function(context)
            cm:force_remove_trait("character_cqi:"..context:character():command_queue_index(), "wh2_main_trait_corrupted_vampire")
        end,
        true
    )

    -- Nothing needed here right?
    -- --- TODO auto-equip traitor kings with one of the books
    -- core:add_listener(
    --     "NagashTraitor",
    --     "CharacterCreated",
    --     function (context)
    --         local character = context:character()
    --         local faction = character:faction()

    --         return faction:name() == faction_key and character:character_subtype_key() == "nag_traitor_king"
    --     end,
    --     function (context)
    --         local character = context:character()

    --         --- TODO restrict to only 1-3 for a while, then 1-6, then 1-9.
    --         local anc = "nag_anc_talisman_books_of_nagash_book_"
    --         local d = {"one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}

    --         local anc_key = anc .. d[cm:random_number(#d)]
    --         cm:force_add_ancillary(
    --             character,
    --             anc_key,
    --             true,
    --             false
    --         )
    --     end
    -- )

    --- TODO handle the mission chains!
    if not cm:get_saved_value("nagash_intro_completed") then
        core:add_listener(
            "NagashIntroChain",
            "MissionSucceeded",
            function(context)
                local mission = context:mission()
                bdsm:logf("Completed %s", mission:mission_record_key())
                return string.find(mission:mission_record_key(), "nagash_intro_")
            end,
            ---@param context MissionSucceeded
            function(context)
                bdsm:logf("In NagashIntroChain")
                local mission_key = context:mission():mission_record_key()
                local num = string.gsub(mission_key, "nagash_intro_", "")

                bdsm:logf("Mission num is %s", num)
                num = tonumber(num)
                bdsm:logf("Tonumber is %d", num)

                local nag_fact = bdsm:get_faction_key()

                bdsm:logf("???")
                
                if num == 5 then
                    bdsm:logf("5")
                    --- last mission, TP through
                    local nag = bdsm:get_faction_leader()
                    local nag_str = cm:char_lookup_str(nag)
                    
                    --- TODO db-ify and err check
                    local nx,ny = cm:find_valid_spawn_location_for_character_from_position(bdsm:get_faction_key(), 718, 187, true, 3)
                    bdsm:logf("Trying to find a spot to spawn from (%d, %d); pos is (%d, %d); char str is %s", 718, 187, nx, ny, nag_str)

                    --- TP to the other side
                    cm:callback(function()
                        cm:teleport_to(
                            nag_str,
                            nx,
                            ny,
                            false
                        )

                        cm:zero_action_points(nag_str)
                        
                        local mort = bdsm:get_mortarch_with_key("nag_mortarch_arkhan")
                        mort:spawn()

                        --- make BP visible
                        cm:make_region_visible_in_shroud(nag_fact, "wh2_main_great_mortis_delta_black_pyramid_of_nagash")

                        --- TODO trigger Chapter 1 objectives (include BP conquer and raising as a part of that)
                        --- TODO trigger the BP mission chain
                        local mm = mission_manager:new(nag_fact, "nag_nagash_capture_settlement_black_pyramid")
                        mm:add_new_objective("CAPTURE_REGIONS");
                        mm:add_condition("region wh2_main_great_mortis_delta_black_pyramid_of_nagash");
                        mm:add_payload("money 1000");
                        mm:trigger()
                    end, 0.5)


                    --- remove interactive marker
                    cm:remove_interactable_campaign_marker("nagash_intro_5")

                    cm:set_saved_value("nagash_intro_completed", true)
                    core:remove_listener("NagashIntroChain")
                elseif num == 4 then 
                    bdsm:logf("4")
                    -- trigger num 5
                    cm:trigger_mission(nag_fact, "nagash_intro_5", true, false, true)
                    
                    --- spawn an interactive marker!
                    cm:add_interactable_campaign_marker(
                        "nagash_intro_5",
                        "nagash_intro_5",
                        800, -- ALSO SET IN cdir_events_mission_option_junctions!!!
                        206, -- DITTO
                        5,
                        nag_fact,
                        ""
                    )
                elseif num == 3 then
                    bdsm:logf("3")
                    -- trigger num 4
                    local mm = mission_manager:new(nag_fact, "nagash_intro_4")
                    mm:add_new_objective("CAPTURE_REGIONS");
                    mm:add_condition("region wh2_main_the_broken_teeth_desolation_of_nagash");
                    mm:add_payload("money 1000");
                    mm:trigger()
                    
                elseif num == 2 then 
                    bdsm:logf("2")
                    -- trigger num 3
                    local mm = mission_manager:new(nag_fact, "nagash_intro_3")
                    mm:add_new_objective("OWN_N_UNITS");
                    
                    --- TODO?
                    -- mm:add_condition("unit wh2_dlc09_tmb_inf_skeleton_spearmen_0");
                    -- mm:add_condition("unit wh2_dlc09_tmb_inf_skeleton_warriors_0");
                    
                    mm:add_condition("total 15");
                    mm:add_payload("money 1000");
                    mm:trigger()
                elseif num == 1 then 
                    bdsm:logf("Creating new mission 2")
                    -- trigger num 2
                    local mm = mission_manager:new(nag_fact, "nagash_intro_2")

                    mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
                    mm:add_condition("faction " .. nag_fact);
                    mm:add_condition("building_level nag_outpost_special_nagashizzar_2");
                    mm:add_condition("total 1");
                    mm:add_payload("money 1000")
                    mm:trigger()
                end
            end,
            true
        )
    end
end

local function init()
    local faction = cm:get_faction(faction_key)
    --- player only
    if not faction:is_human() then return end

    bdsm:setup_rites()

    local option = "intro"
    local all_morts = false
    if mct then
        option = mct:get_mod_by_key("nagash_dev"):get_option_by_key("start_choice"):get_finalized_setting()
        all_morts = mct:get_mod_by_key("nagash_dev"):get_option_by_key("morts"):get_finalized_setting()
    end

    local f = nil

    --- DEBUG beta only settings
    option = "bp"
    all_morts = false

    if option == "intro" then
        bdsm:logf("Starting the intro, first_turn_begin()!")
        f = bdsm.first_turn_begin
    elseif option == "bp" then
        bdsm:logf("Starting the intro, mid_game_start()!")
        f = bdsm.mid_game_start
    elseif option == "domination" then
        bdsm:logf("Starting the intro, world_domination_start()!")
        f = bdsm.world_domination_start
    end

    if cm:is_new_game() then
        -- spawn units, set buildings, etc.
        -- intro battle triggered after the rest
        local ok, err = pcall(function()
            bdsm:logf("Starting first turn")
            f(bdsm)
            bdsm:logf("Ending first turn")
        end) if not ok then bdsm:errorf(err) end

        if all_morts then
            bdsm:all_morts()
        end
    else
        -- if option == "intro" then
            if not cm:get_saved_value("bdsm_first_turn_completed") and cm:get_saved_value("bdsm_intro_battle_completed") then
                -- trigger post-battle stuff
                bdsm:post_intro_battle()
            end
        -- end
    end

    local ok, err = pcall(function()
        init_listeners()
    end) if not ok then bdsm:errorf(err) end

    vlib:load_module("armies", bdsm._default_module_path)
end

cm:add_first_tick_callback(
    function()
        local ok, err = pcall(function()
        init()

        --- BETA
        if not cm:get_saved_value("vandy_fix_pls") then 
            cm:transfer_region_to_faction(bdsm._izar_key, bdsm._faction_key)
            cm:set_saved_value("vandy_fix_pls", true)
        end
        end) if not ok then bdsm:errorf(err) end

        bdsm:logf("nagash_init OK")
    end
)