local function rhox_check_azhag_status()
    local faction =cm:get_faction("wh2_dlc15_grn_bonerattlaz")
    if faction:is_dead() then --if faction is dead, you can't trigger mission
        return false
    end
    
    local faction_leader = faction:faction_leader()
    if faction_leader:has_military_force() == false then
        return false
    end
    
    if cm:get_saved_value("rhox_nagash_mortarch_azhag_check") == true then
        return false
    end
    return true
end


core:add_listener(
    "rhox_nagash_crown_check",
    "CharacterRankUp",
    function(context)
        local character = context:character()
        local faction = character:faction()
        return character:character_subtype("nag_nagash_boss") and character:rank() >= 20 and faction:ancillary_exists("nag_anc_enchanted_item_crown_of_nagash") == false and cm:get_saved_value("rhox_nagash_azhag_mission_active") ~= true
    end,
    function(context)
        out("Rhox Nagash: In the listener")
        local character = context:character()
        local faction = character:faction()
        if rhox_check_azhag_status() ==true and faction:is_human() then--check Azhag's status and trigger the mission + only human is able to get the mission
            local faction_key = faction:name()
            local mission_key = "rhox_nagash_get_azhag_mission"
            local mm = mission_manager:new(faction_key, mission_key)
            mm:set_mission_issuer("CLAN_ELDERS")
            
            mm:add_new_objective("ENGAGE_FORCE")
            mm:add_condition("cqi "..cm:get_faction("wh2_dlc15_grn_bonerattlaz"):faction_leader():military_force():command_queue_index())
            mm:add_condition("requires_victory")
            
            mm:add_payload("add_ancillary_to_faction_pool{ancillary_key nag_anc_enchanted_item_crown_of_nagash;}");
            mm:trigger()

        else
            cm:force_add_ancillary(context:character(), "nag_anc_enchanted_item_crown_of_nagash", true, false)
        end
        cm:set_saved_value("rhox_nagash_azhag_mission_active", true) --regardless whether you get the mission or not, we don't need to trgigger this again.
    end,
    false
) 


core:add_listener(
    "rhox_nagash_azhag_mission_failsafe",
    "MissionCancelled",
    function(context)
        return context:mission():mission_record_key() == "rhox_nagash_get_azhag_mission"
    end,
    function(context)
        cm:add_ancillary_to_faction(cm:get_faction("mixer_nag_nagash"), "nag_anc_enchanted_item_crown_of_nagash", false)
    end,
    false
);


core:add_listener(
    "rhox_nagash_azhag_mission_failsafe2",
    "MissionFailed",
    function(context)
        return context:mission():mission_record_key() == "rhox_nagash_get_azhag_mission"
    end,
    function(context)
        cm:add_ancillary_to_faction(cm:get_faction("mixer_nag_nagash"), "nag_anc_enchanted_item_crown_of_nagash", false)
    end,
    false
);



-------------------AI Nagash Ascend

local units = {
    "nag_vanilla_vmp_inf_skeleton_warriors_0",
    "nag_vanilla_vmp_inf_skeleton_warriors_0",
    "nag_vanilla_tmb_cav_nehekhara_horsemen_0",
    "nag_carrion_riders",
    "nag_nagashi_guard",
    "nag_nagashi_guard",
    "nag_nagashi_guard",
    "nag_nagashi_guard",
    "nag_nagashi_guard_halb",
    "nag_nagashi_guard_halb",
    "nag_nagashi_guard_halb",
    "nag_nagashi_guard_halb",
    "nag_morghasts",
    "nag_morghasts",
}
    
    
core:add_listener(
    "rhox_nagash_ai_nagash",
    "CharacterRankUp",
    function(context)
        local character = context:character()
        local faction = character:faction()
        return character:character_subtype("nag_nagash_husk") and character:rank() >= 20 and faction:is_human() ==false
    end,
    function(context)
        local character = context:character()
        local faction = character:faction()
        local faction_leader_cqi= character:command_queue_index()

        local old_char_details={
            mf = character:military_force(),
            rank = character:rank(),
            traits = character:all_traits()
        }

        local x,y

        if old_char_details.mf then
            x, y = cm:find_valid_spawn_location_for_character_from_character(faction:name(), cm:char_lookup_str(faction_leader_cqi), true, 5)
        else
            x, y = cm:find_valid_spawn_location_for_character_from_settlement(faction:name(), "wh3_main_combi_region_nagashizzar", false, true, 5)
        end
            
        if x== -1 or y== -1 then
            out("Rhox Nagash failed to find the summonable position, stopping the ascending")
            return
        end

        local nagash_character
        cm:create_force_with_general(
        -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
        faction:name(),
        table.concat(units, ","),
        "wh3_main_combi_region_nagashizzar",
        x,
        y,
        "general",
        "nag_nagash_boss",
        "names_name_1937224328",
        "",
        "",
        "",
        true,
        function(cqi)
            nagash_character = cm:get_character_by_cqi(cqi)
            cm:callback(
                function()
                    local forename = common:get_localised_string("names_name_1937224328")
                    cm:change_character_custom_name(nagash_character, forename, "","","") --damn it's not working on faction leaders
                end,
                0.5
            )
        end);

            
        local new_char_lookup = cm:char_lookup_str(nagash_character)
        local traits_to_copy = old_char_details.traits
        if traits_to_copy then
            for i =1, #traits_to_copy do
                
                local trait_to_copy = traits_to_copy[i]
                cm:force_add_trait(new_char_lookup, trait_to_copy)
            end
        end
        cm:add_agent_experience(new_char_lookup,old_char_details.rank, true)
        
        cm:callback(
            function()
                cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), false);  
                cm:kill_character_and_commanded_unit(cm:char_lookup_str(faction_leader_cqi), true)
            end,
            2
        )
        
        --cm:kill_character(cm:char_lookup_str(character))
        



    end,
    true --might fail in summoning
)
