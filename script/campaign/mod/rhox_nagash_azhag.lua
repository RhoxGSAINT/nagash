local azhag_faction_key = "wh2_dlc15_grn_bonerattlaz"
local azhag_subtype = "wh_main_grn_azhag_the_slaughterer"
local nagash_faction_key = "wh3_dlc29_nag_host_of_nagash"
local mortarch_azhag_subtype = "nag_mortarch_azhag"

-- same as the old rhox_kill_faction: kill every army and abandon every region
local function rhox_nagash_kill_azhag_faction()
    local faction = cm:get_faction(azhag_faction_key)
    if not faction or faction:is_dead() then
        return
    end
    cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "")
    cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")

    cm:kill_all_armies_for_faction(faction)
    local region_list = faction:region_list()
    for i = 0, region_list:num_items() - 1 do
        cm:set_region_abandoned(region_list:item_at(i):name())
    end

    cm:callback(function()
        cm:disable_event_feed_events(false, "wh_event_category_conquest", "", "")
        cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "")
    end, 0.5)
end

local function rhox_nagash_summon_azhag()
    local azhag_faction = cm:get_faction(azhag_faction_key)
    local nagash_faction = cm:get_faction(nagash_faction_key)
    if not nagash_faction then
        return
    end

    -- read Azhag
    local azhag = nil
    if azhag_faction then
        local character_list = azhag_faction:character_list()
        for i = 0, character_list:num_items() - 1 do
            local character = character_list:item_at(i)
            if character:character_subtype(azhag_subtype) then
                azhag = character
                break
            end
        end
    end
    local rank, traits = 1, {}
    if azhag then
        rank = azhag:rank()
        traits = azhag:all_traits()
    end

    -- same as the vanilla mortarchs: next to Nagash, otherwise at the capital. The name comes from unique_agents
    local cqi = nil
    local nagash = nagash_faction:faction_leader()
    if is_character(nagash) and nagash:is_wounded() == false then
        cqi = cm:spawn_unique_agent_at_character(nagash_faction:command_queue_index(), mortarch_azhag_subtype, nagash:cqi(), true)
    elseif is_region(nagash_faction:home_region()) then
        cqi = cm:spawn_unique_agent_at_region(nagash_faction:command_queue_index(), mortarch_azhag_subtype, nagash_faction:home_region():cqi(), true)
    end
    if not is_number(cqi) then
        out("Rhox Nagash: Couldn't spawn Azhag")
        return
    end
    local new_lookup = cm:char_lookup_str(cqi)

    rhox_nagash_kill_azhag_faction()

    -- give the new Azhag a moment before touching xp and traits
    cm:callback(function()
        if not is_character(cm:get_character_by_cqi(cqi)) then
            return
        end
        local xp = cm.character_xp_per_level[math.min(rank, #cm.character_xp_per_level)] or 0
        cm:add_agent_experience(new_lookup, xp, false)
        for i = 1, #traits do
            cm:force_add_trait(new_lookup, traits[i])
        end
    end, 0.5)
end

local function rhox_check_azhag_status()
    local faction =cm:get_faction("wh2_dlc15_grn_bonerattlaz")
    if not faction then
        return
    end
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



cm:add_first_tick_callback(
	function()
        core:add_listener(
            "rhox_nagash_crown_check",
            "CharacterRankUp",
            function(context)
                local character = context:character()
                local faction = character:faction()
                return character:character_subtype("wh3_dlc29_nag_nagash") and character:rank() >= 20 and cm:get_saved_value("rhox_nagash_azhag_mission_active") ~= true
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
                    
                    mm:add_payload("money 10000");
                    mm:trigger()
                end
                cm:set_saved_value("rhox_nagash_azhag_mission_active", true) --regardless whether you get the mission or not, we don't need to trgigger this again.
            end,
            false
        ) 

        core:add_listener(
            "rhox_azhag_mission_success",
            "MissionSucceeded",
            function(context)
                local mission = context:mission()
                return mission:mission_record_key() == "rhox_nagash_get_azhag_mission" and cm:get_saved_value("rhox_nagash_mortarch_azhag_check") ~= true --don't call it if player already saw the garrison event
            end,
            function(context)
                out("Rhox Nagash: You finished the Azhag mission!")           
                
                local faction_key = "wh2_dlc15_grn_bonerattlaz"
                local faction = cm:get_faction(faction_key)
                if faction and not faction:is_dead() then
                    --fire incident
                    cm:trigger_incident_with_targets(cm:get_faction("wh3_dlc29_nag_host_of_nagash"):command_queue_index(), "rhox_nagash_azhag_mortarch", 0,0,
                    faction:faction_leader():cqi(), 0,0,0)
                    --summon Azhag
                    rhox_nagash_summon_azhag()
                    cm:set_saved_value("rhox_nagash_mortarch_azhag_check", true)--for failsafe mission thing
                end
            end,
            true
        )

        core:add_listener(
            "rhox_nagash_enter_garrison",
            "CharacterEntersGarrison",
            function(context)
                local character = context:character()    
                local region_object = context:garrison_residence():region()
                local region_name = region_object:name()
                return character:character_subtype_key() == "wh3_dlc29_nag_nagash" and character:rank() >= 40 and region_name == "wh3_main_combi_region_khazid_irkulaz" and cm:get_saved_value("rhox_nagash_mortarch_azhag_check") ~= true and character:faction():is_human()
            end,
            function(context)
                local character = context:character()
                cm:callback( --above mission complete and this enter can happen in the same time
                    function()
                        if cm:get_saved_value("rhox_nagash_mortarch_azhag_check") == true then
                            return --above mission complete and this enter can happen in the same time
                        end
                        cm:set_saved_value("rhox_nagash_mortarch_azhag_check", true)--set it true regardless of result
                        local dilemma_builder = cm:create_dilemma_builder("rhox_nagash_azhag_recruit");
                        local payload_builder = cm:create_payload();
                        
                
                        payload_builder:text_display("nag_azhag_will_join")
                        payload_builder:treasury_adjustment(-50000);
                        dilemma_builder:add_choice_payload("FIRST", payload_builder);
                        payload_builder:clear();
                        
                        dilemma_builder:add_choice_payload("SECOND", payload_builder);
                        
                        dilemma_builder:add_target("default", character:family_member());
                        
                        
                        
                        cm:launch_custom_dilemma_from_builder(dilemma_builder, character:faction());
                    end,
                    1
                )
            end,
            true
        )
        core:add_listener(
            "rhox_nagash_azhag_DilemmaChoiceMadeEvent", 
            "DilemmaChoiceMadeEvent",
            function(context)
                return context:dilemma() == "rhox_nagash_azhag_recruit"
            end,
            function(context)
                local choice = context:choice();

                
                if choice == 0 then
                    --summon Azhag
                    rhox_nagash_summon_azhag()
                end
            end,
            false
        )
	end
)







