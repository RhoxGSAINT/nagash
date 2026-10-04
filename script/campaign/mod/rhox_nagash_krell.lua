local krell_hero_subtype = "wh3_dlc29_vmp_krell"

local function rhox_nagash_get_krell_hero(faction)
    local character_list = faction:character_list()
    for i = 0, character_list:num_items() - 1 do
        local character = character_list:item_at(i)
        if character:character_subtype(krell_hero_subtype) then
            return character
        end
    end
    return false
end

local function rhox_nagash_convert_krell_to_lord(faction)
    local krell = rhox_nagash_get_krell_hero(faction)
    if not krell then
        --out("Rhox Nagash Krell: Couldn't find hero Krell")
        return
    end

    local faction_key = faction:name()
    local krell_lookup = cm:char_lookup_str(krell)
    local krell_fm_cqi = krell:family_member():command_queue_index()
    local krell_details = krell:character_details()
    local traits = krell:all_traits()
    local rank = krell:rank()

    -- next to Krell, otherwise next to the capital
    local region = krell:region()
    if not is_region(region) then
        region = faction:home_region()
    end
    if not is_region(region) then
        --out("Rhox Nagash Krell: No region to spawn the lord")
        return
    end
    local x, y = cm:find_valid_spawn_location_for_character_from_character(faction_key, krell_lookup, true, 5)
    if x == -1 then
        x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction_key, faction:home_region():name(), false, true, 10)
    end
    if x == -1 then
        --out("Rhox Nagash Krell: No valid position for the lord")
        return
    end

    cm:create_force_with_general(
        faction_key,
        "",
        region:name(),
        x,
        y,
        "general",
        "nag_mortarch_krell",
        "names_name_1937224333",
        "",
        "names_name_978618377",
        "",
        false,
        function(cqi)
            local new_lookup = cm:char_lookup_str(cqi)

            cm:set_character_unique(new_lookup, true)

            -- give the new lord a moment to be fully set up before touching xp, traits and items
            cm:callback(
                function()
                    local new_character = cm:get_character_by_cqi(cqi)
                    if not is_character(new_character) then
                        --out("Rhox Nagash Krell: Couldn't find the new lord")
                        return
                    end

                    -- same as the vanilla character upgrading: moves every equipped item. Old Krell has to be alive for this
                    cm:reassign_ancillaries_to_character_of_same_faction(krell_details, new_character:character_details())

                    -- total xp of the old rank, not level ups on top of rank 1
                    local xp = cm.character_xp_per_level[math.min(rank, #cm.character_xp_per_level)] or 0
                    --out("Rhox Nagash Krell: Old rank ".. rank .. ", giving xp ".. xp)
                    cm:add_agent_experience(new_lookup, xp, false)

                    for i = 1, #traits do
                        cm:force_add_trait(new_lookup, traits[i])
                    end
                    cm:force_add_trait(new_lookup, "rhox_nagash_krell_hero_carryover_trait")

                    -- remove the hero silently, after the items are moved
                    cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
                    cm:suppress_immortality(krell_fm_cqi, true)
                    cm:kill_character(krell_lookup, false, true)
                    cm:callback(function() cm:disable_event_feed_events(false, "", "", "wh_event_category_character") end, 0.2);

                    --out("Rhox Nagash Krell: Krell is now a lord, new rank ".. new_character:rank())
                end,
                0.5
            )
        end
    )
end


core:add_listener(
    "rhox_nagash_krell_check",
    "CharacterTurnStart",
    function(context)
        local character = context:character()
        local faction = character:faction()
        return character:character_subtype_key() == krell_hero_subtype and character:faction():name() == "wh3_dlc29_nag_host_of_nagash" and cm:get_saved_value("rhox_nagash_krell_dilemma_triggered") ~= true and faction:is_human()
    end,
    function(context)
        cm:set_saved_value("rhox_nagash_krell_dilemma_triggered", true)
        local character = context:character()
        local faction = character:faction()
        local dilemma_builder = cm:create_dilemma_builder("rhox_nagash_krell_lord_dilemma");
        local payload_builder = cm:create_payload();
        dilemma_builder:add_choice_payload("FIRST", payload_builder);
        dilemma_builder:add_choice_payload("SECOND", payload_builder);
        dilemma_builder:add_target("default", character:family_member());
        
        cm:launch_custom_dilemma_from_builder(dilemma_builder, faction);
    end,
    false
)

core:add_listener(
    "rhox_nagash_krell_lord_DilemmaChoiceMadeEvent",
    "DilemmaChoiceMadeEvent",
    function(context)
        local choice = context:choice();
        return context:dilemma() == "rhox_nagash_krell_lord_dilemma" and choice == 1
    end,
    function(context)
        rhox_nagash_convert_krell_to_lord(context:faction())
    end,
    false
)
