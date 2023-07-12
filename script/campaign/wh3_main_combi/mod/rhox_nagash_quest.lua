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
