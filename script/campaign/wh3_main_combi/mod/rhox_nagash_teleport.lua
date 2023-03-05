local nagash_faction = "mixer_nag_nagash"

-- Daemon Army
random_army_manager:new_force("daemon_intercept");
random_army_manager:add_mandatory_unit("daemon_intercept", "wh3_main_kho_inf_bloodletters_0", 3);
random_army_manager:add_mandatory_unit("daemon_intercept", "wh3_main_kho_inf_chaos_warhounds_0", 4);
random_army_manager:add_mandatory_unit("daemon_intercept", "wh3_main_kho_cav_gorebeast_chariot", 1);



function rhox_nagash_add_teleport_listener()
    core:add_listener(
        "rhox_nagash_teleport_check",
        "FactionTurnStart",
        function (context)
            return context:faction():name() == cm:get_local_faction_name(true)
        end,
        function (context)
            local region = cm:get_region("wh3_main_combi_region_ancient_city_of_quintex")
            local owner = region:owning_faction()


            if owner:name() == nagash_faction then--and region:building_exists("wh2_main_special_tower_of_hoeth_2") then --not doing building now as we don't have a building
                cm:teleportation_network_open_node("rhox_nagash_combi_province_broken_teeth");
                cm:teleportation_network_open_node("rhox_nagash_combi_province_marshes_of_madness");
                cm:teleportation_network_open_node("rhox_nagash_combi_province_southern_sylvania");
                cm:teleportation_network_open_node("rhox_nagash_combi_province_land_of_the_dead");
                cm:teleportation_network_open_node("rhox_nagash_combi_province_vampire_coast");
                cm:teleportation_network_open_node("rhox_nagash_combi_province_titan_peaks");
                cm:teleportation_network_open_node("rhox_nagash_combi_province_crater_of_the_waking_dead");
            end
        end,
        false
    );
        
        
    core:add_listener(
		"nagash_character_uses_nagash_rift",
		"TeleportationNetworkMoveCompleted",
		function(context)
			local character = context:character():character();
			if not character:is_null_interface() and context:success() and character:has_military_force() and context:from_record():network_key() == "rhox_nagash_teleportation_network" and not cm:get_faction(nagash_faction):has_effect_bundle("rhox_nagash_disabled") then --rhox_nagash_disabled means it's using the tunnel. Don't call this invasion thing.
				local faction = character:faction();
				
				return faction:is_human();
			end;
		end,
		function(context)
            out("Rhox Nagash: In the rift clause!")
            local character = context:character():character();
			local attacking_force = random_army_manager:generate_force("daemon_intercept", 5, false);
            local x,y = cm:find_valid_spawn_location_for_character_from_settlement(
                "wh3_main_kho_khorne_qb1",
                character:region():name(),
                false,
                true,
                20
                );
            out("Rhox Nagash: valid spawn location: "..x..", "..y)
            local enemy_char_cqi
            local enemy_force_cqi
            cm:create_force(
                "wh3_main_kho_khorne_qb1",
                attacking_force,
                character:region():name(),
                x,
                y,
                true,
                function(char_cqi,force_cqi)
                    enemy_force_cqi = force_cqi;
                    
                    cm:disable_event_feed_events(true, "", "", "diplomacy_war_declared");
                    cm:force_declare_war("wh3_main_kho_khorne_qb1", nagash_faction, false, false);	
                    cm:callback(function() cm:disable_event_feed_events(false, "", "", "diplomacy_war_declared") end, 0.2);
                    cm:disable_movement_for_character(cm:char_lookup_str(char_cqi));
                    cm:set_force_has_retreated_this_turn(cm:get_military_force_by_cqi(force_cqi));
                    enemy_char_cqi = char_cqi
                end
            );
            out("Rhox Nagash: Created Force")
            
    
    
            --find move coords for battlefield
            local b_x, b_y = cm:find_valid_spawn_location_for_character_from_position(
                "wh3_main_kho_khorne_qb1",
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
            return context:faction():name() == "wh3_main_kho_khorne_qb1"
        end,
        function(context)
            cm:disable_event_feed_events(true, "", "", "diplomacy_faction_destroyed");

            cm:kill_all_armies_for_faction(context:faction());

            cm:callback(function() cm:disable_event_feed_events(false, "", "", "diplomacy_faction_destroyed") end, 0.2);
        end,
        true
    );

end