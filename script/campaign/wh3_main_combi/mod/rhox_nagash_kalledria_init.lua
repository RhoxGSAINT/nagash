local rhox_list={--yes it's a single entry but template is helpful
    mixer_vmp_wailing_conclave ={
        leader={
            subtype="nag_vmp_kalledria",
            unit_list="wh2_dlc11_cst_inf_syreens,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_inf_crypt_ghouls,wh_main_vmp_cav_hexwraiths,wh_main_vmp_inf_cairn_wraiths",
            x=1261,
            y=383,
            forename ="names_name_1937224345",
            familiyname ="",
        },
        agent={
            type="spy",
            subtype="wh_main_vmp_banshee"
        },
        hand_over_region="wh3_main_combi_region_waili_village",
        region="wh3_main_combi_region_waili_village",
        how_they_play="rhox_nagash_how_they_play_kalledria",
        pic=594,
        faction_trait="rhox_vmp_kalledria_lord_trait",
        enemy={
            key="wh3_main_cth_burning_wind_nomads",
            subtype="wh3_main_cth_lord_magistrate_yang",
            unit_list="wh3_main_cth_inf_peasant_spearmen_1,wh3_main_cth_inf_peasant_spearmen_1,wh3_main_cth_inf_peasant_spearmen_1,wh3_main_cth_inf_peasant_archers_0,wh3_main_cth_inf_peasant_archers_0",
            x=1253,
            y=388,
        },
        additional = function(faction, faction_key) 
            local vmp_ror_table = {
                "wh_dlc04_vmp_cav_chillgheists_0",
                "wh_dlc04_vmp_cav_vereks_reavers_0",
                "wh_dlc04_vmp_inf_feasters_in_the_dusk_0",
                "wh_dlc04_vmp_inf_konigstein_stalkers_0",
                "wh_dlc04_vmp_inf_sternsmen_0",
                "wh_dlc04_vmp_inf_tithe_0",
                "wh_dlc04_vmp_mon_devils_swartzhafen_0",
                "wh_dlc04_vmp_veh_claw_of_nagash_0",
                "wh_dlc04_vmp_mon_direpack_0",
                "wh2_dlc11_cst_mon_mournguls_ror_0"
            }
            local vmp_raise_dead_faction_table = {
                "wh3_dlc29_vmp_inf_lahmian_handmaidens_death",
                "wh3_dlc29_vmp_inf_spirit_host",
                "wh3_main_vmp_blood_knights_sword_shield",
                "wh3_dlc29_vmp_inf_lahmian_handmaidens_shadow",
                "wh3_dlc29_vmp_veh_coven_throne",
                "wh3_dlc29_vmp_cav_drakenhof_templars",
                "wh3_dlc29_vmp_mon_zombie_dragon",
                "wh_main_vmp_cav_hexwraiths",
                "wh_main_vmp_inf_cairn_wraiths",
                "wh_main_vmp_mon_terrorgheist",
                "wh_main_vmp_mon_vargheists",
                "wh_main_vmp_mon_varghulf",
                "wh_main_vmp_veh_black_coach",
                "wh_dlc02_vmp_cav_blood_knights_0",
                "wh_dlc04_vmp_veh_mortis_engine_0"
            }
            local vmp_raise_dead_province_table = {
                "wh2_dlc11_cst_mon_mournguls_0",
                "wh_main_vmp_inf_skeleton_warriors_0",
                "wh_main_vmp_inf_skeleton_warriors_1",
                "wh_main_vmp_inf_zombie",
                "wh_main_vmp_cav_black_knights_0",
                "wh_main_vmp_cav_black_knights_3",
                "wh_main_vmp_inf_grave_guard_0",
                "wh_main_vmp_inf_grave_guard_1",
                "wh_main_vmp_mon_crypt_horrors",
                "wh_main_vmp_inf_crypt_ghouls",
                "wh_main_vmp_mon_dire_wolves",
                "wh_main_vmp_mon_fell_bats",
                "wh_dlc04_vmp_veh_corpse_cart_0",
                "wh_dlc04_vmp_veh_corpse_cart_1",
                "wh_dlc04_vmp_veh_corpse_cart_2",
                "wh3_main_vmp_inf_grave_guard_2",
                "wh2_dlc11_cst_inf_syreens"
            }
            local vmp_additional_units = {
                "wh2_dlc11_vmp_inf_crossbowmen",
                "wh2_dlc11_vmp_inf_handgunners"
            }
            local defaults = {
                replen_chance = 100,
                max = 1,
                max_per_turn = 0.1,
                xp_level = 0,
                faction_restriction = "",
                subculture_restriction = "",
                tech_restriction = "",
                partial_replenishment = true,
            }
            
            local raise_dead_defaults = {
                replen_chance = 1,
                max = 999999,
                max_per_turn = 100,
                xp_level = 0,
                faction_restriction = "",
                subculture_restriction = "",
                tech_restriction = "",
                partial_replenishment = false,
            }
            for i, ror in pairs(vmp_ror_table) do
                cm:add_unit_to_faction_mercenary_pool(
                    faction,
                    ror,
                    "wh3_main_regiments_of_renown_pool",
                    1,
                    defaults.replen_chance,
                    defaults.max,
                    defaults.max_per_turn,
                    defaults.faction_restriction,
                    defaults.subculture_restriction,
                    defaults.tech_restriction,
                    defaults.partial_replenishment,
                    ror
                )
            end
            for i, ror in pairs(vmp_additional_units) do
                cm:add_unit_to_faction_mercenary_pool(
                    faction,
                    ror,
                    "wh3_dlc29_vmp_additional_units",
                    raise_dead_defaults.max,
                    raise_dead_defaults.replen_chance,
                    raise_dead_defaults.max,
                    raise_dead_defaults.max_per_turn,
                    raise_dead_defaults.faction_restriction,
                    raise_dead_defaults.subculture_restriction,
                    raise_dead_defaults.tech_restriction,
                    raise_dead_defaults.partial_replenishment,
                    ror
                )
            end
            for i, ror in pairs(vmp_raise_dead_faction_table) do
                cm:add_unit_to_faction_mercenary_pool(
                    faction,
                    ror,
                    "wh3_dlc29_vmp_raise_dead_faction",
                    raise_dead_defaults.max,
                    raise_dead_defaults.replen_chance,
                    raise_dead_defaults.max,
                    raise_dead_defaults.max_per_turn,
                    raise_dead_defaults.faction_restriction,
                    raise_dead_defaults.subculture_restriction,
                    raise_dead_defaults.tech_restriction,
                    raise_dead_defaults.partial_replenishment,
                    ror
                )
            end
            for i, ror in pairs(vmp_raise_dead_province_table) do
                cm:add_unit_to_faction_mercenary_pool(
                    faction,
                    ror,
                    "wh3_dlc29_vmp_raise_dead_province",
                    raise_dead_defaults.max,
                    raise_dead_defaults.replen_chance,
                    raise_dead_defaults.max,
                    raise_dead_defaults.max_per_turn,
                    raise_dead_defaults.faction_restriction,
                    raise_dead_defaults.subculture_restriction,
                    raise_dead_defaults.tech_restriction,
                    raise_dead_defaults.partial_replenishment,
                    ror
                )
            end
            
            if faction:is_human() == false then
                local target_region = cm:get_region("wh3_main_combi_region_waili_village")
                cm:instantly_set_settlement_primary_slot_level(target_region:settlement(), 3)
                local target_slot = target_region:slot_list():item_at(1)
                cm:instantly_upgrade_building_in_region(target_slot, "wh_main_vmp_garrison_2")
                cm:heal_garrison(target_region:cqi())
            end
        end,
        first_tick = function(faction, faction_key) 
        end
    }
}




cm:add_first_tick_callback_new(
    function()
        if cm:is_multiplayer() then
            mixer_disable_starting_zoom = true
        end


        for faction_key, faction_info in pairs(rhox_list) do
			local faction = cm:get_faction(faction_key);
            local faction_leader_cqi = faction:faction_leader():command_queue_index();

            if faction_info.hand_over_region then
                cm:transfer_region_to_faction(faction_info.hand_over_region,faction_key)
                local target_region_cqi = cm:get_region(faction_info.hand_over_region):cqi()
                cm:heal_garrison(target_region_cqi)
            end

            cm:create_force_with_general(
                -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
                faction_key,
                faction_info.leader.unit_list,
                faction_info.region,
                faction_info.leader.x,
                faction_info.leader.y,
                "general",
                faction_info.leader.subtype,
                faction_info.leader.forename,
                "",
                faction_info.leader.familiyname,
                "",
                true,
                function(cqi)
                    cm:set_character_unique(cm:char_lookup_str(cqi),true)
                end
            );
            cm:disable_event_feed_events(true, "wh_event_category_character", "", "")
            cm:set_character_immortality(cm:char_lookup_str(faction_leader_cqi), false);          
            cm:kill_character_and_commanded_unit(cm:char_lookup_str(faction_leader_cqi), true)
            cm:callback(function() cm:disable_event_feed_events(false, "", "", "wh_event_category_character") end, 0.2);

            if faction_info.agent then
                local agent_x, agent_y = cm:find_valid_spawn_location_for_character_from_position(faction_key, faction_info.leader.x, faction_info.leader.y, false, 5);
                cm:create_agent(faction_key, faction_info.agent.type, faction_info.agent.subtype, agent_x, agent_y);       
            end

            if faction_info.enemy then
                cm:disable_event_feed_events(true, "wh_event_category_diplomacy", "", "")
                cm:force_declare_war(faction_key, faction_info.enemy.key, false, false)
                cm:callback(function() cm:disable_event_feed_events(false, "wh_event_category_diplomacy", "", "") end, 0.5)
                
                
                if faction_info.enemy.subtype and cm:get_faction(faction_info.enemy.key):is_human() == false then
                    local x2=nil
                    local y2=nil
                    if faction_info.enemy.x and faction_info.enemy.y then
                        x2= faction_info.enemy.x
                        y2 = faction_info.enemy.y
                    else
                        x2,y2 = cm:find_valid_spawn_location_for_character_from_settlement(
                            faction_info.enemy.key,
                            faction_info.region,
                            false,
                            true,
                            20
                        )
                    end
                    
                    cm:create_force_with_general(
                    -- faction_key, unit_list, region_key, x, y, agent_type, agent_subtype, forename, clan_name, family_name, other_name, id, make_faction_leader, success_callback
                    faction_info.enemy.key,
                    faction_info.enemy.unit_list,
                    faction_info.region,
                    x2,
                    y2,
                    "general",
                    faction_info.enemy.subtype,
                    "",
                    "",
                    "",
                    "",
                    false,
                    function(cqi)
                    end);
                end
            end


            cm:callback(
                function()
                    cm:show_message_event(
                        faction_key,
                        "event_feed_strings_text_wh2_scripted_event_how_they_play_title",
                        "factions_screen_name_" .. faction_key,
                        "event_feed_strings_text_".. faction_info.how_they_play,
                        true,
                        faction_info.pic
                    );
                end,
                1
            )
            faction_info.additional(faction, faction_key)
		end
    end
)
cm:add_first_tick_callback(
	function()
        for faction_key, faction_info in pairs(rhox_list) do
            pcall(function()
                mixer_set_faction_trait(faction_key, faction_info.faction_trait, true)
            end)
            faction_info.first_tick(cm:get_faction(faction_key), faction_key)
        end
	end
)

