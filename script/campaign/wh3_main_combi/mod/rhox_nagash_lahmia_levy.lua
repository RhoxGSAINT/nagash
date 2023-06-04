

local culture_to_unit={
    wh2_main_def_dark_elves={"rhox_nagash_lahmia_def_inf_shades_2", "rhox_nagash_lahmia_def_cav_cold_one_knights_1"},
    wh2_main_hef_high_elves={"rhox_nagash_lahmia_hef_inf_swordmasters_of_hoeth_0", "rhox_nagash_lahmia_hef_inf_white_lions_of_chrace_0"},
    wh3_dlc23_chd_chaos_dwarfs={"rhox_nagash_lahmia_chd_inf_chaos_dwarf_blunderbusses", "rhox_nagash_lahmia_chd_veh_dreadquake_mortar"},
    wh3_main_cth_cathay ={"rhox_nagash_lahmia_cth_inf_dragon_guard_0", "rhox_nagash_lahmia_cth_inf_dragon_guard_crossbowmen_0"},
    wh3_main_ksl_kislev ={"rhox_nagash_lahmia_ksl_veh_heavy_war_sled_0", "rhox_nagash_lahmia_ksl_cav_war_bear_riders_1"},
    wh3_main_ogr_ogre_kingdoms ={"rhox_nagash_lahmia_ogr_inf_ironguts_0", "rhox_nagash_lahmia_ogr_cav_crushers_0"},
    wh_dlc05_wef_wood_elves ={"rhox_nagash_lahmia_wef_inf_waywatchers_0", "rhox_nagash_lahmia_wef_inf_wardancers_0"},
    wh_dlc08_nor_norsca={"rhox_nagash_lahmia_nor_mon_war_mammoth_1","rhox_nagash_lahmia_nor_inf_marauder_berserkers_0"},
    wh_main_brt_bretonnia={"rhox_nagash_lahmia_brt_cav_questing_knights_0","rhox_nagash_lahmia_brt_cav_knights_of_the_realm"},
    wh_main_dwf_dwarfs={"rhox_nagash_lahmia_dwf_inf_dwarf_warrior_0","rhox_nagash_lahmia_dwf_art_flame_cannon"},
    wh_main_emp_empire={"rhox_nagash_lahmia_emp_art_helstorm_rocket_battery","rhox_nagash_lahmia_emp_art_helblaster_volley_gun"},
    mixer_teb_southern_realms={"rhox_nagash_lahmia_emp_art_helstorm_rocket_battery","rhox_nagash_lahmia_emp_art_helblaster_volley_gun"},
    ovn_albion={"rhox_nagash_lahmia_emp_art_helstorm_rocket_battery","rhox_nagash_lahmia_emp_art_helblaster_volley_gun"},
    ovn_araby={"rhox_nagash_lahmia_emp_art_helstorm_rocket_battery","rhox_nagash_lahmia_emp_art_helblaster_volley_gun"},
}

local vassal_levy_chance = 5;--it's percent
local neferata_chance_per_card = 0.5;

local dilemma_cooldown = 20;
local dilemma_table ={}

local target_faction =nil

core:add_listener(
    "rhox_nagash_lahmia_vassal_turn_start",
    "FactionTurnStart",
    function(context)
        local faction = context:faction()
        local lahmia_faction = cm:get_faction("wh3_main_vmp_lahmian_sisterhood")
        if not lahmia_faction then
            return false
        end
        return faction:is_vassal_of(lahmia_faction)
    end,
    function(context)
        local faction = context:faction()
        
        local faction_key = faction:name()
        local lahmia_faction = cm:get_faction("wh3_main_vmp_lahmian_sisterhood")
        local culture = faction:culture()
        local unit_list = culture_to_unit[culture]
        if not unit_list then
            out("Rhox Nagash Lahmia: This faction's culture " .. culture .. " does not have unit list")
            return
        end
        
        
        ------------------dilemma trigger
        if not dilemma_table[faction_key] then
            dilemma_table[faction_key] = dilemma_cooldown
        end
        dilemma_table[faction_key] = dilemma_table[faction_key]-1
        
        if dilemma_table[faction_key] == 0 then 
            if lahmia_faction:is_human() == false then --just give them units
                for i=1,#unit_list do
                    cm:add_units_to_faction_mercenary_pool(lahmia_faction:command_queue_index(), unit_key[i], 1)
                end
                dilemma_table[faction_key] = dilemma_cooldown
            elseif target_faction then
                dilemma_table[faction_key] = 1; --there was already queued dilemma, postpone it to the next turn
            else
                
                target_faction = faction; --apply it to the global value
                out("Rhox Nagash Lahmia: Triggering confederation dilemma")
                --trigger dilemma
                --Trigger dilemma to be handled by above function
                local dilemma_builder = cm:create_dilemma_builder("rhox_nagash_lahmia_confederate_generic");
                local payload_builder = cm:create_payload();
                
                
                
                payload_builder:text_display("rhox_nagash_lahmia_confederation")
                dilemma_builder:add_choice_payload("FIRST", payload_builder);
                payload_builder:clear();
                
                for i=1,#unit_list do
                    --out("Rhox Nagash Lahmia: Unit Key: ".. unit_list[i])
                    payload_builder:add_mercenary_to_faction_pool(unit_list[i], 1)  
                end
                payload_builder:text_display("rhox_nagash_lahmia_20turns")
                dilemma_builder:add_choice_payload("SECOND", payload_builder);
                
                --dilemma_builder:add_target("default", lahmia_faction);
                dilemma_builder:add_target("default", faction);
                dilemma_builder:add_target("target_faction_1", faction);
                --dilemma_builder:add_target("target_military_1", character:military_force());
                
                
                cm:launch_custom_dilemma_from_builder(dilemma_builder, lahmia_faction);
            end
        end
        
        ---------------------------------------------unit adding
        local chance = vassal_levy_chance
        
        if faction:bonus_values():scripted_value("rhox_nagash_lahmia_levy_chance", "value") > 0 then
            chance= chance+faction:bonus_values():scripted_value("rhox_nagash_lahmia_levy_chance", "value")
        end
        if not cm:model():random_percent(chance) then
            return
        end
        
        local unit_key = unit_list[cm:random_number(#unit_list)]
        local incident_builder = cm:create_incident_builder("rhox_nagash_lahmia_levy_provided")
        --incident_builder:add_target(lahmia_faction)
        incident_builder:add_target("default", faction)
        local payload_builder = cm:create_payload()
        payload_builder:add_mercenary_to_faction_pool(unit_key, 1)  
        
        incident_builder:set_payload(payload_builder)
        cm:launch_custom_incident_from_builder(incident_builder, lahmia_faction)
    end,
    true
)

core:add_listener(
    "rhox_nagash_lahmia_confederation_DilemmaChoiceMadeEvent", 
    "DilemmaChoiceMadeEvent",
    function(context)
        return context:dilemma() == "rhox_nagash_lahmia_confederate_generic"
    end,
    function(context)
        local choice = context:choice();

        local faction = target_faction;
        if not target_faction then
            out("Rhox Nagash Lahmia: There is nothing in the target faction global value")
            return
        end
        target_faction = nil --now reset the value
        local faction_key = faction:name()
        if choice == 0 then    
            out("Rhox Nagash Lahmia: Starting integration")
            cm:kill_all_armies_for_faction(faction);
            
            local loop_char_list = faction:character_list()
            for i = 0, loop_char_list:num_items() - 1 do
                local looping = loop_char_list:item_at(i)
                cm:force_add_trait(cm:char_lookup_str(looping), "rhox_nagash_lahmia_kissed_by_neferata")
            end
            
            --kill all the armies and integrate them
            cm:force_confederation("wh3_main_vmp_lahmian_sisterhood", faction_key)
        elseif choice == 1 then
            dilemma_table[faction_key] = dilemma_cooldown
        end
    end,
    true
)


core:add_listener(
    "rhox_nagash_lahmia_battle_completed",
    "CharacterCompletedBattle",
    function(context)
        local character = context:character()
        local pb = context:pending_battle();

        return character:character_subtype_key() == "nag_lahmia_neferata" and pb:has_been_fought() and character:won_battle()
    end,
    function(context)
        local character = context:character()        
        local pb = cm:model():pending_battle()
        local was_attacker = false
        local card_num = 0;
        local rewards ={}

        local num_attackers = cm:pending_battle_cache_num_attackers()
        local num_defenders = cm:pending_battle_cache_num_defenders()
        

        if pb:night_battle() == true or pb:ambush_battle() == true then
            num_attackers = 1
            num_defenders = 1
        end
        
        for i = 1, num_attackers do
            local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_attacker(i)
            local char_obj = cm:model():character_for_command_queue_index(this_char_cqi)
            
            if this_char_cqi == character:cqi() then
                was_attacker = true
                break
            end
            
            if char_obj:is_null_interface() == false then
                local culture = char_obj:faction():culture()
                local cards_num = #cm:pending_battle_cache_get_attacker_units(i)
                local unit_list =  culture_to_unit[culture]
                out("Rhox Nagash Lahmia: culture: " ..culture.. " /cards num" .. cards_num ..  " /Random percent ".. neferata_chance_per_card*cards_num)
                if unit_list and cm:model():random_percent(neferata_chance_per_card*cards_num) then
                    table.insert(rewards, unit_list[cm:random_number(#unit_list)])
                end
            end
        end
        
        if was_attacker == false then

        end
        
        for i = 1, num_defenders do
            local this_char_cqi, this_mf_cqi, current_faction_name = cm:pending_battle_cache_get_defender(i)
            local char_obj = cm:model():character_for_command_queue_index(this_char_cqi)
            
            if char_obj:is_null_interface() == false then
                local culture = char_obj:faction():culture()
                local cards_num = #cm:pending_battle_cache_get_defender_units(i)
                local unit_list =  culture_to_unit[culture]
                out("Rhox Nagash Lahmia: culture: " ..culture.. " /cards num" .. cards_num ..  " /Random percent ".. neferata_chance_per_card*cards_num)
                if unit_list and cm:model():random_percent(neferata_chance_per_card*cards_num) then
                    table.insert(rewards, unit_list[cm:random_number(#unit_list)])
                end
            end
        end

        out("Rhox Nagash Lahmia: Number of rewards: ".. #rewards)
        if #rewards >0 then
            local lahmia_faction = cm:get_faction("wh3_main_vmp_lahmian_sisterhood")
            local incident_builder = cm:create_incident_builder("rhox_nagash_lahmia_enemy_deserted")
            --incident_builder:add_target(lahmia_faction)
            incident_builder:add_target("default", character)
            local payload_builder = cm:create_payload()
            for i=1, #rewards do
                out("Rhox Nagash Lahmia: unit key: ".. rewards[i])
                payload_builder:add_mercenary_to_faction_pool(rewards[i], 1)  
            end
            
            
            incident_builder:set_payload(payload_builder)
            cm:launch_custom_incident_from_builder(incident_builder, lahmia_faction)
        end
        
    end,
    true
)


 
-- create cults after ritual is performed
core:add_listener(
    "rhox_nagash_lahmia_create_cults_ritual_performed",
    "RitualCompletedEvent",
    function(context)
        local faction = context:performing_faction();
        return context:ritual():ritual_key() == "rhox_nagash_lahmia_ritual_create_cults";
    end,
    function(context)
        local faction = context:performing_faction();
        local valid_region_list = {};
        local cultures_to_check = {
            "wh3_main_ksl_kislev",
            "wh3_main_cth_cathay",
            "wh_main_emp_empire",
            "wh_main_brt_bretonnia",
            "wh_dlc08_nor_norsca",
            "wh2_main_def_dark_elves",
            "wh2_main_hef_high_elves",
            "wh_dlc05_wef_wood_elves",
            "wh_main_dwf_dwarfs",
            "wh3_dlc23_chd_chaos_dwarfs",
            "wh3_main_ogr_ogre_kingdoms",
            "mixer_teb_southern_realms",
            "ovn_albion",
            "ovn_araby"
        };
        
        local region_list = cm:model():world():region_manager():region_list();
        
        for i = 0, region_list:num_items() - 1 do
            local current_region = region_list:item_at(i);
            
            if current_region:foreign_slot_managers():is_empty() then
                for j = 1, #cultures_to_check do
                    if current_region:owning_faction():culture() == cultures_to_check[j] then
                        table.insert(valid_region_list, current_region:cqi());
                        break;
                    end;
                end;
            end;
        end;
        
        valid_region_list = cm:random_sort(valid_region_list);
        local faction_cqi = faction:command_queue_index();
        
        for i = 1, math.min(3, #valid_region_list) do
            local fs = cm:add_foreign_slot_set_to_region_for_faction(faction_cqi, valid_region_list[i], "rhox_nagash_lahmia_slot_set_vmp_cult");
            local region = fs:region();
            if(cm:model():random_percent(50)) then
                cm:trigger_incident_with_targets(faction_cqi, "rhox_nagash_lahmia_incident_cult_created", 0, 0, 0, 0, region:cqi(), region:settlement():cqi());
            else
                cm:trigger_incident_with_targets(faction_cqi, "rhox_nagash_lahmia_incident_cult_created2", 0, 0, 0, 0, region:cqi(), region:settlement():cqi());
            end
        end;
    end,
    true
);


cm:add_first_tick_callback(
	function()
        if cm:get_local_faction_name(true) == "wh3_main_vmp_lahmian_sisterhood" then --ui thing and need to be local
            local parent_ui = find_uicomponent(core:get_ui_root(), "hud_campaign", "resources_bar_holder", "resources_bar");
            local result = core:get_or_create_component("rhox_lahmia_cult_holder", "ui/campaign ui/rhox_nagash_lahmia_cult_holder.twui.xml", parent_ui)
            if not result then
                script_error("Rhox Nagash Lahmia: ".. "ERROR: could not create cult ui component? How can this be?");
                return false;
            end;
            result:SetContextObject(cco("CcoCampaignFaction", "wh3_main_vmp_lahmian_sisterhood"))
        end
	end
)

--------------------------------------------------------------
----------------------- SAVING / LOADING ---------------------
--------------------------------------------------------------
cm:add_saving_game_callback(
	function(context)
		cm:save_named_value("rhox_nagash_lahmia_dilemma_table", dilemma_table, context)
	end
)
cm:add_loading_game_callback(
	function(context)
		if cm:is_new_game() == false then
			dilemma_table = cm:load_named_value("rhox_nagash_lahmia_dilemma_table", dilemma_table, context)
		end
	end
)