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
    local faction_key = self._faction_key
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
            local nagash = faction_obj:faction_leader()

            cm:kill_character_and_commanded_unit("character_cqi:"..nagash:command_queue_index(), true, false)
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

        --- TODO extra buildings for Himselfizar
        --- TODO change corruption (add Skaven corruption at 10-15%, vamp at the rest?)

        cm:callback(function()
            -- upgrade Himselfizar to level 1
            local s = cm:get_region(nagashizar_key):settlement()
            cm:instantly_set_settlement_primary_slot_level(s, 1)
            
            cm:callback(function()
                for i,building in ipairs(settle_buildings) do
                    --- TODO does this work?
                    cm:add_building_to_settlement(nagashizar_key, building)
                end
            end, 0.2)

            -- reenable character events
            cm:disable_event_feed_events(false, "wh_event_category_character", "", "")
            cm:disable_event_feed_events(false, "", "", "character_trait_lost")
            cm:disable_event_feed_events(false, "", "", "character_ancillary_lost")
            cm:disable_event_feed_events(false, "", "", "character_wounded")
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