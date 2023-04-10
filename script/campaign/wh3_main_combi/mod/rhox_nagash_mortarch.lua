local nagash_faction = "mixer_nag_nagash"


RHOX_NAGASH_UNLOCK_TECHS = {
    nag_mortarch_arkhan_unlock = {
        "nag_arkhan_battle_1",
        "nag_arkhan_battle_2",
        "nag_arkhan_battle_3",
        "nag_mortarch_arkhan_event_1",
        "nag_mortarch_arkhan_event_2",
        "nag_mortarch_arkhan_event_3",
        "nag_mortarch_arkhan_unlock",
        "nag_arkhan_proclamation",
        "nag_arkhan_archai"
    },
    nag_mortarch_luthor_unlock = {
        "nag_luthor_battle_1",
        "nag_luthor_battle_2",
        "nag_luthor_battle_3",
        "nag_mortarch_luthor_event_1",
        "nag_mortarch_luthor_event_2",
        "nag_mortarch_luthor_event_3",
        "nag_mortarch_luthor_unlock",
        "nag_luthor_proclamation",
        "nag_luthor_archai"
    },
    nag_mortarch_mannfred_unlock = {
        "nag_mannfred_battle_1",
        "nag_mannfred_battle_2",
        "nag_mannfred_battle_3",
        "nag_mortarch_mannfred_event_1",
        "nag_mortarch_mannfred_event_2",
        "nag_mortarch_mannfred_event_3",
        "nag_mortarch_mannfred_unlock",
        "nag_mannfred_proclamation",
        "nag_mannfred_archai"
    },
    nag_mortarch_krell_unlock = {
        "nag_krell_battle_1",
        "nag_krell_battle_2",
        "nag_krell_battle_3",
        "nag_mortarch_krell_event_1",
        "nag_mortarch_krell_event_2",
        "nag_mortarch_krell_event_3",
        "nag_mortarch_krell_unlock",
        "nag_krell_proclamation",
        "nag_krell_archai"
    },
    nag_mortarch_neferata_unlock = {
        "nag_neferata_battle_1",
        "nag_neferata_battle_2",
        "nag_neferata_battle_3",
        "nag_mortarch_neferata_event_1",
        "nag_mortarch_neferata_event_2",
        "nag_mortarch_neferata_event_3",
        "nag_mortarch_neferata_unlock",
        "nag_neferata_proclamation",
        "nag_neferata_archai"
    },
    nag_mortarch_vlad_unlock = {
        "nag_vlad_battle_1",
        "nag_vlad_battle_2",
        "nag_vlad_battle_3",
        "nag_mortarch_vlad_event_1",
        "nag_mortarch_vlad_event_2",
        "nag_mortarch_vlad_event_3",
        "nag_mortarch_vlad_unlock",
        "nag_vlad_proclamation",
        "nag_vlad_archai"
    },
    nag_mortarch_dieter_unlock = {
        "nag_dieter_battle_1",
        "nag_dieter_battle_2",
        "nag_dieter_battle_3",
        "nag_mortarch_dieter_event_1",
        "nag_mortarch_dieter_event_2",
        "nag_mortarch_dieter_event_3",
        "nag_mortarch_dieter_unlock",
        "nag_dieter_proclamation",
        "nag_dieter_archai"
    }
}


local mort_key_to_faction_key ={
    ["nag_mortarch_arkhan"]="wh2_dlc09_tmb_followers_of_nagash",
    ["nag_mortarch_vlad"]="wh_main_vmp_schwartzhafen",
    ["nag_mortarch_mannfred"]="wh_main_vmp_vampire_counts",
    ["nag_mortarch_luthor"]="wh2_dlc11_cst_vampire_coast",
    ["nag_mortarch_dieter"]="mixer_vmp_helsnicht",
    ["nag_mortarch_azhag"]="wh2_dlc15_grn_bonerattlaz"
}


local mort_key_to_name ={
    ["nag_mortarch_arkhan"]="nag_nagash_name_arkhan",
    ["nag_mortarch_vlad"]="nag_nagash_name_vlad",
    ["nag_mortarch_mannfred"]="nag_nagash_name_mannfred",
    ["nag_mortarch_luthor"]="nag_nagash_name_luthor",
    ["nag_mortarch_neferata"]="nag_nagash_name_neferata",
    ["nag_mortarch_krell"]="nag_nagash_name_krell",
    ["nag_mortarch_isabella"]="nag_nagash_name_isabella",
    ["nag_mortarch_dieter"]="nag_nagash_name_dieter",
    ["nag_mortarch_azhag"]="nag_nagash_name_azhag"
}

local mort_key_to_region ={
    ["nag_mortarch_arkhan"]="wh3_main_combi_region_quatar",
    ["nag_mortarch_vlad"]="wh3_main_combi_region_castle_drakenhof",
    ["nag_mortarch_mannfred"]="wh3_main_combi_region_castle_drakenhof",
    ["nag_mortarch_luthor"]="wh3_main_combi_region_the_awakening",
    ["nag_mortarch_neferata"]="wh3_main_combi_region_silver_pinnacle",
    ["nag_mortarch_krell"]="wh3_main_combi_region_morgheim",
    ["nag_mortarch_isabella"]="wh3_main_combi_region_castle_drakenhof",
    ["nag_mortarch_dieter"]="wh3_main_combi_region_aarnau",
    ["nag_mortarch_azhag"]="wh3_main_combi_region_nagashizzar"
}

local mort_key_to_units={
    ["nag_mortarch_arkhan"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_tmb_inf_nehekhara_warriors_0",
        "nag_vanilla_tmb_veh_skeleton_chariot_0",
        "nag_vanilla_tmb_mon_tomb_scorpion_0",
        "nag_nagashi_guard_halb",
        "nag_nagashi_guard_halb",
    },
    ["nag_mortarch_vlad"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_mon_dire_wolves",
        "nag_vanilla_vmp_mon_dire_wolves",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_vanilla_vmp_cav_black_knights_3",
        "nag_vanilla_vmp_mon_vargheists",
        "nag_vanilla_vmp_mon_vargheists",
        "nag_nagashi_guard_halb",
        "nag_vanilla_vmp_cav_blood_knights_0",
    },
    ["nag_mortarch_mannfred"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_cav_black_knights_0",
        "nag_vanilla_vmp_cav_black_knights_0",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_nagashi_guard",
    },
    ["nag_mortarch_luthor"]={
        "nag_vanilla_cst_mon_bloated_corpse_0",
        "nag_vanilla_cst_mon_bloated_corpse_0",
        "nag_vanilla_cst_art_carronade",
        "nag_vanilla_cst_inf_zombie_deckhands_mob_0",
        "nag_vanilla_cst_inf_zombie_deckhands_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_0",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_1",
        "nag_vanilla_cst_inf_zombie_gunnery_mob_1",
        "nag_nagashi_guard_halb",
        "nag_vanilla_cst_mon_necrofex_colossus_0",
    },
    ["nag_mortarch_neferata"]={
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_skeleton_warriors_0",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_tmb_inf_tomb_guard_0",
        "nag_vanilla_tmb_inf_tomb_guard_0",
        "nag_vanilla_vmp_mon_fell_bats",
        "nag_nagashi_guard_halb",
        "nag_nagashi_guard_halb",
    },
    ["nag_mortarch_krell"]= {                               
        "nag_vanilla_vmp_inf_skeleton_warriors_1",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_0",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_vanilla_vmp_inf_grave_guard_1",
        "nag_nagashi_guard",
    },
    ["nag_mortarch_isabella"]="",
    ["nag_mortarch_dieter"]= {                               
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_vanilla_vmp_mon_varghulf",
        "nag_vanilla_vmp_mon_vargheists",
        "nag_vanilla_vmp_mon_vargheists",
    },
    ["nag_mortarch_azhag"]={                               
        "nag_vanilla_vmp_inf_crypt_ghouls",
        "nag_vanilla_vmp_inf_crypt_ghouls",
    }
}

local raise_dead_sea_units={
    nag_vanilla_cst_inf_zombie_gunnery_mob_0= {2, 20, 2},
    nag_vanilla_cst_inf_zombie_gunnery_mob_1= {1, 20, 1},
    nag_vanilla_cst_inf_zombie_deckhands_mob_1= {0, 10, 1},
    nag_vanilla_cst_inf_zombie_deckhands_mob_0= {1, 50, 3},
    nag_vanilla_cst_mon_bloated_corpse_0= {1, 35, 3}
}


--pass the faction key(string)
function rhox_kill_faction(faction_key)
	--check the faction key is a string
	if not is_string(faction_key) then
		script_error("ERROR: kill_faction() called but supplied region key [" .. tostring(faction_key) .. "] is not a string");
		return false;
	end;
	
	local faction = cm:model():world():faction_by_key(faction_key); 
	
	if faction:is_null_interface() == false then
		cm:disable_event_feed_events(true, "wh_event_category_conquest", "", "")
		cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")
		
		cm:kill_all_armies_for_faction(faction);
		
		local region_list = faction:region_list();
		
		for j = 0, region_list:num_items() - 1 do
			local region = region_list:item_at(j):name();
			cm:set_region_abandoned(region);
		end;
		
		cm:callback(
			function() 
				cm:disable_event_feed_events(false, "wh_event_category_conquest", "", "");
				cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "");
			end,
			0.5
		);
	end;
end;






local function upgrade_into_mortarch(faction, faction_key, mort_key)
    out("Rhox Nagash Upgrading")
    local nagash_character = cm:get_faction(nagash_faction):faction_leader()
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(faction_key, "wh3_main_combi_region_nagashizzar", false, true, 5)
    
    local character = faction:faction_leader() --real leader before the change
    
    if faction:is_human() then
        force_declare_war(nagash_faction, faction_key, true, true) --declare war if mortarch was a player
        --TODO add incident for the player
        return --and do nothing
    end
    

    
    
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    faction_key,
    "",
    "wh3_main_combi_region_nagashizzar",
    new_x,
    new_y,
    "general",
    "nag_nagash_husk",
    "",
    "",
    "",
    "",
    true);     --dummy leader we're going to kill him after
    out("Spawned dummy leader!")
    local character_to_kill = faction:faction_leader() --fake leader to kill
    
    local old_char_details = {
        mf = character:military_force(),
        rank = character:rank(),
        fm_cqi = character:family_member():command_queue_index(),
        character_details = character:character_details(),
        faction_key = character:faction():name(),
        character_forename = character:get_forename(),
        character_surname = character:get_surname(),
        parent_force = character:embedded_in_military_force(),
        subtype = character:character_subtype_key(),
        traits = character:all_traits(),
        ap = character:action_points_remaining_percent()
    }
    --[[
    out("Rhox Nagash: old character details")
    for k, detail in pairs(old_char_details) do
        out(tostring(detail))
    end
    --]]

    
    local new_character

    --out("This leader does not have a military force. Maybe he is wounded")
    local region_key = mort_key_to_region[mort_key]
    local is_at_sea = false--nagash_character:is_at_sea()
    --out("Rhox Nagash: region key: "..region_key)
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, region_key, is_at_sea, true, 5)
    cm:create_force_with_general(
    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
    nagash_faction,
    table.concat(mort_key_to_units[mort_key], ","),
    region_key,
    new_x,
    new_y,
    "general",
    mort_key,
    "",
    "",
    "",
    "",
    false,
    function(cqi)
        new_character = cm:get_character_by_cqi(cqi)
    end); 
    out("Rhox Nagash character details: ")
    out(old_char_details.character_forename)
    out(old_char_details.character_surname)
    --new_character = cm:get_most_recently_created_character_of_type(nagash_faction):military_force()

    out("Created a new character")
    if new_character then
		CUS:update_new_character(old_char_details, new_character, 1)
	end
    out("Upgrading a new character")

    if cm:get_faction(nagash_faction):is_human() then
        rhox_kill_faction(faction_key) -- if nagash is a human, destroy the faction
    else
        cm:force_confederation(nagash_faction, faction_key) --make nagash siphon the mortarch if it's AI
        cm:suppress_immortality(character_to_kill:family_member():command_queue_index(), true)
        cm:kill_character(cm:char_lookup_str(character_to_kill), true)
        cm:remove_effect_bundle("wh_main_bundle_confederation_vmp", nagash_faction)
    end
    
    --
    --
    
    local forename = common.get_localised_string(mort_key_to_name[mort_key])
    cm:change_character_custom_name(new_character, forename, "","","")
    
    
        
end



local function spawn_mortarch(mort_key) --ones without a faction, or faction already has died
    local nagash_character = cm:get_faction(nagash_faction):faction_leader()
    local nagash_rank = nagash_character:rank()
    
    --local new_x, new_y = cm:find_valid_spawn_location_for_character_from_position(nagash_faction, x, y, 5) --spawn him near Nagash
    
    local new_character
    --out("Rhox Nagash: new character subtype: "..mort_key)
    --local region_key = nagash_character:region():name()
    local region_key = mort_key_to_region[mort_key]
    --local is_at_sea = nagash_character:is_at_sea()
    --out("Rhox Nagash: region key: "..region_key)
    local new_x, new_y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, region_key, false, true, 5)
    --out("New x: "..new_x)
    --out("New y: "..new_y)
    if mort_key == "nag_mortarch_isabella" then
        cm:spawn_agent_at_position(cm:get_faction(nagash_faction), new_x, new_y, "dignitary", mort_key)
        new_character = cm:get_most_recently_created_character_of_type(nagash_faction, "dignitary", mort_key)
    else
        cm:create_force_with_general(
        -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
        nagash_faction,
        table.concat(mort_key_to_units[mort_key], ","),
        region_key,
        new_x,
        new_y,
        "general",
        mort_key,
        "",
        "",
        "",
        "",
        false,
        function(cqi)
            new_character = cm:get_character_by_cqi(cqi)
        end);
    end
    
    
    --local new_character = cm:get_most_recently_created_character_of_type(nagash_faction)
    local forename = common.get_localised_string(mort_key_to_name[mort_key])
    cm:change_character_custom_name(new_character, forename, "","","")
    cm:add_agent_experience(cm:char_lookup_str(new_character:command_queue_index()), math.floor(nagash_rank), true)


            
end

                           
                           
                           
function mortarch_unlock_listeners()
    core:add_listener(
    --- When an "unlock" tech is researched, spawn the related Morty.
        "MortarchUnlock",
        "ResearchCompleted",
        function(context)
            return RHOX_NAGASH_UNLOCK_TECHS[context:technology()]
        end,
        function(context)
            out("Rhox Nagash: Hey, you unlocked a Mortarch technology!")
            
            local tech_key = context:technology()
            
            --- format "nag_mortarch_arkhan_unlock" to "nag_mortarch_arkhan"
            local mort_key = string.gsub(tech_key, "_unlock", "")
            
            local mort_clean_key = string.gsub(mort_key, "nag_mortarch", "nag")
            out("Mort key: "..mort_key)
            local nagash_interface = cm:get_faction(nagash_faction)

            
            
            local faction_key = mort_key_to_faction_key[mort_key]
            if faction_key ~= nil then --do something more if that Mortarch has faction
                out("faction key: "..faction_key)
                local faction = cm:get_faction(faction_key)
                if not faction:is_dead() then
                    upgrade_into_mortarch(faction, faction_key, mort_key)
                else
                    spawn_mortarch(mort_key)--just spawn one as the faction is already dead. Not going to get anything from the leader since recruit defeated lords might be affecting them
                end
            else
                spawn_mortarch(mort_key)--just spawn one as this one does not have a faction
            end
            
            --spawn_mortarch(mort_key)--scrap the upgrade idea
            if mort_key == "nag_mortarch_vlad" and (cm:get_faction("wh_main_vmp_schwartzhafen"):is_human()==false or cm:get_faction("wh_main_vmp_schwartzhafen"):is_dead()) then --the faction has to be non-human or dead to summon the Isabella
                spawn_mortarch("nag_mortarch_isabella")--spawn isabella also if it's Vlad
            end
            
            if mort_key == "nag_mortarch_luthor" then --add cst units to the raise dead pool
                local region_list = cm:model():world():region_manager():region_list()
                for i=0,region_list:num_items()-1 do
                    local region= region_list:item_at(i)
                    for key, unit in pairs(raise_dead_sea_units) do
                        cm:add_unit_to_province_mercenary_pool(region, key, "raise_dead", unit[1], unit[2], unit[3], 1, "", "mixer_nag_nagash", "", false, "wh_main_vmp_province_pool")
                    end
                end
            end
            
            
                
        end,
        true
    )
    
    core:add_listener(
        "NagashMortunlockMissions",
        "MissionSucceeded",
        function(context)
            local mission = context:mission()
            return RHOX_NAGASH_UNLOCK_TECHS[mission:mission_record_key()] --mission and unlock has the same name
        end,
        function(context)
            out("Rhox Nagash: You finished the mission!")
            local mission = context:mission()
            local unlock_tech_table = RHOX_NAGASH_UNLOCK_TECHS[mission:mission_record_key()]
            for i, technology in pairs(unlock_tech_table) do
                out("Rhox Nagash Current technology: "..technology)
                cm:unlock_technology(nagash_faction, technology)
            end
        end,
        true
    )
    
    
    core:add_listener(
        "rhox_azhag_mission_success",
        "MissionSucceeded",
        function(context)
            local mission = context:mission()
            return mission:mission_record_key() == "rhox_nagash_get_azhag_mission"
        end,
        function(context)
            out("Rhox Nagash: You finished the Azhag mission!")
            local mort_key = "nag_mortarch_azhag"
            
            
            
            local faction_key = mort_key_to_faction_key[mort_key]
            local faction = cm:get_faction(faction_key)
            if not faction:is_dead() then
                --fire incident
                cm:trigger_incident_with_targets(cm:get_faction(nagash_faction):command_queue_index(), "rhox_nagash_azhag_mortarch", 0,0,
                faction:faction_leader():cqi(), 0,0,0)
                upgrade_into_mortarch(faction, faction_key, mort_key)
            end
        end,
        true
    )
end


function trigger_mortarch_unlock_missions()
    local key = nagash_faction
    local faction_handler = cm:get_faction(key)
    if faction_handler:is_human() then
        out("Rhox Nagash triggering mort unlock missions")

        -- Luthor's mission (go to Vampire Coast)   
        out("pre luthor")
        do
            local mort = "nag_mortarch_luthor"
            cm:trigger_mission(key, mort.."_unlock", true, false, true)
        end
        
        
        
        
        



        out("pre krell")
        --- Krell's mission
        do
            local mort = "nag_mortarch_krell"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("KILL_X_ENTITIES")
            mm:add_condition("total 15000")
            mm:add_payload("money 1000")
            mm:add_payload("text_display nag_mortarch_krell_technology");
            mm:trigger()
        end
        
        out("pre vlad")
        -- Vlad's mission (spend time Channeling near Altdorf)
        do
            local mort = "nag_mortarch_vlad"
            cm:trigger_mission(key, mort.."_unlock", true, false, true)
        end
        
        out("pre manny")
        do 
            local mort = "nag_mortarch_mannfred"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("OWN_N_REGIONS_INCLUDING");
            mm:add_condition("region " .. "wh3_main_combi_region_castle_drakenhof");
            mm:add_condition("total 1");
            mm:add_payload("text_display nag_mortarch_mannfred_technology");
            mm:add_payload("money 1000")

            mm:trigger()
        end
        
        out("pre neffy")
        --- Neffy's mission
        do
            local mort = "nag_mortarch_neferata"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("CONSTRUCT_N_BUILDINGS_INCLUDING");
            mm:add_condition("faction " .. key);
            mm:add_condition("building_level nag_outpost_special_nagashizzar_3");
            mm:add_condition("total 1");
            mm:add_payload("text_display nag_mortarch_neferata_technology");
            mm:add_payload("money 1000")
            mm:trigger()
        end
        
        
        --dieter missions. Only if Mixu lords exist
        if vfs.exists("script/frontend/mod/mixu_frontend_le_darkhand.lua")then --mixer lords exist
            local mort = "nag_mortarch_dieter"
            
            local mm = mission_manager:new(key, mort.."_unlock")
            mm:add_new_objective("DEFEAT_N_ARMIES_OF_FACTION");
            mm:add_condition("subculture wh_dlc08_sc_nor_norsca");
            mm:add_condition("total 1");
            mm:add_payload("text_display nag_mortarch_dieter_technology");
            mm:add_payload("money 1000")
            mm:trigger()
        end
        
        
    else
    end
end
