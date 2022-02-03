--- This script is specifically used for the first turn stuff.
-- From the intro QB, to the cutscene post battle, to the scripted intervention (?)
-- VANDY: Keep in mind MP, please :)
-- TODO keep in mind MP

---@class bdsm
local bdsm = get_bdsm()
local vlib = get_vlib()

local log,logf,err,errf = vlib:get_log_functions("[nag]")

-- this is triggered on the, well, first turn
function bdsm:first_turn_begin()
    local faction_key = bdsm:get_faction_key()
    local nagashizar_key = "wh2_main_the_broken_teeth_nagashizar"

    local faction_obj = cm:get_faction(faction_key)

    if faction_obj:is_human() then
        -- spawn new Nagash, gain Nagashizar, and kill dummy Nagash
        cm:transfer_region_to_faction(nagashizar_key, faction_key)

        -- hide character events, so "Nagash died!" doesn't show up
        cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
        cm:disable_event_feed_events(true, "", "", "character_trait_lost")
        cm:disable_event_feed_events(true, "", "", "character_ancillary_lost")
        cm:disable_event_feed_events(true, "", "", "character_wounded")

        do
            --- Kill fake Nagash
            local nagash = faction_obj:faction_leader()
            cm:kill_character(nagash:command_queue_index(), true, false)
            -- cm:kill_character_and_commanded_unit("character_cqi:"..nagash:command_queue_index(), true, false)
        end
            
        ---@type NagHuskDB
        local starting_info = bdsm:load_db("nag_husk_start")
        local unit_list = table.concat(starting_info.starting_units, ",")
        local forename,surname = starting_info.forename,starting_info.surname
        local subtype = starting_info.subtype
        local pos = starting_info.pos

        local x,y = cm:find_valid_spawn_location_for_character_from_position(
            faction_key,
            pos.x,
            pos.y,
            true,
            3
        )

        logf("Found position for Nagash at (%d, %d)", x, y)

        local ancillary_list = starting_info.ancillaries
        local horde_buildings,settle_buildings = starting_info.horde_buildings, starting_info.nagashizzar_buildings

        cm:create_force_with_general(
            faction_key,
            unit_list,
            nagashizar_key,
            pos.x,
            pos.y,
            "general",
            subtype,
            forename,
            "",
            surname,
            "",
            true,
            function(char_cqi)
                ---@type CHARACTER_SCRIPT_INTERFACE
                local character = cm:get_character_by_cqi(char_cqi)

                for i,anc in ipairs(ancillary_list) do
                    cm:force_add_ancillary(
                        character,
                        anc,
                        true,
                        true
                    )
                end

                local mf_cqi = character:military_force():command_queue_index()

                for i,building in ipairs(horde_buildings) do 
                    cm:add_building_to_force(mf_cqi, building)
                end
            end
        )

        -- incorporate the local Skaven!
        ---@type intro_chain_skaven
        local intro_chain_skaven = bdsm:load_db("intro_chain_skaven")
        local sx,sy = cm:find_valid_spawn_location_for_character_from_position(intro_chain_skaven.faction_key, intro_chain_skaven.pos.x, intro_chain_skaven.pos.y, true)
        
        -- local nagash_cqi = faction_obj:command_queue_index()
        
        cm:force_declare_war(intro_chain_skaven.faction_key, faction_key, false, false, false)
        cm:transfer_region_to_faction(intro_chain_skaven.owned_region, intro_chain_skaven.faction_key)

        local skaven_mfcqi

        cm:create_force(
            intro_chain_skaven.faction_key,
            table.concat(intro_chain_skaven.units, ","),
            nagashizar_key,
            sx,
            sy,
            true,
            function(cqi, mf_cqi)
                skaven_mfcqi = mf_cqi
            end,
            false
        )
        --- TODO change corruption (add Skaven corruption at 10-15%, vamp at the rest?)

        cm:callback(function()
            -- upgrade Himselfizar to level 1
            local s = cm:get_region(nagashizar_key):settlement()
            cm:instantly_set_settlement_primary_slot_level(s, starting_info.nagashizzar_starting_level)
            
            local ss = cm:get_region(intro_chain_skaven.owned_region):settlement()
            cm:instantly_set_settlement_primary_slot_level(ss, intro_chain_skaven.owned_region_starting_level)

            cm:callback(function()
                for i,building in ipairs(settle_buildings) do
                    cm:add_building_to_settlement(nagashizar_key, building)
                end

                -- add in Desolation of Nagash buildings
                for i,building in ipairs(intro_chain_skaven.buildings) do 
                    cm:add_building_to_settlement(intro_chain_skaven.owned_region, building)
                end
            end, 0.2)

            -- reenable character events
            cm:disable_event_feed_events(false, "wh_event_category_character", "", "")
            cm:disable_event_feed_events(false, "", "", "character_trait_lost")
            cm:disable_event_feed_events(false, "", "", "character_ancillary_lost")
            cm:disable_event_feed_events(false, "", "", "character_wounded")
            
            --- mission trigger
            cm:callback(function()
                --- needed to make sure Nagash has full AP after the Nagashizar buildings are built, which have +movement range
                local nag = bdsm:get_faction_leader()
                local nag_cqi = nag:command_queue_index()

                cm:replenish_action_points("character_cqi:"..nag_cqi)

                -- trigger the How To Play event
                cm:show_message_event(
                    faction_key,
                    "event_feed_strings_text_wh2_scripted_event_how_they_play_title",
                    "factions_screen_name_"..faction_key,
                    "event_feed_strings_text_nag_scripted_event_how_they_play_nagasha",
                    true,
                    594,
                    nil,
                    nil
                )

                cm:disable_event_feed_events(false, "wh_event_category_faction", "", "")
                cm:disable_event_feed_events(false, "wh_event_category_military", "", "")
                cm:disable_event_feed_events(false, "", "wh_event_subcategory_faction_missions_objectives", "")
                cm:disable_event_feed_events(false, "", "", "faction_event_mission_issued")

                cm:callback(function()
                    logf("Triggering mission targeting the new Skaven army!")
                    local mm = mission_manager:new(faction_key, "nagash_intro_1")
                    mm:set_mission_issuer("CLAN_ELDERS")
                    mm:add_new_objective("ENGAGE_FORCE")
                    mm:add_condition("cqi " .. skaven_mfcqi)
                    mm:add_condition("requires_victory")
                    mm:add_payload("effect_bundle{bundle_key nag_rite_nagash;turns 0;}");
                    mm:set_turn_limit(0);
                    
                    mm:set_should_whitelist(true)
                    mm:trigger()
                end, 0.1)
            
            end, 1.5)
        end, 0.1)

        -- TODO post-battle cutscene, do it prettily
        -- self:trigger_intro_battle()
    end
end

-- TODO MP?
function bdsm:trigger_intro_battle()
    CampaignUI.ToggleScreenCover(true)
    cm:callback(function()
        
        cm:set_saved_value("bdsm_intro_battle_completed", true)
        
        remove_battle_script_override()

        local intro_battle_xml =  "script/battle/intro_battles/skaven/first/battle.xml"

        cm:add_custom_battlefield(
            "intro_battle_1",												-- string identifier
            0,																-- x co-ord
            0,																-- y co-ord
            5000,															-- radius around position
            false,															-- will campaign be dumped
            "",																-- loading override
            "",																-- script override
            intro_battle_xml,                                   			-- entire battle override
            0,																-- human alliance when battle override
            true,															-- launch battle immediately
            true,															-- is land battle (only for launch battle immediately)
            true															-- force application of autoresolver result
        );
                
    end, 5)
end

function bdsm:post_intro_battle()
    -- CutsceneGoesHere
    -- Probably a scripted intervention about a mechanic or two
    -- How to Play triggers here too?

    -- prevent the post-battle cutscene and the like from being triggered 'gain
    cm:set_saved_value("bdsm_first_turn_completed", true)
end