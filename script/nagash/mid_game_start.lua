-- mid game start file
-- used for dev testing (during our internal beta) and potentially for an optional start campaign mode for release that begins with Nagash at relatively full strength

local bdsm = get_bdsm()

-- set Black Pyramid to ruined, give Nagash the BP horde, spawn Nagash and Arkhan to the faction
function bdsm:mid_game_start()
    local sentinels_key = "wh2_dlc09_tmb_the_sentinels"
    local bp_key = "wh2_main_great_mortis_delta_black_pyramid_of_nagash"

    -- kill the Sentinels completely
    local sentinels = cm:get_faction(sentinels_key)
    do
        local char_list = sentinels:character_list()
        for i = 0, char_list:num_items() -1  do
            local char = char_list:item_at(i)
            local cqi = char:command_queue_index()

            cm:kill_character_and_commanded_unit("character_cqi:"..cqi, true, false)
        end
    end

    -- ruin the BP and set it as untargetable -- TODO figure out if that fucks any other mods or functionalities
    cm:set_region_abandoned(bp_key)
    cm:cai_disable_targeting_against_settlement("settlement:"..bp_key)

    cm:force_religion_factors(bp_key, "wh_main_religion_undeath", 1)

    local faction_key = bdsm:get_faction_key()
    local faction_obj = cm:get_faction(faction_key)
    local faction_leader = faction_obj:faction_leader()
    local cqi = faction_leader:command_queue_index()

    -- spawn the bone daddy
    local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
        faction_key,
        bp_key,
        false,
        true,
        5
    )

    bdsm:log("getting coords:")
    bdsm:log(x)
    bdsm:log(y)

    cm:create_force_with_general(
        faction_key,
        "wh_main_vmp_inf_zombie",
        bp_key,
        x,
        y,
        "general",
        "nag_nagash_boss",
        "names_name_1937224328",
        "",
        "",
        "",
        true,
        nil
    )

    cm:callback(function()
    -- kill the Mixer-spawned lord
        cm:kill_character_and_commanded_unit("character_cqi:"..cqi, true, false)

        -- local nagash = faction_obj:faction_leader()
        -- local cqi = nagash:command_queue_index()
        -- bdsm:log("Nagash cqi is: "..nagash:command_queue_index())

        -- local mf = nagash:military_force()

        -- bdsm:log("converting")
        -- cm:convert_force_to_type(mf, "black_pyramid")
        -- bdsm:log("converted")
    end, 0.5)

    -- TODO spawn in Arkhan
end