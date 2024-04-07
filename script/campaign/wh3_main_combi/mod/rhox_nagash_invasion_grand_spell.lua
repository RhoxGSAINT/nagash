local nagash_faction = "mixer_nag_nagash"




local function throw_enemies_at_settlement(setttlement_key, tech_key, invasion_faction, faction_type)
    -- spawns markers which will later spawn invasion armies
    -- self:logf("++++++tech invasions throw_enemies_at_settlement !")
    local num = cm:random_number(3, 2)
    local nag_key = nagash_faction


    --- TODO add despawn event feed

    for i = 1, num do
        local x,y = cm:find_valid_spawn_location_for_character_from_settlement(nagash_faction, setttlement_key, false, true, cm:random_number(24, 12))
        -- marker:spawn(tech_key..i, x, y)
        local region_key = setttlement_key
        local invasion_key = region_key.."_invasion_"..x.."_"..y.."_"..tech_key.."_"..i

        local unit_list = WH_Random_Army_Generator:generate_random_army(invasion_key, faction_type, 19, 7, true, false)

        local sx,sy = cm:find_valid_spawn_location_for_character_from_position(nag_key, x, y, true)
        local invasion_object = invasion_manager:new_invasion(invasion_key, invasion_faction, unit_list, {sx, sy})
        -- invasion_object:apply_effect(self.invasion_force_effect_bundle, -1);
        invasion_object:set_target("REGION", region_key, nag_key)
        invasion_object:apply_effect("wh_main_bundle_military_upkeep_free_force_siege_attacker", 10);
        invasion_object:apply_effect("wh2_dlc11_bundle_immune_all_attrition", 10);            
        invasion_object:add_aggro_radius(25, {nag_key}, 1)
        invasion_object:start_invasion(true,true,false,false)
    end

end
local undead_subculture = {
    wh2_dlc09_sc_tmb_tomb_kings =true,
    wh2_dlc11_sc_cst_vampire_coast =true,
    wh_main_sc_vmp_vampire_counts =true,
    mixer_vmp_jade_vampires =true,
    wh_main_sc_vmp_jade_vampires = true, --poljanan's one
    jiangshi_subculture=true --damned dynasty
}


local zombie_apocalypse_unit_list={
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie",
    "nag_vanilla_vmp_inf_zombie"
}

local function rhox_nagash_trigger_end_game()
    local all_factions = cm:model():world():faction_list();
    local vassal_list ={}
    for i = 0, all_factions:num_items()-1 do
        local faction = all_factions:item_at(i);
        if faction:is_human() == false and faction:is_dead() == false and undead_subculture[faction:subculture()] == true then
            cm:force_make_vassal(nagash_faction, faction:name())
            table.insert(vassal_list, faction:name());
        end
    end;
    
    local region_list = cm:model():world():region_manager():region_list();
            
    for i = 0, region_list:num_items() - 1 do
        local current_region = region_list:item_at(i);
        
        if current_region:is_province_capital() then
            cm:apply_effect_bundle_to_region("nag_divinity_rite_bundle_region_undead_rises", current_region:name(), 0);
            if #vassal_list > 0 then --you're not getting zombies if there aren't any vassals
                local target_vassal = vassal_list[cm:random_number(#vassal_list)]
                local x,y = cm:find_valid_spawn_location_for_character_from_settlement(target_vassal, current_region:name(), false, true, cm:random_number(24, 12))
                local unit_list = table.concat(zombie_apocalypse_unit_list, ",")
                cm:create_force(target_vassal, unit_list, current_region:name(), x, y, true, function(cqi, force_cqi) cm:apply_effect_bundle_to_force("wh_main_bundle_military_upkeep_free_force_siege_attacker", force_cqi, 0) end)
            end
        end;
    end;
    
end


function rhox_nagash_trigger_rites_listeners()

    core:add_listener(
            "rhox_nagash_faction_turn_start",
            "FactionTurnStart",
            function(context)
                return context:faction():name() == nagash_faction and cm:get_saved_value("nag_bp_ritual_completed") == true
            end,
            function(context)
                
                local nag_fact = nagash_faction
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_black_pyramid_of_nagash")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_nagashizzar")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_morgheim")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_lahmia")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_khemri")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_the_awakening")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_castle_drakenhof")
                cm:make_region_visible_in_shroud(nag_fact, "wh3_main_combi_region_ancient_city_of_quintex")
                rhox_nagash_grandspell_ui()
            end,
            true
    )
    
    

    core:add_listener(
    --- When the end game tech is researched, do stuff.
        "NagashEndWorldTechs",
        "ResearchCompleted",
        function(context)
            return context:technology() == "nag_nagash_ultimate_preprartion" or
            context:technology() == "nag_location_nagashizzar" or
            context:technology() == "nag_location_mourkain" or
            context:technology() == "nag_location_lahmia" or
            context:technology() == "nag_location_khemri" or
            context:technology() == "nag_location_awakening" or
            context:technology() == "nag_location_drakenhof" or
            context:technology() == "nag_location_quintex"
        end,
        function(context)
            -- self:logf("++++++tech invasions !")
            tech_key = context:technology()

            if tech_key == "nag_location_nagashizzar" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_nagashizzar", tech_key, "wh2_dlc13_skv_skaven_invasion", "wh2_main_sc_skv_skaven")
            end
            if tech_key == "nag_location_mourkain" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_morgheim", tech_key, "wh2_dlc13_grn_greenskins_invasion", "wh_main_sc_grn_greenskins")
            end
            if tech_key == "nag_location_lahmia" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_lahmia", tech_key, "wh2_dlc13_bst_beastmen_invasion", "wh_dlc03_sc_bst_beastmen")
            end
            if tech_key == "nag_location_khemri" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_khemri", tech_key, "wh2_dlc16_grn_savage_invasion", "wh_main_sc_grn_savage_orcs")
            end
            if tech_key == "nag_location_awakening" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_the_awakening", tech_key, "wh2_dlc16_emp_colonist_invasion", "wh_main_sc_emp_empire")
            end
            if tech_key == "nag_location_drakenhof" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_castle_drakenhof", tech_key, "wh2_dlc16_emp_empire_invasion", "wh_main_sc_emp_empire")
            end
            if tech_key == "nag_location_quintex" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_ancient_city_of_quintex", tech_key, "wh2_dlc13_nor_norsca_invasion", "wh_dlc08_sc_nor_norsca")
            end
            
            if tech_key == "nag_nagash_ultimate_preprartion" then
                local mm = mission_manager:new(nagash_faction, "rhox_nagash_final_step_mission")
                mm:add_new_objective("DESTROY_FACTION")
                mm:add_condition("faction wh2_dlc13_skv_skaven_invasion")
                mm:add_condition("faction wh2_dlc13_grn_greenskins_invasion")
                mm:add_condition("faction wh2_dlc13_bst_beastmen_invasion")
                mm:add_condition("faction wh2_dlc16_grn_savage_invasion")
                mm:add_condition("faction wh2_dlc16_emp_colonist_invasion")
                mm:add_condition("faction wh2_dlc16_emp_empire_invasion")
                mm:add_condition("faction wh2_dlc13_nor_norsca_invasion")
                mm:add_payload("text_display rhox_nagash_final_tech_unlock")
                mm:trigger()

            end

        end,
        true
    )
    
    
    -- build the BP main 3
    core:add_listener(
        "nag_grand_spell_01_unlocking",
        "MilitaryForceBuildingCompleteEvent",
        function(context)
            return context:building() == "nag_bpyramid_main_3";
        end,
        function(context)
            out("nag_grand_spell_01_unlocking!")
            cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_01", "nag_grand_spell_01_recharge", 20)            
            cm:set_saved_value("grand_spell_status_nag_grand_spell_01", true)
            rhox_nagash_grandspell_ui()
        end,
        true
    )
    
    -- build the BP obelisk 4
    core:add_listener(
        "nag_grand_spell_02_unlocking",
        "MilitaryForceBuildingCompleteEvent",
        function(context)
            return context:building() == "nag_bpyramid_main_obelisk_4";
        end,
        function(context)
            out("nag_grand_spell_02_unlocking!")
            cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_02", "nag_grand_spell_02_recharge", 20)            
            cm:set_saved_value("grand_spell_status_nag_grand_spell_02", true)
            rhox_nagash_grandspell_ui()
        end,
        true
    )

    -- build the BP main 5
    core:add_listener(
        "nag_grand_spell_03_unlocking",
        "MilitaryForceBuildingCompleteEvent",
        function(context)
            return context:building() == "nag_bpyramid_main_5";
        end,
        function(context)
            out("nag_grand_spell_03_unlocking!")
            cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_03", "nag_grand_spell_03_recharge", 20)            
            cm:set_saved_value("grand_spell_status_nag_grand_spell_03", true)
            rhox_nagash_grandspell_ui()
        end,
        true
    )
    
    
    core:add_listener(
        "rhox_nagash_ritual_event",
        "RitualCompletedEvent",
        function(context)
            return context:performing_faction():is_human() and context:ritual():ritual_key() == "nag_winds"
        end,
        function(context)
            if cm:get_saved_value("grand_spell_status_nag_grand_spell_01") ==true then
                cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_01", "nag_grand_spell_01_recharge", 20)            
            end
            if cm:get_saved_value("grand_spell_status_nag_grand_spell_02") ==true then
                cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_02", "nag_grand_spell_02_recharge", 20)            
            end
            if cm:get_saved_value("grand_spell_status_nag_grand_spell_03") ==true then
                cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_03", "nag_grand_spell_03_recharge", 20)            
            end
            
            rhox_nagash_grandspell_ui()
        end,
        true
    )    
    
    
    core:add_listener(
        "NagashFinalMissions",
        "MissionSucceeded",
        function(context)
            local mission = context:mission()
            return mission:mission_record_key()== "rhox_nagash_final_step_mission"
        end,
        function(context)
            out("Rhox Nagash: You finished the final mission!")
            cm:unlock_technology(nagash_faction, "nag_nagash_ultimate")
            
        end,
        true
    )
    

    core:add_listener(
    --- When the end game tech is researched, do stuff.
        "Nagash_the_final_tech",
        "ResearchCompleted",
        function(context)
            return context:technology() == "nag_nagash_ultimate"
        end,
        function(context)
            cm:trigger_incident(nagash_faction, "rhox_nagash_victory", true, false)
            cm:complete_scripted_mission_objective(nagash_faction, "wh_main_long_victory", "nagash_final_ritual_complete", true)
            rhox_nagash_trigger_end_game()
        end,
        true
    )
end


--AI also has access to this, so out
core:add_listener(
    "rhox_nagash_battle_completed",
    "CharacterCompletedBattle",
    function(context)
        return context:character():faction():name() == nagash_faction
    end,
    function(context)
        local pending_battle = cm:model():pending_battle()
        local total_card_number;
        local card_table;
        if pending_battle:has_been_fought() == true then
            local faction = cm:get_faction(nagash_faction);
            
        
            local grand1_used = 0
            grand1_used = pending_battle:get_how_many_times_ability_has_been_used_in_battle(faction:command_queue_index(), "nag_army_abilities_endless_tomb")					

            if grand1_used > 0 then
                cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_01", "nag_grand_spell_01_recharge", -20);
            end
            
            local grand2_used = 0
            grand2_used = pending_battle:get_how_many_times_ability_has_been_used_in_battle(faction:command_queue_index(), "nag_army_abilities_batocalypse")					

            if grand2_used > 0 then
                cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_02", "nag_grand_spell_02_recharge", -20);
            end
            
            local grand3_used = 0
            grand3_used = pending_battle:get_how_many_times_ability_has_been_used_in_battle(faction:command_queue_index(), "nag_army_abilities_blyramid_bombardment_targeting") --other bombardments are called by this

            if grand3_used > 0 then
                cm:faction_add_pooled_resource(nagash_faction, "nag_grand_spell_03", "nag_grand_spell_03_recharge", -20);
            end
            rhox_nagash_grandspell_ui()
        end
    end,
    true
);
