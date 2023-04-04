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
        -- local invasion_faction = "wh2_dlc13_skv_skaven_invasion"
        local invasion_key = region_key.."_invasion_"..x.."_"..y

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

function rhox_nagash_trigger_rites_listeners()

    core:add_listener(
            "rhox_ngash_faction_turn_start",
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
                throw_enemies_at_settlement("wh3_main_combi_region_nagashizzar", "nag_location_nagashizzar", "wh2_dlc13_skv_skaven_invasion", "wh2_main_sc_skv_skaven")
            end
            if tech_key == "nag_location_mourkain" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_morgheim", "nag_location_mourkain", "wh2_dlc13_grn_greenskins_invasion", "wh_main_sc_grn_greenskins")
            end
            if tech_key == "nag_location_lahmia" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_lahmia", "nag_location_lahmia", "wh2_dlc13_bst_beastmen_invasion", "wh_dlc03_sc_bst_beastmen")
            end
            if tech_key == "nag_location_khemri" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_khemri", "nag_location_khemri", "wh2_dlc16_grn_savage_invasion", "wh_main_sc_grn_savage_orcs")
            end
            if tech_key == "nag_location_awakening" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_the_awakening", "nag_location_awakening", "wh2_dlc16_emp_colonist_invasion", "wh_main_sc_emp_empire")
            end
            if tech_key == "nag_location_drakenhof" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_castle_drakenhof", "nag_location_drakenhof", "wh2_dlc16_emp_empire_invasion", "wh_main_sc_emp_empire")
            end
            if tech_key == "nag_location_quintex" or tech_key == "nag_nagash_ultimate_preprartion" then
                throw_enemies_at_settlement("wh3_main_combi_region_ancient_city_of_quintex", "nag_location_quintex", "wh2_dlc13_nor_norsca_invasion", "wh_main_sc_nor_norsca")
            end
         
        end,
        true
    )

end