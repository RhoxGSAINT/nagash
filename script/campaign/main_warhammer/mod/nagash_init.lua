---@class bdsm
local bdsm = get_bdsm()

local mct
local vlib = get_vlib()

if is_function(get_mct) then
    mct = get_mct()
end

local faction_key = bdsm._faction_key

local function init_listeners()
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
                        
                        --- TODO spawn Arkhan

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
    --- TODO player only
    if not faction:is_human() then return end

    bdsm:setup_rites()

    local option = "intro"
    local all_morts = false
    if mct then
        option = mct:get_mod_by_key("nagash_dev"):get_option_by_key("start_choice"):get_finalized_setting()
        all_morts = mct:get_mod_by_key("nagash_dev"):get_option_by_key("morts"):get_finalized_setting()
    end

    local f = nil

    if option == "intro" then
        f = bdsm.first_turn_begin
    elseif option == "bp" then
        f = bdsm.mid_game_start
    elseif option == "domination" then
        f = bdsm.world_domination_start
    end

    if cm:is_new_game() then
        -- spawn units, set buildings, etc.
        -- intro battle triggered after the rest
        f(bdsm)

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

    init_listeners()
end

cm:add_first_tick_callback(init)