local nagash_faction = "mixer_nag_nagash"

-- Daemon Army
random_army_manager:new_force("daemon_intercept1");
random_army_manager:add_mandatory_unit("daemon_intercept1", "wh3_main_kho_inf_bloodletters_0", 3);
random_army_manager:add_mandatory_unit("daemon_intercept1", "wh3_main_kho_inf_chaos_warhounds_0", 4);
random_army_manager:add_mandatory_unit("daemon_intercept1", "wh3_main_kho_cav_gorebeast_chariot", 1);

random_army_manager:new_force("daemon_intercept2");
random_army_manager:add_mandatory_unit("daemon_intercept2", "wh3_main_pro_tze_inf_pink_horrors_0", 3);
random_army_manager:add_mandatory_unit("daemon_intercept2", "wh3_main_pro_tze_inf_blue_horrors_0", 4);
random_army_manager:add_mandatory_unit("daemon_intercept2", "wh3_main_tze_cav_chaos_knights_0", 1);

random_army_manager:new_force("daemon_intercept3");
random_army_manager:add_mandatory_unit("daemon_intercept3", "wh3_main_nur_inf_forsaken_0", 3);
random_army_manager:add_mandatory_unit("daemon_intercept3", "wh3_main_nur_inf_nurglings_0", 4);
random_army_manager:add_mandatory_unit("daemon_intercept3", "wh3_main_nur_inf_plaguebearers_1", 1);

random_army_manager:new_force("daemon_intercept4");
random_army_manager:add_mandatory_unit("daemon_intercept4", "wh3_main_sla_inf_daemonette_1", 3);
random_army_manager:add_mandatory_unit("daemon_intercept4", "wh3_main_sla_inf_daemonette_0", 4);
random_army_manager:add_mandatory_unit("daemon_intercept4", "wh3_main_sla_cav_hellstriders_0", 1);


local daemon_intercept_faction ={
    "wh3_main_kho_khorne_qb1",
    "wh3_main_tze_tzeentch_qb1",
    "wh3_main_nur_nurgle_qb1",
    "wh3_main_sla_slaanesh_qb1"
}

function rhox_nagash_add_teleport_listener()
    core:add_listener(
        "rhox_nagash_teleport_check",
        "FactionTurnStart",
        function (context)
            return context:faction():name() == nagash_faction and cm:get_saved_value("rhox_nagash_teleport_made") ~=true
        end,
        function (context)
            local region = cm:get_region("wh3_main_combi_region_ancient_city_of_quintex")
            local owner = region:owning_faction()


            if owner and owner:name() == nagash_faction then
                cm:set_saved_value("rhox_nagash_teleport_made", true)
                if cm:model():campaign_name_key() == "cr_combi_expanded" then
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_broken_teeth_iee");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_marshes_of_madness_iee");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_southern_sylvania_iee");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_land_of_the_dead_iee");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_vampire_coast_iee");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_titan_peaks_iee");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_crater_of_the_waking_dead_iee");
                else
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_broken_teeth");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_marshes_of_madness");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_southern_sylvania");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_land_of_the_dead");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_vampire_coast");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_titan_peaks");
                    cm:teleportation_network_open_node("rhox_nagash_combi_province_crater_of_the_waking_dead");
                end
                
            end
        end,
        true
    );
        
        
    core:add_listener(
		"nagash_character_uses_nagash_rift",
		"TeleportationNetworkMoveCompleted",
		function(context)
			local character = context:character():character();
			if not character:is_null_interface() and context:success() and character:has_military_force() and (context:from_record():network_key() == "rhox_nagash_teleportation_network" or context:from_record():network_key() == "rhox_nagash_teleportation_network_iee") then
				local faction = character:faction();
				
				return faction:is_human();
			end;
		end,
		function(context)
            out("Rhox Nagash: In the rift clause!")
            local character = context:character():character();
            local id = cm:random_number(4, 1)
            local spawn_faction= daemon_intercept_faction[id]
			local attacking_force = random_army_manager:generate_force("daemon_intercept"..id, 5, false);
            local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
                spawn_faction,
                character:region():name(),
                false,
                true,
                20
                );
            out("Rhox Nagash: valid spawn location: "..x..", "..y)
            local enemy_char_cqi
            local enemy_force_cqi
            cm:create_force(
                spawn_faction,
                attacking_force,
                character:region():name(),
                x,
                y,
                true,
                function(char_cqi,force_cqi)
                    enemy_force_cqi = force_cqi;
                    
                    cm:disable_event_feed_events(true, "", "", "diplomacy_war_declared");
                    cm:force_declare_war(spawn_faction, nagash_faction, false, false);	
                    cm:callback(function() cm:disable_event_feed_events(false, "", "", "diplomacy_war_declared") end, 0.2);
                    cm:disable_movement_for_character(cm:char_lookup_str(char_cqi));
                    cm:set_force_has_retreated_this_turn(cm:get_military_force_by_cqi(force_cqi));
                    enemy_char_cqi = char_cqi
                end
            );
            out("Rhox Nagash: Created Force")
            
    
    
            --find move coords for battlefield
            local b_x, b_y = cm:find_valid_spawn_location_for_character_from_position(
                spawn_faction,
                character:logical_position_x(),
                character:logical_position_y(),
                false
            );
            out("Rhox Nagash: Valid Spawn location "..b_x..", "..b_y)
            --move the carvan here
            cm:teleport_to(cm:char_lookup_str(enemy_char_cqi),  b_x,  b_y);
            local uim = cm:get_campaign_ui_manager();
            uim:override("retreat"):lock();

            cm:force_attack_of_opportunity(
                enemy_force_cqi, 
                character:military_force():command_queue_index(),
                false
            );
    
    
            core:add_listener(
                "rhox_nagash_unlock_retreat_caravan",
                "CharacterCompletedBattle",
                function(context)
                        return context:character() == character or context:character() == cm:get_character_by_cqi(enemy_char_cqi)
                end,
                function(context)
                    uim:override("retreat"):unlock()
                end,
                false
            );

            --uim:override("retreat"):unlock();

		end,
		true
	);

    core:add_listener(
        "rhox_nagash_clean_up_teleport_attacker",
        "FactionTurnStart",
        function(context)
            return context:faction():name() == "wh3_main_kho_khorne_qb1" or context:faction():name() == "wh3_main_tze_tzeentch_qb1" or context:faction():name() == "wh3_main_nur_nurgle_qb1" or context:faction():name() == "wh3_main_sla_slaanesh_qb1"
        end,
        function(context)
            cm:disable_event_feed_events(true, "", "", "diplomacy_faction_destroyed");

            cm:kill_all_armies_for_faction(context:faction());

            cm:callback(function() cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed") end, 0.2);
        end,
        true
    );

end